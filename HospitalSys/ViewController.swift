//
//  ViewController.swift
//  HospitalSys
//
//  Created by krzysiek on 23.11.2016.
//  Copyright © 2016 krzysiek. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    @IBOutlet weak var containerView: NSView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Do any additional setup after loading the view.
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    
    override func prepare(for segue: NSStoryboardSegue, sender: Any?) {
        if segue.identifier == "embeded" {
            if let destinationVC = segue.destinationController as? FirstVC {
                print("****")
                destinationVC.containerView = self.containerView
            }
        }
    }

    

}

