//
//  GradientViewController.swift
//  LogoMaker
//
//  Created by Anjana on 7/18/18.
//  Copyright © 2018 Saraswati Javalkar. All rights reserved.
//

import UIKit

public protocol GradientPickerVCDelegate: AnyObject {
    func gradientPicker(_ gradientPicker: GradientPickerVC!, didChange colorModel:AddColorModel)
}

public class GradientPickerVC: ReusableControlView {
    let SCREEN_WIDTH : CGFloat = min(UIScreen.main.bounds.size.width, UIScreen.main.bounds.size.height)
    
    @IBOutlet weak var replaceButton: UIButton!
    @IBOutlet weak var titleName: UILabel!
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var baseViewTop: NSLayoutConstraint!
    @IBOutlet weak var baseView: UIView!
    @IBOutlet weak var radialImageView: UIImageView!
    @IBOutlet weak var firstView: UIView!
    @IBOutlet weak var gradientView: UIView!
    @IBOutlet weak var colorPickerContainerView: UIView!
    @IBOutlet weak var startBtn: UIButton!
    @IBOutlet weak var endBtn: UIButton!
    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var radiusSlider: UISlider!
    
    @IBOutlet weak var linearStackView: UIStackView!
    @IBOutlet weak var radialStackView: UIStackView!
    @IBOutlet weak var colorPickerTop: NSLayoutConstraint!
    @IBOutlet weak var linearStackLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var radialStackLeadingConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var endColorLabel: UILabel!
    @IBOutlet weak var startColorLabel: UILabel!
    @IBOutlet weak var radialSliderIcon: UIImageView!
    @IBOutlet weak var downBtn: UIButton!
    @IBOutlet weak var leftBtn: UIButton!
    @IBOutlet weak var bottomLeftBtn: UIButton!
    @IBOutlet weak var bottomRightBtn: UIButton!
    
