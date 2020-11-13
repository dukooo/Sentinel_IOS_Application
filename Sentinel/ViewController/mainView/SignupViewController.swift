//
//  SignupViewController.swift
//  ECE1778Project
//
//  Created by Yue Cai on 2020-01-25.
//  Copyright © 2020 ECE1778. All rights reserved.
//

import UIKit
import Firebase

class SignupViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    @IBOutlet weak var confirmTextfield: UITextField!
    @IBOutlet weak var usernameTextfield: UITextField!
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpElements()
    }
    
    func setUpElements() {
        emailTextfield.delegate = self
        passwordTextfield.delegate = self
        confirmTextfield.delegate = self
        usernameTextfield.delegate = self
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func validateFields() -> String? {
        if passwordTextfield.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""
        || confirmTextfield.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""
        || usernameTextfield.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""
        || emailTextfield.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            return "Please fill in all fields!"
        }
        let password = passwordTextfield.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let confirmPW = confirmTextfield.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        if password != confirmPW {
            return "Confirm password does not match password!"
        }
        let username = usernameTextfield.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        if username.count >= 20 {
            return "Username should be less than 20 characters!"
        }
        return nil
    }
    
    func startIndicator() {
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = UIActivityIndicatorView.Style.large
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        self.view.isUserInteractionEnabled = false
    }
    
    func stopIndicator() {
        activityIndicator.stopAnimating()
        self.view.isUserInteractionEnabled = true
    }
    
    func showError(_ message: String) {
        print(message)
        //TODO: show error msg
    }

    @IBAction func signupTapped(_ sender: Any) {
        let error = validateFields()
        if error != nil {
            showError(error!)
        }
        else {
            self.startIndicator()
            let password = passwordTextfield.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let email = emailTextfield.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let username = usernameTextfield.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            Auth.auth().createUser(withEmail: email, password: password) { (result, err) in
                if err != nil {
                    self.showError(err?.localizedDescription ?? "Error when creating users")
                    self.stopIndicator()
                }
                else {
                    // save username, bio uid to firestore
                    let db = Firestore.firestore()
                    db.collection("users").document(result!.user.uid).setData(["username": username]) {error in
                        if error != nil {
                            self.showError(err?.localizedDescription ?? "Error when storing user data")
                            self.stopIndicator()
                        }
                        else {
                            self.stopIndicator()
                            self.transitionToHome()
                        }
                    }
                }
            }
        }
    }
    
    func transitionToHome() {
        let vc = storyboard?.instantiateViewController(identifier: "homeVC")
        view.window?.rootViewController = vc
        view.window?.makeKeyAndVisible()
    }
}
