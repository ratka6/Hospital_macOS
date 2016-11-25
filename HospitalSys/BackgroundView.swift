//
//  BackgroundView.swift
//  HospitalSys
//
//  Created by krzysiek on 25.11.2016.
//  Copyright © 2016 krzysiek. All rights reserved.
//

import Cocoa

class BackgroundView: NSView {

    override func draw(_ dirtyRect: NSRect) {
        
        let backgroundColor = NSColor(patternImage: #imageLiteral(resourceName: "background"))
        backgroundColor.setFill()
        NSRectFill(dirtyRect)
        
        super.draw(dirtyRect)
        // Drawing code here.
    }
    
}
