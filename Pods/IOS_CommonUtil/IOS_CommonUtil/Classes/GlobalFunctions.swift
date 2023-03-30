//
//  GlobalFunctions.swift
//  IOS_CommonUtil
//
//  Created by JD on 8/17/20.
//

import Foundation

public func launchApp(_ url: URL, options: [UIApplication.OpenExternalURLOptionsKey : Any] = [:], completionHandler completion: ((Bool) -> Void)? = nil) -> SwiftError? {
    if UIApplication.shared.canOpenURL(url)
    {
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
       return nil
    }
    else
    {
        return SwiftError.applicationMessage(.AppNotInstalled)
    }
}

public func getData(image:UIImage)->Data? {
    return image.pngData() ?? nil
}

public func getData(videoOrAudio:URL) -> Data? {
    do {
       return try Data(contentsOf: videoOrAudio)
    }
    catch {
        return nil
    }
}
