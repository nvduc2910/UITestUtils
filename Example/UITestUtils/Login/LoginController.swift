//
//  ViewController.swift
//  demo_uitest
//
//  Created by Duckie N on 3/13/20.
//  Copyright © 2020 Nguyen Van Duc. All rights reserved.
//

import UIKit
import MBProgressHUD
import UITestUtils

class LoginController: UIViewController {
    
    @IBOutlet weak var usernameTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        title = "Login"
        makeViewTestable()
    }
    
    func login() {
        
        if usernameTextField.text?.isEmpty ?? false {
            showAlert(title: "Error", message: "Username can not be empty")
            return
        }
        
        if passwordTextField.text?.isEmpty ?? false {
            showAlert(title: "Error", message: "Password can not be empty")
            return
        }
        
        MBProgressHUD.showAdded(to: self.view, animated: true)
        ServicesAPI.shared.login(username: "sdf", password: "sdf") { [weak self] accessToken in
            guard let self = self else { return }
            DispatchQueue.main.async {
                if !accessToken.isEmpty {
                    
                    MBProgressHUD.hide(for: self.view, animated: true)
                    self.gotoSecondVC()
                }
            }
        }
    }
    
    private func showAlert(title: String, message: String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    
    @IBAction func loginTap(_ sender: Any) {
        login()
    }
    
    func gotoSecondVC() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let bookVC = storyboard.instantiateViewController(withIdentifier: "BooksViewController")
        self.navigationController?.pushViewController(bookVC, animated: true)
    }
}

extension LoginController: UITestablePage {
    
    typealias UIElementType = UIElements.LoginUIElements
    
    func makeViewTestable() {
        self.makeViewTestable(self.usernameTextField, using: .userNameTextField)
        self.makeViewTestable(self.passwordTextField, using: .passwordTextField)
        self.makeViewTestable(self.loginButton, using: .loginButton)
    }
}
