//
//  Vignette.swift
//  MetalFilters
//
//  Created by HKBeast on 29/03/23.
//

import Foundation

class Vignette:ColorAdjustProtocol{
    var kernalName: String = "vignette"
    
    var value: Float = 0.3
    
    var min: CGFloat = 0.3
    
    var max: CGFloat = 1.0
    
    
}
