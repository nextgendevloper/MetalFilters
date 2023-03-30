//
//  AppStandardFont.swift
//  Unknowns
//
//  Created by JD on 25/04/22.
//

import Foundation
import UIKit

// MARK: - Protocols

/// Available Standard Fonts
public protocol AppStandardFont  {
    static func RegularFont(_ style : FontStyles , autoAdjustForIpad : Bool) -> UIFont
    static func RegularFont(_ iPhoneStyle : FontStyles , iPadStyle : FontStyles) -> UIFont
    static func RegularFont(_ iPhoneSize : CGFloat  , iPadSize : CGFloat) -> UIFont

    static func BoldFont(_ style : FontStyles  , autoAdjustForIpad : Bool) -> UIFont
    static func BoldFont(_ iPhoneStyle : FontStyles , iPadStyle : FontStyles) -> UIFont
    static func BoldFont(_ iPhoneSize : CGFloat  , iPadSize : CGFloat) -> UIFont
    
}


// MARK: - FontChoice enum
/// appfont to chosse from
public enum FontChoice {
    /// Normal font - Dafault Font if you will - use for common text
    case Regular
    /// Bold Font - Highlight or header font if you will - use for highlighing titles etc
    case Bold
}

// MARK: - FontStyles enum
/// set of generic fontSize to choose from ( Different Font Size - Apples TextStyle Under the hood )
public enum FontStyles {
    case ExtraLarge
    case VeryLarge
    case Large
    case Medium
    case Normal
    case Small
    case VerySmall
    case ExtraSmall
    case Mini
    case Tiny
  
    /// converts fontStyles to Apple TextStyles and returns
    public func appleTextStyle()->UIFont.TextStyle {
        switch self {
            
        case .ExtraLarge : return UIFont.TextStyle.largeTitle
        case .VeryLarge : return  UIFont.TextStyle.title1
        case .Large : return  UIFont.TextStyle.title2
        case .Medium : return  UIFont.TextStyle.title3
        case .Normal : return  UIFont.TextStyle.body
        case .Small : return  UIFont.TextStyle.callout
        case .VerySmall : return  UIFont.TextStyle.subheadline
        case .ExtraSmall : return  UIFont.TextStyle.footnote
        case .Mini : return  UIFont.TextStyle.caption1
        case .Tiny : return  UIFont.TextStyle.caption2
        }
    }
    
    public static var allStyles : [FontStyles] = [.ExtraLarge,.VeryLarge,.Large,.Medium,.Normal,.Small,.VerySmall,.ExtraSmall,.Mini,.Tiny]
}



