//
//  LoginPage.swift
//  demo_uitestUITests
//
//  Created by Duckie N on 3/30/20.
//  Copyright © 2020 Nguyen Van Duc. All rights reserved.
//

import Foundation
import XCTest
import Then
import UITestUtils

class LoginUITestable: UIElementPage<UIElements.LoginUIElements> {

    private(set) lazy var userNameTextField = self.textField(.userNameTextField)
    private(set) lazy var passwordTextField = self.textField(.passwordTextField)
    private(set) lazy var loginButton = self.button(.loginButton)
    private(set) lazy var invalidUsernameAlert = self.alert(.invalidUserName)
    private(set) lazy var invalidPasswordAlert = self.alert(.invalidPassword)
    
    override init(app: XCUIApplication) {
        super.init(app: app)
    }
    
    func enterUsername(_ username: String) -> Self {
        enterText(username, into: userNameTextField)
        return self
    }
    
    func enterPassword(_ password: String) -> Self {
        enterText(password, into: passwordTextField)
        return self
    }
    
    func tapLoginButton() -> Self {
        loginButton.tap()
        return self
    }
}
