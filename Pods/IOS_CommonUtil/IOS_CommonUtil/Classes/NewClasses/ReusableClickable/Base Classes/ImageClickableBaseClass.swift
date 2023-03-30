//
//  ImageClickableBaseClass.swift
//  Premium
//
//  Created by SimplyEntertaining on 5/18/22.
//

import Foundation
import UIKit
import AVFoundation


open class ImageClickableBaseClass : ReusableNib , ImageClickableInput, ClickableInputProtocol, OnStateChangeMethodsProtocol {
    public var imageName: String?
    
  
    
    @IBOutlet weak public var image : UIImageView!
    
    @IBOutlet weak public var clickable : Clickable!
    
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
    
      // set UI Appearance for showing this is Default state
    open func onStateDefault() {
          self.backgroundColor = .yellow
      }
      
      // set UI Appearance for showing this is selected state
    open func onStateSelected() {
          self.backgroundColor = .green

      }
      
      /// set UI Things Which  need to be shown while user touch is on button ( transitioning from one state to other )
    open func onStateHighlight() {
          self.backgroundColor = .red
      }
      
      /// set UI Things common in Default and Selected states if not dont override
    open func onStateUnHighlight() {
          
      }
      
    open func onStateDisable() {
          
      }
    
    
   
   
}


