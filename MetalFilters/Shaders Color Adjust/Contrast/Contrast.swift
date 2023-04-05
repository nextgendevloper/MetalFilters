//
//  Conytrast.swift
//  MetalFilters
//
//  Created by HKBeast on 29/03/23.
//


import Foundation

class Contrast:ColorAdjustProtocol{
    var kernalName: String = "contrast"
    
    var value: [Float] = [1.0]
    
    var min: CGFloat = 0.5
    
    var max: CGFloat = 2.0
    
    
}
