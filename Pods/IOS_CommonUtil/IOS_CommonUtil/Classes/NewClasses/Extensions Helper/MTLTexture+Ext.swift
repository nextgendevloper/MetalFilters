//
//  MTLTexture+Ext.swift
//  IOS_CommonUtil
//
//  Created by Developer on 7/15/21.
//

import Foundation
extension MTLTexture {
  
    public  func bytes() -> UnsafeMutableRawPointer {
    let width = self.width
    let height = self.height
    let rowBytes = self.width * 4
    let p = malloc(width * height * 4)!
    
        self.getBytes(p, bytesPerRow: rowBytes, from: MTLRegionMake2D(0, 0, width, height), mipmapLevel: 0)
    
    return p
  }
    public func toImage() -> CGImage? {
       let p = bytes()
       
       let pColorSpace = CGColorSpaceCreateDeviceRGB()
       
        let rawBitmapInfo = CGImageAlphaInfo.noneSkipFirst.rawValue | CGBitmapInfo.byteOrder32Little.rawValue
        
       let bitmapInfo:CGBitmapInfo = CGBitmapInfo(rawValue: rawBitmapInfo)
        let selftureSize = self.width * self.height * 4
        let rowBytes = self.width * 4
        let releaseMaskImagePixelData: CGDataProviderReleaseDataCallback = { (info: UnsafeMutableRawPointer?, data: UnsafeRawPointer, size: Int) -> () in
            return
        }

        guard let provider = CGDataProvider(dataInfo: nil, data: p, size: selftureSize, releaseData: releaseMaskImagePixelData) else {
            return nil
            
        }
        let cgref = CGImage(width: self.width, height: self.height, bitsPerComponent: 8, bitsPerPixel: 32, bytesPerRow: rowBytes, space: pColorSpace, bitmapInfo: bitmapInfo, provider: provider, decode: nil, shouldInterpolate: true, intent: CGColorRenderingIntent.defaultIntent)
        return cgref
        

}
}
