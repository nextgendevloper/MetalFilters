//
//  AppStandardInfo.swift
//  Unknowns
//
//  Created by zmobile on 25/04/22.
//

import Foundation
import UIKit

public protocol AppStandardInfo {
    
  var Icon__Name                          : String {get}
  var Display__Name                       : String {get}
  var Appstore__AppLink                   : String {get}
  var Appstore__AppReview_Link            : String {get}
  var Bundle__ID                          : String {get}
  var Devloper_Account                    : Info.DeveloperAccount {get}
  var Support__Email                      : String {get}
  var AppStore__DeveloperAccount_Link     : String {get}
  var Privacy__Policy_Link                : String {get}
  var Terms__And_Condition_Link           : String {get}
  var iTunes_ValidationRecipt_URL         : String {get}
  var SandBox_ValidationRecipt_URL        : String {get}
    
}

public struct AdsAndSubscriptionModel {
    var appStore_AppID                      : String
    var oneTime_Subscription_Key            : String
    var monthly_Subscription_Key            : String
    var yearly_Subscription_Key             : String
    var googleAds__ID                       : String
    var interstatialAds__ID                 : String
    var bannerAds__ID                       : String
    var nativeAds_ID                        : String
    var inHouseAds_PackageName              : String
    var inHouseAds_GetConfig_Link           : String
    var interstatialAds_Link                : String
    var interstatial_HitCount_URL           : String
    var inHouse_MoreApps_Link               : String
    var inHouse_MoreApps_HitCount_Link      : String
    
    static var defaults : AdsAndSubscriptionModel {
        return AdsAndSubscriptionModel(appStore_AppID: "", oneTime_Subscription_Key: "", monthly_Subscription_Key: "", yearly_Subscription_Key: "", googleAds__ID: "", interstatialAds__ID: "", bannerAds__ID: "", nativeAds_ID: "", inHouseAds_PackageName: "", inHouseAds_GetConfig_Link: "", interstatialAds_Link: "", interstatial_HitCount_URL: "", inHouse_MoreApps_Link: "", inHouse_MoreApps_HitCount_Link: "")
    }
    public init(appStore_AppID: String,
                oneTime_Subscription_Key: String,
                monthly_Subscription_Key: String,
                yearly_Subscription_Key: String,
                googleAds__ID: String,
                interstatialAds__ID: String,
                bannerAds__ID: String,
                nativeAds_ID: String,
                inHouseAds_PackageName: String,
                inHouseAds_GetConfig_Link: String,
                interstatialAds_Link: String,
                interstatial_HitCount_URL: String,
                inHouse_MoreApps_Link: String,
                inHouse_MoreApps_HitCount_Link: String) {
        self.appStore_AppID = appStore_AppID
        self.oneTime_Subscription_Key = oneTime_Subscription_Key
        self.monthly_Subscription_Key = monthly_Subscription_Key
        self.yearly_Subscription_Key = yearly_Subscription_Key
        self.googleAds__ID = googleAds__ID
        self.interstatialAds__ID = interstatialAds__ID
        self.bannerAds__ID = bannerAds__ID
        self.nativeAds_ID = nativeAds_ID
        self.inHouseAds_PackageName = inHouseAds_PackageName
        self.inHouseAds_GetConfig_Link = inHouseAds_GetConfig_Link
        self.interstatialAds_Link = interstatialAds_Link
        self.interstatial_HitCount_URL = interstatial_HitCount_URL
        self.inHouse_MoreApps_Link = inHouse_MoreApps_Link
        self.inHouse_MoreApps_HitCount_Link = inHouse_MoreApps_HitCount_Link
        
    }
    
}

public struct Info : AppStandardInfo  {
    public var OneTime_Subscription_Key: String {
        return subscriptionDetails.oneTime_Subscription_Key
    }
    
    public var Monthly_Subscription_Key: String {
        return subscriptionDetails.monthly_Subscription_Key
    }
    
    public var Yearly_Subscription_Key: String {
        return subscriptionDetails.yearly_Subscription_Key
    }
    
    public var GoogleAds__ID: String {
        return subscriptionDetails.googleAds__ID
    }
    
    public var InterstatialAds__ID: String {
        return subscriptionDetails.interstatialAds__ID
    }
    
    public var BannerAds__ID: String {
        return subscriptionDetails.bannerAds__ID
    }
    
    public var NativeAds_ID: String {
        return subscriptionDetails.nativeAds_ID
    }
    
    public var InHouseAds_PackageName: String {
        return subscriptionDetails.inHouseAds_PackageName
    }
    
    public var InHouseAds_GetConfig_Link: String {
        return subscriptionDetails.inHouseAds_GetConfig_Link
    }
    
    public var InterstatialAds_Link: String {
        return subscriptionDetails.interstatialAds_Link
    }
    
    public var Interstatial_HitCount_URL: String {
        return subscriptionDetails.interstatial_HitCount_URL
    }
    
    public var InHouse_MoreApps_Link: String {
        return subscriptionDetails.inHouse_MoreApps_Link
    }
    
    public var InHouse_MoreApps_HitCount_Link: String {
        return subscriptionDetails.inHouse_MoreApps_HitCount_Link
    }
    
    public var Icon__Name: String {
        return "appIcon"
    }
    
    public var Display__Name: String {
        return Bundle.appName()
    }
    
    public var Appstore__AppLink: String {
        return "https://apps.apple.com/us/app/\(subscriptionDetails.appStore_AppID)"
    }
    
