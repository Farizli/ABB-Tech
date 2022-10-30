//
//  FilterButton.swift
//  Rick-and-Morty-
//
//  Created by Ali  Farizli  on 29.10.22.
//

import UIKit

class FilterButton: UIButton {
    
    var isTapped: Bool = false {
        didSet {
            isExpanded = isTapped
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }

    private var isExpanded: Bool = false {
        didSet {
            UIView.animate(withDuration: 0.25) {
                if self.isExpanded {
                    self.transform = CGAffineTransform(rotationAngle: -CGFloat.pi / 4.0)
                } else {
                    
                    self.transform = CGAffineTransform.identity
                    
                }
            }
        }
    }
       
    

    private func addShadow() {
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.1
        layer.shadowOffset = .zero
        let shadowRect = CGRect(x: 10, y: 5, width: 30, height: 30)
        layer.shadowPath = UIBezierPath(roundedRect: shadowRect, cornerRadius: 30).cgPath
        
        self.layer.masksToBounds = false
    }
    
    
    private func setupView() {
        isExpanded = false
        addShadow()
        
    }
   
    
}
