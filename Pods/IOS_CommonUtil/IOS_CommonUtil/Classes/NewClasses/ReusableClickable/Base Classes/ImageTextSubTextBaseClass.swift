//
//  ImageTextSubTextBaseClass.swift
//  Premium
//
//  Created by SimplyEntertaining on 5/18/22.
//

import Foundation
import UIKit



open class ImageTextSubTextClickableBaseClass : ReusableNib , TextClickableInput, SubTextClickableInput, ImageClickableInput,ClickableInputProtocol, OnStateChangeMethodsProtocol {
    public var imageName: String?
    
  
    
    @IBOutlet weak public var title : VerticalAlignLabel!
    @IBOutlet weak public var subTitle : VerticalAlignLabel!
    @IBOutlet weak public var image : UIImageView!
    @IBOutlet weak public var clickable: Clickable!
    
    override open func commonInit() {
        clickable.onTapAction = { [self] in
            onTapAction?()
        }
        clickable.onContinousTouchAction = { [self] in
            onLongTapAction?()
        }
        
    }
    
    
    // set UI Appearance for showing this is Default state
   open func onStateDefault() {
     
    }
    
    // set UI Appearance for showing this is selected state
    open func onStateSelected() {
      

    }
    
    /// set UI Things Which  need to be shown while user touch is on button ( transitioning from one state to other )
    open func onStateHighlight() {
   
    }
    
    /// set UI Things common in Default and Selected states if not dont override
    open func onStateUnHighlight() {
        
    }
    
    open func onStateDisable() {
        
    }
  
  
    public var onTapAction: (() -> ())?
  
    public var onLongTapAction: (() -> ())?
  
 
  
}

