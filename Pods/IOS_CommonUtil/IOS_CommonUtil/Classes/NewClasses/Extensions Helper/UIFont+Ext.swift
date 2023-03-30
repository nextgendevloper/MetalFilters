//
//  UIFont+Ext.swift
//  IOS_CommonUtil
//
//  Created by Developer on 7/15/21.
//

import Foundation
//
//  Font Manager.swift
//  Textro - Text Intro Maker
//
//  Created by JD on 6/21/21.
//  Copyright © 2021 irissolutions. All rights reserved.
//

import Foundation
public struct AppFontName {
  static var regular = "AvenirNext-Regular"
  static var bold = "AvenirNext-Medium"
  static var lightAlt = "AvenirNext-MediumItalic"
                    
}

extension UIFontDescriptor.AttributeName {
    public static let nsctFontUIUsage = UIFontDescriptor.AttributeName(rawValue: "NSCTFontUIUsageAttribute")
}

extension UIFont {
    /// standard apps regular font - default SF Display Regular
    static var AppRegularFont : String = "Helvetica"
    /// standard apps Bold font - default SF Display Medium
    static var AppBoldFont : String = "Helvetica"
    
  @objc class func mySystemFont(ofSize size: CGFloat) -> UIFont? {
        return UIFont(name: AppRegularFont, size: size)
  }

  @objc class func myBoldSystemFont(ofSize size: CGFloat) -> UIFont? {
        return UIFont(name: AppBoldFont, size: size)  }

/// telling what stuff to overide in apple font environment
  @objc convenience init(myCoder aDecoder: NSCoder) {
    guard
        let fontDescriptor = aDecoder.decodeObject(forKey: "UIFontDescriptor") as? UIFontDescriptor,
        let fontAttribute = fontDescriptor.fontAttributes[.nsctFontUIUsage] as? String else {
        self.init(myCoder: aDecoder)
        return
    }
    var fontName = ""
    switch fontAttribute {
    case "CTFontRegularUsage":
        fontName = Self.AppRegularFont
    case "CTFontEmphasizedUsage", "CTFontBoldUsage":
        fontName = Self.AppBoldFont
    default:
        fontName = Self.AppRegularFont
    }
      self.init(name: fontName, size: fontDescriptor.pointSize)!
  }

    /// replace default system and bold method with custom mySystemFont(_:),myBoldSystemFont(_:)
    public  class func overrideInitialize(regularFont:String , boldFont:String) {
        AppRegularFont = regularFont
        AppBoldFont = boldFont
    guard self == UIFont.self else { return }

      // replace Normal Font AppRegularFont
    if let systemFontMethod = class_getClassMethod(self, #selector(systemFont(ofSize:))),
        let mySystemFontMethod = class_getClassMethod(self, #selector(mySystemFont(ofSize:))) {
        method_exchangeImplementations(systemFontMethod, mySystemFontMethod)
    }

      // replace Bold Font With AppBoldFont
    if let boldSystemFontMethod = class_getClassMethod(self, #selector(boldSystemFont(ofSize:))),
        let myBoldSystemFontMethod = class_getClassMethod(self, #selector(myBoldSystemFont(ofSize:))) {
        method_exchangeImplementations(boldSystemFontMethod, myBoldSystemFontMethod)
    }

        // TODO: Italic Font - Future

//    if let italicSystemFontMethod = class_getClassMethod(self, #selector(italicSystemFont(ofSize:))),
//        let myItalicSystemFontMethod = class_getClassMethod(self, #selector(myItalicSystemFont(ofSize:))) {
//        method_exchangeImplementations(italicSystemFontMethod, myItalicSystemFontMethod)
//    }

    if let initCoderMethod = class_getInstanceMethod(self, #selector(UIFontDescriptor.init(coder:))), // Trick to get over the lack of UIFont.init(coder:))
        let myInitCoderMethod = class_getInstanceMethod(self, #selector(UIFont.init(myCoder:))) {
        method_exchangeImplementations(initCoderMethod, myInitCoderMethod)
    }
  }


/// scaling custom font to match system font
     func appleCompatibleFont( textStyle : UIFont.TextStyle) -> UIFont {
       
        let metrics = UIFontMetrics(forTextStyle: textStyle)
        let scaledFont = metrics.scaledFont(for: self)
        
        return scaledFont
}
}
