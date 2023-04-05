//
//  Exposure.swift
//  MetalFilters
//
//  Created by HKBeast on 29/03/23.
//

import Foundation

class Exposure:ColorAdjustProtocol{
    var kernalName: String = "exposure"
    
    var value: [Float] = [-4.0]
    
    var min: CGFloat = -4.0
    
    var max: CGFloat = -1.0
    
    
}
