//
//  Permissions.swift
//  IOS_CommonUtil
//
//  Created by JD on 8/25/20.
//

import Photos
import AdSupport
import MediaPlayer
import UserNotifications

#if canImport(AppTrackingTransparency)
import AppTrackingTransparency
#endif

public class Permissions : NSObject {
    
    public static var defaults = Permissions()
     
     @available(iOS 14, *)
    public typealias trackingStatus = ATTrackingManager.AuthorizationStatus
    public typealias photoAccessStatus  = PHAuthorizationStatus
    public typealias musicAccessStatus  = MPMediaLibraryAuthorizationStatus

     /**
      key : NSUserTrackingUsageDescription
     value : allow tracking so that app can deliver personlised ads for you.
      */
     @available(iOS 14, *)
   public  func askForAdsTracking(completion : @escaping ((trackingStatus, SwiftError?) -> Void)) {
         ATTrackingManager.requestTrackingAuthorization { (status) in
             switch status {
             case .authorized :
                 completion(status,nil)
                 
             case .denied , .notDetermined , .restricted :
                completion(status,SwiftError.permissionMessage(.photoAccessDenied))
                 
             @unknown default:
                 fatalError()
             }
         }
     }
     
     
     
     
    public func askForPhotoLibraryStatus(completion : @escaping ((photoAccessStatus, SwiftError?) -> Void)) {
         if #available(iOS 14, *) {
             onCheckForPhotoLibraryAccess { (status, error) in
                 completion(status,error)
             }
         }
         else {
            PHPhotoLibrary.requestAuthorization { (status) in
             
             switch status {
             case .authorized ,.limited:
                 completion(status,nil)
                 
             case .denied , .notDetermined , .restricted :
                completion(status,SwiftError.permissionMessage(.photoAccessDenied))
                 
             @unknown default:
                 fatalError()
             }
            }
         }
     }
    public func isPhotoLibraryAccessAllowed() -> Bool {
        
        switch PHPhotoLibrary.authorizationStatus() {
     
        case .authorized ,.limited:
            return true
            
        case .denied , .notDetermined , .restricted :
          return false
            
        @unknown default:
            fatalError()
        
        }
    }
    public func isAppTransparencyAllowed() -> Bool {
        if #available(iOS 14, *) {
            switch ATTrackingManager.trackingAuthorizationStatus {
                
            case .authorized :
                return true
                
            case .denied , .notDetermined , .restricted :
                return false
                
            @unknown default:
                fatalError()
                
            }
        } else {
            // Fallback on earlier versions
            return true
        }
    }
    public func isPhotoPermissionRequired() -> Bool {
        
        switch PHPhotoLibrary.authorizationStatus() {
     
        case .authorized ,.limited , .denied :
            return true
            
        case .notDetermined , .restricted :
          return false
            
        @unknown default:
            fatalError()
        
        }
    }
    public func isAppTrackingPermissionRequired() -> Bool {
        if #available(iOS 14, *) {
            switch ATTrackingManager.trackingAuthorizationStatus {
                
            case .authorized , .denied:
                return true
                
            case .notDetermined , .restricted :
                return false
                
            @unknown default:
                fatalError()
                
            }
        } else {
            // Fallback on earlier versions
            return true
        }
    }
    
     
     @available(iOS 14.0 , *)
    private func onCheckForPhotoLibraryAccess(for level: PHAccessLevel = .readWrite,completion : @escaping ((photoAccessStatus, SwiftError?) -> Void)) {
         let status = PHPhotoLibrary.authorizationStatus(for: level)
         switch status {
         case .authorized, .limited: // *
             completion(status,nil)
         case .notDetermined:
             PHPhotoLibrary.requestAuthorization() { status in
                DispatchQueue.main.async {
                    let a = status == .authorized
                    let b = status == .limited
                    if a || b {
                         completion(status,nil)
                    }else{
                        completion(status,SwiftError.permissionMessage(.photoAccessDenied))
                    }
                 }
             }
         case .denied , .restricted :
            completion(status,SwiftError.permissionMessage(.photoAccessDenied))
             
         @unknown default:
             fatalError()

     }
    }
    
 

    public func isMusicLibraryAccessAllowed() -> Bool {
   switch MPMediaLibrary.authorizationStatus() {
       case .authorized:
        return true
        
       case .notDetermined,.denied , .restricted:
            return false
       
       @unknown default:
       break
   }
       return false
}

    public func askForMusicLibraryAccess(completion : @escaping ((musicAccessStatus, SwiftError?) -> Void)){
    MPMediaLibrary.requestAuthorization { (status) in
        switch status {
        case .authorized :
            completion(status,nil)

        case .denied , .notDetermined , .restricted :
            completion(status,SwiftError.permissionMessage(.musicAccessDenied))

        @unknown default:
            fatalError()
            
        }
}
}
    
    
    public   func askForLocalNotificationAccess(completion : @escaping ((Bool, SwiftError?) -> Void)){
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
         
            if granted{
            completion(granted, nil)
            }else{
                completion(granted,SwiftError.permissionMessage(.notificationAccessDenied))
            }
            // Enable or disable features based on the authorization.
        }
        

    }
}
