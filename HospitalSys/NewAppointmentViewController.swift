//
//  NewAppointmentViewController.swift
//  HospitalSys
//
//  Created by krzysiek on 25.11.2016.
//  Copyright © 2016 krzysiek. All rights reserved.
//

import Cocoa

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

class NewAppointmentViewController: NSViewController {
    
    fileprivate var selectedSpecialization: String? {
        didSet {
            matchingDoctors = doctors?.filter({$0.specialization == selectedSpecialization})
            doctorsNameComboBox.isEnabled = true
            yearComboBox.isEnabled = true
            monthComboBox.isEnabled = true
            dayComboBox.isEnabled = true
            hourComboBox.isEnabled = true
            
        }
    }
    
    fileprivate var index: Int? {
        didSet {
            selectedSpecialization = specialities[index!]
        }
    }
    
    fileprivate var selectedName: String?
    fileprivate var selectedYear: String?
    fileprivate var selectedMonth: String?
    fileprivate var selectedDay: String?
    fileprivate var selectedHour: String?
    
    var specialities = [
        "Pediatra",
        "Internista",
        "Laryngolog",
        "Urolog"
    ]
    
    var names = [
        "Lubicz",
        "Iwanowicz",
        "Góra",
        "Fryźlewicz",
        "Who"
    ]
    
    
    var matchingDoctors: [Doctor]? {
        didSet {
            doctorsNameComboBox.reloadData()
        }
    }
    
    var hours: [String]? {
        didSet {
            hourComboBox.reloadData()
        }
    }
    
    var doctors: [Doctor]?
    
    var months = [1,2,3,4,5,6,7,8,9,10,11,12]
    var days = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31]
    
    @IBOutlet weak var specializationComboBox: NSComboBox! {
        didSet {
            specializationComboBox.dataSource = self
            specializationComboBox.delegate = self
        }
    }
    @IBOutlet weak var doctorsNameComboBox: NSComboBox! {
        didSet {
            doctorsNameComboBox.dataSource = self
            doctorsNameComboBox.delegate = self
            doctorsNameComboBox.isEnabled = false
        }
    }
    
    @IBOutlet weak var yearComboBox: NSComboBox! {
        didSet {
            yearComboBox.dataSource = self
            yearComboBox.delegate = self
            yearComboBox.isEnabled = false
        }
    }
    
    @IBOutlet weak var monthComboBox: NSComboBox! {
        didSet {
            monthComboBox.dataSource = self
            monthComboBox.delegate = self
            monthComboBox.isEnabled = false
        }
    }
    
    @IBOutlet weak var dayComboBox: NSComboBox! {
        didSet {
            dayComboBox.dataSource = self
            dayComboBox.delegate = self
            dayComboBox.isEnabled = false
        }
    }
    
    @IBOutlet weak var hourComboBox: NSComboBox! {
        didSet {
            hourComboBox.dataSource = self
            hourComboBox.delegate = self
            hourComboBox.isEnabled = false
        }
    }
    
    
    @IBOutlet weak var progressIndicator: NSProgressIndicator!
    @IBOutlet weak var infoLabel: NSTextField!
    
    @IBAction func makeAppointmentButtonClicked(_ sender: Any) {
        dismiss(self)
    }
    
    
    @IBAction func cancelButtonClicked(_ sender: Any) {
        dismiss(self)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        if let doctors = doctors {
            for doctor in doctors {
                print(doctor.name, doctor.specialization)
            }
        }
        // Do view setup here.
    }
    
    fileprivate func setup() {
        var index: Int
        doctors = [Doctor]()
        for j in 0..<specialities.count {
            for i in 0...5 {
                index = Int(arc4random()) % names.count
                doctors?.append(Doctor("\(names[index])\(i)", specialization: specialities[j]))
            }
        }
        hours = [String]()
        for hour in 9...16 {
            hours?.append("\(hour).00")
            hours?.append("\(hour).30")
        }
        
        hourComboBox.reloadData()
        
    }
    
}

extension NewAppointmentViewController: NSComboBoxDataSource {
    func numberOfItems(in comboBox: NSComboBox) -> Int {
        if comboBox === specializationComboBox {
            return specialities.count
        }
        else if comboBox === doctorsNameComboBox {
            if let docs = matchingDoctors {
                return docs.count
            }
            else {
                return 0
            }
        }
        else if comboBox === yearComboBox {
            return 3
        }
        else if comboBox === monthComboBox {
            return months.count
        }
        else if comboBox === dayComboBox {
            return days.count
        }
        else if comboBox === hourComboBox {
            return hours?.count ?? 0
        }
        else {
            return 0
        }
    }
    
    func comboBox(_ comboBox: NSComboBox, objectValueForItemAt index: Int) -> Any? {
        switch comboBox {
        case specializationComboBox:
            return specialities[index]
        case doctorsNameComboBox:
            if let docs = matchingDoctors {
                return docs[index].name
            }
            else {
                return "-"
            }
        case yearComboBox:
            switch index {
            case 0:
                return "2016"
            case 1:
                return "2017"
            case 2:
                return "2018"
            default:
                return "-"
            }
        case monthComboBox:
            return months[index]
        case dayComboBox:
            return days[index]
        case hourComboBox:
            if let h = hours {
                return h[index]
            }
            else {
                return "-"
            }
        default:
            return "-"
        }
    }
    
    
    
}

extension NewAppointmentViewController: NSComboBoxDelegate {
    func comboBoxSelectionDidChange(_ notification: Notification) {
        if let obj = notification.object as? NSComboBox, obj === specializationComboBox {
            print("yes!")
            let i = specializationComboBox.indexOfSelectedItem
            if i != -1 {
                selectedSpecialization = specialities[i]
                let j = doctorsNameComboBox.indexOfSelectedItem
                if j != -1 {
                    doctorsNameComboBox.deselectItem(at: j)
                }
            }
        }
    }
}
