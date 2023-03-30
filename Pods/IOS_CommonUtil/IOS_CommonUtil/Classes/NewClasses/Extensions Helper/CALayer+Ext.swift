//
//  CALayer+Ext.swift
//  IOS_CommonUtil
//
//  Created by Developer on 7/15/21.
//

import Foundation
extension CALayer {
    
   @objc public func colorOfPoint(point:CGPoint) -> CGColor {
        
        var pixel: [CUnsignedChar] = [0, 0, 0, 0]
        
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.premultipliedLast.rawValue)
        
        let context = CGContext(data: &pixel, width: 1, height: 1, bitsPerComponent: 8, bytesPerRow: 4, space: colorSpace, bitmapInfo: bitmapInfo.rawValue)
        
        context!.translateBy(x: -point.x, y: -point.y)
        
        self.render(in: context!)
        
        let red: CGFloat   = CGFloat(pixel[0]) / 255.0
        let green: CGFloat = CGFloat(pixel[1]) / 255.0
        let blue: CGFloat  = CGFloat(pixel[2]) / 255.0
        let alpha: CGFloat = CGFloat(pixel[3]) / 255.0
        
        let color = UIColor(red:red, green: green, blue:blue, alpha:alpha)
        
        return color.cgColor
    }
    
    public func addDropShadow() {
        
        self.shadowColor    = UIColor.black.cgColor
        self.shadowOpacity  = 0.4
        self.shadowRadius   = 5
        self.shadowOffset   = CGSize(width: 0, height: 0)
    }
    
}
