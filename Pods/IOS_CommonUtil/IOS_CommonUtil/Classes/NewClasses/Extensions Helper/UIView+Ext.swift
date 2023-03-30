//
//  UIView+Ext.swift
//  IOS_CommonUtil
//
//  Created by Developer on 7/15/21.
//

import Foundation
extension UIView {
    
    @IBInspectable
  public  var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            clipsToBounds = true
        }
    }
   
    
    @IBInspectable
   public var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable
   public var borderColor: UIColor? {
        get {
            if let color = layer.borderColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.borderColor = color.cgColor
            } else {
                layer.borderColor = nil
            }
        }
    }
    
    @IBInspectable
   public var shadowRadius: CGFloat {
        get {
            return layer.shadowRadius
        }
        set {
            layer.shadowRadius = newValue
        }
    }
    
    @IBInspectable
  public  var shadowOpacity: Float {
        get {
            return layer.shadowOpacity
        }
        set {
            layer.shadowOpacity = newValue
        }
    }
    // Background color
    @IBInspectable public var layerBackgroundColor: UIColor {
        get {
            return UIColor(cgColor: self.layer.backgroundColor!)
        }
        set {
            self.backgroundColor = nil
            self.layer.backgroundColor = newValue.cgColor
        }
    }
    // Mask to bounds controll
    @IBInspectable public var maskToBounds: Bool {
        get{
            return self.layer.masksToBounds
        }
        set {
            self.layer.masksToBounds = newValue
        }
    }
    
    // Rasterize option
    @IBInspectable public var rasterize: Bool {
        get {
            return self.layer.shouldRasterize
        }
        set {
            self.layer.shouldRasterize = newValue
            self.layer.rasterizationScale = UIScreen.main.scale
        }
    }
    // Create bezier path of shadow for rasterize
    @IBInspectable public var enableBezierPath: Bool {
        get {
            return self.layer.shadowPath != nil
        }
        set {
            if newValue {
                self.layer.shadowPath = UIBezierPath(roundedRect: self.layer.bounds, cornerRadius: self.layer.cornerRadius).cgPath
            } else {
                self.layer.shadowPath = nil
            }
        }
    }
    
    public  func roundCorners(corners: UIRectCorner , radius : CGFloat = 20) {
      DispatchQueue.main.async { [self] in

              let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
              let mask = CAShapeLayer()
              mask.path = path.cgPath
              layer.mask = mask
          }
    }
    
  public  func animateView() {
    UIView.animate(withDuration: SHOW_ANIMATION_TIME, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 0, options: .curveEaseIn, animations: {
            self.layoutIfNeeded()
        }, completion: nil);
    }
    public func applyShadowWithCornerRadius(color:UIColor, opacity:Float, radius: CGFloat, edge:AIEdge, shadowSpace:CGFloat, shadowCornerRadius : CGFloat = 0)    {
        var cornerShadowRadius = shadowCornerRadius
        if shadowCornerRadius == 0 {
            cornerShadowRadius  = frame.size.height / 2
        }
            var sizeOffset:CGSize = CGSize.zero
            switch edge {
            case .Top:
                sizeOffset = CGSize(width: 0, height: -shadowSpace)
            case .Left:
                sizeOffset = CGSize(width: -shadowSpace, height: 0)
            case .Bottom:
                sizeOffset = CGSize(width: 0, height: shadowSpace)
            case .Right:
                sizeOffset = CGSize(width: shadowSpace, height: 0)


            case .Top_Left:
                sizeOffset = CGSize(width: -shadowSpace, height: -shadowSpace)
            case .Top_Right:
                sizeOffset = CGSize(width: shadowSpace, height: -shadowSpace)
            case .Bottom_Left:
                sizeOffset = CGSize(width: -shadowSpace, height: shadowSpace)
            case .Bottom_Right:
                sizeOffset = CGSize(width: shadowSpace, height: shadowSpace)


            case .All:
                sizeOffset = CGSize(width: 0, height: 0)
            case .None:
                sizeOffset = CGSize.zero
            }

            self.layer.cornerRadius = cornerShadowRadius
            self.layer.masksToBounds = true;

            self.layer.shadowColor = color.cgColor
            self.layer.shadowOpacity = opacity
            self.layer.shadowOffset = sizeOffset
            self.layer.shadowRadius = radius
            self.layer.masksToBounds = false

        self.layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        }
    
    /// inside shadow
    /// - Parameters:
    ///   - edges: <#edges description#>
    ///   - radius: <#radius description#>
    ///   - opacity: <#opacity description#>
    ///   - color: <#color description#>
    func addInnerShadow(to edges: [UIRectEdge], radius: CGFloat = 3.0, opacity: Float = 0.6, color: CGColor = UIColor.black.cgColor) {
        
        let fromColor = color
        let toColor = UIColor.clear.cgColor
        let viewFrame = self.frame
        for edge in edges {
            let gradientLayer = CAGradientLayer()
            gradientLayer.colors = [fromColor, toColor]
            gradientLayer.opacity = opacity
            
            switch edge {
            case .top:
                gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
                gradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0)
                gradientLayer.frame = CGRect(x: 0.0, y: 0.0, width: viewFrame.width, height: radius)
            case .bottom:
                gradientLayer.startPoint = CGPoint(x: 0.5, y: 1.0)
                gradientLayer.endPoint = CGPoint(x: 0.5, y: 0.0)
                gradientLayer.frame = CGRect(x: 0.0, y: viewFrame.height - radius, width: viewFrame.width, height: radius)
            case .left:
                gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
                gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
                gradientLayer.frame = CGRect(x: 0.0, y: 0.0, width: radius, height: viewFrame.height)
            case .right:
                gradientLayer.startPoint = CGPoint(x: 1.0, y: 0.5)
                gradientLayer.endPoint = CGPoint(x: 0.0, y: 0.5)
                gradientLayer.frame = CGRect(x: viewFrame.width - radius, y: 0.0, width: radius, height: viewFrame.height)
            default:
                break
            }
            self.layer.addSublayer(gradientLayer)
        }
    }
    public func highlightBG(_ withColor : UIColor){
        //self.layer.cornerRadius = 5
        let baseColor = self.backgroundColor?.cgColor ?? UIColor.clear.cgColor
        
        let highlightAnimation = CAKeyframeAnimation(keyPath: "backgroundColor")
        highlightAnimation.values = [baseColor,withColor.cgColor,baseColor]
        highlightAnimation.duration = TimeInterval(0.3)
        highlightAnimation.calculationMode = CAAnimationCalculationMode.cubic
        self.layer.add(highlightAnimation, forKey: nil)
    }
   public func currentAngle() -> Float {
        
        let transform: CGAffineTransform = self.transform
        return atan2f(Float(transform.b), Float(transform.a))
        
    }
}

