//
//  UICollectionViewBaseClass.swift
//  WatermarkHelper
//
//  Created by zmobile on 26/05/22.
//

import Foundation
// MARK: - BASE Class CVCell

open class BaseClassCollectionViewCell : UICollectionViewCell  {
    open override  func awakeFromNib() {
        commonUI()
    }
//    
//    // make UI Changes show immediately（on touch）
//    open override var isHighlighted: Bool {
//           willSet {
//               onHighlight(newValue)
//           }
//       }
    
       // keep This UIChanges from selected until unselected
    open override var isSelected: Bool {
           willSet {
               onSelect(newValue)
           }
       }
    
    
    // set default UI Here // gets called by awakeFromNib
  open func commonUI(){
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 2
      
      
    }
    
  open  func onStateSelected() {
        UIView.animate(withDuration: 0.25) {
            self.transform = .identity.scaledBy(x: 1.1, y: 1.1)
        }
    }
   
  open func onStateDefault(){
        UIView.animate(withDuration: 0.25) {
            self.transform = .identity
        }
       
    }
    
   open func onStateHighlight(){
        UIView.animate(withDuration: 0.25) {
            self.backgroundColor = .black.alpha(0.8)
        }
    }
    
    private func onSelect(_ newValue: Bool) {
         newValue ? onStateSelected() : onStateDefault()
        }
    private  func onHighlight(_ newValue: Bool) {
         if isHighlighted != newValue {
              newValue ? onStateHighlight() : onStateDefault()
         }
     }
    
     
}
