//
//  HistoryViewController.swift
//  HospitalSys
//
//  Created by krzysiek on 26.11.2016.
//  Copyright © 2016 krzysiek. All rights reserved.
//

import Cocoa



class HistoryViewController: NSViewController {
    
    var patientCards: [PatientCard]? {
        didSet {
            historyTableView.reloadData()
        }
    }
    
    @IBOutlet weak var historyTableView: NSTableView! {
        didSet {
            historyTableView.delegate = self
            historyTableView.dataSource = self
        }
    }
    
    @IBOutlet weak var detailsTableView: NSTableView! {
        didSet {
            detailsTableView.delegate = self
            detailsTableView.dataSource = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadFakeData()
        // Do view setup here.
    }
    
    fileprivate func loadFakeData() {
        patientCards = [PatientCard]()
        patientCards?.append(PatientCard(date: "10.01.2015", recognition: "Przeziębienie", weight: nil, height: nil, temperature: 38.4, pressure: (120,80), pulse: nil, medicines: "Rutinoscorbin, Aspiryna", doctor: "Lubicz"))
        patientCards?.append(PatientCard(date: "11.04.2015", recognition: "Grypa", weight: nil, height: nil, temperature: 39.0, pressure: nil, pulse: nil, medicines: "Aspiryna", doctor: "Lubicz"))
        patientCards?.append(PatientCard(date: "31.05.2015", recognition: "Angina", weight: 55.0, height: 165, temperature: 37.7, pressure: nil, pulse: 70, medicines: "Antybiotyk, osłona, syrop", doctor: "Lubicz"))
        patientCards?.append(PatientCard(date: "12.06.2016", recognition: "Dałn", weight: 99.0, height: 180, temperature: 36.6, pressure: (120,90), pulse: 80, medicines: "Koks", doctor: "Ania"))
    }
}

extension HistoryViewController: NSTableViewDelegate {
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        if let cards = patientCards {
            var cellID = ""
            var text = ""
            if tableView === historyTableView {
                cellID = "HistoryCellID"
                text = cards[row].admissionDate
            }
            else if tableView === detailsTableView, historyTableView.selectedRow != -1 {
                let item = cards[historyTableView.selectedRow]
                
                if tableColumn == tableView.tableColumns[0] {
                    cellID = "LabelCellID"
                    text = setRowLabelText(row, item: item)
                }
                else if tableColumn == tableView.tableColumns[1] {
                    cellID = "DetailCellID"
                    text = setRowDetailText(row, item: item)
                }
                
            }
            if let cell = tableView.make(withIdentifier: cellID, owner: nil) as? NSTableCellView {
                cell.textField?.stringValue = text
                return cell
            }
        }
        return nil
    }
    
    func setRowDetailText(_ row: Int, item: PatientCard) -> String {
        var text = ""
        switch row {
        case 0:
            text = item.admissionDate
        case 1:
            text = item.recognition
        case 2:
            text = item.doctor
        case 3:
            if item.weight != nil {
                text = "\(item.weight!)"
            }
            else {
                text = "-"
            }
        case 4:
            if item.height != nil {
                text = "\(item.height!)"
            }
            else {
                text = "-"
            }
        case 5:
            if item.temperature != nil {
                text = "\(item.temperature!)"
            }
            else {
                text = "-"
            }
        case 6:
            if item.pressure != nil {
                text = "\(item.pressure!.0)/\(item.pressure!.1)"
            }
            else {
                text = "-"
            }
        case 7:
            if item.pulse != nil {
                text = "\(item.pulse!)"
            }
            else {
                text = "-"
            }
        case 8:
            if item.medicines != nil {
                text = item.medicines!
            }
            else {
                text = "-"
            }
        default:
            break
        }
        return text
        
    }
    
    func setRowLabelText(_ row: Int, item: PatientCard) -> String {
        var text = ""
        switch row {
        case 0:
            text = "Data"
        case 1:
            text = "Rozpoznanie"
        case 2:
            text = "Lekarz"
        case 3:
            text = "Waga[kg]"
        case 4:
            text = "Wzrost[cm]"
        case 5:
            text = "Temperatura[◦C]"
        case 6:
            text = "Ciśnienie"
        case 7:
            text = "Tętno"
        case 8:
            text = "Leki"
        default:
            break
        }
        return text
    }
    
}

extension HistoryViewController: NSTableViewDataSource {
    func numberOfRows(in tableView: NSTableView) -> Int {
        if tableView === historyTableView {
            if let cards = patientCards {
                return cards.count
            }
        }
        else if tableView === detailsTableView {
            if historyTableView.selectedRow != -1, let _ = patientCards {
                return 9
            }
        }
        return 0
    }
    
    func tableViewSelectionDidChange(_ notification: Notification) {
        if let obj = notification.object as? NSTableView, obj === historyTableView {
            detailsTableView.reloadData()
        }
    }
}