/// structure repsresent and manages under the hood font conversion and setting up actual font - must use indirectly via `App` class.
 struct Fonts {
    static var isIpad : Bool {
         return UIDevice.current.userInterfaceIdiom == .pad
     }
   private static var systemFonts: [UIFont.TextStyle: UIFont] = [
    .largeTitle: UIFont(name: UIFont.AppRegularFont, size: 34)!,
        .title1: UIFont(name: UIFont.AppRegularFont, size: 28)!,
        .title2: UIFont(name: UIFont.AppRegularFont, size: 22)!,
        .title3: UIFont(name: UIFont.AppRegularFont, size: 20)!,
        .body: UIFont(name: UIFont.AppRegularFont, size: 17)!,
        .callout: UIFont(name: UIFont.AppRegularFont, size: 16)!,
        .subheadline: UIFont(name: UIFont.AppRegularFont, size: 15)!,
        .footnote: UIFont(name: UIFont.AppRegularFont, size: 13)!,
        .caption1: UIFont(name: UIFont.AppRegularFont, size: 12)!,
        .caption2: UIFont(name: UIFont.AppRegularFont, size: 11)!
    ]
   private static let boldFonts: [UIFont.TextStyle: UIFont] = [
        .largeTitle: UIFont(name: UIFont.AppBoldFont, size: 34)!,
        .title1: UIFont(name: UIFont.AppBoldFont, size: 28)!,
        .title2: UIFont(name: UIFont.AppBoldFont, size: 22)!,
        .title3: UIFont(name: UIFont.AppBoldFont, size: 20)!,
        .body: UIFont(name: UIFont.AppBoldFont, size: 17)!,
        .callout: UIFont(name: UIFont.AppBoldFont, size: 16)!,
        .subheadline: UIFont(name: UIFont.AppBoldFont, size: 15)!,
        .footnote: UIFont(name: UIFont.AppBoldFont, size: 13)!,
        .caption1: UIFont(name: UIFont.AppBoldFont, size: 12)!,
        .caption2: UIFont(name: UIFont.AppBoldFont, size: 11)!
    ]
     private static var systemFontsIpad: [UIFont.TextStyle: UIFont] = [
        .largeTitle: UIFont(name: UIFont.AppRegularFont, size: 42)!,
        .title1: UIFont(name: UIFont.AppRegularFont, size: 34)!,
        .title2: UIFont(name: UIFont.AppRegularFont, size: 29)!,
        .title3: UIFont(name: UIFont.AppRegularFont, size: 27)!,
        .body: UIFont(name: UIFont.AppRegularFont, size: 23)!,
        .callout: UIFont(name: UIFont.AppRegularFont, size: 22)!,
        .subheadline: UIFont(name: UIFont.AppRegularFont, size: 21)!,
        .footnote: UIFont(name: UIFont.AppRegularFont, size: 19)!,
        .caption1: UIFont(name: UIFont.AppRegularFont, size: 18)!,
        .caption2: UIFont(name: UIFont.AppRegularFont, size: 17)!
      ]
     // whats new thkur
//     private static let boldFontsIpad: [UIFont.TextStyle: UIFont] = [
//          .largeTitle: UIFont(name: UIFont.AppBoldFont, size: 46)!,
//          .title1: UIFont(name: UIFont.AppBoldFont, size: 44)!,
//          .title2: UIFont(name: UIFont.AppBoldFont, size: 41)!,
//          .title3: UIFont(name: UIFont.AppBoldFont, size: 36)!,
//          .body: UIFont(name: UIFont.AppBoldFont, size: 34)!,
//          .callout: UIFont(name: UIFont.AppBoldFont, size: 28)!,
//          .subheadline: UIFont(name: UIFont.AppBoldFont, size: 22)!,
//          .footnote: UIFont(name: UIFont.AppBoldFont, size: 20)!,
//          .caption1: UIFont(name: UIFont.AppBoldFont, size: 17)!,
//          .caption2: UIFont(name: UIFont.AppBoldFont, size: 15)!
//      ]
     
     private static let boldFontsIpad: [UIFont.TextStyle: UIFont] = [
          .largeTitle: UIFont(name: UIFont.AppBoldFont, size: 42)!,
          .title1: UIFont(name: UIFont.AppBoldFont, size: 34)!,
          .title2: UIFont(name: UIFont.AppBoldFont, size: 29)!,
          .title3: UIFont(name: UIFont.AppBoldFont, size: 27)!,
          .body: UIFont(name: UIFont.AppBoldFont, size: 23)!,
          .callout: UIFont(name: UIFont.AppBoldFont, size: 22)!,
          .subheadline: UIFont(name: UIFont.AppBoldFont, size: 21)!,
          .footnote: UIFont(name: UIFont.AppBoldFont, size: 19)!,
          .caption1: UIFont(name: UIFont.AppBoldFont, size: 18)!,
          .caption2: UIFont(name: UIFont.AppBoldFont, size: 17)!
      ]
     
     private static func getBoldFontFor(textStyle:UIFont.TextStyle)->UIFont? {
         return Fonts.isIpad ? boldFontsIpad[textStyle] : boldFonts[textStyle]!
     }
     private static func getRegularFontFor(textStyle:UIFont.TextStyle)->UIFont? {
         
         return Fonts.isIpad ? systemFontsIpad[textStyle] : systemFonts[textStyle]!
     }
     
    
   /// dynamic font masked by apple font system for given Textstyle
     public static func getAppleCompatibleFont(style:FontStyles,automaticallyAdjustForIpad : Bool ,fontChoice:FontChoice) -> UIFont {
        
        let textStyle = style.appleTextStyle()
        var font = fontChoice == .Bold ? boldFonts[textStyle] : systemFonts[textStyle]

         if automaticallyAdjustForIpad {
            font = fontChoice == .Bold ? getBoldFontFor(textStyle: textStyle) : getRegularFontFor(textStyle: textStyle)
         }
         return font?.appleCompatibleFont(textStyle: textStyle) ?? Fonts.getAppleCompatibleFont(size: 17, fontChoice: fontChoice)
    }
     /// dynamic font masked by apple font system for given Textstyle for ipad and iphone
     public static func getAppleCompatibleFont(iPhoneStyle:FontStyles,iPadStyle:FontStyles,fontChoice:FontChoice) -> UIFont {
          
           let iphoneStyle = iPhoneStyle.appleTextStyle()
           let iPadStyle = iPadStyle.appleTextStyle()
           var font : UIFont?
           if Fonts.isIpad {
               font = fontChoice == .Bold ?  boldFontsIpad[iPadStyle] : systemFontsIpad[iPadStyle]
               return font?.appleCompatibleFont(textStyle: iPadStyle) ?? Fonts.getAppleCompatibleFont(size: 22, fontChoice: fontChoice)

           }else{
                font = fontChoice == .Bold ? boldFonts[iphoneStyle] : systemFonts[iphoneStyle]
               return font?.appleCompatibleFont(textStyle: iphoneStyle) ?? Fonts.getAppleCompatibleFont(size: 17, fontChoice: fontChoice)
           }
           
      }
    
   /// dynamic font masked by apple font system for given fontSize
     public static func getAppleCompatibleFont(size:CGFloat,fontChoice:FontChoice) -> UIFont {
      
        return fontChoice == .Regular ? .systemFont(ofSize: size) : .boldSystemFont(ofSize: size)
    }
    
}



