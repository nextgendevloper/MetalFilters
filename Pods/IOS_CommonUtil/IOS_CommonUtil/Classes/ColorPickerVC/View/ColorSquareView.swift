//
//  ColorSquareView.swift
//  HueKit
//
//  Created by Louis D'hauwe on 25/07/2017.
//  Copyright © 2017 Silver Fox. All rights reserved.
//

import UIKit

@IBDesignable
open class ColorSquareView: UIImageView {

	private var drawnHue: CGFloat = 0.0
	
	@IBInspectable
	open var hue: CGFloat = 0.0 {
		didSet {

			if self.image != nil && abs(drawnHue - hue) <= 1e-10 {
				return
			}
			
			let cgImage = HSBGen.createSaturationBrightnessSquareContentImageWithHue(hue: self.hue * 360.0)
			
			if let cgImage = cgImage {
				self.image = UIImage(cgImage: cgImage)
			} else {
				assertionFailure("Expected CGImage")
			}
			
			drawnHue = hue
		}
	}
    open override func draw(_ rect: CGRect) {
        self.borderColor = .white
        self.borderWidth = 1.0
        self.layer.cornerRadius = 15.0
    }
	
}
