//
//  VisitsViewController.swift
//  HospitalSys
//
//  Created by krzysiek on 25.11.2016.
//  Copyright © 2016 krzysiek. All rights reserved.
//

import Cocoa

class VisitsViewController: NSViewController {
    
    @IBOutlet weak var visitsTableView: NSTableView! {
        didSet {
            visitsTableView.delegate = self
            visitsTableView.dataSource = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
}

extension VisitsViewController: NSTableViewDelegate {
    
}

extension VisitsViewController: NSTableViewDataSource {
    
}
