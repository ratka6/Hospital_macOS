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
    @IBOutlet weak var datePicker: NMDatePicker!
    
    @IBAction func makeAppointmentButtonClicked(_ sender: Any) {
        dismiss(self)
    }
    
    @IBAction func cancelButtonClicked(_ sender: Any) {
        dismiss(self)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDatePicker()
        // Do view setup here.
    }
    
    fileprivate func setupDatePicker() {
        datePicker.dateValue = Date()
        datePicker.delegate = self
        datePicker.backgroundColor = NSColor.white
        datePicker.titleFont = NSFont.boldSystemFont(ofSize: 14.0)
        datePicker.textColor = NSColor.black
        datePicker.todayTextColor = NSColor.blue
        datePicker.selectedTextColor = NSColor.white
        datePicker.todayBackgroundColor = NSColor.blue
        datePicker.todayBorderColor = NSColor.blue
        datePicker.highlightedBackgroundColor = NSColor.lightGray
        datePicker.highlightedBorderColor = NSColor.darkGray
        datePicker.selectedBackgroundColor = NSColor.orange
        datePicker.selectedBorderColor = NSColor.blue
    }
    
}

extension NewAppointmentViewController: NMDatePickerDelegate {
    func nmDatePicker(_ datePicker: NMDatePicker, selectedDate: Date) {
        
    }
}
