//
//  Protocols.swift
//  IOS_CommonUtil
//
//  Created by JD on 8/17/20.
//

import Foundation
public protocol IdentifiableCell: AnyObject {
    
    static var identifier: String { get }
}
