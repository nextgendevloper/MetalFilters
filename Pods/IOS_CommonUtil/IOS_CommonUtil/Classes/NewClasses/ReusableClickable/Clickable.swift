//
//  Clickable.swift
//  Unknowns
//
//  Created by zmobile on 23/05/22.
//

import UIKit

public protocol ClickableInputProtocol {
    var clickable : Clickable! {get set}
    
    var onTapAction : (()->())?{get set}
    var onLongTapAction : (()->())?{get set}
    
    var isBtnSelected : Bool {get set}
    var isBtnDisabled : Bool {get set}
}
public extension ClickableInputProtocol {
    var isBtnSelected : Bool {
         get {
             return clickable.isSelected
         }
         set {
                 clickable.isSelected = newValue
             }
     }
    var isBtnDisabled : Bool {
         get {
             return !clickable.isEnabled
         }
         set {
                 clickable.isEnabled = !newValue
             }
     }
 }

public protocol OnStateChangeProtocol {
    
    /// write logic here to reflect when btn action in Continous Touch
    var onContinousTouchAction: (() -> ())?{get set}
    /// write logic here to reflect when btn state changes
    var onStateSelected : (()->())?{get set}
    /// write logic here to reflect when btn state changes
    var onStateHighlighted : (()->())?{get set}
    /// write logic here to reflect when btn state changes
    var onStateUnHighlighted : (()->())?{get set}
    /// write logic here to reflect when btn state is disable
    var onStateDisable : (()->())?{get set}
    /// write logic here to reflect when btn state changes
    var onStateDefault : (()->())?{get set}
    /// set value true to get callback for tap action. Default true
    
   
    
}
public protocol OnStateChangeMethodsProtocol {
    
    func onStateDefault()
    func onStateSelected()
    func onStateHighlight()
    func onStateUnHighlight()
    func onStateDisable()
   
}


@IBDesignable
public class Clickable : UIButton,OnStateChangeProtocol {
   
   // MARK: - Binders
    /// write logic here to reflect when btn action is tap
    public var onTapAction: (() -> ())?
    /// write logic here to reflect when btn action in Continous Touch
    public   var onContinousTouchAction: (() -> ())?
    /// write logic here to reflect when btn state changes
    public  var onStateSelected : (()->())?
    /// write logic here to reflect when btn state changes
    public   var onStateHighlighted : (()->())?
    /// write logic here to reflect when btn state changes
    public  var onStateUnHighlighted : (()->())?

    /// write logic here to reflect when btn state is disable
    public  var onStateDisable : (()->())?
    /// write logic here to reflect when btn state changes
    public  var onStateDefault : (()->())?
    /// set value true to get callback for tap action. Default true
    
    
    var goBackToOriginalState : Bool = true {
        willSet {
            print("\(goBackToOriginalState) : STATE :",newValue)
            
        }
    }
    
    // MARK: - LIFE CYCLE
    public override func didMoveToSuperview() {
        onStateDefault?()
    }
    
