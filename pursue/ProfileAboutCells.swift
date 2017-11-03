//
//  ProfileAboutCells.swift
//  pursue
//
//  Created by Jaylen Sanders on 10/26/17.
//  Copyright © 2017 Glory. All rights reserved.
//

import UIKit

class ProfileAboutCells : UICollectionViewCell {
    
    let selectInterests : UIButton = {
        let button = UIButton()
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.cornerRadius = 16
        button.layer.borderWidth = 1
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .black
        return button
    }()
    
    let buttonLabel : UILabel = {
        let label = UILabel()
        label.text = "ANIMALS"
        label.font = UIFont.boldSystemFont(ofSize: 10)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(selectInterests)
        selectInterests.addSubview(buttonLabel)
        selectInterests.anchor(top: nil, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: buttonLabel.intrinsicContentSize.width + 20, height: 0)
        selectInterests.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        selectInterests.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        buttonLabel.centerYAnchor.constraint(equalTo: selectInterests.centerYAnchor).isActive = true
        buttonLabel.centerXAnchor.constraint(equalTo: selectInterests.centerXAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
