//
//  ColorPickerVC.swift
//  IOS_CommonUtil
//
//  Created by Developer on 6/2/21.
//

import Foundation

public protocol ColorPickerVCDelegate : AnyObject {
    func colorPicker(_ colorPicker: ColorPickerVC!, didChange colorModel:AddColorModel)

}
public class ColorPickerVC: ReusableControlView {
   public enum PresentMode {
        case Full
        case Mini
    }
    @IBOutlet weak var baseView: UIView!
    public weak var delegate : ColorPickerVCDelegate?
    @IBOutlet weak var navigationBar: UIStackView!
    
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var navigationTitle: UILabel!
    @IBOutlet weak var doneButton: UIButton!
    
    @IBOutlet weak var topColorBar: UIView!
    @IBOutlet weak var indicatorArea: UIView!
    
    @IBOutlet weak var spacerView: UIView!
    @IBOutlet weak var colorSquarePicker: ColorSquarePicker!
    
    @IBOutlet weak var squareAspectConstrain: NSLayoutConstraint!
    @IBOutlet weak var colorBarPicker: ColorBarPicker!
    @IBOutlet weak var pickedColorLabel: UILabel!
    @IBOutlet weak var pickedIndicator: UIView!
    @IBOutlet weak var hexIndicator: UILabel!
    public override class func awakeFromNib() {
    }
   
    @IBOutlet weak var baseViewTop: NSLayoutConstraint!
    public override func viewDidLoad() {
        showMinimizer = true
        super.viewDidLoad()
        setCustomColor(color: defaultColor?.solidColor ?? .blue)
        baseViewTop.constant = showMinimizer == true ? 25 : 0
        navigationTitle.text = "_Color".translate()
        cancelButton.setTitle("_Cancel".translate(), for: .normal)
        doneButton.setTitle("_Done".translate(), for: .normal)
    }
    
    public override var appColors: AppColors {
        didSet {
            super.appColors = appColors
            cancelButton.setTitleColor(appColors.light, for: .normal)
            navigationTitle.textColor = appColors.textColor
            doneButton.setTitleColor(appColors.textColor, for: .normal)
            baseView.backgroundColor = .clear
            
        }
    }
    
   
    public var defaultColor : AddColorModel? {
        didSet {
            if let color = defaultColor?.solidColor {
                setCustomColor(color: color)
              //  didChangeColor( colorSquarePicker.color )

            }else{
                didChangeColor( colorSquarePicker.color )

            }
          
         }
    }
    
    public var presentMode : PresentMode? = .Full {
        didSet {
           updateViewMode()
         }
    }
    @IBOutlet weak var mainStackView: UIStackView!
    
        
    func setCustomColor(color : UIColor) {
        didChangeColor(color)
        let hsv = color.rgbValue?.toHSV(preserveHS: true)
        colorSquarePicker.hue = hsv?.h ?? 0.0
        colorSquarePicker.value = CGPoint(x: hsv?.s ?? 0.0, y: hsv?.v ?? 0.0)
        colorBarPicker.hue = hsv?.h ?? 0.0
    }
     func updateViewMode(){
        pickedIndicator.superview?.isHidden = presentMode == .Full ? false : true
        navigationBar.isHidden = presentMode == .Full ? false : true
        topColorBar.isHidden = presentMode == .Full ? true : true
        indicatorArea.isHidden = presentMode == .Full ? false : true
        spacerView.isHidden = presentMode == .Full ? false : true
       // colorSquarePicker.heightAnchor.constraint(equalTo: colorSquarePicker.widthAnchor, multiplier: presentMode == .Full ? 1.0 : 0.4).isActive = true
        mainStackView.spacing = presentMode == .Full ? 25 : 0
        view.layoutIfNeeded()
    }
    
    public static func createInstance()->ColorPickerVC {
        let podBundle = Bundle(for: ColorPickerVC.self)
        let bundleUrl = podBundle.url(forResource: "IOS_CommonUtil", withExtension: "bundle")
        let bundle = Bundle(url: bundleUrl!)!
        let shareDirectVC  = ColorPickerVC(nibName: "ColorPickerVC", bundle: bundle)
        return shareDirectVC
    }
    
    

    @IBAction func cancelDidPressed(_ sender: UIButton) {
        removeOrDismissViewController(self)
    }
    @IBAction func doneDidPressed(_ sender: UIButton) {
        delegate?.colorPicker(self, didChange: AddColorModel(solidColor: colorSquarePicker.color))
        removeOrDismissViewController(self)
    }
    @IBAction func colorBarPickerValueChanged(_ sender: ColorBarPicker) {
        
        colorSquarePicker.hue = sender.hue
        didChangeColor(colorSquarePicker.color)

    }
    
    @IBAction func colorSquarePickerValueChanged(_ sender: ColorSquarePicker) {
        
        didChangeColor(sender.color)
        
    }
    @IBAction func whiteColorDidSelect(_ sender: UIButton) {
        setCustomColor(color: .white)
    }
    @IBAction func grayColorDidSelect(_ sender: UIButton) {
        setCustomColor(color: .gray)

    }
    @IBAction func blackColorDidSelect(_ sender: UIButton) {
        setCustomColor(color: .black)

    }
    
    func didChangeColor(_ color: UIColor) {
        
        guard color.rgbValue != nil else {
            return
        }
        
        guard color.hsvValue != nil else {
            return
        }
        
        
        hexIndicator?.text = color.hexString
        pickedIndicator?.backgroundColor = color
        
        if presentMode == .Mini {
            delegate?.colorPicker(self, didChange: AddColorModel(solidColor: color))
        }
    }
    
    public override func getRestictedViewsIfAny() -> [UIView] {
        return [colorSquarePicker,colorBarPicker]
    }
    
}
extension UIColor {
    
    public var hexString: String {
        var r: CGFloat = 0
        var g: CGFloat = 0
        var b: CGFloat = 0
        var a: CGFloat = 0
        self.getRed(&r, green: &g, blue: &b, alpha: &a)
        
        return String(format: "#%02X%02X%02X", Int(r * 255), Int(g * 255), Int(b * 255))
    }
    public var hexStringWithoutHash: String {
        var r: CGFloat = 0
        var g: CGFloat = 0
        var b: CGFloat = 0
        var a: CGFloat = 0
        self.getRed(&r, green: &g, blue: &b, alpha: &a)
        
        return String(format: "%02X%02X%02X", Int(r * 255), Int(g * 255), Int(b * 255))
    }
    
}
