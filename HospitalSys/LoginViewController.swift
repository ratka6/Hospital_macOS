//
//  LoginViewController.swift
//  HospitalSys
//
//  Created by krzysiek on 24.11.2016.
//  Copyright © 2016 krzysiek. All rights reserved.
//

import Cocoa

class LoginViewController: NSViewController {
    
    
    @IBOutlet weak var usernameTextField: NSTextField!
    
    @IBOutlet weak var passwordTextField: NSSecureTextField!
    
    @IBOutlet weak var infoLabel: NSTextField!
    
    
    @IBAction func loginButtonClicked(_ sender: Any) {
        
        if textFieldsAreValid() {
            print("zalogowano")
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        infoLabel.stringValue = ""
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
