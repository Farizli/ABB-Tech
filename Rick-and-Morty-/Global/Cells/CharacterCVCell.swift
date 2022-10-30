//
//  CharacterCVCell.swift
//  Rick-and-Morty-
//
//  Created by Ali  Farizli  on 29.10.22.
//

import UIKit
import Kingfisher

class CharacterCVCell: UICollectionViewCell {
    
    @IBOutlet weak var species: UILabel!
    @IBOutlet weak var gender: UILabel!
    @IBOutlet weak var state: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var img: UIImageView!{
        didSet {
            img.layer.cornerRadius = 15
            img.isUserInteractionEnabled = false
        }
        
    }
    
    
    
    func setupCell(species: String, gender: String, state: String, name: String, img: URL) {
        self.species.text = species
        self.name.text = name
        self.state.text = state
        self.gender.text = gender
        KF.url(img).set(to: self.img)
        
    }
    
    
    
}
