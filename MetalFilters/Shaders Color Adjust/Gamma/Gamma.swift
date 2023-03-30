//
//  Gamma.swift
//  MetalFilters
//
//  Created by HKBeast on 29/03/23.
//

import Foundation

class Gamma:ColorAdjustProtocol{
    var kernalName: String = "gamma"
    
    var value: Float = 0.5
    
    var min: CGFloat = 0.5
    
    var max: CGFloat = 2.0
    
    
}
