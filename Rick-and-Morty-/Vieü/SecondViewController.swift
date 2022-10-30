//
//  SecondViewController.swift
//  Rick-and-Morty-
//
//  Created by Ali  Farizli  on 30.10.22.
//

import UIKit
import Kingfisher

class SecondViewController: UIViewController {

    var selectedCharData: Results?
    
    @IBOutlet weak var charImg: UIImageView! {
        didSet {
            charImg.layer.cornerRadius = 15
            charImg.layer.borderWidth = 5
            charImg.layer.borderColor = #colorLiteral(red: 0.1953752637, green: 0.5366188884, blue: 0.2644298077, alpha: 1)
            KF.url(selectedCharData?.image).set(to: charImg)
        }
    }
    
    @IBOutlet weak var originLbl: UILabel!{
        didSet {
            originLbl.text = "Origin of the character: \(selectedCharData?.origin.name ?? "")"
        }
    }
    @IBOutlet weak var typeLbl: UILabel!{
        didSet {
            typeLbl.text = "Type of the character: \(selectedCharData?.type ?? "")"
        }
    }
    @IBOutlet weak var speciesLbl: UILabel!{
        didSet {
            speciesLbl.text = "Species of the character: \(selectedCharData?.species ?? "")"
        }
    }
    @IBOutlet weak var statusLbl: UILabel!{
        didSet {
            statusLbl.text = "Status of the character: \(selectedCharData?.status ?? "")"
        }
    }
    @IBOutlet weak var genderLbl: UILabel!{
        didSet {
            genderLbl.text = "Gender of the character: \(selectedCharData?.gender ?? "")"
        }
    }
    @IBOutlet weak var nameLbl: UILabel!{
        didSet {
            nameLbl.text = "\(selectedCharData?.name ?? "")"
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    


}
