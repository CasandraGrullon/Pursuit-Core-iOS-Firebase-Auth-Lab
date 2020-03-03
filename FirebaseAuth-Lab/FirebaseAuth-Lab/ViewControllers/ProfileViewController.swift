//
//  ProfileViewController.swift
//  FirebaseAuth-Lab
//
//  Created by casandra grullon on 3/2/20.
//  Copyright © 2020 casandra grullon. All rights reserved.
//

import UIKit
import FirebaseAuth

class ProfileViewController: UIViewController {

    @IBOutlet weak var userNameTextField: UITextField!
    
    @IBOutlet weak var phoneNumberTextField: UITextField!
    
    @IBOutlet weak var emailAddressTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        userNameTextField.delegate = self
        phoneNumberTextField.delegate = self
        emailAddressTextField.delegate = self
    }
    
    private func updateUI() {
        guard let user = Auth.auth().currentUser else {
            return
        }
        emailAddressTextField.text = user.email
        userNameTextField.text = user.displayName
        phoneNumberTextField.text = user.phoneNumber
    }
    
    
    @IBAction func updateProfileButtonAction(_ sender: UIButton) {
        guard let username = userNameTextField.text, !username.isEmpty, let phoneNumber = phoneNumberTextField.text, !phoneNumber.isEmpty else {
            showAlert(title: "Missing Fields!", message: "Please fill all required fields")
            return
        }
        
        let request = Auth.auth().currentUser?.createProfileChangeRequest()
        
        request?.displayName = username
        
        request?.commitChanges(completion: { [unowned self] (error) in
            if let error = error {
                self.showAlert(title: "Error", message: "error changing username \(error)")
            } else {
                self.showAlert(title: "Username Updated", message: "successfully updated your username")
            }
        })
        
    }
    
}
extension ProfileViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

}
