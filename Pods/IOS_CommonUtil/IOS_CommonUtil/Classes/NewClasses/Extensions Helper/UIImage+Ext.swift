//
//  UIImage+Ext.swift
//  IOS_CommonUtil
//
//  Created by Developer on 7/15/21.
//

import Foundation
public extension UIImage {
    //Function To Fix Image Oriantation
     func fixImageOrientation() -> UIImage {
        UIGraphicsBeginImageContext(self.size)
        self.draw(at: .zero)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage ?? self
    }
    
    func maskedImage(_ maskImage: UIImage , interpolate:Bool = true) -> UIImage? {
        if let maskImageCG = maskImage.cgImage , let mask: CGImage = CGImage(maskWidth: maskImageCG.width, height: maskImageCG.height, bitsPerComponent: maskImageCG.bitsPerComponent, bitsPerPixel: maskImageCG.bitsPerPixel, bytesPerRow: maskImageCG.bytesPerRow, provider: maskImageCG.dataProvider!, decode: nil, shouldInterpolate: interpolate) {
            if let masked: CGImage = self.cgImage?.masking(mask) {
                let result = UIImage(cgImage: masked)
                return result
            }
            return nil
        }
        return nil
    }
    
    // MARK:- GrayScale
    func grayScaleImage() -> UIImage {
        let imageRect = CGRect(x: CGFloat(0), y: CGFloat(0), width: CGFloat(self.size.width), height: CGFloat(self.size.height))
        let colorSpace: CGColorSpace? = CGColorSpaceCreateDeviceGray()
        let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.none.rawValue)
        let context = CGContext.init(data: nil, width: Int(size.width), height: Int(size.height), bitsPerComponent: 8, bytesPerRow: 0, space: colorSpace!, bitmapInfo: UInt32(bitmapInfo.rawValue))
        context?.draw(self.cgImage!, in: imageRect)
        let imageRef: CGImage = context!.makeImage()!
        let newImage = UIImage(cgImage: imageRef)
        return newImage
    }
     func tileImage(rect: CGRect, size: CGSize, value: CGFloat) -> UIImage? {
        
        let newSize = CGSize(width: rect.size.width / value , height: rect.size.width / value)
        
        UIGraphicsBeginImageContext(rect.size)
        let cgContext = UIGraphicsGetCurrentContext()
        
        
        // Apply transfrom getting uiimage as up
        var transform = CGAffineTransform.identity
        transform = CGAffineTransform(translationX: 0.0, y: newSize.height)
        transform = transform.scaledBy(x: 1.0, y: -1.0)
        cgContext?.translateBy(x: 0, y: -newSize.height)
        cgContext?.concatenate(transform)

        
        
        cgContext?.draw(self.cgImage!, in:CGRect(origin: rect.origin, size: newSize) , byTiling: true)
        
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return img
        
    }
    func tint(with fillColor: UIColor) -> UIImage? {
        let image = withRenderingMode(.alwaysTemplate)
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        fillColor.set()
        image.draw(in: CGRect(origin: .zero, size: size))

        guard let imageColored = UIGraphicsGetImageFromCurrentImageContext() else {
            return nil
        }

        UIGraphicsEndImageContext()
        return imageColored
    }
    
}
