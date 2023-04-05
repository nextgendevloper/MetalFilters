//
//  Compute.swift
//  MetalFilters
//
//  Created by HKBeast on 24/03/23.
//

import Foundation
import Metal

final class Compute {

    static var deviceSupportsNonuniformThreadgroups = MTLContext.shared.defaultLibrary.device.supportsFeatureSet(.iOS_GPUFamily4_v1)
    static var pipelineState: MTLComputePipelineState? = nil
    static var effect:CGFloat = 0.0

  
   static func getPipelineState(filterModel:ColorAdjustProtocol) -> MTLComputePipelineState? {
//       effect = CGFloat(filterModel.value)

        let constantValues = MTLFunctionConstantValues()
        constantValues.setConstantValue(&self.deviceSupportsNonuniformThreadgroups,
                                        type: .bool,
                                        index: 0)
       do {
           let function =  try MTLContext.shared.defaultLibrary.makeFunction(name: filterModel.kernalName,
                                                                             constantValues: constantValues)
           self.pipelineState =  try MTLContext.shared.defaultLibrary.device.makeComputePipelineState(function: function)
           return pipelineState
       } catch {
           return nil
       }
       
     
    }


  

static func adjustColor(textures:[MTLTexture],model:ColorAdjustProtocol,state:MTLComputePipelineState){
        // buffer = Mcontext.commandQueue.makeBuffer()
    var filterModel = model
        let commandBuffer = MTLContext.shared.commandQueue.makeCommandBuffer()
        // Encoder = buffer.makeComputeEncoder()
        guard let encoder = commandBuffer?.makeComputeCommandEncoder()
        else { return }
        
        //set texture
        encoder.setComputePipelineState(state)
    
    var atIndex = 0
         for texture in textures {
            encoder.setTexture(texture,index: atIndex)
             atIndex += 1
        }
        
        // encoder.setBytes(filter.value , Float.size)
    var count = 0
    for val in filterModel.value{
        var value:Float = val
        encoder.setBytes(&value,
                             length: MemoryLayout<Float>.size,
                             index: count)
        count += 1
    }
   
    if let filter = model as? SpecialColorAdjust{
        filter.setupSpecialParameters(encoder: encoder, index: count)
    }

        let gridSize = MTLSize(width: textures[0].width,
                               height: textures[0].height,
                               depth: 1)
        let threadGroupWidth = state.threadExecutionWidth
        let threadGroupHeight = state.maxTotalThreadsPerThreadgroup / threadGroupWidth
        let threadGroupSize = MTLSize(width: threadGroupWidth,
                                      height: threadGroupHeight,
                                      depth: 1)

        encoder.setComputePipelineState(state)

        if Compute.deviceSupportsNonuniformThreadgroups {
            encoder.dispatchThreads(gridSize,
                                    threadsPerThreadgroup: threadGroupSize)
        } else {
            let threadGroupCount = MTLSize(width: (gridSize.width + threadGroupSize.width - 1) / threadGroupSize.width,
                                           height: (gridSize.height + threadGroupSize.height - 1) / threadGroupSize.height,
                                           depth: 1)
            encoder.dispatchThreadgroups(threadGroupCount,
                                         threadsPerThreadgroup: threadGroupSize)
        }
    
    
          // Too large some Gpus are not supported. Too small gpus have low efficiency
          // 2D texture, depth set to 1
//          let threadGroupCount = MTLSize(width: 16, height: 16, depth: 1)
//          let destTexture = textures[0]
//          // +1 Objective To solve the problem that the edges of images are not drawn
//          let w = max(Int((destTexture.width + threadGroupCount.width - 1) / threadGroupCount.width), 1)
//          let h = max(Int((destTexture.height + threadGroupCount.height - 1) / threadGroupCount.height), 1)
//          let threadGroups = MTLSizeMake(w, h, destTexture.arrayLength)
//        
//        encoder.dispatchThreadgroups(threadGroups, threadsPerThreadgroup: threadGroupCount)

        encoder.endEncoding()
    
    commandBuffer?.commit()
    commandBuffer?.waitUntilCompleted()
    commandBuffer?.addCompletedHandler({ buffer in
        print("DOne")
    })
    }
}


//final class Compute1{
//    func getPipeLineState(model:FilterModel){
//        let function = MTLContext.shared.defaultLibrary.makeFunction(name: model.name)
//        self.pipelineState = try MTLContext.shared.defaultLibrary.device.makeComputePipelineState(function: function)
//    }
//}
