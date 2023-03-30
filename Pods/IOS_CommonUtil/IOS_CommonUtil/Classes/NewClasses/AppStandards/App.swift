//
//  UI.swift
//  Unknowns
//
//  Created by JD on 22/04/22.
//

import Foundation
import UIKit
/*
 
 
 
 
 */
// APP.Info.SupportEmail
// App.Primary
// App.ThemeColor.faded()
// App.PrimaryFont.Title

/// Use This static Object App to handle And get appstandard Colors,Fonts,UI-Defaults,AppDetails
public struct App : AppStandardColors , AppStandardFont {
    static public func RegularFont(_ style: FontStyles, autoAdjustForIpad: Bool = true) -> UIFont {
       return Fonts.getAppleCompatibleFont(style: style, automaticallyAdjustForIpad: autoAdjustForIpad, fontChoice: .Regular)
    }
    
   static  public func RegularFont(_ iPhoneStyle: FontStyles, iPadStyle: FontStyles) -> UIFont {
        
        return Fonts.getAppleCompatibleFont(iPhoneStyle: iPhoneStyle, iPadStyle: iPadStyle, fontChoice: .Regular)

    }
    
    static  public func RegularFont(_ iPhoneSize: CGFloat, iPadSize: CGFloat) -> UIFont {
        return Fonts.isIpad ? Fonts.getAppleCompatibleFont(size: iPadSize, fontChoice: .Regular) :  Fonts.getAppleCompatibleFont(size: iPhoneSize, fontChoice: .Regular)
        

    }
    
   static public func BoldFont(_ style: FontStyles, autoAdjustForIpad: Bool = true ) -> UIFont {
        return Fonts.getAppleCompatibleFont(style: style, automaticallyAdjustForIpad: autoAdjustForIpad, fontChoice: .Bold)

    }
    
    static public  func BoldFont(_ iPhoneStyle: FontStyles, iPadStyle: FontStyles) -> UIFont {
        return Fonts.getAppleCompatibleFont(iPhoneStyle: iPhoneStyle, iPadStyle: iPadStyle, fontChoice: .Bold)
    }
    
   static  public  func BoldFont(_ iPhoneSize: CGFloat, iPadSize: CGFloat) -> UIFont {
        return Fonts.isIpad ? Fonts.getAppleCompatibleFont(size: iPadSize, fontChoice: .Regular) :  Fonts.getAppleCompatibleFont(size: iPhoneSize, fontChoice: .Bold)

    }
    
  
    static public func setAccountName(_ name : Info.DeveloperAccount , uniqueDetailsModel:AdsAndSubscriptionModel) {
        informationAboutAppAndSubscription = Info(developerAccount: name, uniqueDetailsModel)
    }
    
    private static var informationAboutAppAndSubscription : Info? = nil
    
    public static var info : Info{
        if let details = informationAboutAppAndSubscription{
            return details
        } else{
            showthatError()
            return Info(developerAccount: .IrisStudio, AdsAndSubscriptionModel.defaults)
        }
    }
    
    
    private static func showthatError(){
        DispatchQueue.main.asyncAfter(deadline: .now()+3.0, execute: {
            if let view = UIApplication.shared.keyWindowPresentedController {
                view.showAlert("Account Details Missing", message: "Call 'App.setAccount(_:,model_:) mthod in appDelegate setup and confront with AppUniqueDetails For easy access")
            }
        })
    }
    
    
}
