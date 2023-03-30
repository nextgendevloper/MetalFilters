//
//  TextSubTextClickableBaseClass.swift
//  Premium
//
//  Created by SimplyEntertaining on 5/18/22.
//

import Foundation
import UIKit

class TextSubTextClickableBaseClass : ReusableNib ,TextClickableInput, SubTextClickableInput,ClickableInputProtocol , OnStateChangeProtocol{
    var onContinousTouchAction: (() -> ())?
    
    var onStateSelected: (() -> ())?
    
    var onStateHighlighted: (() -> ())?
    
    var onStateUnHighlighted: (() -> ())?
    
    var onStateDisable: (() -> ())?
    
    var onStateDefault: (() -> ())?
    
    var clickable: Clickable!
    
    var onTapAction: (() -> ())?
    
    var onLongTapAction: (() -> ())?
    
    
    
  
    @IBOutlet weak var title : VerticalAlignLabel!
    @IBOutlet weak var subTitle : VerticalAlignLabel!
    
    override open func commonInit() {
        clickable.onTapAction = { [self] in
            onTapAction?()
        }
        clickable.onContinousTouchAction = { [self] in
            onLongTapAction?()
        }
    }
}