    override public init(frame: CGRect) {
            super.init(frame: frame)
        addTarget(self, action: #selector(touchoutside(_:event:)), for: .touchUpOutside)
        addTarget(self, action: #selector(touchoutside(_:event:)), for: .touchDragOutside)
        if #available(iOS 15.0, *) {
            self.configuration = UIButton.Configuration.plain()
        } else {
            // Fallback on earlier versions
        }
    }
    required public init?(coder aDecoder: NSCoder) {
           super.init(coder: aDecoder)
        addTarget(self, action: #selector(touchoutside(_:event:)), for: .touchUpOutside)
        addTarget(self, action: #selector(touchoutside(_:event:)), for: .touchDragOutside)
        if #available(iOS 15.0, *) {
            self.configuration = UIButton.Configuration.plain()
        } else {
            // Fallback on earlier versions
        }    }
    
    
    // MARK: - IB INSPECTABLE
    
    /// designable set to enable default tap action . dont use enableContinousAction
    @IBInspectable public var enableTapAction : Bool = true {
        didSet {
            if enableTapAction {
                addTarget(self, action: #selector(touchUpInside(_:event:)), for: .touchUpInside)
            }else{
                self.removeTarget(self, action: #selector(touchUpInside(_:event:)), for: .touchUpInside)
            }
        }
    }
    /// set value true to get callback for continous touch action. Default False. dont use enableTapAction
    @IBInspectable  public var enableContinousTouchInside : Bool = false {
        didSet {
            if enableContinousTouchInside {

                let longTapGesture = UILongPressGestureRecognizer(target: self, action: #selector(downButtonLongPressHandler(_:)))
                self.addGestureRecognizer(longTapGesture)
            }else{
                let longTapGesture = UILongPressGestureRecognizer(target: self, action: #selector(downButtonLongPressHandler(_:)))
                self.removeGestureRecognizer(longTapGesture)

            }
        }
    }
    
    @objc func downButtonLongPressHandler(_ sender: UILongPressGestureRecognizer) {
            if sender.state == .began {
                timer = Timer.scheduledTimer(withTimeInterval: 0.05, repeats: true, block: { [self]_ in
                    self.onContinousTouchAction?()
                   isSelected = true
                })
            } else if sender.state == .ended || sender.state == .cancelled {
               // print("FINISHED UP LONG PRESS")
                timer?.invalidate()
                timer = nil
                isSelected = false
            }
    }
    
    @IBInspectable public var defaultAnim : Bool = true
    // MARK: - OBSERVERS
    /// should toggle between selected and unselected state
   private var shouldToggleSelectedState : Bool = true {
        didSet{
            if oldValue != shouldToggleSelectedState && !shouldToggleSelectedState {
                isSelected = shouldToggleSelectedState
                setDefaultState()
            }
        }
    }
   
    override public var isSelected: Bool {
        didSet {
           
            if let onStateSelected = onStateSelected {
                isSelected ? onStateSelected() : onStateDefault?()
            }else{
                onStateDefault?()
            }
        
        }
    }
    
    
    override public var isHighlighted: Bool {
        didSet {
            // highlighted state is given then enter otherwise skip
            if onStateHighlighted != nil {
                if oldValue == false && isHighlighted {
                    highlight()
                } else if oldValue == true && !isHighlighted {
                    unHighlight()
                }
            }else{
                toggleState()
            }
         
        }
    }
    
    public override var isEnabled: Bool {
        didSet {
            if isEnabled {
                self.superview?.isUserInteractionEnabled = true
                self.tintColor = .clear
                onStateDefault?()
                
            }else{
                self.superview?.isUserInteractionEnabled = false
                self.tintColor = .clear
                 onStateDisable?()
            }
        }
    }
    
    
    // MARK: - PRIVATE METHODS
    @objc private func touchoutside(_ sender: Clickable , event : UIEvent) {
        shouldToggleSelectedState = false
        touchUpHandler()
    }
    
    @objc private func touchUpInside(_ sender: Clickable , event : UIEvent) {
      print("INSIDE TOUCH")
        shouldToggleSelectedState = true
        
        //updateState()
       let location = event.allTouches?.first?.location(in: self)
        if sender.bounds.contains(location!) {
            goBackToOriginalState = false
            isHighlighted = false
            onTapAction?()
        }
    }
    
//    @objc private func touchDragInside(_ sender: Clickable , event : UIEvent) {
//
//       shouldToggleSelectedState = true
//
//
//        let location = event.allTouches?.first?.location(in: self)
//         if sender.bounds.contains(location!) {
//             timer?.invalidate()
//             timer = nil
//             onContinousTouchAction?()
//             timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true, block: { [unowned self] (timer) in
//                    onContinousTouchAction?()
//                    })
//         }
//    }
//
    @objc private func touchUpHandler() {
        if enableContinousTouchInside {
        timer?.invalidate()
        timer = nil
        }
        }
    
    var timer : Timer?
   private func toggleState(){
        if shouldToggleSelectedState {
            isSelected = !isSelected
        }
    }
    
    
   private func highlight() {
        // Animate changes for highlighting
       if defaultAnim {
        UIView.animate(withDuration: 0.25) { [self] in
            onStateHighlighted?()
        }
       }else{
           onStateHighlighted?()
       }
    }

  private func unHighlight() {
     
//          if defaultAnim {
//              UIView.animate(withDuration: 0.25) { [self] in
//              onUnhighlight()
//           }
//          }else{
              onUnhighlight()
        //  }
      
     
       
    }
    
    private func onUnhighlight(){
        if let onStateUnHighlighted = onStateUnHighlighted {
            onStateUnHighlighted()
        }
        
        // Animate changes for un-highlighting
//        if shouldToggleSelectedState {
//        toggleState()
//        }else{
//            setDefaultState()
//        }
        print("UnHighlithed")
        if goBackToOriginalState {
            if isSelected {
                setSelectedState()
            }else{
                setDefaultState()
            }
        }else{
            toggleState()
            goBackToOriginalState = true
        }
    }
    
    
    
// MARK: - PUBLIC METHODS
    public func setDefaultState(){
            onStateDefault?()
    }
    public func setSelectedState(){
        onStateSelected?()
    }
    
    
}
