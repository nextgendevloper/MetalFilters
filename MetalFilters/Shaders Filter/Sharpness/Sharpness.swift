//
//  Sharpness.swift
//  MetalFilters
//
//  Created by HKBeast on 29/03/23.
//

import Foundation

class Sharpness:ColorAdjustProtocol{
    var kernalName: String = "sharpness"
    
    var value: Float = 0.0
    
    var min: CGFloat = -1.0
    
    var max: CGFloat = 1.0
    
    
}
