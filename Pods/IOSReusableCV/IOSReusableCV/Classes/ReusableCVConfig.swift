//
//  ReusableCVConfig.swift
//  IOSReusableCV
//
//  Created by JD on 8/14/20.
//

import Foundation
import IOS_CommonUtil

public struct CVConfig {
    
    var cellClass : UICollectionViewCell
    var cellIdentifier : String
    var cellNib : UINib? = nil

   public var layout : ReusableCVLayout
    public var appColor : AppColors = AppColors(darkColor: .clear, lightColor: .blue, highLightColor: .darkGray, textColor: .white)
    
    public init(cellClass : UICollectionViewCell
        , cellIdentifier : String,reusableLayout : ReusableCVLayout = ReusableCVLayout.basic , cellNib : UINib? = nil ) {
        self.layout = reusableLayout
        self.cellClass = cellClass
        self.cellIdentifier = cellIdentifier
        self.cellNib = cellNib
    }
    public mutating func setColorTheme(appColor : AppColors) {
        self.appColor = appColor
    }
    
    
}
