//
//  radialGradient.swift
//  LogoMaker
//
//  Created by SimplyEntertaining on 7/23/18.
//

import UIKit

/*class radialGradient: CALayer {
    
    override init(){
        
        super.init()
        
        needsDisplayOnBoundsChange = true
    }
    
    init(center:CGPoint,radius:CGFloat,colors:[CGColor]){
        
        self.center = center
        self.radius = radius
        self.colors = colors
        
        super.init()
        
    }
    
    required init(coder aDecoder: NSCoder) {
        
        super.init()
        
    }
    
    var center:CGPoint = CGPoint(x: 50, y: 50)
    var radius:CGFloat = 20
    var colors:[CGColor] = [UIColor(red: 251/255, green: 237/255, blue: 33/255, alpha: 1.0).cgColor , UIColor(red: 251/255, green: 179/255, blue: 108/255, alpha: 1.0).cgColor]
    
    override func draw(in ctx: CGContext!) {
        
        ctx.saveGState()
        
        var locations:[CGFloat] = [0.0, 1.0]
        
        let tColour: UIColor = .red
        let bColour: UIColor = .blue
        
        let colours = [tColour.cgColor, bColour.cgColor] as CFArray
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let gradient = CGGradient(colorsSpace: colorSpace, colors: colours , locations: nil)
        
//        var gradient = CGGradientCreateWithColors(colorSpace, colors as CFArray, [0.0,1.0])
//
//        var startPoint = CGPointMake(0, self.bounds.height)
//        var endPoint = CGPointMake(self.bounds.width, self.bounds.height)
//
        ctx.drawRadialGradient(gradient!, startCenter: center, startRadius: 0.0, endCenter: center, endRadius: radius, options: CGGradientDrawingOptions(rawValue: 0))
        
    }
    
}*/

/*class radialGradient:CALayer {
    var startColor:UIColor = .red
    var endColor:UIColor = .blue
    
    override init() {
        super.init()
        setNeedsDisplay()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        setNeedsDisplay()
    }
    
    override func draw(in ctx: CGContext) {
        let gradLocationsNum = 2
        let gradLocations:[CGFloat] = [0.0, 1.0]
        
       
        
        var gradColors = [CGFloat](repeating: 0.0, count: 8)
        
        var red:CGFloat = 0.0, green:CGFloat = 0.0, blue:CGFloat = 0.0, alpha:CGFloat = 0.0
        startColor.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        gradColors[0] = red
        gradColors[1] = green
        gradColors[2] = blue
        gradColors[3] = alpha
        
        endColor.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        gradColors[4] = red
        gradColors[5] = green
        gradColors[6] = blue
        gradColors[7] = alpha
        
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let gradient = CGGradient(colorSpace: colorSpace, colorComponents: gradColors, locations: gradLocations, count: gradLocationsNum)
        
        let gradCenter = CGPoint(x: bounds.size.width * 0.5, y: bounds.size.height)
        let gradRadius = min(bounds.size.width, bounds.size.height)
        
        ctx.drawRadialGradient(gradient!, startCenter: gradCenter, startRadius: 0, endCenter: gradCenter, endRadius: gradRadius, options: .drawsAfterEndLocation)
        
        
        
    }
}*/


class RadialGradialView: UIView {
    
    var radiusValue:CGFloat = 20.0
    var colorSet:CFArray?
    var context: CGContext?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        radiusValue = bounds.size.width
        colorSet = [UIColor.orange.cgColor, UIColor.green.cgColor] as CFArray
        //context = UIGraphicsGetCurrentContext()
        // Initialization code
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
    override func draw(_ layer: CALayer, in ctx: CGContext) {
        super.draw(layer, in: ctx)
        let colors = colorSet! as CFArray
        
        //let endRadius = sqrt(pow(frame.width/2 , 2) + pow(frame.height/2 , 2))
        let endRadius = radiusValue * bounds.size.width
        let center = CGPoint(x: bounds.size.width / 2, y: bounds.size.height / 2)
        let gradient = CGGradient(colorsSpace: nil, colors: colors, locations: nil)
        ctx.drawRadialGradient(gradient!, startCenter: center, startRadius: 0.0 , endCenter: center, endRadius: endRadius, options: CGGradientDrawingOptions.drawsAfterEndLocation)
        //ctx.clear(self.frame)
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        //#if TARGET_INTERFACE_BUILDER
       // applyGradient()
       // #endif
        
    }
    
    func applyGradient() {
        //let colors = [UIColor.orange.cgColor, UIColor.green.cgColor] as CFArray
        let colors = colorSet! as CFArray
        
        //let endRadius = sqrt(pow(frame.width/2 , 2) + pow(frame.height/2 , 2))
        let endRadius = radiusValue * bounds.size.width
        let center = CGPoint(x: bounds.size.width / 2, y: bounds.size.height / 2)
        let gradient = CGGradient(colorsSpace: nil, colors: colors, locations: nil)
        //let context1 = UIGraphicsGetCurrentContext()
        
        //let size = bounds.size
        context?.drawRadialGradient(gradient!, startCenter: center, startRadius: 0.0 , endCenter: center, endRadius: endRadius, options: CGGradientDrawingOptions.drawsAfterEndLocation)

        //context?.clear(CGRect)
        //context?.drawRadialGradient(gradient!, startCenter: center, startRadius: 4.0, endCenter: center, endRadius: endRadius, options: CGGradientDrawingOptions.drawsBeforeStartLocation)
    }
    
}
