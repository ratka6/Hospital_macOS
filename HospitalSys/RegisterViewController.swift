//
//  RegisterViewController.swift
//  HospitalSys
//
//  Created by krzysiek on 24.11.2016.
//  Copyright © 2016 krzysiek. All rights reserved.
//

import Cocoa

class RegisterViewController: NSViewController {
    
    @IBOutlet weak var peselTextField: NSTextField!
    @IBOutlet weak var lastNameTextField: NSTextField!
    
    @IBOutlet weak var firstNameTextField: NSTextField!
    @IBOutlet weak var streetTextField: NSTextField!
    @IBOutlet weak var cityTextField: NSTextField!
    @IBOutlet weak var phoneNumberTextField: NSTextField!
    @IBOutlet weak var emailTextField: NSTextField!
    @IBOutlet weak var passwordTextField: NSSecureTextField!
    @IBOutlet weak var retypePasswordTextField: NSSecureTextField!
    
    @IBOutlet weak var sexButton: NSPopUpButton!
    @IBOutlet weak var infoLabel: NSTextField!
    
    
    @IBAction func registerButtonTapped(_ sender: Any) {
        //WebserviceConnector.register(registerVC: self)
        if textFieldsAreValid() {
            print("zarejestrowano")
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        infoLabel.stringValue = ""
    }
    

    fileprivate func textFieldsAreValid() -> Bool{
        guard !peselTextField.stringValue.isEmpty else {
            infoLabel.stringValue = "Wprowadź PESEL"
            return false
        }
        
        guard !lastNameTextField.stringValue.isEmpty else {
            infoLabel.stringValue = "Wprowadź nazwisko"
            return false
        }
        
        guard !firstNameTextField.stringValue.isEmpty else {
            infoLabel.stringValue = "Wprowadź imię"
            return false
        }
        
        guard !streetTextField.stringValue.isEmpty else {
            infoLabel.stringValue = "Wprowadź ulicę"
            return false
        }
        
        guard !cityTextField.stringValue.isEmpty else {
            infoLabel.stringValue = "Wprowadź miejscowość"
            return false
        }
        
        guard !emailTextField.stringValue.isEmpty else {
            infoLabel.stringValue = "Wprowadź email"
            return false
        }
        
        guard !passwordTextField.stringValue.isEmpty else {
            infoLabel.stringValue = "Wprowadź hasło"
            return false
        }
        
        guard passwordTextField.stringValue == retypePasswordTextField.stringValue else {
            infoLabel.stringValue = "Hasła nie pasują"
            return false
        }
        
        infoLabel.stringValue = ""
        return true
    }
    
    
}
