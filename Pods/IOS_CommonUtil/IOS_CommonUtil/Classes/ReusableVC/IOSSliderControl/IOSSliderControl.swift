//
//  IOSSliderControl.swift
//  IOS_CommonUtil
//
//  Created by Developer on 6/6/21.
//

import Foundation

/* protocol IOSSliderControlDelegate : AnyObject {
    func valueDidChange(_ slider : IOSSliderControl , touchBegan value : Float)
    func valueDidChange(_ slider : IOSSliderControl ,touchContinous  value : Float)
    func valueDidChange(_ slider : IOSSliderControl , touchEnded value : Float)
    func slider(doneButtonPressed slider : IOSSliderControl)
    func slider(cancelButtonPressed slider : IOSSliderControl)

}
*/


/// Reusable Slider Control ViewController - Skeleton Class ( Subclass it as per requirement or use as it )
open  class IOSSliderControl : ReusableControlView  {
  
    @IBOutlet weak var baseView: UIView!
    open func valueDidChange(touchBegan value: Float) {}
    open func valueDidChange(touchContinous value: Float) {}
    open func valueDidChange(touchEnded value: Float) {}
    open func sliderCancel() {}
    open func sliderDone() {}
    
    @IBOutlet weak var topBar: UIView!
    
    @IBOutlet weak var bgView: UIView!
    
    @IBOutlet weak var iconImageView: UIImageView!
    
    @IBOutlet weak var slider: UISlider!
    
    @IBOutlet weak var valueLabel: UILabel!
    
    @IBOutlet weak var valueExtension: UILabel!

   
    @IBOutlet weak var titleNameOutlet: UILabel!
   
    @IBOutlet weak var cancelButtonOutlet: UIButton!
    
   
    @IBOutlet weak var doneButtonOutlet: UIButton!
    
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open override var appColors: AppColors {
        didSet {
            super.appColors = appColors
            baseView.backgroundColor = UIColor.clear
            titleNameOutlet.textColor = appColors.textColor
            cancelButtonOutlet.setTitleColor(appColors.textColor.lighter(), for: .normal)
            doneButtonOutlet.setTitleColor(appColors.textColor, for: .normal)
            slider.maximumTrackTintColor = appColors.light
            slider.thumbTintColor = appColors.highLight
            slider.minimumTrackTintColor = appColors.highLight
            valueLabel.textColor = appColors.textColor
            valueExtension.textColor = appColors.textColor
            if #available(iOS 13.0, *) {
                iconImageView.tintColor = appColors.light
            }
            
        }
    }
    
    /** tell slider to return all events ( True ) else Only when User lift a finger from slider ( False ) */
    public var continuesUpdate  : Bool = true {
        didSet {
          //  slider.isContinuous = continuesUpdate
        
        }
    }
    public var titleName  : String = "" {
        didSet {
            titleNameOutlet.text = titleName
        }
    }
    
    public var doneButtonTitle : String = "_Done".translate() {
        didSet {
            doneButtonOutlet.setTitle(doneButtonTitle, for: .normal)
        }
    }
    public var doneButtonImage : UIImage? = nil {
        didSet {
            doneButtonOutlet.setImage(doneButtonImage, for: .normal)
        }
    }
    public var doneButtonIsHidden : Bool = false {
        didSet {
            cancelButtonOutlet.isHidden  = doneButtonIsHidden
        }
    }
    public var cancelButtonTitle : String = "_Cancel".translate() {
        didSet {
            cancelButtonOutlet.setTitle(cancelButtonTitle, for: .normal)
        }
    }
    public var cancelButtonImage : UIImage? = nil {
        didSet {
            doneButtonOutlet.setImage(cancelButtonImage, for: .normal)
        }
    }
    public var cancelButtonIsHidden : Bool = false {
        didSet {
            cancelButtonOutlet.isHidden  = cancelButtonIsHidden
        }
    }
    
    public var valueExt  : String = "" {
        didSet {
             valueExtension.text = valueExt
        }
    }
    public var sliderRange  : (Float,Float) = (0.0,1.0) {
        didSet {
            slider.minimumValue = sliderRange.0
            slider.maximumValue = sliderRange.1
        }
    }
    public var sliderIcon  : UIImage? = nil {
        didSet {
            iconImageView.image = sliderIcon
        }
    }
    public var defaultValue : Float = 0.5 {
        didSet {
            slider.value = defaultValue
            valueLabel.text = String(format: "%.1f", defaultValue)
        }
    }

    public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
    }
    
    @IBOutlet weak var baseViewTop: NSLayoutConstraint!

       
    open override func viewDidLoad() {
        super.viewDidLoad()
        self.view.clipsToBounds = false
        
        doneButtonTitle = "_Done".translate()
        cancelButtonTitle = "_Cancel".translate()
        baseViewTop.constant = showMinimizer == true ? -25 : 0

    }
    
    public override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

    }
    open override func viewDidAppear(_ animated: Bool) {
        //print(container.frame)
      //  baseView.heightAnchor.constraint(equalTo: container.heightAnchor, multiplier: 1.0).isActive = true
       
    
    }
    @IBAction func sliderValueChange(_ sender: UISlider, forEvent event: UIEvent) {

        valueLabel.text =  String(format: "%.1f", sender.value)

        if let touchEvent = event.allTouches?.first {
            switch touchEvent.phase {
            case .began :
                if continuesUpdate {
                valueDidChange(touchBegan: sender.value)
                }
               // print("start")

            case .moved:
                if continuesUpdate {
               valueDidChange(touchContinous: sender.value)
                }
               // print("change")
              //  jf(value: sender.value)
            case .ended:
               valueDidChange(touchEnded: sender.value)
               // print("end")
               // baseView.backgroundColor = .cyan
            default:
           break
               
            }
       }
       
            
    }
    
    @IBOutlet weak var headerName: UILabel!
    @IBAction func cancelButtonDidPressed(_ sender: UIButton) {
        removeOrDismissViewController(self)
        sliderCancel()
    }
    
    @IBAction func doneButtonDidPressed(_ sender: UIButton) {
        removeOrDismissViewController(self)
        sliderDone()
    }
  
    
}
