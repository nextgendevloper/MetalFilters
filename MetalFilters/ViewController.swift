//
//  ViewController.swift
//  MetalFilters
//
//  Created by HKBeast on 24/03/23.
//

import UIKit
import IOSReusableCV
import IOS_CommonUtil
import PhotosUI

class ViewController: UIViewController, ReusableCVDelegate, PHPickerViewControllerDelegate {
    func numberOfSections(collectionview: UICollectionView) -> Int {
        return 1
    }
    
    func numberOfcells(collectionview: UICollectionView) -> Int {
        return viewModel.countOfFilter()
    }
    
    func configure(_ cell: UICollectionViewCell, at indexPath: IndexPath, for collectionview: UICollectionView) {
        if  let cell = cell as? FilterCVC {
            cell.config(indexPath: indexPath, model: viewModel.listOfFilters[indexPath.item])
        }
    }
    
    func didSelect(_ cell: UICollectionViewCell, at indexPath: IndexPath, for collectionview: UICollectionView) {
        viewModel.didSelect(indexPath: indexPath)
    }
    
    
    

    @IBOutlet weak var imageView:UIImageView!
    @IBOutlet weak var filterSlider:UISlider!
    @IBOutlet weak var addImageButton:UIButton!
    @IBOutlet weak var collectionViewPlaceHolder:UIView!
    @IBOutlet weak var addFilter:UIButton!
    @IBOutlet weak var addColorAdjust:UIButton!
    
    var viewModel = HomeViewModel()
    
    
    lazy var collectionView : ReusableCV = {
        let customLayout = ReusableCVLayout(numberOfRow: 4, column: 1, and: .horizontal)
           var myConfig = CVConfig(cellClass: FilterCVC(), cellIdentifier: "FilterCVC", reusableLayout: customLayout)
           return ReusableCV.createInstance(delegate: self, config: myConfig)
       }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activateBinder()
        // Do any additional setup after loading the view.
        self.addChildVCWithMultiplier(collectionView, toView: self.collectionViewPlaceHolder, aniamte: false)
        
    }
    
   @IBAction func didAddPhotosClicked(_ sender:UIButton){
        openGallary()
    }
    @IBAction func addFilterDidClicked(_ sender:UIButton){
        viewModel.listOfFilters = colorAdjust
        collectionView.collectionView.reloadData()
    }
    @IBAction func addColorAdjust(_ sender:UIButton){
        viewModel.listOfFilters = filters
        collectionView.collectionView.reloadData()
    }
    
    
    @IBAction func didFilterValueChanged(_ sender:UISlider){
        viewModel.valueChanged(CGFloat(sender.value))
       
    }

    
    func activateBinder(){
        viewModel.onSliderValueChanged={ img in
            self.imageView.image = img
        }
        viewModel.onSliderMinMax={min,max,value in
            self.filterSlider.minimumValue = Float(min!)
            self.filterSlider.maximumValue = Float(max!)
            self.filterSlider.value = value!
        }
    }
    func openGallary() {
        var configuration = PHPickerConfiguration()
        configuration.selectionLimit = 2
        configuration.preferredAssetRepresentationMode = .automatic
         let picker = PHPickerViewController(configuration: configuration)
        picker.delegate = self
         self.present(picker, animated: true, completion: nil)
    }
    
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        dismiss(animated: true)
        let itemProviders = results.map(\.itemProvider)
        var count = 0
        for item in itemProviders {
            if item.canLoadObject(ofClass: UIImage.self) {
                item.loadObject(ofClass: UIImage.self) { (image, error) in
                    DispatchQueue.main.async { [self] in
                        if let image = image as? UIImage {
                            self.imageView.image = image
                            viewModel.currentImage.append(image)
                            count+=1
                        }
                    }
                }
            }
        }
    }

}

