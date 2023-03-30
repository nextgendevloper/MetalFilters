//
//  ReusableControlView.swift
//  IOS_CommonUtil
//
//  Created by Developer on 6/6/21.
//

import Foundation
import UIKit

open class ReusableControlView : UIViewController , UIGestureRecognizerDelegate{
    
    open func didRemoveMyself(){
        removeOrDismissViewController(self)
    }
    
    open var appColors : AppColors = AppColors() {
        didSet {
            radiusContainer.backgroundColor = appColors.dark
        }
    }
    open override func viewDidLoad() {
        super.viewDidLoad()
        addStackView()
        if showMinimizer {
        addImageView()
        }
        addContainerView()
        if enableDropShadow {
        addShadowView()
        }
        
        addcornerRadiusContainerView()
       // self.view.backgroundColor = .orange
        // Do any additional setup after loading the view.
        
        if enableSwipeAnimation {
            let swipeGesture = UIPanGestureRecognizer(target: self, action: #selector(handleSwipeToDismiss))
            swipeGesture.delegate = self
            self.view.addGestureRecognizer(swipeGesture)
        }
    }
    /// default is true - hides/show dismiss icon of top
    public var showMinimizer : Bool = true
    /// minimizer should be enable before enabling this animation
    public var enableSwipeAnimation : Bool = true
    /// shows hides drop shadow around view
    public var enableDropShadow : Bool = true
    /// default is 20
    public var cornerRadius : CGFloat = 20
    ///   shadow radius distance of fading from center to rangeValue
    /// default is 15
    public var dropShadowRange : CGFloat = 15
    /// default is 5
    public var dropShadowSpace : CGFloat = 5
    /// default is 1
    public var dropShadowOpacity : CGFloat = 1
    /// minimum set to 1 // default is 0 which will make full corner radius
    private var dropShadowCornerRadius : CGFloat = 0

    /// default is true - hides/show dismiss icon of top
    public var shadowColor : UIColor = .darkGray
    
    public var minmiserImageName : String = "minimise"

    public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var shadowContainer = UIView()
    var radiusContainer = UIView()
    var container = UIView()
    var stackView = UIStackView()
    var imageView = UIImageView()
    
    func addShadowView(){
      //  self.view.backgroundColor = .clear
        
        let views: [String : Any] = [
          "shadowView": shadowContainer
          ]
        
        shadowContainer.translatesAutoresizingMaskIntoConstraints = false
        shadowContainer.backgroundColor = .clear
        container.addSubview(shadowContainer)
        
        container.addConstraints(NSLayoutConstraint
          .constraints(withVisualFormat: "H:|[shadowView]|", options: [], metrics: nil, views: views))
        container.addConstraints(NSLayoutConstraint
          .constraints(withVisualFormat: "V:|[shadowView]|", options: [], metrics: nil, views: views))
        container.sendSubviewToBack(shadowContainer)

    }
    
    func addContainerView(){
      //  self.view.backgroundColor = .clear
        
       // container.backgroundColor = .brown
        container.translatesAutoresizingMaskIntoConstraints = false
        //container.backgroundColor = .blue
        stackView.addArrangedSubview(container)
       
//          .constraints(withVisualFormat: "V:|[container]|", options: [], metrics: nil, views: views))

    }
    
    func addcornerRadiusContainerView(){
        let views: [String : Any] = [
          "radiusContainer": radiusContainer
          ]
        radiusContainer.translatesAutoresizingMaskIntoConstraints = false
      //  radiusContainer.backgroundColor = .white
        shadowContainer.addSubview(radiusContainer)
        shadowContainer.addConstraints(NSLayoutConstraint
          .constraints(withVisualFormat: "H:|[radiusContainer]|", options: [], metrics: nil, views: views))
        shadowContainer.addConstraints(NSLayoutConstraint
          .constraints(withVisualFormat: "V:|[radiusContainer]|", options: [], metrics: nil, views: views))
        
        radiusContainer.sendSubviewToBack(radiusContainer)

    }
    
    
    func addStackView() {
          self.view.backgroundColor = .clear
          
          let views: [String : Any] = [
            "stackView": stackView
            ]
       // stackView.backgroundColor = .yellow
        stackView.translatesAutoresizingMaskIntoConstraints = false
          //container.backgroundColor = .blue
          self.view.addSubview(stackView)
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.axis = .vertical
        
              view.addConstraints(NSLayoutConstraint
            .constraints(withVisualFormat: "H:|[stackView]|", options: [], metrics: nil, views: views))
          view.addConstraints(NSLayoutConstraint
            .constraints(withVisualFormat: "V:|[stackView]|", options: [], metrics: nil, views: views))
          self.view.sendSubviewToBack(stackView)

      }
    
    func addImageView(){
        
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .clear
        imageView.translatesAutoresizingMaskIntoConstraints = true
       // container.backgroundColor = .blue
        stackView.addArrangedSubview(imageView)
            self.imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDismiss)))
        
        
        imageView.isUserInteractionEnabled = true
        imageView.heightAnchor.constraint(equalToConstant: 25).isActive = true

        if #available(iOS 13.0, *) {
            imageView.image = Resource.getImage(name: minmiserImageName)?.withTintColor(.lightGray.lighter())
            
        } else {
            // Fallback on earlier versions
        }
    }
    @objc
    func handleDismiss(gesture: UITapGestureRecognizer){
       // print("recognised ... hurrey.")
       // self.view.transform = CGAffineTransform(translationX: 0, y: -self.view.transform.ty + 50)

//        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
//            self.view.transform = CGAffineTransform(translationX: 0, y: self.view.transform.ty + self.view.frame.height)
//
//        })
       
        didRemoveMyself()
        
    }
    var viewTranslation = CGPoint(x: 0.0, y: 0.0)
    @objc
    func handleSwipeToDismiss(gesture: UIPanGestureRecognizer){
        switch gesture.state {
        case .changed :
            //print("panning",viewTranslation.y)

            viewTranslation.y =  gesture.translation(in: view).y
          if viewTranslation.y >= 0 {
            UIView.animate(withDuration: SHOW_ANIMATION_TIME, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                   self.view.transform = CGAffineTransform(translationX: 0, y: self.viewTranslation.y)
               })
            
          }
        case .ended:
            if viewTranslation.y < (self.view.frame.height/2.0) {
                UIView.animate(withDuration: SHOW_ANIMATION_TIME, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                    self.view.transform = .identity
                })
            } else {
               // dismiss(animated: true, completion: nil)
//                UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .curveLinear) {
//                    self.view.transform = CGAffineTransform(translationX: 0, y: self.view.transform.ty + self.view.frame.height)
//
//                } completion: { [self] _ in
                    didRemoveMyself()
              //  }
            }
            
           default:
               break
           }
    }
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
//        return touch.view == gestureRecognizer.view
        
        // get resticted view array
        // check if touch.view != anyOfResticted View
        // return true
        // else return false
        var allowTouch = true
        let restrictedViews =  getRestictedViewsIfAny()
        if !restrictedViews.isEmpty {
            restrictedViews.forEach { view in
                if view == touch.view {
                    allowTouch = false
                    print("touchNot allowed")
                }
            }
        }
        if allowTouch {
        let restrictedFrames =  getRestictedFramesIfAny()
        if !restrictedFrames.isEmpty {
            let touchPoint = touch.location(in: self.view)
            restrictedFrames.forEach { frame in
//               print("1.frame: ",frame)
//                print("2.touchPoint: ",touchPoint)
//                print("3.containts: ",frame.contains(touchPoint))

                if frame.contains(touchPoint) {
                    allowTouch = false
                }
                
            }
        }
        }
        
        return allowTouch
    }
    
    
    
    /// views returned wont react to swipe to dismiss gesture
   open func getRestictedViewsIfAny()->[UIView] {
        return [UIView]()
    }
    open func getRestictedFramesIfAny()->[CGRect] {
         return [CGRect]()
     }
    
   
    public var roundCorners : UIRectCorner  = [.topLeft , .topRight]
    
    open override func viewDidLayoutSubviews() {
        DispatchQueue.main.async { [self] in
            radiusContainer.roundCorners(corners: roundCorners, radius: cornerRadius)
            shadowContainer.applyShadowWithCornerRadius(color: shadowColor, opacity: Float(dropShadowOpacity), radius: dropShadowRange, edge: .None, shadowSpace: dropShadowSpace,shadowCornerRadius: dropShadowCornerRadius)
    }
    }
    


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
//@IBDesignable class RoundRectView: UIView {
////
////@IBInspectable var cornerRadius: CGFloat = 0.0
////@IBInspectable var borderColor: UIColor = UIColor.black
////@IBInspectable var borderWidth: CGFloat = 0.5
//private var customBackgroundColor = UIColor.white
//override var backgroundColor: UIColor?{
//    didSet {
//        customBackgroundColor = backgroundColor!
//        super.backgroundColor = UIColor.clear
//    }
//}
//
//func setup() {
////    layer.shadowColor = UIColor.red.cgColor;
////    layer.shadowOffset = CGSize.zero
////    layer.shadowRadius = shadowRadius;
////    layer.shadowOpacity = shadowOpacity;
//    super.backgroundColor = UIColor.clear
//    
//
//}
//
//override init(frame: CGRect) {
//    super.init(frame: frame)
//    self.setup()
//}
//
//required init?(coder aDecoder: NSCoder) {
//    super.init(coder: aDecoder)
//    self.setup()
//}
//
//override func draw(_ rect: CGRect) {
//    customBackgroundColor.setFill()
//    UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius ).fill()
//
//    let borderRect = bounds.insetBy(dx: borderWidth/2, dy: borderWidth/2)
//    let borderPath = UIBezierPath(roundedRect: borderRect, cornerRadius: cornerRadius - borderWidth/2)
//    borderColor!.setStroke()
//    borderPath.lineWidth = borderWidth
//    borderPath.stroke()
//
//    // whatever else you need drawn
//}
//}

/*

 
 |--------------|
 | |---------|  |
 | |         |  |
 | |---------|  |
 |              |
 |              |
 |              |
 |--------------|
 
 
 
*/
