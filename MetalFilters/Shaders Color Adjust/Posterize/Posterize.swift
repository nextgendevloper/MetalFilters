//
//  Posterize.swift
//  MetalFilters
//
//  Created by HKBeast on 30/03/23.
//

import Foundation

class Posterize:ColorAdjustProtocol{
    var kernalName: String = "posterize"
    
    var value: Float = 2.0
    
    var min: CGFloat = 2.0
    
    var max: CGFloat = 10.0
    
    
}
