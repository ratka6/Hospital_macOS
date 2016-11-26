//
//  HistoryViewController.swift
//  HospitalSys
//
//  Created by krzysiek on 26.11.2016.
//  Copyright © 2016 krzysiek. All rights reserved.
//

import Cocoa



class HistoryViewController: NSViewController {

    @IBOutlet weak var historyTableView: NSTableView! {
        didSet {
            historyTableView.delegate = self
            historyTableView.dataSource = self
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
}

extension HistoryViewController: NSTableViewDelegate {
    
}

extension HistoryViewController: NSTableViewDataSource {
    
}
