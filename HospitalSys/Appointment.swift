//
//  Appointment.swift
//  HospitalSys
//
//  Created by krzysiek on 26.11.2016.
//  Copyright © 2016 krzysiek. All rights reserved.
//

import Foundation

class Appointment {
    let date: String
    let doctorsName: String
    
    init(_ date: String, doctorsName: String) {
        self.date = date
        self.doctorsName = doctorsName
    }
}
