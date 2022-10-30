//
//  CollectionReusableView.swift
//  Rick-and-Morty-
//
//  Created by Ali  Farizli  on 30.10.22.
//

import UIKit

class CollectionReusableView: UICollectionReusableView {
    
    lazy var spinner = UIActivityIndicatorView(style: .large)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.color = #colorLiteral(red: 0.1953752637, green: 0.5366188884, blue: 0.2644298077, alpha: 1)
        self.addSubview(spinner)
        
        spinner.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        spinner.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }
    
    
    
}
