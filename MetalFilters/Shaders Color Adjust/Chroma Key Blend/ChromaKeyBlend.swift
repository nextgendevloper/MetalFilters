//
//  ChromaKeyBlend.swift
//  MetalFilters
//
//  Created by HKBeast on 03/04/23.
//

import Foundation
import Metal
import simd

class ChromaKeyBlend:ColorAdjustProtocol,SpecialColorAdjust{
    var kernalName: String = "chromaKeyBlend"
    
    var value: [Float] = [0.0,0.1]
    
    var min: CGFloat = -1.0
    
    var max: CGFloat = 1.0
    
    func setupSpecialParameters(encoder: MTLComputeCommandEncoder, index: Int) {
        var inputColor = float3(0.0,1.0,0.0)
        encoder.setBytes(&inputColor, length:  MemoryLayout<float3>.size, index: index)
    }
    
    
}
