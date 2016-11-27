//
//  VisitsViewController.swift
//  HospitalSys
//
//  Created by krzysiek on 25.11.2016.
//  Copyright © 2016 krzysiek. All rights reserved.
//

import Cocoa

class VisitsViewController: NSViewController {
    
    var schedule = [Appointment("27.09.2016 9.00", doctorsName: "dr Lubicz"),
                    Appointment("28.09.2016 9.30", doctorsName: "dr Lubicz"),
                    Appointment("29.09.2016 11.00", doctorsName: "dr Lubicz"),
                    Appointment("30.09.2016 14.30", doctorsName: "dr Lubicz")
    ]
    
    fileprivate var login: Int64?
    fileprivate var rowToDelete: Int?
    
    @IBOutlet weak var deleteButton: NSButton!
    @IBOutlet weak var makeAppointmentButton: NSButton!
    
    @IBAction func deleteButtonClicked(_ sender: Any) {
        let selected = visitsTableView.selectedRow
        if selected != -1 {
            showDeleteAlert(selected)
        }
    }
    
    
    @IBAction func makeAppointmentButtonClicked(_ sender: Any) {
        let storyboard = NSStoryboard(name: "Main", bundle: nil)
        let appointmentVC = storyboard.instantiateController(withIdentifier: "MakeAppointmentVC") as! NewAppointmentViewController
        self.view.alphaValue = 0.2
        appointmentVC.delegate = self
        appointmentVC.login = self.login
        self.presentViewControllerAsSheet(appointmentVC)
    }
    
    fileprivate func showDeleteAlert(_ rowToDelete: Int) {
        let alert = NSAlert()
        alert.messageText = "Czy na pewno chcesz anulować wizytę?"
        alert.informativeText = "Operacja jest nieodwracalna. W przypadku pomyłki należy zarezerwować ponownie - dostępność terminów nie jest gwarantowana!"
        alert.alertStyle = .warning
        alert.addButton(withTitle: "Tak")
        alert.addButton(withTitle: "Nie")
        
        let response = alert.runModal()
        if response == NSAlertFirstButtonReturn {
            deleteAppointment(rowToDelete)
        }
    }
    
    
    @IBOutlet weak var visitsTableView: NSTableView! {
        didSet {
            visitsTableView.delegate = self
            visitsTableView.dataSource = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLogin()
        getAppointments()
        // Do view setup here.
    }
    
    fileprivate func setupLogin() {
        let appDelegate = NSApplication.shared().delegate as! AppDelegate
        if let login = appDelegate.loggedUser {
            self.login = login
        }
    }
    
    fileprivate func getAppointments() {
        if let login = login {
            WebserviceConnector.getAppointments(visitsVC: self, login: login)
        }
    }
    
    func didGetAppointments(successfully: Bool) {
        if successfully {
            visitsTableView.reloadData()
        }
        else {
            showConnectionAlert(method: "getAppointments")
        }
        
    }
    
    fileprivate func deleteAppointment(_ rowToDelete: Int) {
        self.rowToDelete = rowToDelete
        let appointment = schedule[rowToDelete]
        if let login = login {
            WebserviceConnector.deleteAppointment(visitsVC: self, appointment: appointment, login: login)
        }
        deleteButton.isEnabled = false
        makeAppointmentButton.isEnabled = false
    }
    
    func didDeleteAppointment(successfully: Bool) {
        if successfully {
            if let row = rowToDelete {
                schedule.remove(at: row)
                rowToDelete = nil
                visitsTableView.reloadData()
            }
        }
        else {
            showConnectionAlert(method: "deleteAppointment")
        }
        deleteButton.isEnabled = true
        makeAppointmentButton.isEnabled = true
    }
    
    fileprivate func showConnectionAlert(method: String) {
        let alert = NSAlert()
        alert.messageText = "Błąd w połączeniu z serwerem"
        alert.informativeText = "Sprawdz połączenie z internetem i kliknij OK"
        alert.alertStyle = .warning
        alert.addButton(withTitle: "OK")
        let response = alert.runModal()
        if response == NSAlertFirstButtonReturn {
            if method == "getAppointments" {
                getAppointments()
            }
            else if method == "deleteAppointment"{
                if let row = rowToDelete {
                    deleteAppointment(row)
                }
            }
        }
    }
    
}

extension VisitsViewController: NSTableViewDelegate {
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        
        var text = ""
        var cellIdentifier = ""
        
        let item = schedule[row]
        
        if tableColumn == tableView.tableColumns[0] {
            text = item.date
            cellIdentifier = "DateCellID"
        }
        else if tableColumn == tableView.tableColumns[1] {
            text = item.doctorsName
            cellIdentifier = "NameCellID"
        }
        
        if let cell = tableView.make(withIdentifier: cellIdentifier, owner: nil) as? NSTableCellView {
            cell.textField?.stringValue = text
            return cell
        }
        return nil
    }
}

extension VisitsViewController: NSTableViewDataSource {
    func numberOfRows(in tableView: NSTableView) -> Int {
        return schedule.count
    }
    
}

extension VisitsViewController: NewAppointmentViewControllerDelegate {
    func didMakeNewAppointment(_ doctorsName: String, date: String) {
        schedule.append(Appointment(date, doctorsName: doctorsName))
        visitsTableView.reloadData()
    }
}
