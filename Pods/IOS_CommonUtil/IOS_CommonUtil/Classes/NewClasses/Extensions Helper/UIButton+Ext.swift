//
//  UIButton+Ext.swift
//  IOS_CommonUtil
//
//  Created by Developer on 7/29/21.
//

import Foundation
extension UIButton{
    public func setText(title:String , font:UIFont , forState:iOSButtonState)
    {

        let fontAtb = [ NSAttributedString.Key.font: font ]
        let atb = NSAttributedString(string: title, attributes: fontAtb)
        switch forState {
        case .Selected:
            self.setAttributedTitle(atb, for: .selected)

        case .Normal:
            self.setAttributedTitle(atb, for: .normal)
            
        case .Disable:
            self.setAttributedTitle(atb, for: .disabled)
            
        case .All:
            self.setAttributedTitle(atb, for: .normal)
            self.setAttributedTitle(atb, for: .selected)
        }

    }
    
}
