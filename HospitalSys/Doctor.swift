//
//  Doctor.swift
//  HospitalSys
//
//  Created by krzysiek on 26.11.2016.
//  Copyright © 2016 krzysiek. All rights reserved.
//

import Foundation

class Doctor: NSCopying {
    let name: String
    let specialization: String
    
    init(_ name: String, specialization: String) {
        self.name = name
        self.specialization = specialization
    }
    
    func copy(with zone: NSZone? = nil) -> Any {
        let doctor = Doctor(self.name, specialization: self.specialization)
        return doctor
    }
    
}
