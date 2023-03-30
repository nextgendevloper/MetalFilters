//
//  Translation.swift
//  IOS_CommonUtil
//
//  Created by Developer on 10/19/20.
//

import Foundation

public struct Translation {
    
    public static func forkey(_ key : String)->String {
        return key.translate()
    }
    
}
