//
//  FilterCVCell.swift
//  Rick-and-Morty-
//
//  Created by Ali  Farizli  on 29.10.22.
//

import UIKit

class FilterCVCell: UICollectionViewCell {
    
    var cancelTapped: (() -> Void)?

    @IBAction func cancelBtnTapped(_ sender: UIButton) {
        cancelTapped?()
    }
    
    @IBOutlet weak var cancelBtn: UIButton!
    @IBOutlet weak var filterTypeTitle: UILabel!
    @IBOutlet weak var containerView: UIView! {
        didSet {
            containerView.layer.cornerRadius = 15
        }
    }
}
