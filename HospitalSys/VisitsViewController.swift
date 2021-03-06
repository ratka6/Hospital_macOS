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
    
    @IBOutlet weak var deleteButton: NSButton!
    
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
            schedule.remove(at: rowToDelete)
            visitsTableView.reloadData()
            
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
        for date in schedule {
            print(date.date, date.doctorsName)
        }
        // Do view setup here.
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
