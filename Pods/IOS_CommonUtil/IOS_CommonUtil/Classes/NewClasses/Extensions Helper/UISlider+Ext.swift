//
//  UISlider+Ext.swift
//  IOS_CommonUtil
//
//  Created by Developer on 7/15/21.
//

import Foundation
extension UISlider {
    @IBInspectable public var thumbImage: UIImage {
        get {
            return self.thumbImage(for: .normal)!
        } set {
            self.setThumbImage(newValue, for: .normal)
        }
    }
}
