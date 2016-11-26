//
//  PatientCard.swift
//  HospitalSys
//
//  Created by krzysiek on 26.11.2016.
//  Copyright © 2016 krzysiek. All rights reserved.
//

import Foundation

class PatientCard {
    let admissionDate: String
    let recognition: String
    let weight: Double?
    let height: Int?
    let temperature: Double?
    let pressure: (Int, Int)?
    let pulse: Int?
    let medicines: String?
    let doctor: String
    
    init(date: String, recognition: String, weight: Double?, height: Int?, temperature: Double?, pressure: (systolic: Int, diastolic: Int)?, pulse: Int?, medicines: String?, doctor: String) {
        self.admissionDate = date
        self.recognition = recognition
        self.weight = weight
        self.height = height
        self.temperature = temperature
        self.pressure = pressure
        self.pulse = pulse
        self.medicines = medicines
        self.doctor = doctor
    }
}
