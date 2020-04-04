//
//  LoginPageTest.swift
//  demo_uitestUITests
//
//  Created by Duckie N on 3/30/20.
//  Copyright © 2020 Nguyen Van Duc. All rights reserved.
//

import Foundation
import XCTest
import UITestUtils
import Then

class LoginPageTest: BaseUITestCase {
    
    private var loginPage: LoginUITestable!
    
    override func setUp() {
        super.setUp()
        loginPage = LoginUITestable(app: embassyapp)
        embassyapp.launch()
    }
    
    override func tearDown() {
        super.tearDown()
        loginPage = nil
    }
    
    func testElementExists() {
        XCTAssert(loginPage.userNameTextField.exists)
        XCTAssert(loginPage.passwordTextField.exists)
        XCTAssert(loginPage.loginButton.exists)
    }
    
    func testInvalidUsername() {
        _ = loginPage
            .enterUsername("")
            .enterPassword("12345678")
            .tapLoginButton()
            .then { _ in
                XCTAssert(loginPage.invalidUsernameAlert.exists)
            }
    }
    
    func testInvalidPassword() {
        
        _ = loginPage
            .enterUsername("nvduc2910")
            .enterPassword("")
            .tapLoginButton()
            .then { _ in
                XCTAssert(loginPage.invalidPasswordAlert.exists)
            }
    }
    
    func testInvalidUsernameAndPassword() {
        _ = loginPage
            .enterUsername("")
            .enterPassword("")
            .tapLoginButton()
            .then { _ in
                XCTAssert(loginPage.invalidUsernameAlert.exists)
            }
    }
    
    func testValidUsernameAndPassword() {
        _ = loginPage
            .enterUsername("nvduc2910")
            .enterPassword("12345678")
            .tapLoginButton()
            .then { _ in
                
            }
    }
}
