//
//  UILabel+Ext.swift
//  IOS_CommonUtil
//
//  Created by Developer on 7/29/21.
//

import Foundation

public extension UILabel {
    func updateAlignmentRTL(){
        switch textAlignment {
        case .center:
            return
        case .left:
            if RTL { textAlignment = .right }
            return
        case .right:
            if RTL { textAlignment = .left }
            return
         default :
            return
        }
        
    }
}
public extension UIButton {
    func updateAlignmentRTL() {
        switch contentHorizontalAlignment {
        case .left :
            if RTL {contentHorizontalAlignment = .right }
        case .right :
            if RTL {contentHorizontalAlignment = .left }
        case .leading :
            if RTL {contentHorizontalAlignment = .trailing }
        case .trailing :
            if RTL {contentHorizontalAlignment = .leading }
        default :
        return
        }
    }
    
    func updateImageRTL() {
        if RTL { self.setImage(self.imageView?.image?.imageFlippedForRightToLeftLayoutDirection(), for: .normal) }
    }
    
}


 
public protocol NecessorySkeletons : AnyObject {
    func setLocalisation()
    func setRTL()
    func setFontSize()
    func setDefaults()
    func setAppTheme()
}
public extension NecessorySkeletons {
    func configureSkeletons() {
        setDefaults()
        setLocalisation()
        setFontSize()
        setRTL()
    }
}
