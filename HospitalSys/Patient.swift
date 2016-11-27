//
//  Patient.swift
//  HospitalSys
//
//  Created by krzysiek on 27.11.2016.
//  Copyright © 2016 krzysiek. All rights reserved.
//

import Foundation

class Patient {
    
    let pesel: Int64
    let firstName: String
    let lastName: String
    let gender: String
    let street: String
    let city: String
    let phone: Int64
    let email: String
    
    init(pesel: Int64, firstName: String, lastName: String, gender: String, street: String, city: String, phone: Int64, email: String) {
        self.pesel = pesel
        self.firstName = firstName
        self.lastName = lastName
        self.gender = gender
        self.street = street
        self.city = city
        self.phone = phone
        self.email = email
    }
    
    func getParameters() -> [String: Any] {
        return [
            "pesel": self.pesel,
            "firstName": self.firstName,
            "lastName": self.lastName,
            "gender": self.gender,
            "street": self.street,
            "city": self.city,
            "phone": self.phone,
            "email": self.email
        ]
    }
    
}
