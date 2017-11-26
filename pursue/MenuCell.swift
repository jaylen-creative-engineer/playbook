//
//  MenuCell.swift
//  pursue
//
//  Created by Jaylen Sanders on 11/25/17.
//  Copyright © 2017 Glory. All rights reserved.
//

import UIKit

class MenuCell : UICollectionViewCell {
    
    let imageView: UIImageView = {
        let iv = UIImageView()
        iv.tintColor = UIColor.rgb(red: 128, green: 128, blue: 128)
        iv.backgroundColor = .clear
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    override var isHighlighted: Bool {
        didSet {
            imageView.tintColor = isHighlighted ? UIColor.black : UIColor.rgb(red: 128, green: 128, blue: 128)
        }
    }
    
    override var isSelected: Bool {
        didSet {
            imageView.tintColor = isSelected ? UIColor.black : UIColor.rgb(red: 128, green: 128, blue: 128)
        }
    }
    
    func setupView(){
        addSubview(imageView)
        imageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        imageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
