//
//  File.swift
//  MetalFilters
//
//  Created by HKBeast on 24/03/23.
//

import Foundation
import UIKit

class HomeViewModel{
    
    var listOfFilters:[ColorAdjustProtocol]
    var currentfilter:ColorAdjustProtocol?
    var currentImage:UIImage?
    var onSliderValueChanged:((UIImage?)->())?
    var onSliderMinMax:((CGFloat?,CGFloat?,Float?)->())?
    
    
    init(){
        self.listOfFilters = filters
    }
    func didSelect(indexPath:IndexPath){
        print("selected IndexPath", indexPath)
       
            currentfilter = listOfFilters[indexPath.item]
            onSliderValueChanged?(getColorAdjustImage())
        onSliderMinMax?(currentfilter?.min,currentfilter?.max, currentfilter?.value)
            
        
      
    }
    
    func valueChanged(_ value:CGFloat){
        currentfilter?.value = Float(value)
        onSliderValueChanged?(getColorAdjustImage())
        
    }
   
    
    func countOfFilter()->Int{
        return listOfFilters.count
    }
    
    func getColorAdjustImage()->UIImage?{
       
        let inputTexture = currentImage?.toTexture()
        
        let outputTexture = inputTexture
        
         let textures = [inputTexture!,outputTexture!]
       let pipeLineState =  Compute.getPipelineState(filterModel: currentfilter!)
    
        Compute.adjustColor(textures: textures, model: currentfilter!, state: pipeLineState!)
        
        
        return outputTexture?.toUIImage()
        
    }
  
}

func addSepiaTone(_ inputImage:UIImage)->UIImage{
    let context = CIContext()
    
    let sepiaFilter = CIFilter(name:"CISepiaTone")
    let inputImage = CIImage(cgImage: inputImage.cgImage!)
    sepiaFilter?.setValue(inputImage, forKey: kCIInputImageKey)
    sepiaFilter?.setValue(0.9, forKey: kCIInputIntensityKey)
    let sepiaCIImage = sepiaFilter?.outputImage
    let cgOutputImage = context.createCGImage(sepiaCIImage!, from: inputImage.extent)
    return UIImage(cgImage: cgOutputImage!)
}
