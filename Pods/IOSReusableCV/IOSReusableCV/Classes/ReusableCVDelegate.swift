//
//  ReusableCVDelegate.swift
//  IOSReusableCV
//
//  Created by JD on 8/14/20.
//

import Foundation

@objc
public protocol ReusableCVDelegate : class {
    func numberOfSections(collectionview : UICollectionView)->Int
    func numberOfcells(collectionview : UICollectionView)->Int
    func configure(_ cell:UICollectionViewCell,at indexPath : IndexPath,for collectionview : UICollectionView)
    func didSelect(_ cell:UICollectionViewCell,at indexPath: IndexPath,for collectionview : UICollectionView)

    @objc optional func shouldSelect(_ cell:UICollectionViewCell,at indexPath : IndexPath,for collectionview : UICollectionView) -> Bool
    @objc optional func willDisplay(_ cell:UICollectionViewCell,at indexPath : IndexPath , for collectionview : UICollectionView)
    @objc optional func didDeSelect(_ cell:UICollectionViewCell,at indexPath: IndexPath, for collectionview : UICollectionView)
    @objc optional func shouldAllowDragging(at indexPath : IndexPath, for collectionview : UICollectionView) -> Bool
    @objc optional func canFocus(at indexPath : IndexPath , for collectionview : UICollectionView) -> Bool
    @objc optional func moveCell(from fromIndexPath : IndexPath , to toIndexPath : IndexPath , for collectionview : UICollectionView)
    @objc optional func endDisplaying(_ cell:UICollectionViewCell, at indexpath : IndexPath, for collectionview : UICollectionView)
}
