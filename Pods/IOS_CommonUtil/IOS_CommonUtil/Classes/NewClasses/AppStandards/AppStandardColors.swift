//
//  AppStandardColors.swift
//  Unknowns
//
//  Created by JD on 22/04/22.
//

import Foundation
import UIKit

// MARK: - PROTOCOLS

/// Standard Available Colros For Application Color Scheme
public protocol AppStandardColors {
    
    static var Primary : UIColor {get}
    static var Secondary : UIColor {get}
    static var ThemeColor : UIColor {get}
    static var DefaultColor : UIColor {get}
    static var DefaultLight : UIColor { get}
    
    static var Warning : UIColor {get}
    static var Success : UIColor {get}
    static var Informative : UIColor {get}
    static var Negation : UIColor {get}
    static var Error : UIColor {get}

}

public extension UIColor {
    /// fades given color with fixed 0.7 opacity
    func faded()->UIColor {
        return self.withAlphaComponent(0.7)
    }
    /// return fade color with passed alpha value  in paramter. Range - 0.0-1.0
    func alpha(_ v: CGFloat)->UIColor {
        return self.withAlphaComponent(v)
    }
}

// Default Implemenation - fetch colors from app assets default given
public extension AppStandardColors {
   
    static  var Primary : UIColor {
        return UIColor(named: "Primary", in: Bundle.main, compatibleWith: nil) ?? .black
    }
    static  var Secondary : UIColor {
        return UIColor(named: "Secondary", in: Bundle.main, compatibleWith: nil) ?? .gray
    }
    
    static var ThemeColor : UIColor {
        return UIColor(named: "ThemeColor", in: Bundle.main, compatibleWith: nil) ?? .blue
    }
    
    static var DefaultColor : UIColor {
        return UIColor(named: "DefaultColor", in: Bundle.main, compatibleWith: nil) ?? .white
    }
    static var DefaultLight : UIColor {
        return UIColor(named: "DefaultLight", in: Bundle.main, compatibleWith: nil) ?? .gray
    }
    static var G : UIColor {
        return UIColor(named: "DefaultLight", in: Bundle.main, compatibleWith: nil) ?? .gray
    }
    
    static  var Warning : UIColor {
        return UIColor(named: "Warning", in: Bundle.main, compatibleWith: nil) ?? .black
    }
    static  var Success : UIColor {
        return UIColor(named: "Success", in: Bundle.main, compatibleWith: nil) ?? .gray
    }
    
    static var Informative : UIColor {
        return UIColor(named: "Informative", in: Bundle.main, compatibleWith: nil) ?? .blue
    }
    
    static var Negation : UIColor {
        return UIColor(named: "Negation", in: Bundle.main, compatibleWith: nil) ?? .white
    }
    static var Error : UIColor {
        return UIColor(named: "Error", in: Bundle.main, compatibleWith: nil) ?? .white
    }
}
