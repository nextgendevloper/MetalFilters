//
//  ResourceHelper.swift
//  IOSMediaView
//
//  Created by JD on 8/25/20.
//

import UIKit

public class Resource {
    
    static func getPodBundle(for name : String , ext : String , className : AnyClass = Resource.self) -> Bundle? {
        
        let appBundle = Bundle(for: className.self)
        if let bundleUrl = appBundle.url(forResource: "IOS_CommonUtil", withExtension: "bundle") {
            if let podBundle = Bundle(url: bundleUrl) {
                if podBundle.url(forResource: name, withExtension: ext) != nil {
                    return podBundle
                }
            }
        }else  if Bundle.main.path(forResource: name, ofType: ext) != nil {
            return  Bundle.main
        }
        return nil
    }
    
    static func getImage(name: String , ext : String = "png") -> UIImage? {
        if let bundle = Resource.getPodBundle(for: name, ext: ext) {
            if #available(iOS 13.0, *) {
                if let image = UIImage(named: name, in: bundle, with: nil) {
                    return image
                }
            } else {
                if let image =  UIImage(named: name, in: bundle, compatibleWith: nil) {
                    return image
                }
               
            }
        }
        return nil
    }

    public class func  getNibFromPodBundle<T: UINib>(named name: String, cellIdentifier : String ,bundle: Bundle? = nil, filesOwner: AnyObject = NSNull.init(),className : AnyClass) -> T? {
        if let nib : T =  createNib(named: name, bundle: bundle, filesOwner: filesOwner, className: className) {
              return nib
            }
              return nil
               }
        
    fileprivate  class func createNib<T: UINib>(named name: String, bundle: Bundle? = nil, filesOwner: AnyObject = NSNull.init(),className : AnyClass)  -> T? {
            var resolvedBundle: Bundle?
            if let bundle = bundle {
           resolvedBundle = bundle
            }else{
                resolvedBundle = Resource.getPodBundle(for: name, ext: "nib",className: className)
            }

        if let cellNib = UINib(nibName: name, bundle: resolvedBundle) as? T {
            return cellNib
        }
            return nil
        }
  
    
    
    

        
    
}
/// Flexible Function To Load Image From Path
/// - Parameter path: you can pass either
///                                          - Image name
///                                          - directoryPath of image
///
/// - Returns: UIImage object (Optional )
public func loadImage(path:String )->UIImage?{
    if let image = UIImage(named: path){
                   return image
               }else {
                guard let image = IOSDirectory_Manager.getImageFromDirectory(imagePath: path)  else {return nil}
                  return image
               }
}

public func getTopPadding() -> CGFloat? {
    let window = UIApplication.shared.keyWindow
    let topPadding = window?.safeAreaInsets.top
    return topPadding
}

public func getBottomPadding() -> CGFloat? {
    let window = UIApplication.shared.keyWindow
    let bottomPadding = window?.safeAreaInsets.bottom
    return bottomPadding
}

public func setFont( ipad : CGFloat , iPhone : CGFloat , style : UIFont.Weight) -> UIFont{
    switch style {
    case .regular , .medium:
        return UIFont.systemFont(ofSize: I_Am_Ipad == true ? ipad : iPhone)
    case .bold:
        return UIFont.boldSystemFont(ofSize: I_Am_Ipad == true ? ipad : iPhone)
    
    default:
        return UIFont.systemFont(ofSize: I_Am_Ipad == true ? ipad : iPhone)
    }
}


public func + (left: UIColor, right: UIColor) -> UIColor {
    var (r1, g1, b1, a1) = (CGFloat(0), CGFloat(0), CGFloat(0), CGFloat(0))
    var (r2, g2, b2, a2) = (CGFloat(0), CGFloat(0), CGFloat(0), CGFloat(0))
    left.getRed(&r1, green: &g1, blue: &b1, alpha: &a1)
    right.getRed(&r2, green: &g2, blue: &b2, alpha: &a2)
    return UIColor(red: (r1 + r2)/2, green: (g1 + g2)/2, blue: (b1 + b2)/2, alpha: (a1 + a2)/2)
}
public var RTL : Bool {
    return UIApplication.shared.userInterfaceLayoutDirection == .rightToLeft ? true : false
}
public var I_Am_Ipad : Bool {
    return UIDevice.current.userInterfaceIdiom == .phone ? false : true
}
