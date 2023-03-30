//
//  MTLContext.swift
//  MetalFilters
//
//  Created by HKBeast on 24/03/23.
//

import Foundation
import UIKit
import Metal

class MTLContext{
       let device: MTLDevice!
    /// Single command queue
       let commandQueue: MTLCommandQueue
       /// Metal file in your local project
       let defaultLibrary: MTLLibrary
    
   static let shared = MTLContext()
    
    init() {
         guard let device = MTLCreateSystemDefaultDevice() else {
             fatalError("Could not create Metal Device")
         }
         self.device = device
         
         guard let queue = device.makeCommandQueue() else {
             fatalError("Could not create command queue")
         }
         self.commandQueue = queue
         
         if #available(OSX 10.12, *) {
             self.defaultLibrary = try! device.makeDefaultLibrary(bundle: Bundle.main)
         } else {
             self.defaultLibrary = device.makeDefaultLibrary()!
         }
      
         
       
     }
    
    
    deinit {
        print("Device is deinit.")
    }
}
