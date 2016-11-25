//
//  NewAppointmentViewController.swift
//  HospitalSys
//
//  Created by krzysiek on 25.11.2016.
//  Copyright © 2016 krzysiek. All rights reserved.
//

import Cocoa

class NewAppointmentViewController: NSViewController {
    
    @IBOutlet weak var specialtyComboBox: NSComboBox!
    @IBOutlet weak var doctorsNameComboBox: NSComboBox!
    @IBOutlet weak var datePicker: NSDatePicker!
    
    @IBAction func makeAppointmentButtonClicked(_ sender: Any) {
        dismiss(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
}
