


import UIKit

public  struct AppColors {
    /** BG Color */
    public var dark : UIColor = .clear
    /** Secondary Color ( use for except BG and Text Color ) */
    public var light : UIColor = .darkGray
    /** App Theme Highlight Color  ( Tint Color )*/
    public var highLight : UIColor = .blue
    /** Normal Text Color  */
    public var textColor : UIColor = .white
    
    public init(darkColor : UIColor ,lightColor : UIColor , highLightColor : UIColor , textColor : UIColor ) {
        
        self.dark = darkColor
        self.light = lightColor
        self.highLight = highLightColor
        self.textColor = textColor

        }
    public init(){}
    
    public static var Default = {
        return AppColors(darkColor: .white, lightColor: .gray, highLightColor: .blue, textColor: .white)
    }
    
}



/*
func centerButtonImageAndTitle(button: UIButton) {
   
       // UIView.appearance().semanticContentAttribute = .forceRightToLeft
button.semanticContentAttribute = .forceLeftToRight
        let spacing: CGFloat = 6.0
        let imageSize = button.imageView!.frame.size
        
    button.titleEdgeInsets = UIEdgeInsets(top: 0, left: -imageSize.width, bottom: -(imageSize.height + spacing), right: 0)
        
        let titleSize = button.titleLabel!.frame.size
        
    button.imageEdgeInsets = UIEdgeInsets(top: -(titleSize.height + spacing), left: 0, bottom: 0, right: -titleSize.width)
    
}
 
 extension String {
     func separate(every stride: Int = 4, with separator: Character = " ") -> String {
         return String(enumerated().map { $0 > 0 && $0 % stride == 0 ? [separator, $1] : [$1]}.joined())
     }
 }
 extension StringProtocol where Self: RangeReplaceableCollection {
     mutating func insert(separator: Self, every n: Int) {
         for index in indices.reversed() where index != startIndex &&
             distance(from: startIndex, to: index) % n == 0 {
                 insert(contentsOf: separator, at: index)
         }
     }
     
     func inserting(separator: Self, every n: Int) -> Self {
         var string = self
         string.insert(separator: separator, every: n)
         return string
     }
 }
 extension UISegmentedControl {
     func setSegmentStyle() {
         
         let segmentGrayColor = UIColor.black
         self.backgroundColor = segmentGrayColor
         
         //self.layerBackgroundColor
         setBackgroundImage(imageWithColor(color: UIColor.white,height: 1.0), for: .normal, barMetrics: .default)
     
         setBackgroundImage(imageWithColor(color: tintColor!,height: 1.0), for: .selected, barMetrics: .default)
         setBackgroundImage(imageWithColor(color: tintColor!,height: 1.0), for: .highlighted, barMetrics: .default)
         setDividerImage(imageWithColor(color: UIColor.clear,height: self.bounds.size.height), forLeftSegmentState: .selected, rightSegmentState: .normal, barMetrics: .default)
       
         setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.black], for: .normal)
         setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.black], for: .selected)
        
      
         self.layer.borderWidth = 1.0
         self.layer.cornerRadius = 5.0
         self.layer.borderColor = segmentGrayColor.cgColor
         self.layer.masksToBounds = true
     }
     
     // create a 1x1 image with this color
     private func imageWithColor(color: UIColor , height: CGFloat) -> UIImage {
         let rect = CGRect(x: 0.0, y: 0.0, width:  1.0, height: height)
         UIGraphicsBeginImageContext(rect.size)
         let context = UIGraphicsGetCurrentContext()
         context!.setFillColor(color.cgColor);
         context!.fill(rect);
         let image = UIGraphicsGetImageFromCurrentImageContext();
         UIGraphicsEndImageContext();
         return image!
     }
 }
 extension UIColor {
   /**
    Create a lighter color
    */
   func lighterm(by percentage: CGFloat = 30.0) -> UIColor {
     return self.adjustBrightness(by: abs(percentage))
   }

   /**
    Create a darker color
    */
   func darkerm(by percentage: CGFloat = 30.0) -> UIColor {
     return self.adjustBrightness(by: -abs(percentage))
   }

   /**
    Try to increase brightness or decrease saturation
    */
   func adjustBrightness(by percentage: CGFloat = 30.0) -> UIColor {
     var h: CGFloat = 0, s: CGFloat = 0, b: CGFloat = 0, a: CGFloat = 0
     if self.getHue(&h, saturation: &s, brightness: &b, alpha: &a) {
       if b < 1.0 {
         let newB: CGFloat = max(min(b + (percentage/100.0)*b, 1.0), 0.0)
         return UIColor(hue: h, saturation: s, brightness: newB, alpha: a)
       } else {
         let newS: CGFloat = min(max(s - (percentage/100.0)*s, 0.0), 1.0)
         return UIColor(hue: h, saturation: newS, brightness: b, alpha: a)
       }
     }
     return self
   }
 }
 
*/
