//
//  Extensions.swift
//  IOS_CommonUtil
//
//  Created by JD on 8/17/20.
//

import Foundation
import PhotosUI

extension UIViewController {
   @available(iOS 14, *)
   public func pickPhoto(limit : Int , delegate : PHPickerViewControllerDelegate){
       // new in iOS 14, we can get the asset _later_ so we don't need access up front
       do {
           // if you create the configuration with no photo library, you will not get asset identifiers
           var config = PHPickerConfiguration()
           // try it _with_ the library
           config = PHPickerConfiguration(photoLibrary: PHPhotoLibrary.shared())
           config.selectionLimit = limit // default
           // what you filter out will indeed not appear in the picker
               config.filter = .any(of: [.images , .livePhotos]) // default is all three appear, no filter
           config.preferredAssetRepresentationMode = .current

           let picker = PHPickerViewController(configuration: config)
           picker.delegate = delegate
           // works okay as a popover but even better just present, it will be a normal sheet
           self.present(picker, animated: true)
          // PHPhotoLibrary.shared().presentLimitedLibraryPicker(from: self)
       }
   }
       
   @available(iOS 14, *)
   public  func pickVideo(limit : Int = 1 , delegate : PHPickerViewControllerDelegate){
       // new in iOS 14, we can get the asset _later_ so we don't need access up front
       do {
           // if you create the configuration with no photo library, you will not get asset identifiers
           var config = PHPickerConfiguration()
           // try it _with_ the library
          // config = PHPickerConfiguration(photoLibrary: PHPhotoLibrary.shared())
           config.selectionLimit = limit // default
           // what you filter out will indeed not appear in the picker
           config.filter = .videos // default is all three appear, no filter
           config.preferredAssetRepresentationMode = .current
           let picker = PHPickerViewController(configuration: config)
           picker.delegate = delegate
           // works okay as a popover but even better just present, it will be a normal sheet
           self.present(picker, animated: true)
          // PHPhotoLibrary.shared().presentLimitedLibraryPicker(from: self)
       }
   }
   public  func getViewController(name:String , storyboard : String = "Main") -> UIViewController? {
       return UIStoryboard(name: storyboard, bundle: nil).instantiateViewController(withIdentifier: name)
   }
   
//    // MARK:- Private Methods ------
//    public func addChildVCWithMultiplier(_ childViewController: UIViewController, toView view: UIView? = nil,  aniamte : Bool = false) {
//              let view: UIView = view ?? self.view
//        childViewController.removeFromParent()
//        childViewController.willMove(toParent: self)
//        if aniamte {
//            childViewController.view.transform = CGAffineTransform(translationX: 0, y: UIScreen.main.bounds.size.height)
//        }
//
//        addChild(childViewController)
//        childViewController.didMove(toParent: self)
//              childViewController.view.translatesAutoresizingMaskIntoConstraints = false
//              view.addSubview(childViewController.view)
//              view.addConstraints([
//                  NSLayoutConstraint(item: childViewController.view!, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: 0),
//                  NSLayoutConstraint(item: childViewController.view!, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: 0),
//                  NSLayoutConstraint(item: childViewController.view!, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: 0),
//                  NSLayoutConstraint(item: childViewController.view!, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1, constant: 0)
//              ])
//        if aniamte {
//            UIView.animate(withDuration: SHOW_ANIMATION_TIME, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 1, options: .curveLinear) {
//                childViewController.view.transform = .identity
//            } completion: { _ in
//
//            }
//
//
//        }
//
//              view.layoutIfNeeded()
//          }
//    public  func addChildVCWithMultiplier(_ childViewController: UIViewController, toView view: UIView? = nil,aniamte : Bool = false , heightMultiplier : CGFloat = 1.0) {
//               let view: UIView = view ?? self.view
//         childViewController.removeFromParent()
//         childViewController.willMove(toParent: self)
//         if aniamte {
//             childViewController.view.transform = CGAffineTransform(translationX: 0, y: UIScreen.main.bounds.size.height)
//         }
//
//         addChild(childViewController)
//         childViewController.didMove(toParent: self)
//               childViewController.view.translatesAutoresizingMaskIntoConstraints = false
//               view.addSubview(childViewController.view)
//               view.addConstraints([
//                 NSLayoutConstraint(item: childViewController.view!, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: view.frame.height-(view.frame.height*(heightMultiplier))),
//                   NSLayoutConstraint(item: childViewController.view!, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: 0),
//                   NSLayoutConstraint(item: childViewController.view!, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: 0),
//                   NSLayoutConstraint(item: childViewController.view!, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1, constant: 0)
//               ])
//         if aniamte {
//            UIView.animate(withDuration: SHOW_ANIMATION_TIME, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 1, options: .curveLinear) {
//                childViewController.view.transform = .identity
//            } completion: { _ in
//
//            }
//
//
//
//         }
//
//               view.layoutIfNeeded()
//           }
    public enum TransitionType {
        case fromLeft , fromRight ,fromTop , fromBottom
        case Zoom
        case None
    }
    
