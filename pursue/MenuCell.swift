//
//  MenuCell.swift
//  pursue
//
//  Created by Jaylen Sanders on 11/25/17.
//  Copyright © 2017 Glory. All rights reserved.
//

import UIKit

class MenuCell : UICollectionViewCell {
    
    var homeLogo : UIImageView? {
        didSet {
            guard let home = homeLogo else { return }
            addSubview(home)
            home.anchor(top: nil, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 44, height: 28)
            updateConstraints()
        }
    }
    
    let imageView: UIImageView = {
        let iv = UIImageView()
        iv.tintColor = UIColor.black
        iv.backgroundColor = .clear
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    override var isHighlighted: Bool {
        didSet {
            imageView.tintColor = isHighlighted ? UIColor.black : UIColor.rgb(red: 91, green: 14, blue: 13)
        }
    }
    
    override var isSelected: Bool {
        didSet {
            imageView.tintColor = isSelected ? UIColor.black : UIColor.rgb(red: 91, green: 14, blue: 13)
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
