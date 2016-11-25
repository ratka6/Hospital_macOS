//
//  ContainerViewController.swift
//  HospitalSys
//
//  Created by krzysiek on 24.11.2016.
//  Copyright © 2016 krzysiek. All rights reserved.
//

import Cocoa

class ContainerViewController: NSViewController {

    @IBOutlet weak var containerView: NSView!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
    override func prepare(for segue: NSStoryboardSegue, sender: Any?) {
        if let destinationVC = segue.destinationController as? NSTabViewController {
            if let vc = destinationVC.tabViewItems.first?.viewController as? LoginViewController {
                vc.containerVC = self
            }
        }
    }
    
    func loginSuccessful() {
        let storyboard = NSStoryboard(name: "Main", bundle: nil)
        let mainVC = storyboard.instantiateController(withIdentifier: "MainTab") as! NSTabViewController
        
        self.childViewControllers.removeAll()
        containerView.subviews.removeAll()
        self.addChildViewController(mainVC)
        containerView.addSubview(mainVC.view)
    }

}