    public  func addChildVCWithMultiplier(_ childViewController: UIViewController, toView view: UIView? = nil,aniamte : Bool = true ,transitionType:TransitionType = .fromBottom , fadeEnable:Bool = false, heightMultiplier : CGFloat = 1.0) {
                   let view: UIView = view ?? self.view
             childViewController.removeFromParent()
             childViewController.willMove(toParent: self)
             if aniamte {
                 switch transitionType {
                 case .fromLeft:
                     childViewController.view.transform = CGAffineTransform(translationX: -UIScreen.main.bounds.size.width+(UIScreen.main.bounds.size.width*0.4), y: 0)

                 case .fromRight:
                     childViewController.view.transform = CGAffineTransform(translationX: UIScreen.main.bounds.size.width-(UIScreen.main.bounds.size.width*0.4), y: 0)

                 case .fromTop:
                     childViewController.view.transform = CGAffineTransform(translationX: 0, y: -UIScreen.main.bounds.size.height+(UIScreen.main.bounds.size.height*0.4))

                 case .fromBottom:
                     childViewController.view.transform = CGAffineTransform(translationX: 0, y: UIScreen.main.bounds.size.height-(UIScreen.main.bounds.size.height*0.4))

                 case .Zoom:
                     childViewController.view.transform = CGAffineTransform(scaleX: 0.0, y: 0.0)
                
                 case .None:
                     break
                 }
                 
                 if fadeEnable {
                     childViewController.view.alpha = 0
                 }
                 
             }
             
             addChild(childViewController)
             childViewController.didMove(toParent: self)
                   childViewController.view.translatesAutoresizingMaskIntoConstraints = false
                   view.addSubview(childViewController.view)
            if heightMultiplier != -1 {
                   view.addConstraints([
                     NSLayoutConstraint(item: childViewController.view!, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: view.frame.height-(view.frame.height*(heightMultiplier))),
                       NSLayoutConstraint(item: childViewController.view!, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: 0),
                       NSLayoutConstraint(item: childViewController.view!, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: 0),
                       NSLayoutConstraint(item: childViewController.view!, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1, constant: 0)
                   ])
            } else {
               // let hCons =  NSLayoutConstraint(item:childViewController.view!, attribute: .height, relatedBy: .lessThanOrEqual, toItem: view, attribute: .height, multiplier: 0.5, constant: 0)
                let hCon =  NSLayoutConstraint(item: childViewController.view!, attribute: .top, relatedBy: .lessThanOrEqual, toItem: view, attribute: .top, multiplier: 1, constant: 0)
                hCon.priority = .defaultLow
                
                view.addConstraints([hCon,

                    NSLayoutConstraint(item: childViewController.view!, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: 0),
                    NSLayoutConstraint(item: childViewController.view!, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: 0),
                    NSLayoutConstraint(item: childViewController.view!, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1, constant: 0)
                ])
            }
             if aniamte {
                
                 UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut) {
                     
                     if fadeEnable {
                         childViewController.view.alpha = 1
                     }
                     childViewController.view.transform = .identity

                 } completion: { _ in
                     
                 }
             }


                   view.layoutIfNeeded()
               }
    
    
   public func isModal() -> Bool {
          return self.presentingViewController?.presentedViewController == self
              || (self.navigationController != nil && self.navigationController?.presentingViewController?.presentedViewController == self.navigationController)
              || self.tabBarController?.presentingViewController is UITabBarController
      }
      
