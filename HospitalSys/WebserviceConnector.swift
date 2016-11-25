//
//  WebserviceConnector.swift
//  HospitalSys
//
//  Created by krzysiek on 25.11.2016.
//  Copyright © 2016 krzysiek. All rights reserved.
//

import Foundation
import Alamofire

class WebserviceConnector {
    
    class func login() {
        
        let URL = NSURL()
        
        Alamofire.request(URL as! URLRequestConvertible)
            .validate()
            .responseJSON {
                (response) in
                
                guard response.result.isSuccess else {
                    print("Login Error \(response.result.error!)")
                    return
                }
        }
    }
}