    public var Appstore__AppReview_Link: String {
        return "https://apps.apple.com/us/app/\(subscriptionDetails.appStore_AppID)?action=write-review"
    }
    
    public var Bundle__ID: String {
        return Bundle.main.bundleIdentifier ?? ""
    }
    
    public var Devloper_Account: DeveloperAccount {
        return devAccount
    }
    
    public var Support__Email: String {
        return Devloper_Account == .IrisStudio ? "irisstudio345@gmail.com" : "help.simplyentertaining@gmail.com"
    }
    
    public var AppStore__DeveloperAccount_Link: String {
        return Devloper_Account == .IrisStudio ? "https://apps.apple.com/us/developer/saraswati-javalkar/id1305053157" : "https://apps.apple.com/tr/developer/simply-entertaining-llc/id1052676820"
    }
    
    public var Privacy__Policy_Link: String {
        return Devloper_Account == .IrisStudio ? "https://irisstudioprivacypolicy.wordpress.com" : "http://www.simplyentertaining.us/privacypolicy.html"
    }
    
    public var Terms__And_Condition_Link: String {
        return Devloper_Account == .IrisStudio ? "https://irisstudioprivacypolicy.wordpress.com/2018/06/20/termsofservice/" : "http://www.simplyentertaining.us/terms-and-conditions.html"
    }
    
    public var iTunes_ValidationRecipt_URL: String {
        return  "https://buy.itunes.apple.com/verifyReceipt"
    }
    
    public var SandBox_ValidationRecipt_URL: String {
        return "https://sandbox.itunes.apple.com/verifyReceipt"
    }
    
    
    private var devAccount : DeveloperAccount = .IrisStudio
    private var subscriptionDetails : AdsAndSubscriptionModel
 
    
    public  init(developerAccount:Info.DeveloperAccount , _ subScriptionModel : AdsAndSubscriptionModel) {
        self.devAccount = developerAccount
        self.subscriptionDetails = subScriptionModel
    }
    
    public  enum DeveloperAccount : String {
        case IrisStudio = "IrisStudio"
        case SimplyEntertaining = "SimplyEntertaning"
    }
    

   
}

public protocol AppUniqueDetails {
   static  func setDeveloperAccount() -> Info.DeveloperAccount?
   static func setADsAndSubscriptionDetails() -> AdsAndSubscriptionModel?
}




//
//var APP_THEME = AppColors(darkColor: .white, lightColor: .darkGray, highLightColor: .orange, textColor: .black)
//
//var APP_FONTS = AppFontName()
//
//let APP_ICON_NAME = "TextroIcon"
//
//let APP_NAME = "Textro"
//
//let APP_LINK = "https://apps.apple.com/us/app/textro-animated-text-videos/id1475746046"
//
//let APP_REVEIW_LINK = "https://apps.apple.com/us/app/textro-animated-text-videos/id1475746046?action=write-review"
//
//let BUNDLE_IDENTIFIER = "com.irisstudio.textro"
//
//let DEVELOPER_ACCOUNT_NAME = "irisstudio"
//
//let SUPPORT_EMAIL =  "irisstudio345@gmail.com"
//
//let DEVELOPER_ACCOUNT_LINK = "https://apps.apple.com/us/developer/saraswati-javalkar/id1305053157"
//
//let PRIVACY_POLICY_LINK = "https://irisstudioprivacypolicy.wordpress.com"
//
//let TERMS_AND_CONDITION_LINK = "https://irisstudioprivacypolicy.wordpress.com/2018/06/20/termsofservice/"
//
//let GOOGLE_APP_ID = "ca-app-pub-8451337763779485~8523789480"
//
//let INTERSTITIAL_ID = "ca-app-pub-8451337763779485/6452159918"
//
//let BANNER_ID = "ca-app-pub-8451337763779485/5728490783"
//
//let NATIVE_ID = "ca-app-pub-8451337763779485/4009829403"
//
//let PACKAGE_NAME = "com.irisstudio.Textro.ios"
//
//let APP_CONFIG_URL = "http://aegisdemoserver.in/SEGAds/webservices/AppConfigs/getAppConfigs.php?packageName="
//
//let INTERSTITIAL_ADS_LINK = "http://aegisdemoserver.in/SEGAds/webservices/InHouseAds/Interstitial_IOS.php?"
//
//let MORE_APPS_LINK = "http://aegisdemoserver.in/SEGAds/webservices/InHouseAds/MoreApps_IOS.php?"
//
//let HIT_COUNT_URL = "http://aegisdemoserver.in/SEGAds/webservices/InHouseAds/InterstitialAnalytics_IOS.php?Id="
//
//let MORE_APP_COUNT_URL = "http://aegisdemoserver.in/SEGAds/webservices/InHouseAds/MoreAppsAnalytics_IOS.php?Ad_Id="
//
//let ONE_TIME_PLAN_KEY = "com.irisstudio.Textro.pro"
//
//let MONTHLY_PLAN_KEY = ""
//
//let YEARLY_PLAN_KEY = ""
//
//let VALIDATION_RECIPT_URL = "https://buy.itunes.apple.com/verifyReceipt"
//
//let VALIDATION_RECIPT_URL_SANDBOX = "https://sandbox.itunes.apple.com/verifyReceipt"


// weights
// font size and weights
// primary secondary



// LARGE
// TITE
// CAPTION1 - PRIMARY 10
// CAPTION2 - PRIMARY 10

// BODY

// NAVIGATION_TITLE -> CAPTION
// TABBAR