//    public func removeOrDismissViewController(_ childViewController: UIViewController , animate : Bool = true) {
//           if childViewController.isModal() {
//               childViewController.dismiss(animated: animate, completion: nil)
//           }else{
//            if animate {
//                UIView.animate(withDuration: SHOW_ANIMATION_TIME, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1, options: .curveEaseOut) {
//                childViewController.view.transform = CGAffineTransform(translationX: 0, y: self.view.transform.ty + self.view.frame.height)
//
//            } completion: { _ in
//                self.removeChildVC(childViewController)
//
//            }
//            }else{
//                self.removeChildVC(childViewController)
//
//            }
//           }
//       }
    public func removeOrDismissViewController(_ childViewController: UIViewController, toView view: UIView? = nil,aniamte : Bool = true ,transitionType:TransitionType = .fromTop , fadeEnable:Bool = false) {
           if childViewController.isModal() {
               childViewController.dismiss(animated: aniamte, completion: nil)
           }else{

                
                if aniamte {
                   UIView.animate(withDuration: SHOW_ANIMATION_TIME, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1, options: .curveEaseOut) {
                    switch transitionType {
                    case .fromLeft:
                        childViewController.view.transform = CGAffineTransform(translationX: self.view.transform.tx + UIScreen.main.bounds.size.width, y: 0)

                    case .fromRight:
                        childViewController.view.transform = CGAffineTransform(translationX:self.view.transform.tx - UIScreen.main.bounds.size.width, y: 0)

                    case .fromTop:
                        childViewController.view.transform = CGAffineTransform(translationX: 0, y: self.view.transform.ty+UIScreen.main.bounds.size.height)

                    case .fromBottom:
                        childViewController.view.transform = CGAffineTransform(translationX: 0, y:self.view.transform.ty-UIScreen.main.bounds.size.height)

                    case .Zoom:
                        childViewController.view.transform = CGAffineTransform(scaleX: 0.0, y: 0.0)
                   
                    case .None:
                        break
                    }
                    
                    if fadeEnable {
                        childViewController.view.alpha = 0
                    }
                    
               } completion: { _ in
                       self.removeChildVC(childViewController)
               }
                
            }else{
                self.removeChildVC(childViewController)

            }
           }
       }
    
    

   public func removeChildVC(_ childViewController: UIViewController) {
           childViewController.removeFromParent()
           childViewController.willMove(toParent: nil)
           childViewController.removeFromParent()
           childViewController.didMove(toParent: nil)
             childViewController.view.removeFromSuperview()
             view.layoutIfNeeded()
         }
    
    
    public  func addChildViewController(childViewController : UIViewController , parentView:UIView? = nil , aniamte:Bool , heightConstant:CGFloat = 0) {
        let view: UIView = view ?? self.view
  childViewController.removeFromParent()
  childViewController.willMove(toParent: self)
  if aniamte {
      childViewController.view.transform = CGAffineTransform(translationX: 0, y: UIScreen.main.bounds.size.height)
  }
  
  addChild(childViewController)
  childViewController.didMove(toParent: self)
        childViewController.view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(childViewController.view)
        childViewController.view.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: heightConstant == 0 ? view.frame.height : heightConstant)
        
  if aniamte {
      UIView.animate(withDuration: SHOW_ANIMATION_TIME, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 1, options: .curveLinear) {
          childViewController.view.transform = .identity
      } completion: { _ in
          
      }

      
  }

        view.layoutIfNeeded()
    }
      
}


//
//public extension Bundle {
//    static func getPodBundle(for fileName:String , ext: String) -> Bundle?    {
//
//
//        if Bundle.main.path(forResource: fileName, ofType: ext) != nil {
//            return  Bundle.main
//        } else {
//           let bundles =  Bundle.allBundles
//            for bundle in bundles {
//                if bundle.path(forResource: fileName, ofType: ext) != nil {
//                   return bundle
//                }
//            }
//        }
//return nil
//
//    }
//}





public extension UILabel {
   func autoAdjustFont(){
          
       let margin : CGFloat = 0.8
       
          // Try all font sizes from largest to smallest font size
          var fontSize: CGFloat = 100

          // Fit label width wize
          let constraintSize = CGSize(width: CGFloat(MAXFLOAT) , height: CGFloat(MAXFLOAT))
          
       
          var hi:Int = 400
          var lo: Int = 5
          var mid:Int = (Int)(hi + lo)/2
          var labelSize: CGSize!
          repeat {
              // Set current font size
           self.font = UIFont(name: self.font.fontName, size: CGFloat(mid))

              labelSize = self.sizeThatFits(constraintSize) //textRect.size
              // Done, if created label is within target size
           if labelSize.height < self.frame.height * margin  && labelSize.width < self.frame.width * margin {
                  lo = mid + 1
              } else{
                  hi = mid - 1
              }
              mid = (Int)(hi + lo)/2
              //self. = labelSize
          } while lo <= hi
          
          fontSize = CGFloat(mid)
          
       self.font = UIFont(name: self.font.fontName, size: fontSize)
      }
}

public extension UINib {
   
   func instantiate() -> Any? {
       
       return self.instantiate(withOwner: nil, options: nil).first
   }
 
}


extension UICollectionViewCell : IdentifiableCell {

   public static var identifier: String {
       
       return "\(self)"
   }
}
extension UITableViewCell : IdentifiableCell {

   public static var identifier: String {
       
       return "\(self)"
   }
}

extension UIButton{

   func setImageTintColor(_ color: UIColor , state: UIControl.State = .normal) {
       let tintedImage = self.imageView?.image?.withRenderingMode(.alwaysTemplate)
       self.setImage(tintedImage, for: state)
       self.tintColor = color
   }

}
