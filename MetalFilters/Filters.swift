//
//  Filters.swift
//  MetalFilters
//
//  Created by HKBeast on 24/03/23.
//

import Foundation


let temp = Temperature()
var filters:[ColorAdjustProtocol] = [Temperature(),Luminous(),Exposure(),Gamma(),Brightness(),Saturation(),Contrast(),Sharpness(),Vibrance(),Vignette(),Tint(),Hue(),WhiteBalance(),ZoomBlur(),Pixellete(),HighlightShadow(),LuminousThersold()
                                     ]



// var temperature:ColorAdjustProtocol {
//
//     let temperature:ColorAdjustProtocol
//     temperature.kernalName = "temperature"
//     temperature.value = 0.0
//     temperature.min = -100.0
//     temperature.max = 100.0
//
////    return temperature
// }
//
//var tint:ColorAdjustProtocol {
//
//    let tint:ColorAdjustProtocol
//    tint.kernalName = "tint"
//    tint.value = 0.0
//    tint.min = -100.0
//    tint.max = 100.0
//
//   return tint
//}
//
//var luminance:ColorAdjustProtocol {
//
//    let luminance:ColorAdjustProtocol
//    luminance.kernalName = "luminance"
//    luminance.value = 0.0
//    luminance.min = -100.0
//    luminance.max = 100.0
//
//   return luminance
//}
//ColorAdjustProtocol(name: "Tint", value: 0, min: -180, max: 180),
//ColorAdjustProtocol(name: "Brightness", value: 0, min: -100, max: 100),
//ColorAdjustProtocol(name: "Contrast", value: 0, min: -100, max: 100),
//ColorAdjustProtocol(name: "Saturation", value: 0, min: -100, max: 100),
//ColorAdjustProtocol(name: "Vibrance", value: 0, min: -100, max: 100),
//ColorAdjustProtocol(name: "Sharpness", value: 0, min: 0, max: 100),
//ColorAdjustProtocol(name: "Vignette", value: 0, min: 0, max: 100),
//ColorAdjustProtocol(name: "Pixellate", value: 0, min: 0, max: 100),
//ColorAdjustProtocol(name: "Luminance", value: 0, min: -100, max: 100),
//ColorAdjustProtocol(name: "White Balance", value: 0, min: -100, max: 100),
//ColorAdjustProtocol(name: "Granularity", value: 0, min: 0, max: 100),
//ColorAdjustProtocol(name: "Blurr", value: 0, min: 0, max: 100),
//ColorAdjustProtocol(name: "Gamma", value: 0, min: 0, max: 100),
