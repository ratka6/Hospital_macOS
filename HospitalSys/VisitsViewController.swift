//
//  VisitsViewController.swift
//  HospitalSys
//
//  Created by krzysiek on 25.11.2016.
//  Copyright © 2016 krzysiek. All rights reserved.
//

import Cocoa

class ScheduledVisit {
    let date: String
    let doctorsName: String
    
    init(_ date: String, doctorsName: String) {
        self.date = date
        self.doctorsName = doctorsName
    }
}

class VisitsViewController: NSViewController {
    
    var schedule = [ScheduledVisit("27.09.2016", doctorsName: "dr Lubicz"),
                    ScheduledVisit("28.09.2016", doctorsName: "dr Lubicz"),
                    ScheduledVisit("29.09.2016", doctorsName: "dr Lubicz"),
                    ScheduledVisit("30.09.2016", doctorsName: "dr Lubicz")
                    ]
    
    @IBOutlet weak var deleteButton: NSButton!
    
    @IBAction func deleteButtonClicked(_ sender: Any) {
        let selected = visitsTableView.selectedRow
        if selected != -1 {
            schedule.remove(at: selected)
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
