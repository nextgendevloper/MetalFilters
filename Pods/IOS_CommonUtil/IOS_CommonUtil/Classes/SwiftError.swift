//
//  SwiftError.swift
//  IOS_CommonUtil
//
//  Created by JD on 8/17/20.
//

import Foundation
/**
 The `SwiftError` enum contains the errors thrown by App.
 */
public enum SwiftError: Error , LocalizedError {

   
    case custom(title : String , message : String? , actionLabel : String?)
    case toast(_ title : String)
    case float( _ title : String , message : String?)
    case generalMessage(_ message : GeneralMessages)
    case applicationMessage( _ message : ApplicationMessage)
    case apiMessage( _ message : APIMessage)
    case permissionMessage ( _  message : PermissionMessages)

    
    public var info : ErrorInfo {

        switch self {
            
        case let .custom(title: title, message: message, actionLabel: actionLabel) :
        return ErrorInfo(title: title, message: message, actionLabel: actionLabel)
            
        case let .toast(title):
            
            return ErrorInfo(title: title, message: nil, actionLabel: nil)

        case let .float(title, message: message):
        return ErrorInfo(title: title, message: message, actionLabel: nil)
            
        case .generalMessage(let message) :
            return message.info
            
        case .apiMessage(let message) :
            return message.info
            
        case .applicationMessage(let message):
            return message.info
            
        case .permissionMessage(let message) :
        return message.info
            
        }
    }
    
    
}



public struct ErrorInfo {
    public  var title : String?
    public  var message : String? = ""
    public var actionLabel : String? = ""
 
}

public enum GeneralMessages  : Int {
    
    case noInternet = 0
    case UnderContsruction = 1
    case Loading = 2
    case savingFailed = 3
    case savingSuccessful = 4
    
    public var info : ErrorInfo {
        
        return GeneralMessages.messageCode[self.rawValue]!
    }
    
      static var messageCode : [Int : ErrorInfo] =
            [
                0 : ErrorInfo(title: "_NoInternet".translate(), message: "_NoInternet_Body".translate()),
                1 : ErrorInfo(title: "Coming Soon", message: "This Feature is coming soon"),
                2 : ErrorInfo(title: "Loading", message: "Please wait while loading"),
                3 : ErrorInfo(title: "_ErrorWhileSaving".translate(), message: "_SomethingWentWrongPleaseTryAgain".translate(), actionLabel: "_Done".translate()),
                4 : ErrorInfo(title: "_SavedSuccessfully".translate(), message: "_SavedSuccessfully".translate(), actionLabel: "_Done".translate())
            ]
    
}
public enum ApplicationMessage : Int{
    case AppNotInstalled = 0
    case AppReadContent = 1
    
    public var info : ErrorInfo {
        return ApplicationMessage.messageCode[self.rawValue]!
    }
    
    static var messageCode : [Int : ErrorInfo] =
          [
            0 : ErrorInfo(title: "_AppNotInstalled".translate(), message: "_AppNotInstalled_msg_".translate()),
            1 : ErrorInfo(title: "_ErrorOcuured".translate(), message: "_AppReadContent_msg_".translate()),
            
          ]
}

public enum APIMessage : Int{
    case ServerFailedToOpen = 0
    case NoResponse = 1
    
    public var info : ErrorInfo {

            switch self {
            case .ServerFailedToOpen :
                return ErrorInfo(title: "Oops", message: "Server Failed To Load")
    
            case .NoResponse :
                return APIMessage.messageCode[self.rawValue]!
            }
    }
    
      static  var messageCode : [Int : ErrorInfo] =
            [
                0 : ErrorInfo(title: "Oops", message: "Server Failed To Load"),
                1 : ErrorInfo(title: "No Response", message: "Unable To Get Response")
            ]

    
}
public enum PermissionMessages : Int{
    case photoAccessDenied = 0
    case musicAccessDenied = 1
    case notificationAccessDenied = 2
    public var info : ErrorInfo {

            switch self {
    
            case .photoAccessDenied ,.musicAccessDenied , .notificationAccessDenied:
                return PermissionMessages.messageCode[self.rawValue]!
            }
    
    }
    
      static  var messageCode : [Int : ErrorInfo] =
            [
                0 : ErrorInfo(title: "_PermissionError".translate(), message: "\("_askForPhotoPermissionChange_main_".translate()) \n\n1." +
                    "\("_askForPhotoPermissionChange_step1_".translate()) \n\n2." +
                    "\("_askForPhotoPermissionChange_step2_".translate()) \n\n3." +
                                "_askForPhotoPermissionChange_step3_".translate() ,actionLabel: "_OpenSettings".translate()),
                1 : ErrorInfo(title: "_PermissionError".translate(), message: "\("_askForMusicPermissionChange_main_".translate()) \n\n1." +
                    "\("_askForMusicPermissionChange_step1_".translate()) \n\n2." +
                    "\("_askForMusicPermissionChange_step2_".translate()) \n\n3." +
                                "_askForMusicPermissionChange_step3_".translate() ,actionLabel: "_OpenSettings".translate()),
                2 : ErrorInfo(title: "_PermissionError".translate(), message: "\("_askForNotificationPermissionChange_main_".translate()) \n\n1." +
                    "\("_askForNotificationPermissionChange_step1_".translate()) \n\n2." +
                    "\("_askForNotificationPermissionChange_step2_".translate()) \n\n3." +
                                "_askForNotificationPermissionChange_step3_".translate() ,actionLabel: "_OpenSettings".translate())
            
            ]

    
}



