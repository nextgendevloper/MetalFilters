//
//  LuminousThersold.swift
//  MetalFilters
//
//  Created by HKBeast on 29/03/23.
//

import Foundation

class LuminousThersold:ColorAdjustProtocol{
    var kernalName: String = "luminousThersold"
    
    var value: Float = 0.01
    
    var min: CGFloat = 0.01
    
    var max: CGFloat = 1.0
    
    
}
