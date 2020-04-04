//
//  LoginElementsIdentifier.swift
//  demo_uitest
//
//  Created by Duckie N on 4/2/20.
//  Copyright © 2020 Nguyen Van Duc. All rights reserved.
//

import Foundation
import UITestUtils

extension UIElements {

    public enum LoginUIElements: String, UIElement {

        case userNameTextField = "username"
        case passwordTextField = "password"
        case loginButton = "loginButton"
        case invalidUserName = "Username can not be empty"
        case invalidPassword = "Password can not be empty"
    }
}
