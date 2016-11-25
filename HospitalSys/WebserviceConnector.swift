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
    static let Pokemon = "http://pokeapi.co/api/v2/pokemon/1/"
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
                
                print("bulbasaur")
                loginVC.loginSuccessful()
        }
    }
}
