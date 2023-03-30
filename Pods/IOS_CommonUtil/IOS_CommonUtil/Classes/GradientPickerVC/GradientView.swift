//
//  GradientView.swift
//  LogoMaker
//
//  Created by Anjana on 7/20/18.
//  Copyright © 2018 Saraswati Javalkar. All rights reserved.
//

import UIKit

class GradientView: UIView {
    
    
    @IBInspectable var gradient: CAGradientLayer!
    @IBInspectable var startColor: UIColor!
    @IBInspectable var endColor: UIColor!
    var startPoint: CGPoint!
    var endPoint: CGPoint!
    
//    required convenience init?(coder aDecoder: NSCoder) {
//        self.init(coder:aDecoder)
//        self.setUp()
//    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setUp()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.setUp()
    }
    
    
    
    
    func setUp()  {
        self.startColor = UIColor.white
        self.endColor = UIColor.white
        self.startPoint = CGPoint(x: 1, y: 0)
        self.endPoint = CGPoint(x: 1, y: 1)
    }
    
    override func draw(_ rect: CGRect) {
        if gradient == nil {
            gradient = CAGradientLayer()
            gradient.frame = self.bounds
            self.layer.addSublayer(gradient)
        }
        
        self.updateColors()
        self.updatePoints()
    }
    
    private func updateColors() {
        gradient.colors = [self.startColor.cgColor, self.endColor.cgColor]
    }
    
    private func updatePoints() {
        gradient.startPoint = self.startPoint
        gradient.endPoint = self.endPoint
    }
    
    public func updateFirstColor(color: UIColor) {
        self.startColor = color
        updateColors()
    }
    
    public func updateSecondColor(color: UIColor) {
        self.endColor = color
        updateColors()
    }
    
    public func updatePoints(startPoint: CGPoint, endPoint: CGPoint) {
        self.startPoint = startPoint
        self.endPoint = endPoint
        updatePoints()
    }
}
