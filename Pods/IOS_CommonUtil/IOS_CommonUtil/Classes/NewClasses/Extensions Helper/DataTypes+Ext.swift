//
//  DataTypes+Ext.swift
//  IOS_CommonUtil
//
//  Created by Developer on 7/15/21.
//

import Foundation
public extension CGFloat {
    func pixelsToPoints() -> CGFloat {
        return self / CGFloat(UIScreen.main.scale)
    }
    func pointsToPixel() -> CGFloat {
        return self * CGFloat(UIScreen.main.scale)
    }
}

public extension CGRect {
    func calculatePrespective(xRotation: CGFloat, yRotation: CGFloat)-> prespectiveRect{
        // cWidth & cHeight
        
        // Reset Values
        var topLeftPoint = CGPoint(x: 0, y: self.height)
        var topRightPoint = CGPoint(x: self.width, y: self.height)
        var bottomRightPoint = CGPoint(x: self.width, y: 0)
        var bottomLeftPoint = CGPoint(x: 0, y: 0)
        
        // Four Points
        if(xRotation>0)
        {
            // xRotation is Positive
            // TopLeft X and TopRight X
            topLeftPoint.x = topLeftPoint.x + (self.width * xRotation/100)
            topRightPoint.x = topRightPoint.x - (self.width * xRotation/100)
            // xRotation is Negative
            bottomLeftPoint.x = bottomLeftPoint.x - (self.width * xRotation/100)
            bottomRightPoint.x = bottomRightPoint.x + (self.width * xRotation/100)
            
            // Adjust Y
            topLeftPoint.y = topLeftPoint.y - (self.height * xRotation/100)
            topRightPoint.y = topRightPoint.y - (self.height * xRotation/100)
            bottomLeftPoint.y = bottomLeftPoint.y + (self.height * xRotation/100)
            bottomRightPoint.y = bottomRightPoint.y + (self.height * xRotation/100)
            
            
        } else
        {
            // xRotation is Negative
            topLeftPoint.x = topLeftPoint.x + (self.width * xRotation/100)
            topRightPoint.x = topRightPoint.x - (self.width * xRotation/100)
            bottomLeftPoint.x = bottomLeftPoint.x - (self.width * xRotation/100)
            bottomRightPoint.x = bottomRightPoint.x + (self.width * xRotation/100)
            
            // Adjust Y
            topLeftPoint.y = topLeftPoint.y + (self.height * xRotation/100)
            topRightPoint.y = topRightPoint.y + (self.height * xRotation/100)
            bottomLeftPoint.y = bottomLeftPoint.y - (self.height * xRotation/100)
            bottomRightPoint.y = bottomRightPoint.y - (self.height * xRotation/100)
        }
        // apply y Rotation
        if(yRotation>0)
        {
            
            bottomRightPoint.y = bottomRightPoint.y + (self.height * yRotation/100)
            topRightPoint.y = topRightPoint.y - (self.height * yRotation/100)
            bottomLeftPoint.y = bottomLeftPoint.y - (self.height * yRotation/100)
            topLeftPoint.y = topLeftPoint.y + (self.height * yRotation/100)
            
            // Left Points of X Should Go In
            topLeftPoint.x = topLeftPoint.x + (self.width * yRotation/100)
            bottomLeftPoint.x = bottomLeftPoint.x + (self.width * yRotation/100)
            // Right Points of X Should Go In
            topRightPoint.x = topRightPoint.x - (self.width * yRotation/100)
            bottomRightPoint.x = bottomRightPoint.x - (self.width * yRotation/100)
            
        } else
        {
            
            // xRotation is Negative
            bottomLeftPoint.y = bottomLeftPoint.y - (self.height * yRotation/100)
            topLeftPoint.y = topLeftPoint.y + (self.height * yRotation/100)
            bottomRightPoint.y = bottomRightPoint.y + (self.height * yRotation/100)
            topRightPoint.y = topRightPoint.y - (self.height * yRotation/100)
            
            // Left Points of X Should Go In
            topLeftPoint.x = topLeftPoint.x - (self.width * yRotation/100)
            bottomLeftPoint.x = bottomLeftPoint.x - (self.width * yRotation/100)
            // Right Points of X Should Go In
            topRightPoint.x = topRightPoint.x + (self.width * yRotation/100)
            bottomRightPoint.x = bottomRightPoint.x + (self.width * yRotation/100)
            
        }
        
 
        let prespectiveRectanglePoints: prespectiveRect = prespectiveRect(topLeftPoint: topLeftPoint,topRightPoint : topRightPoint, bottomRightPoint: bottomRightPoint,bottomLeftPoint : bottomLeftPoint)
        return prespectiveRectanglePoints
    }
}
