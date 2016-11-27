//
//  WebserviceConnector.swift
//  HospitalSys
//
//  Created by krzysiek on 25.11.2016.
//  Copyright © 2016 krzysiek. All rights reserved.
//

import Foundation
import Alamofire

private enum NetworkingConstants {
    static let Pokemon = "http://www.recipepuppy.com/api/?i=onions,garlic&q=omelet&p=3"
    static let Tomek = "http://192.168.0.17:8080/test/get"
    static let AddPatient = "http://192.168.0.17:8080/test/add"
}

class WebserviceConnector {
    
    class func login(loginVC: LoginViewController) {
        
        let URL = NetworkingConstants.Pokemon
        
        
        
        Alamofire.request(URL)
            .validate()
            .responseJSON {
                (response) in
                
                guard response.result.isSuccess else {
                    print("Login Error \(response.result.error!)")
                    loginVC.loginUnsuccessful()
                    return
                }
                
                print(response.result.value)
                loginVC.loginSuccessful()
        }
    }
    
    class func register(registerVC: RegisterViewController) {
        
        let URL = NetworkingConstants.AddPatient
        
        let parameters: Parameters = [
            "pesel": 91012351,
            "firstName": "Krzysztof",
            "lastName": "Fryzlewicz",
            "gender": "Man",
            "street": "Na Brzegu",
            "city": "Kraków",
            "phone": 515515,
            "email": "ratka6@gmail.com"
        ]
        
        Alamofire.request(URL, method: .put, parameters: parameters, encoding: JSONEncoding.default, headers: nil)
            .validate()
            .responseJSON {
                (response) in
                print(response.response?.statusCode)
                guard response.result.isSuccess else {
                    print("Register Error \(response.result.error!)")
                    return
                }
                
                print(response.result.value)
        }
    }
}
