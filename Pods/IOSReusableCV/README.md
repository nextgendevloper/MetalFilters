# IOSReusableCV

[![CI Status](https://img.shields.io/travis/jd-seg/IOSReusableCV.svg?style=flat)](https://travis-ci.org/jd-seg/IOSReusableCV)
[![Version](https://img.shields.io/cocoapods/v/IOSReusableCV.svg?style=flat)](https://cocoapods.org/pods/IOSReusableCV)
[![License](https://img.shields.io/cocoapods/l/IOSReusableCV.svg?style=flat)](https://cocoapods.org/pods/IOSReusableCV)
[![Platform](https://img.shields.io/cocoapods/p/IOSReusableCV.svg?style=flat)](https://cocoapods.org/pods/IOSReusableCV)

## HOW TO USE
<h3>Displaying the ReuseCollectionView </h3>

<p>First, Configure CVConfig  </p>

```swift
// configure Color Theme To Match Your App Color Scheme - AppColor //
let appColors = AppColors(dark:.red , highlight : .blue , light : .darkGray , textColor : .white)

// With Default Layouts  //

var myConfig = CVConfig(cellClass: CustomCell(), cellIdentifier: "CustomCell", reusableLayout: ReusableLayout.vertical)

//OR//

// With Custom Layout //

let customLayout = ReusableLayout(numberOfRow: 2, column: 6, and: UICollectionView.ScrollDirection.vertical)

//Config
var myConfig = CVConfig(cellClass: CustomCell(), cellIdentifier: "CustomCell", reusableLayout: customLayout)

// Set Color
myConfig.setColorTheme(appColor: appColors)

```

<p>Seocnd, initialize the ReuseCollectionView </p>

```swift
lazy var collectionView : ReusableCV = {
       
       let customLayout = ReusableLayout(numberOfRow: 2, column: 6, and: UICollectionView.ScrollDirection.vertical)
       let appColors = AppColors(dark:.red , highlight : .blue , light : .darkGray , textColor : .white)
       
       var myConfig = CVConfig(cellClass: CustomCell(), cellIdentifier: "CustomCell", reusableLayout: customLayout)
       myConfig.setColorTheme(appColor: appColors)
       
       return ReusableCV.createInstance(delegate: self, config: myConfig)
   }()
```

<p>Third, Add as ChildVC   </p>

```swift
override func viewDidLoad() {
super.viewDidLoad()

// add collectionView as ChildVC to container 
self.addChildVC(collectionView, toView: self.view)

}
```
<br/>

<br />

<br />
<br />

## Delegate CallBack the `ReusableCVDelegate`
<p>  Extend VC Class With  ReusableCVDelegate Protocol </p>

```swift
extension ViewController : ReusableCVDelegate {
 
    func didSelect(_ cell: UICollectionViewCell, at indexPath: IndexPath) {
        print("cell selected at index - ",indexPath.item)
    }
 
    
    func numberOfSections() -> Int {
           1
    }
       
    func numberOfcells() -> Int {
           200
    }
       // User Custom Cell Internaly Registered and Initiated //
       // Call Configure other methods ragarding customCell class here //
       
    func configure(_ cell: UICollectionViewCell, at indexPath: IndexPath) {
        
        if let myCell = cell as? CustomCell {
               myCell.configure()
        }
    }
    
}
```
<br />

##  `ReusableCVDelegate` Methods Accesible -
```swift
   func numberOfSections()->Int
   
   func numberOfcells()->Int
   
   func configure(_ cell:UICollectionViewCell,at indexPath : IndexPath)
   
   func didSelect(_ cell:UICollectionViewCell,at indexPath: IndexPath)

   @objc optional func shouldSelect(_ cell:UICollectionViewCell,at indexPath : IndexPath) -> Bool
   
   @objc optional func willDisplay(_ cell:UICollectionViewCell,at indexPath : IndexPath)
   
   @objc optional func didDeSelect(_ cell:UICollectionViewCell,at indexPath: IndexPath)
   
   @objc optional func shouldAllowDragging(at indexPath : IndexPath) -> Bool
   
   @objc optional func canFocus(at indexPath : IndexPath ) -> Bool
   
   @objc optional func moveCell(from fromIndexPath : IndexPath , to toIndexPath : IndexPath )
   
   @objc optional func endDisplaying(_ cell:UICollectionViewCell, at indexpath : IndexPath)
```

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

IOSReusableCV is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'IOSReusableCV'
```

## Author

jd-seg, jayesh.chaudhari@simplyentertaining.us

## License

IOSReusableCV is available under the MIT license. See the LICENSE file for more info.
