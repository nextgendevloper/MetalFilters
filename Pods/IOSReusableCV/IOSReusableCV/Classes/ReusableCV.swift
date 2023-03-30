//
//  ReusableCV.swift
//  IOSReusableCV
//
//  Created by JD on 7/14/20.
//

import UIKit
import IOS_CommonUtil

private let reuseIdentifier = "Cell"



public class ReusableCV: UICollectionViewController {
   
     var customConfig : CVConfig?

     weak var delegate : ReusableCVDelegate?
    
    override public func viewDidLoad() {
        super.viewDidLoad()
    }
    
    fileprivate func commonInit(){
        
    if let confg = customConfig {
        if let nib = confg.cellNib {
            self.collectionView.register(nib, forCellWithReuseIdentifier: confg.cellIdentifier)
        }else{
        self.collectionView?.register(cell: type(of: confg.cellClass))
        }
        
        self.collectionView.collectionViewLayout = confg.layout
        self.collectionView.backgroundColor = confg.appColor.dark
    }else{
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    }
    }
    
    
    
    
    public class func createInstance(delegate:ReusableCVDelegate , config : CVConfig) -> ReusableCV{
            let podBundle = Bundle(for: ReusableCV.self)
            let bundleUrl = podBundle.url(forResource: "IOSReusableCV", withExtension: "bundle")
            let bundle = Bundle(url: bundleUrl!)!
            let reusableCV  = ReusableCV(nibName: "ReusableCV", bundle: bundle)
                reusableCV.customConfig = config
                reusableCV.delegate = delegate
                reusableCV.commonInit()
            return reusableCV
    }

   
    public func refresh(at indexpaths : [IndexPath]? = nil){
        if indexpaths != nil {
            collectionView.reloadItems(at: indexpaths!)
        return
        }
        collectionView.reloadData()
    }
    
    
    // MARK: UICollectionViewDataSource

    override public func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
       if let del = delegate {
        return del.numberOfSections(collectionview: collectionView)
              }
        return 1
    }
    


    override public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        if let del = delegate {
            return del.numberOfcells(collectionview: collectionView)
               }
        return 0
    }

    
    
    
    override public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let confg = customConfig , let del = delegate ,
           let cell = collectionView.dequeueReusableCell(with: type(of: confg.cellClass), indexPath: indexPath) {
            del.configure(cell, at: indexPath, for: collectionView)
            return cell

        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
            return cell
        }
    }
    
    
    public override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if let del = delegate {
            del.willDisplay?(cell, at: indexPath, for: collectionView)
        }
    }

    
    // Uncomment this method to specify if the specified item should be selected
       override public func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        
        if let del = delegate ,let confg = customConfig {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: confg.cellIdentifier, for: indexPath)
            return del.shouldSelect?(cell, at: indexPath, for: collectionView) ?? true
        }
           return true
       }
       
    
    public override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
         if let del = delegate,let confg = customConfig {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: confg.cellIdentifier, for: indexPath)
            del.didSelect(cell, at: indexPath, for: collectionView)
         } else{
            print("cell \(indexPath.item + 1) didSelected")
        }
    }
    
    
    public override func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
                 if let del = delegate,let confg = customConfig {
                    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: confg.cellIdentifier, for: indexPath)
                    del.didDeSelect?(cell, at: indexPath, for: collectionView)
        }
    }
    
    public override func collectionView(_ collectionView: UICollectionView, canMoveItemAt indexPath: IndexPath) -> Bool {
            if let del = delegate {
                return del.shouldAllowDragging?(at: indexPath, for: collectionView) ?? false
            }
        return false
    }
    
    public override func collectionView(_ collectionView: UICollectionView, canFocusItemAt indexPath: IndexPath) -> Bool {
           if let del = delegate {
            return del.canFocus?(at: indexPath, for: collectionView) ?? false
        }
        return false

    }
    
    public override func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
         if let del = delegate{
            del.moveCell?(from: sourceIndexPath, to: destinationIndexPath, for: collectionView)
        }
    }
  
    public override func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
           if let del = delegate{
            del.endDisplaying?(cell, at: indexPath, for: collectionView)
        }
       }
    
    // MARK: UICollectionViewDelegate

    /*
     Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    
   

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */
    
}
