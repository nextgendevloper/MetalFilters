//
//  Posterize.swift
//  MetalFilters
//
//  Created by HKBeast on 30/03/23.
//

import Foundation

class Posterize:ColorAdjustProtocol{
    var kernalName: String = "posterize"
    
    var value: Float = 0.0
    
    var min: CGFloat = 0.9
    
    var max: CGFloat = 1.0
    
    
}