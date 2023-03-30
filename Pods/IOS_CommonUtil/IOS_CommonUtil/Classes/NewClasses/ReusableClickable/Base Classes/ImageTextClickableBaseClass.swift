//
//  ImageTextClickableBaseClass.swift
//  Premium
//
//  Created by SimplyEntertaining on 5/18/22.
//

import Foundation
import UIKit

open class ImageTextClickableBaseClass : ReusableNib , TextClickableInput, ImageClickableInput,ClickableInputProtocol, OnStateChangeMethodsProtocol  {
    public var imageName: String?
    
   
    
  
    
    
  @IBOutlet weak  public var clickable: Clickable!
    
    @IBOutlet weak public var title : VerticalAlignLabel!
    @IBOutlet weak public var image : UIImageView!
    public var onTapAction: (() -> ())?
    
    public var onLongTapAction: (() -> ())?
    
    override open func commonInit() {
        clickable.onTapAction = { [self] in
            onTapAction?()
        }
        clickable.onContinousTouchAction = { [self] in
            onLongTapAction?()
        }
    }
    
  
    
  open func onStateDefault() {
        
    }
    
    open func onStateSelected() {
        
    }
    
   open func onStateHighlight() {
        
    }
    
    open func onStateUnHighlight() {
        
    }
    
    open func onStateDisable() {
        
    }
    
  
 
}
