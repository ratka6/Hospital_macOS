//
//  FirstVC.swift
//  HospitalSys
//
//  Created by krzysiek on 24.11.2016.
//  Copyright © 2016 krzysiek. All rights reserved.
//

import Cocoa

class FirstVC: NSViewController {
    
    weak var containerView: NSView?

    @IBAction func buttonTapped(_ sender: Any) {
        let storyboard = NSStoryboard(name: "Main", bundle: nil)
        let secondVC = storyboard.instantiateController(withIdentifier: "SecondVC") as! SecondVC
        
        containerView?.subviews.first?.removeFromSuperview()
        containerView?.addSubview(secondVC.view)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
    deinit {
        print("firstVC deinit")
    }
    
}
