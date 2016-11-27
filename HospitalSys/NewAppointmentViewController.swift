//
//  NewAppointmentViewController.swift
//  HospitalSys
//
//  Created by krzysiek on 25.11.2016.
//  Copyright © 2016 krzysiek. All rights reserved.
//

import Cocoa



protocol NewAppointmentViewControllerDelegate: class {
    func didMakeNewAppointment(_ doctorsName: String, date: String)
}

class NewAppointmentViewController: NSViewController {
    
    weak var delegate: NewAppointmentViewControllerDelegate?
    
    var login: Int64?
    
    fileprivate var appointment: Appointment?
    
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
    
    fileprivate var selectedMonth: Int?
    
    var specializations: [String]? {
        didSet {
            specializationComboBox.reloadData()
        }
    }
    var doctors: [Doctor]?
    
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
    
    var months = [1,2,3,4,5,6,7,8,9,10,11,12]
    var days = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31]
    var years = ["2016", "2017", "2018"]
    
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
    
    @IBOutlet weak var makeAppointmentButton: NSButton!
    @IBOutlet weak var cancelButton: NSButton!
    @IBOutlet weak var progressIndicator: NSProgressIndicator!
    @IBOutlet weak var infoLabel: NSTextField!
    
    @IBAction func makeAppointmentButtonClicked(_ sender: Any) {
        makeAppointment()
        cancelButtonClicked(self)
    }
    
    
    @IBAction func cancelButtonClicked(_ sender: Any) {
        self.presenting?.view.alphaValue = 1.0
        dismiss(self)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        infoLabel.stringValue = ""
        progressIndicator.isHidden = true
        getData()
        setup()
        // Do view setup here.
    }
    
    fileprivate func getData() {
        WebserviceConnector.getDoctors(newAppointmentVC: self)
    }
    
    func didUpdateData(succesfully: Bool) {
        if succesfully {
            specializationComboBox.reloadData()
            doctorsNameComboBox.reloadData()
        }
        else {
            showConnectionAlert(method: "getData")
        }
    }
    
    fileprivate func setup() {
        //        specializations = [
        //            "Pediatra",
        //            "Internista",
        //            "Laryngolog",
        //            "Urolog"
        //        ]
        //
        //        let names = [
        //            "Lubicz",
        //            "Iwanowicz",
        //            "Góra",
        //            "Fryźlewicz",
        //            "Who"
        //        ]
        //
        //        specializationComboBox.reloadData()
        //        var index: Int
        //        doctors = [Doctor]()
        //        for j in 0..<specializations!.count {
        //            for i in 0...5 {
        //                index = Int(arc4random()) % names.count
        //                doctors?.append(Doctor("\(names[index])\(i)", specialization: specializations![j]))
        //            }
        //        }
        hours = [String]()
        for hour in 9...16 {
            hours?.append("\(hour).00")
            hours?.append("\(hour).30")
        }
        
        hourComboBox.reloadData()
        
    }
    
    func didMakeAppointment(successfully: Bool, reserved: Bool = false) {
        if successfully {
            if reserved {
                infoLabel.stringValue = "Termin zarezerwowany!"
            }
            else {
                if let app = appointment {
                    delegate?.didMakeNewAppointment(app.doctorsName, date: app.date)
                }
            }
        }
        else {
            showConnectionAlert(method: "makeAppointment")
        }
        hideProgressIndicator()
    }
    
    
    
    fileprivate func makeAppointment() {
        var doctorsName = ""
        var date = ""
        if doctorsNameComboBox.indexOfSelectedItem != -1 {
            if let matching = matchingDoctors {
                doctorsName = matching[doctorsNameComboBox.indexOfSelectedItem].name
            }
        }
        if dayComboBox.indexOfSelectedItem != -1 {
            date += "\(days[dayComboBox.indexOfSelectedItem])"
            date += "."
        }
        if monthComboBox.indexOfSelectedItem != -1 {
            date += "\(months[monthComboBox.indexOfSelectedItem])"
            date += "."
        }
        if yearComboBox.indexOfSelectedItem != -1 {
            date += years[yearComboBox.indexOfSelectedItem]
            date += " "
        }
        if hourComboBox.indexOfSelectedItem != -1 {
            date += "\(hours![hourComboBox.indexOfSelectedItem])"
        }
        appointment = Appointment(date, doctorsName: doctorsName)
        if let app = appointment, let login = login {
            WebserviceConnector.makeNewAppointment(newAppointmentVC: self, appointment: app, login: login)
            showProgressIndicator()
        }
        
    }
    
    fileprivate func showConnectionAlert(method: String) {
        let alert = NSAlert()
        alert.messageText = "Błąd w połączeniu z serwerem"
        alert.informativeText = "Sprawdz połączenie z internetem i kliknij OK"
        alert.alertStyle = .warning
        alert.addButton(withTitle: "OK")
        let response = alert.runModal()
        if response == NSAlertFirstButtonReturn {
            if method == "makeAppointment" {
                makeAppointment()
            }
            else if method == "getData" {
                getData()
            }
        }
    }
    
    fileprivate func showProgressIndicator() {
        progressIndicator.isHidden = false
        progressIndicator.startAnimation(self)
        makeAppointmentButton.isEnabled = false
        cancelButton.isEnabled = false
    }
    
    fileprivate func hideProgressIndicator() {
        progressIndicator.isHidden = true
        progressIndicator.stopAnimation(self)
        makeAppointmentButton.isEnabled = true
        cancelButton.isEnabled = true
    }
    
}

extension NewAppointmentViewController: NSComboBoxDataSource {
    func numberOfItems(in comboBox: NSComboBox) -> Int {
        if comboBox === specializationComboBox {
            if let specs = specializations {
                return specs.count
            }
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
        return 0
    }
    
    func comboBox(_ comboBox: NSComboBox, objectValueForItemAt index: Int) -> Any? {
        switch comboBox {
        case specializationComboBox:
            if let specs = specializations {
                return specs[index]
            }
        case doctorsNameComboBox:
            if let docs = matchingDoctors {
                return docs[index].name
            }
            else {
                return "-"
            }
        case yearComboBox:
            return years[index]
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
        return "-"
    }
    
    
    
}

extension NewAppointmentViewController: NSComboBoxDelegate {
    func comboBoxSelectionDidChange(_ notification: Notification) {
        if let obj = notification.object as? NSComboBox, obj === specializationComboBox {
            print("yes!")
            let i = specializationComboBox.indexOfSelectedItem
            if i != -1 {
                if let specs = specializations {
                    selectedSpecialization = specs[i]
                }
                let j = doctorsNameComboBox.indexOfSelectedItem
                if j != -1 {
                    doctorsNameComboBox.deselectItem(at: j)
                }
            }
        }
    }
}
