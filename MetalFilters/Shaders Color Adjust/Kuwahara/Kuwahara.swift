//
//  Kuwahara.swift
//  MetalFilters
//
//  Created by HKBeast on 30/03/23.
//

import Foundation

class Kuwahara:ColorAdjustProtocol{
    var kernalName: String = "kuwahara"
    
    var value: Float = 0.0
    
    var min: CGFloat = 0.0
    
    var max: CGFloat = 10.0
    
    
}
