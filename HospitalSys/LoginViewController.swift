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
            WebserviceConnector.login(loginVC: self)
            startShowingProgress()
        }
        
    }
    
    fileprivate func startShowingProgress() {
        progressIndicator.isHidden = false
        progressIndicator.startAnimation(nil)
        loginButton.isEnabled = false
    }
    
    
    fileprivate func stopShowingProgress() {
        progressIndicator.stopAnimation(nil)
        progressIndicator.isHidden = true
        loginButton.isEnabled = true
    }
    
    func loginSuccessful() {
        print("login successful")
        stopShowingProgress()
        containerVC?.loginSuccessful()
    }
    
    func loginUnsuccessful() {
        print("login unsuccessful")
        stopShowingProgress()
        infoLabel.stringValue = "Nie udało się zalogować"
    }
    
    deinit {
        print("login deinit")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        infoLabel.stringValue = ""
        progressIndicator.isHidden = true
    }
    
    fileprivate func textFieldsAreValid() -> Bool{
        guard !usernameTextField.stringValue.isEmpty else {
            infoLabel.stringValue = "Wprowadź login"
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
