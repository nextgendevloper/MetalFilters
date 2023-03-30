//
//  filterCVC.swift
//  MetalFilters
//
//  Created by HKBeast on 24/03/23.
//

import UIKit

class FilterCVC: UICollectionViewCell {

    @IBOutlet weak var filterImageView:UIImageView!
    @IBOutlet weak var filterNameLabel:UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func config(indexPath:IndexPath,model:ColorAdjustProtocol){
        filterNameLabel.text = model.kernalName
    }
}
