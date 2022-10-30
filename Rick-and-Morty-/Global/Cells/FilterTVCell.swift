//
//  FilterTVCell.swift
//  Rick-and-Morty-
//
//  Created by Ali  Farizli  on 29.10.22.
//

import UIKit

class FilterTVCell: UITableViewCell {
    
    var label: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Chalkduster", size: 17)
        label.numberOfLines = 0
        label.textColor = .white
        label.text = "Type"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var containerView: UIView = {
       let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.1953752637, green: 0.5366188884, blue: 0.2644298077, alpha: 1)
        view.layer.cornerRadius = 15
        view.translatesAutoresizingMaskIntoConstraints = false

        return view
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(containerView)
        containerView.addSubview(label)
//        contentView.backgroundColor = #colorLiteral(red: 0.1118823215, green: 0.1218930408, blue: 0.2724337578, alpha: 1)
//        contentView.addSubview(label)
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
            containerView.heightAnchor.constraint(equalToConstant: 30),
            containerView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 200),
            containerView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -5),
            
            label.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 10),
            label.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -10),
            label.heightAnchor.constraint(equalToConstant: 20),
            label.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 10),
            label.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -10)
        ])
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    

}