    public override var appColors: AppColors {
        didSet {
            super.appColors = appColors
            baseView.backgroundColor = .clear
            cancelButton.setTitleColor(appColors.light.lighter(), for: .normal)
            doneButton.setTitleColor(appColors.textColor, for: .normal)
            titleName.textColor = appColors.textColor
            [leftBtn,downBtn,bottomLeftBtn,bottomRightBtn].forEach({ button in
                button.tintColor = appColors.light
            })
            startColorLabel.textColor = appColors.light
            endColorLabel.textColor = appColors.light

            radiusSlider.minimumTrackTintColor = appColors.highLight
            radiusSlider.maximumTrackTintColor = appColors.light
            radiusSlider.thumbTintColor = appColors.highLight
            if #available(iOS 13.0, *) {
                radialSliderIcon.tintColor = appColors.light
            } else {
                // Fallback on earlier versions
            }
            let fontAttr = setFont(ipad: 15, iPhone: 12, style: .medium)

            self.segmentControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: appColors.textColor,NSAttributedString.Key.font : fontAttr], for: .selected)
            self.segmentControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: appColors.light,NSAttributedString.Key.font : fontAttr], for: .normal)
            if #available(iOS 13.0, *) {
                self.segmentControl.selectedSegmentTintColor = appColors.highLight
            } else {
                // Fallback on earlier versions
            }
            self.segmentControl.backgroundColor = UIColor.clear

        }
    }
    
    var aspectRatio = "1:1"
    var gradientLayer: CAGradientLayer!
    var colorSets = [[CGColor]]()
    lazy var colorPickerView : ColorPickerVC = {
        let vc = ColorPickerVC.createInstance()
        vc.delegate = self
        return vc
    }()
    public var defaultColor : AddColorModel = AddColorModel() {
        didSet {
            setGradColors(for: defaultColor)
        }
    }
    private var finalColorModel : AddColorModel!
    var currentIndex:IOSLinearGradType = .LeftRight
    
    public  var delegate:GradientPickerVCDelegate?
    
    func setGradColors(for model: AddColorModel) {
        finalColorModel = model
        segmentControl.selectedSegmentIndex = model.typeOfGradient  == .Linear ? 0 : 1
        startBtn.backgroundColor = model.grad_firstColor
        endBtn.backgroundColor = model.grad_secondColor
        startColorLabel.text = model.grad_firstColor.hexString
        endColorLabel.text = model.grad_secondColor.hexString

        createColorSets()
        
        if model.typeOfGradient == .Linear {
            switchLinearGradButton(type: model.typeForLinearGrad)
            layoutLinearView()
            
        }else{
            radiusSlider.value = Float(model.radiusForRadialGrad)
            layoutRadialView()
            
        }
    }
    
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        showMinimizer = true
        self.segmentControl.setTitle("_Linear".translate(), forSegmentAt: 0)
        self.segmentControl.setTitle("_Radial".translate(), forSegmentAt: 1)

        setGradColors(for: defaultColor)
        baseViewTop.constant = showMinimizer == true ? -25 : 0
        titleName.text = "_Gradient".translate()
        cancelButton.setTitle("_Cancel".translate(), for: .normal)
        doneButton.setTitle("_Done".translate(), for: .normal)
    }
    public static func createInstance()->GradientPickerVC {
        let podBundle = Bundle(for: GradientPickerVC.self)
        let bundleUrl = podBundle.url(forResource: "IOS_CommonUtil", withExtension: "bundle")
        let bundle = Bundle(url: bundleUrl!)!
        let shareDirectVC  = GradientPickerVC(nibName: "GradientPickerVC", bundle: bundle)
        return shareDirectVC
    }
    
    
    public override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        createGradientLayer()
    }
    
    // MARK:- BUTTON ACTIONS
    @IBAction func cancelDidPressed(_ sender: UIButton) {
        removeOrDismissViewController(self)
    }
    @IBAction func doneDidPressed(_ sender: UIButton) {
        delegate?.gradientPicker(self, didChange:finalColorModel )
        removeOrDismissViewController(self)
    }
    
    @IBAction func startColorBtnDidTapped(_ sender: UIButton) {
        colorPickerView.view.tag = 1111
        self.addChildVCWithMultiplier(colorPickerView, toView: self.view, aniamte: true,heightMultiplier: 0.35)
        colorPickerView.presentMode = .Mini
        colorPickerView.defaultColor = AddColorModel(solidColor: sender.backgroundColor ?? .white)
        colorPickerView.appColors = appColors

    }
    
    @IBAction func endColorBtnDidTapped(_ sender: UIButton) {
        
        colorPickerView.view.tag = 2222
        self.addChildVCWithMultiplier(colorPickerView, toView: self.view, aniamte: true,heightMultiplier: 0.35)
        colorPickerView.presentMode = .Mini
        colorPickerView.defaultColor = AddColorModel(solidColor: sender.backgroundColor ?? .black)
        colorPickerView.appColors = appColors

    }
    
    @IBAction func upDirectionBtnDidTapped(_ sender: UIButton) {
        finalColorModel.typeForLinearGrad = .UpDown
        switchLinearGradButton(type: .UpDown)
        createGradientLayer()
    }
    
    @IBAction func leftDirectionBtnDidTapped(_ sender: UIButton) {
        switchLinearGradButton(type: .LeftRight)
        finalColorModel.typeForLinearGrad = .LeftRight
        createGradientLayer()
        
        
    }
    
    @IBAction func leftTopDirectionBtnDidTapped(_ sender: UIButton) {
        switchLinearGradButton(type: .TopLeftToBottomRight)
        finalColorModel.typeForLinearGrad = .TopLeftToBottomRight
        createGradientLayer()
    }
    
    @IBAction func bottomRightBtnDidTap(_ sender: UIButton) {
        switchLinearGradButton(type: .BottomLeftToTopRight)
        finalColorModel.typeForLinearGrad = .BottomLeftToTopRight
        createGradientLayer()
    }
    
    func switchLinearGradButton(type: IOSLinearGradType) {
        
        switch type {
        case .UpDown:
            downBtn.tintColor = appColors.highLight
            [leftBtn,bottomLeftBtn,bottomRightBtn].forEach({ button in
                button.tintColor = appColors.light
            })
           
        case .LeftRight:
            leftBtn.tintColor = appColors.highLight
            [downBtn,bottomLeftBtn,bottomRightBtn].forEach({ button in
                button.tintColor = appColors.light
            })
        case .BottomLeftToTopRight :
            bottomRightBtn.tintColor = appColors.highLight
            [leftBtn,downBtn,bottomLeftBtn].forEach({ button in
                button.tintColor = appColors.light
            })
        case .TopLeftToBottomRight:
            bottomLeftBtn.tintColor = appColors.highLight
            [leftBtn,bottomRightBtn,downBtn].forEach({ button in
                button.tintColor = appColors.light
            })
        }
    }
    
    @IBAction func exchnageBtnDidTapped(_ sender: UIButton) {
        
        let bgColorOfBStartBtn = self.startBtn.backgroundColor
        self.startBtn.backgroundColor = self.endBtn.backgroundColor
        self.endBtn.backgroundColor = bgColorOfBStartBtn
        finalColorModel.grad_firstColor =  self.startBtn.backgroundColor!
        finalColorModel.grad_secondColor =  self.endBtn.backgroundColor!
        
        startColorLabel.text = self.startBtn.backgroundColor!.hexString
        endColorLabel.text = self.endBtn.backgroundColor!.hexString

        colorSets = []
        createColorSets()
        createGradientLayer()
        
    }
    
    
    //MARK:- SEGEMNT ACTION
    @IBAction func segmentDidTapped(_ sender: UISegmentedControl) {
        
        if sender.selectedSegmentIndex == 0 {
            finalColorModel.typeOfGradient = .Linear
            layoutLinearView()
            createGradientLayer()
            self.view.animateView()
        } else {
            finalColorModel.typeOfGradient = .Radial
            layoutRadialView()
            createGradientLayer()
            self.view.animateView()
            
        }
    }
    
    
    
    
    func layoutRadialView() {
        linearStackLeadingConstraint.constant = -SCREEN_WIDTH
        radialStackLeadingConstraint.constant = 0
        linearStackView.isHidden = true
        radialStackView.isHidden = false
    }
    
    func layoutLinearView() {
        linearStackLeadingConstraint.constant = 0
        radialStackLeadingConstraint.constant = -SCREEN_WIDTH
        linearStackView.isHidden = false
        radialStackView.isHidden = true
    }
    
    //MARK:-SLIDER ACTION
    @IBAction func radiusValueChange(_ sender: UISlider) {
        finalColorModel.radiusForRadialGrad = CGFloat(sender.value)
        createGradientLayer()
    }
    
    //MARK:- SCREEN TAP ACTION
    @IBAction func taponScreen(_ sender: UITapGestureRecognizer) {
        self.children.forEach { vc in
            removeChildVC(vc)
        }
    }
    
    
    // MARK:- CREATE GRADIENT
    func createGradientLayer() {
        
        let string = aspectRatio
        var ratioWidth:Int?
        var ratioHeight:Int?
        // RK Test
        
        
        if string != "" {
            let splittedString = string.split(separator: ":")
            let firstPart = splittedString[0]
            let secondPart = splittedString[1]
            ratioWidth = Int(firstPart)
            ratioHeight = Int(secondPart)
        }
        
        
        let size  = getWorkingViewSize(aspectRatioSize: CGSize(width: ratioWidth!, height: ratioHeight!), width: radialImageView.frame.size.width, height: radialImageView.frame.size.height)
        
        let image = finalColorModel.gradientImage(withReferenceSize: size)
        radialImageView.image = image
        self.view.setNeedsDisplay()
        
    }
    
    //MARK:- Assign COLORS
    func createColorSets() {
        colorSets = []
        colorSets.append([(startBtn.backgroundColor?.cgColor)!, (endBtn.backgroundColor?.cgColor)!])
    }
    
    
    
}

extension GradientPickerVC: ColorPickerVCDelegate {
    public func colorPicker(_ colorPicker: ColorPickerVC!, didChange colorModel: AddColorModel) {
        if (colorPicker.view.tag == 1111) {
            finalColorModel.grad_firstColor = colorModel.solidColor
            setGradColors(for: finalColorModel)
            createGradientLayer()
        } else if (colorPicker.view.tag == 2222) {
            finalColorModel.grad_secondColor = colorModel.solidColor
            setGradColors(for: finalColorModel)
            createGradientLayer()
        }
    }
    
    
    
}

func valueFromPoint(xValue: CGFloat, yValue: CGFloat) -> CGPoint{
    return CGPoint(x: xValue, y: yValue)
}

func getWorkingViewSize(aspectRatioSize: CGSize, width: CGFloat, height: CGFloat) -> CGSize {
    
    //
    var newWidth = width
    var newHeight = newWidth * aspectRatioSize.height/aspectRatioSize.width
    
    if(newHeight > height)
    {
        newHeight = height
        newWidth = newHeight * aspectRatioSize.width/aspectRatioSize.height
    }
    let WorkingViewSize = CGSize(width: newWidth, height: newHeight)
    return WorkingViewSize
}



