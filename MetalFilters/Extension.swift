//
//  Extension.swift
//  MetalFilters
//
//  Created by HKBeast on 24/03/23.
//

import Foundation
import UIKit
import Metal

extension UIImage {
    
    func toTexture() -> MTLTexture? {
        //convert self into cg image
        guard let cgImage = self.cgImage else {
            return nil
        }
        
        
        // make texture discriptor
        let textureDescriptor = MTLTextureDescriptor.texture2DDescriptor(
            pixelFormat: .rgba8Unorm,
            width: cgImage.width,
            height: cgImage.height,
            mipmapped: false)
        textureDescriptor.usage = [.shaderRead , .shaderWrite]
        
        // pass descriptor to device make texture
        let texture = MTLContext.shared.device.makeTexture(descriptor: textureDescriptor)
        
        let bytesPerPixel = 4
        let bytesPerRow = bytesPerPixel * cgImage.width
        let imageData = UnsafeMutableRawPointer.allocate(byteCount: bytesPerRow * cgImage.height, alignment: bytesPerPixel)
        defer { imageData.deallocate() }
        
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let context = CGContext(data: imageData, width: cgImage.width, height: cgImage.height, bitsPerComponent: 8, bytesPerRow: bytesPerRow, space: colorSpace, bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue)
        
        context?.draw(cgImage, in: CGRect(x: 0, y: 0, width: cgImage.width, height: cgImage.height))
        
        let region = MTLRegionMake2D(0, 0, cgImage.width, cgImage.height)
        texture?.replace(region: region, mipmapLevel: 0, withBytes: imageData, bytesPerRow: bytesPerRow)
        
        return texture
    }
}

extension MTLTexture {
    func toUIImage() -> UIImage? {
        let width = self.width
        let height = self.height
        let pixelData = UnsafeMutableRawPointer.allocate(byteCount: width * height * 4, alignment: 1)
        self.getBytes(pixelData, bytesPerRow: width * 4, from: MTLRegionMake2D(0, 0, width, height), mipmapLevel: 0)
        
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.premultipliedLast.rawValue)
        let context = CGContext(data: pixelData, width: width, height: height, bitsPerComponent: 8, bytesPerRow: width * 4, space: colorSpace, bitmapInfo: bitmapInfo.rawValue)!
        
        let cgImage = context.makeImage()!
        let image = UIImage(cgImage: cgImage)
        
        pixelData.deallocate()
        
        return image
    }
}

