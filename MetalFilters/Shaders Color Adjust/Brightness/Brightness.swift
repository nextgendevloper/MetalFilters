//
//  Luminous.swift
//  MetalFilters
//
//  Created by HKBeast on 29/03/23.
//

import Foundation

class Brightness:ColorAdjustProtocol{
    var kernalName: String = "brightness"
    
    var value: [Float] = [0.0]
    
    var min: CGFloat = -100.0
    
    var max: CGFloat = 100.0
    
    
}
