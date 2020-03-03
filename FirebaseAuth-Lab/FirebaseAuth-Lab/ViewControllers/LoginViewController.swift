//
//  ViewController.swift
//  FirebaseAuth-Lab
//
//  Created by casandra grullon on 3/2/20.
//  Copyright © 2020 casandra grullon. All rights reserved.
//

import UIKit

enum AccountState {
    case existingUser
    case newUser
}

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var signUpHereButton: UIButton!
    
    private var accountState: AccountState = .newUser
    private var authSession = AuthenticationSession()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emailTextField.delegate = self
        passwordTextField.delegate = self
    }

    @IBAction func loginButtonAction(_ sender: UIButton) {
        guard let emailAddress = emailTextField.text,
            !emailAddress.isEmpty,
            let password = passwordTextField.text,
            !password.isEmpty else {
            showAlert(title: "Missing Fields", message: "Please fill in all required fields")
            return
        }
        
        loginFlow(email: emailAddress, password: password)
    }
    
    @IBAction func signUpAction(_ sender: UIButton) {
        accountState = accountState == .existingUser ? .newUser : .existingUser
        
        if accountState == .existingUser {
            loginButton.setTitle("Login", for: .normal)
        } else {
            loginButton.setTitle("Create Account", for: .normal)
        }
    }
    
    private func loginFlow(email: String, password: String) {
        if accountState == .existingUser {
            authSession.signExistingUser(email: email, password: password) { (result) in
                switch result {
                case .failure(let error):
                    self.showAlert(title: "Login Error", message: "\(error)")
                case .success:
                    self.navigateToProfileVC()
                }
            }
        } else {
            authSession.createNewUser(email: email, password: password) { (result) in
                switch result {
                case .failure(let error):
                    self.showAlert(title: "Sign Up Error", message: "\(error)")
                case .success:
                    self.navigateToProfileVC()
                }
            }
        }
    }
    
    private func navigateToProfileVC() {
        UIViewController.showViewController(storyboardName: "Main", viewControllerID: "ProfileViewController")
    }
    
}
extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

