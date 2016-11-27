//
//  LoginViewController.swift
//  HospitalSys
//
//  Created by krzysiek on 24.11.2016.
//  Copyright © 2016 krzysiek. All rights reserved.
//

import Cocoa

class LoginViewController: NSViewController {
    
    weak var containerVC: ContainerViewController?
    
    @IBOutlet weak var progressIndicator: NSProgressIndicator!
    
    @IBOutlet weak var usernameTextField: NSTextField!
    
    @IBOutlet weak var loginButton: NSButton!
    
    @IBOutlet weak var passwordTextField: NSSecureTextField!
    
    @IBOutlet weak var infoLabel: NSTextField!
    
    
    @IBAction func loginButtonClicked(_ sender: Any) {
        
        if textFieldsAreValid() {
            print("zalogowano")
            WebserviceConnector.login(loginVC: self, login: Int64(usernameTextField.stringValue)!, password: passwordTextField.stringValue)
            startShowingProgress()
        }
        
    }
    
    fileprivate func startShowingProgress() {
        progressIndicator.isHidden = false
        progressIndicator.startAnimation(nil)
        loginButton.isEnabled = false
        infoLabel.textColor = NSColor(red: 127.0/255.0, green: 170.0/255.0, blue: 171.0/255.0, alpha: 1)
        infoLabel.stringValue = "Logowanie..."
        usernameTextField.isEnabled = false
        passwordTextField.isEnabled = false
        loginButton.isEnabled = false
    }
    
    
    fileprivate func stopShowingProgress() {
        progressIndicator.stopAnimation(nil)
        progressIndicator.isHidden = true
        loginButton.isEnabled = true
        infoLabel.textColor = NSColor.red
        usernameTextField.isEnabled = true
        passwordTextField.isEnabled = true
        loginButton.isEnabled = true
    }
    
    func didLogin(successfully: Bool) {
        if successfully {
            print("login successful")
            stopShowingProgress()
            containerVC?.loginSuccessful()
        }
        else {
            print("login unsuccessful")
            stopShowingProgress()
            infoLabel.stringValue = "PESEL albo hasło niepoprawne"
        }
        stopShowingProgress()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        infoLabel.stringValue = ""
        infoLabel.textColor = NSColor.red
        progressIndicator.isHidden = true
        
    }
    
    fileprivate func textFieldsAreValid() -> Bool{
        guard !usernameTextField.stringValue.isEmpty else {
            infoLabel.stringValue = "Wprowadź PESEL"
            return false
        }
        
        guard !passwordTextField.stringValue.isEmpty else {
            infoLabel.stringValue = "Wprowadź hasło"
            return false
        }
        
        infoLabel.stringValue = ""
        return true
    }
    
    
    
}
