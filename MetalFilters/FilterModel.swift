//
//  Filters.swift
//  MetalFilters
//
//  Created by HKBeast on 24/03/23.
//

import Foundation
import Metal

protocol ColorAdjustProtocol {
    var kernalName:String { get set }
    var value:[Float] { get set }
    var min:CGFloat { get set }
    var max:CGFloat { get set }

}
protocol SpecialColorAdjust{
    func setupSpecialParameters(encoder:MTLComputeCommandEncoder , index:Int)
}
