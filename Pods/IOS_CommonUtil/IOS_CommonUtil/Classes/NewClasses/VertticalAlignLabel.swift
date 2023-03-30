//
//  Enum.swift
//  Premium
//
//  Created by SimplyEntertaining on 3/15/22.
//

import Foundation
import UIKit


public class VerticalAlignLabel: LocalisedUILabel {
    public enum VerticalAlignment {
        case top
        case center
        case bottom
    }

    public  var verticalAlignment : VerticalAlignment = .top {
        didSet {
            setNeedsDisplay()
        }
    }

    override public func textRect(forBounds bounds: CGRect, limitedToNumberOfLines: Int) -> CGRect {
        let rect = super.textRect(forBounds: bounds, limitedToNumberOfLines: limitedToNumberOfLines)

        var labelX =  (self.bounds.size.width - rect.size.width)/2 // center Align
       
        
        if UIView.userInterfaceLayoutDirection(for: .unspecified) == .rightToLeft {
            
            if self.textAlignment == .right {
                labelX =  bounds.origin.x  //right aligned
            }else if self.textAlignment == .left {
                labelX = self.bounds.size.width - rect.size.width  // leftALigned
            }
            
            switch verticalAlignment {
            case .top:
                return CGRect(x: labelX, y: bounds.origin.y, width: rect.size.width, height: rect.size.height)
            case .center:
                return CGRect(x: labelX, y: bounds.origin.y + (bounds.size.height - rect.size.height) / 2, width: rect.size.width, height: rect.size.height)
            case .bottom:
                return CGRect(x:labelX, y: bounds.origin.y + (bounds.size.height - rect.size.height), width: rect.size.width, height: rect.size.height)
            }
        } else {
            
            if self.textAlignment == .right {
                labelX =   self.bounds.size.width - rect.size.width  //right aligned
            }else if self.textAlignment == .left {
                labelX = bounds.origin.x // leftALigned
            }
            
            switch verticalAlignment {
            case .top:
                return CGRect(x: labelX, y: bounds.origin.y, width: rect.size.width, height: rect.size.height)
            case .center:
                return CGRect(x:labelX, y: bounds.origin.y + (bounds.size.height - rect.size.height) / 2, width: rect.size.width, height: rect.size.height)
            case .bottom:
                return CGRect(x: labelX, y: bounds.origin.y + (bounds.size.height - rect.size.height), width: rect.size.width, height: rect.size.height)
            }
        }
    }

    override public func drawText(in rect: CGRect) {
        let r = self.textRect(forBounds: rect, limitedToNumberOfLines: self.numberOfLines)
        super.drawText(in: r)
    }
}
public extension VerticalAlignLabel{
    func attriText(left:String,right:String){
       self.textColor = .clear
       let myAttribute = [ NSAttributedString.Key.foregroundColor: App.DefaultColor]
       let myLeftString = NSAttributedString(string: left, attributes: myAttribute)
       let myAttribute2 = [ NSAttributedString.Key.foregroundColor: App.DefaultLight ]
       let myRightString = NSAttributedString(string: right, attributes: myAttribute2)
       let leftCopy = NSMutableAttributedString(attributedString: myLeftString)
       leftCopy.append(myRightString)
       self.attributedText = leftCopy
       
   }
   
    
}

public class LocalisedUILabel : UILabel {
    
    
    public override var text: String? {
        didSet {
            if let nv = text , !nv.contains("_") {
                print("Not Localised :- ",text as Any)
            }
        }
       
    }
}

 public class Localisedbutton : UIButton {
     public override func setTitle(_ title: String?, for state: UIControl.State) {
        if let nv = title , !nv.contains("_") {
            print("Not Localised Btn :- ",title as Any)
        }
    }
}


