//
//  BaseUITestCase.swift
//  UITestUtils
//
//  Created by Duckie N on 4/2/20.
//  Copyright © 2020 Nguyen Van Duc. All rights reserved.
//

import Foundation
import XCTest
import Embassy
import EnvoyAmbassador

open class BaseUITestCase: XCTestCase {
    
    let port = 8080
    var router: Router!
    var eventLoop: EventLoop!
    var server: HTTPServer!
    open var embassyapp: XCUIApplication!
    
    var eventLoopThreadCondition: NSCondition!
    var eventLoopThread: Thread!
    
    override open func setUp() {
        super.setUp()
        setupWebApp()
        setupApp()
    }
    
    private func setupWebApp() {
        eventLoop = try! SelectorEventLoop(selector: try! KqueueSelector())
        router = Router()
        server = DefaultHTTPServer(eventLoop: eventLoop, port: port, app: router.app)
        
        // Start HTTP server to listen on the port
        try! server.start()
        
        eventLoopThreadCondition = NSCondition()
        eventLoopThread = Thread(target: self, selector: #selector(runEventLoop), object: nil)
        eventLoopThread.start()
    }
    
    private func setupApp() {
        embassyapp = XCUIApplication()
        embassyapp.launchEnvironment = ["BASEURL" : "http://localhost:8080"]
        embassyapp.launchArguments = ["UI_TESTING"]
    }
    
    override open func tearDown() {
        
        embassyapp.terminate()
        server.stopAndWait()
        eventLoopThreadCondition.lock()
        eventLoop.stop()
        while eventLoop.running {
            if !eventLoopThreadCondition.wait(until: (NSDate().addingTimeInterval(10) as Date)) {
                fatalError("Join eventLoopThread timeout")
            }
        }
        super.tearDown()
    }
    
    @objc private func runEventLoop() {
        eventLoop.runForever()
        eventLoopThreadCondition.lock()
        eventLoopThreadCondition.signal()
        eventLoopThreadCondition.unlock()
    }
    
    open func expectToSee(_ element: XCUIElement,
                     within timeout: TimeInterval = 5,
                     _ file: StaticString = #file,
                     _ line: UInt = #line) {
      if element.exists {
        XCTAssertTrue(true)
      } else {
        XCTAssertTrue(element.waitForExistence(timeout: timeout), file: file, line: line)
      }
    }
    
    open func expectNotToSee(_ element: XCUIElement,
                        within timeout: TimeInterval = 5,
                        _ file: StaticString = #file,
                        _ line: UInt = #line) {
      let date = Date().addingTimeInterval(timeout)
      var result = false
      repeat {
        result = !element.exists
      } while !result && Date().timeIntervalSince1970 < date.timeIntervalSince1970

      XCTAssertTrue(result, file: file, line: line)
    }
}
