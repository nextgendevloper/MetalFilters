//
//  ResuableProtocols.swift
//  Premium
//
//  Created by SimplyEntertaining on 5/18/22.
//
import UIKit
import Foundation


public protocol TextClickableInput {
    var title : VerticalAlignLabel! {get set}
    func setTitle(_ text : String, font:UIFont )
}

// defULT IMPLEMENTtion
extension TextClickableInput {
    public func setTitle(_ text : String,font : UIFont) {
        title.text = text
        title.font = font
        
    }
    
}

public protocol ImageClickableInput {
    var image : UIImageView! {get set}
    var imageName : String? {get set}
    func setImageByName(_ inputImageName : String)
    func setImage(_ inputImage : UIImage )
}

// defULT IMPLEMENTtion
extension ImageClickableInput {
    public  func setImage(_ inputImage: UIImage) {
        image.image = inputImage
       
    }
    public func setImageByName(_ inputImageName : String){
        image.image = UIImage(named: inputImageName)
    }
}

protocol SubTextClickableInput {
    var subTitle : VerticalAlignLabel! {get set}
   
    func setSubTitle(_ text : String)
}

// defULT IMPLEMENTtion
extension SubTextClickableInput {
    func setSubTitle(_ text : String) {
        subTitle.text = text
    }
}
