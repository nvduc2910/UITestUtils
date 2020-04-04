//
//  AppDelegate.swift
//  demo_uitest
//
//  Created by Duckie N on 3/13/20.
//  Copyright © 2020 Nguyen Van Duc. All rights reserved.
//

import UIKit
import PushKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, PKPushRegistryDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        let arguments = ProcessInfo.processInfo.arguments
        for argument in arguments {
            switch argument {
            case "UI_TESTING":
                ServicesAPI.shared.configureBaseURL("http://localhost:8080")
            default:
                ServicesAPI.shared.configureBaseURL("https://da31de14-b60e-4249-8921-0dcf5d5796ef.mock.pstmn.io")
            }
        }
        
//        let voipRegistry: PKPushRegistry = PKPushRegistry(queue: .main)
//        
//            // Set the registry's delegate to self
//        voipRegistry.delegate = self
//
//        // Set the push type to VoIP
//        voipRegistry.desiredPushTypes = [PKPushType.voIP]
        
        return true
    }
    
    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }

    
    func pushRegistry(_ registry: PKPushRegistry, didReceiveIncomingPushWith payload: PKPushPayload, for type: PKPushType, completion: @escaping () -> Void) {
        
    }
    
    func pushRegistry(_ registry: PKPushRegistry, didUpdate pushCredentials: PKPushCredentials, for type: PKPushType) {
        
    }

}

