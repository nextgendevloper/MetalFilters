//
//  UIColor+Ext.swift
//  IOS_CommonUtil
//
//  Created by Developer on 6/15/21.
//

import Foundation

extension UIColor {
    public var r: CGFloat{ return CIColor(color: self).red }
    public var g: CGFloat{ return CIColor(color: self).green }
    public var b: CGFloat{ return CIColor(color: self).blue }
    public var a: CGFloat{ return CIColor(color: self).alpha }
    /**
     creates lighter shade of current UIColor. Range is 0.0 - 1.0,Default is 0.1
     */
   public func lighter(componentDelta: CGFloat = 0.1) -> UIColor {
           return makeColor(componentDelta: componentDelta)
       }
    /**
     
     creates Darker shade of current UIColor. Range is 0.0 - 1.0,Default is 0.1
     */
    public func darker(componentDelta: CGFloat = 0.1) -> UIColor {
           return makeColor(componentDelta: -1*componentDelta)
       }
    
    
    // add delta to component rgba and create new shade.
    private func makeColor(componentDelta: CGFloat) -> UIColor {
            var red: CGFloat = 0
            var blue: CGFloat = 0
            var green: CGFloat = 0
            var alpha: CGFloat = 0
            
            // Extract r,g,b,a components from the
            // current UIColor
            getRed( &red, green: &green,blue: &blue,alpha: &alpha)
            
            // Create a new UIColor modifying each component
            // by componentDelta, making the new UIColor either
            // lighter or darker.
            return UIColor(  red:  add(componentDelta, toComponent: red),
                             green: add(componentDelta, toComponent: green),
                             blue: add(componentDelta, toComponent: blue),
                             alpha: alpha
                            )
        }
    
    // Add value to component ensuring the result is
    // between 0 and 1
    private func add(_ value: CGFloat, toComponent: CGFloat) -> CGFloat {
        return max(0, min(1, toComponent + value))
    }
    
    static public func random () -> UIColor {
        return UIColor(
            red: CGFloat.random(in: 0...1),
            green: CGFloat.random(in: 0...1),
            blue: CGFloat.random(in: 0...1),
            alpha: 1.0)
    }
    
    
   public func rgb() -> (red:Int, green:Int, blue:Int, alpha:Int)? {
        var fRed : CGFloat = 0
        var fGreen : CGFloat = 0
        var fBlue : CGFloat = 0
        var fAlpha: CGFloat = 0
        if self.getRed(&fRed, green: &fGreen, blue: &fBlue, alpha: &fAlpha) {
            let iRed = Int(fRed * 255.0)
            let iGreen = Int(fGreen * 255.0)
            let iBlue = Int(fBlue * 255.0)
            let iAlpha = Int(fAlpha * 255.0)
            
            return (red:iRed, green:iGreen, blue:iBlue, alpha:iAlpha)
        } else {
            // Could not extract RGBA components:
            return nil
        }
    }
  public  func rgbaOfColor() -> (red:Float, green:Float, blue:Float, alpha:Float)? {
        var fRed : CGFloat = 0
        var fGreen : CGFloat = 0
        var fBlue : CGFloat = 0
        var fAlpha: CGFloat = 0
        if self.getRed(&fRed, green: &fGreen, blue: &fBlue, alpha: &fAlpha) {
            let iRed = Float(fRed )
            let iGreen = Float(fGreen)
            let iBlue = Float(fBlue )
            let iAlpha = Float(fAlpha)
            
            return (red:iRed, green:iGreen, blue:iBlue, alpha:iAlpha)
        } else {
            // Could not extract RGBA components:
            return nil
        }
    }

    public func createImage(refSize:CGSize)->UIImage?{
        let rect = CGRect(origin: CGPoint.zero, size: refSize)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(self.cgColor)
        context?.fill(rect)
        guard let newImage = UIGraphicsGetImageFromCurrentImageContext() else {
            return nil
        }
        UIGraphicsEndImageContext();
        return newImage
    }
 
}
