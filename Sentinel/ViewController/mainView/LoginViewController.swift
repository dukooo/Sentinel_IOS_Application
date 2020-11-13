//
//  LoginViewController.swift
//  ECE1778Project
//
//  Created by Yue Cai on 2020-01-25.
//  Copyright © 2020 ECE1778. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpElements()
    }
    
    func setUpElements() {
        // redirect to profile page if user has logged in
        if Auth.auth().currentUser != nil {
            DispatchQueue.main.async {
                self.transitionToHome()
            }
        }
        passwordTextfield.delegate = self
        emailTextfield.delegate = self
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func validateFields() -> String? {
        if passwordTextfield.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""
        || emailTextfield.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            return "Please fill in all fields!"
        }
        return nil
    }
    
    func showError(_ message: String) {
        print(message)
        //TODO: show error msg
    }
    
    @IBAction func loginTapped(_ sender: Any) {
        
        let error = validateFields()
        if error != nil {
            showError(error!)
        }
        else {
            let password = passwordTextfield.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let email = emailTextfield.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
                if error != nil {
                    self.showError(error?.localizedDescription ?? "Error when storing user data")
                }
                else {
                    self.transitionToHome()
                }
            }
        }
    }
    
    func transitionToHome() {
        let vc = self.storyboard?.instantiateViewController(identifier: "homeVC")
        self.view.window?.rootViewController = vc
        self.view.window?.makeKeyAndVisible()
    }
}
