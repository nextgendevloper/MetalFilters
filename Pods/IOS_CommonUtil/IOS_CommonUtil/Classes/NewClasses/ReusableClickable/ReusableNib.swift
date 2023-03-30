//
//  button.swift
//  Premium
//
//  Created by SimplyEntertaining on 5/16/22.
//

import Foundation

import UIKit
@IBDesignable
open class ReusableNib : UIView {  // ImageTapable
    
    public var imageView = UIImageView()
    
    override public init(frame: CGRect) {
        
           super.init(frame: frame)
           xibSetup()
           commonInit()
       }
    
    public func setImage(){
        // image is settnig
    }

    required public init?(coder aDecoder: NSCoder) {
          
        super.init(coder: aDecoder)

        xibSetup()
        commonInit()
    }
    
    public func xibSetup() {
           let view = loadViewFromNib()

            // use bounds not frame or it'll be offset
            view.frame = bounds
            // Make the view stretch with containing view
        view.autoresizingMask = [UIView.AutoresizingMask.flexibleWidth, UIView.AutoresizingMask.flexibleHeight]
            // Adding custom subview on top of our view (over any custom drawing > see note below)
            addSubview(view)
        
        if !self.subviews.isEmpty {
            // if nib alredy has child added via storyboard only then move back parent
            self.sendSubviewToBack(view)
        }
    }
    public func loadViewFromNib() -> UIView {
        let name = String(describing: type(of: self))
       let nib = UINib(nibName: name, bundle: .main)
     let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
      
      return view
    }
    
    open func commonInit(){
        
    }

}



