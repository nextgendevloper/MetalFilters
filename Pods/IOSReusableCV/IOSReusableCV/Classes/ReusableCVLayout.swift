//
//  ReusableCVLayout.swift
//  IOSReusableCV
//
//  Created by JD on 8/14/20.
//

import UIKit

public class ReusableCVLayout: UICollectionViewFlowLayout {
    
    public var cellsPerRow : Float = 2
    public var cellPerColumn : Float = 3
     public var aspectRatio : Bool = true
     public static var basic = BasicCollectionViewLayout()
     public static var vertical = VerticalCollectionViewLayout()
     public static var horizontal = HorizontalCollectionViewLayout()
     
     public override init() {
         super.init()
     }
     
     convenience public init(numberOfRow: Float,column: Float , and scrollDirection : UICollectionView.ScrollDirection , minimumInteritemSpacing: CGFloat = 10, minimumLineSpacing: CGFloat = 10, sectionInset: UIEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)) {
         self.init()
         self.cellsPerRow = numberOfRow
         self.cellPerColumn = column
         self.scrollDirection = scrollDirection
         self.minimumInteritemSpacing = minimumInteritemSpacing
         self.minimumLineSpacing = minimumLineSpacing
         self.sectionInset = sectionInset
        }
    
     override public func prepare() {
         super.prepare()

         guard let collectionView = collectionView else { return }
         let marginsAndInsets = sectionInset.left + sectionInset.right + collectionView.safeAreaInsets.left + collectionView.safeAreaInsets.right + minimumInteritemSpacing * CGFloat(cellsPerRow - 1)
         let itemWidth = ((collectionView.bounds.size.width - marginsAndInsets) / CGFloat(cellsPerRow)).rounded(.down)
         let marginsAndInsets1 = sectionInset.left + sectionInset.right + collectionView.safeAreaInsets.left + collectionView.safeAreaInsets.right + minimumInteritemSpacing * CGFloat(cellPerColumn - 1)

         let itemHeight = ((collectionView.bounds.size.height - marginsAndInsets1) / CGFloat(cellPerColumn)).rounded(.down)

         itemSize = CGSize(width: itemWidth, height: itemHeight)
     }

     override public func invalidationContext(forBoundsChange newBounds: CGRect) -> UICollectionViewLayoutInvalidationContext {
         let context = super.invalidationContext(forBoundsChange: newBounds) as! UICollectionViewFlowLayoutInvalidationContext
         context.invalidateFlowLayoutDelegateMetrics = newBounds.size != collectionView?.bounds.size
         return context
     }

     required init?(coder: NSCoder) {
         fatalError("init(coder:) has not been implemented")
     }

 }



 public class BasicCollectionViewLayout: ReusableCVLayout {
     
     override init() {
         super.init()
         
         self.scrollDirection = scrollDirection
         self.minimumInteritemSpacing = minimumInteritemSpacing
         self.minimumLineSpacing = minimumLineSpacing
         self.sectionInset = sectionInset
     }
     
     required init?(coder: NSCoder) {
         fatalError("init(coder:) has not been implemented")
     }
     
     override public func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
         return true
     }
 }
 public class  VerticalCollectionViewLayout: ReusableCVLayout {
     
     override public var cellsPerRow: Float  {
         get {
                return 2
            }
         set {
             super.cellsPerRow = newValue
         }
     }
     override public var cellPerColumn: Float  {
         get {
                       return 3
                   }
                set {
                    super.cellPerColumn = newValue
                }
     }
     
     override init() {
         super.init()
         scrollDirection = .vertical
         sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
         minimumLineSpacing = 10
         minimumInteritemSpacing = 10
         }
        
     
     required init?(coder: NSCoder) {
         fatalError("init(coder:) has not been implemented")
     }
     
     override public func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
         return true
     }
 }

 public class  HorizontalCollectionViewLayout: ReusableCVLayout {
     
     override init() {
         super.init()
         scrollDirection = .horizontal
         sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
         minimumLineSpacing = 10
         minimumInteritemSpacing = 10
     }
     
       override public var cellsPerRow: Float  {
           get {
                  return 2
              }
           set {
               super.cellsPerRow = newValue
           }
       }
       override public var cellPerColumn: Float  {
           get {
                         return 2
                     }
                  set {
                      super.cellPerColumn = newValue
                  }
       }

     required init?(coder: NSCoder) {
         fatalError("init(coder:) has not been implemented")
     }
     
     override public func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
         return true
     }
 }

