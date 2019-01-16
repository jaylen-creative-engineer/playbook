//
//  CreateNewPursuitCell.swift
//  Inpursuit
//
//  Created by Jaylen Sanders on 1/15/19.
//  Copyright © 2019 Glory. All rights reserved.
//

import UIKit

class CreateNewPursuitCell : UICollectionViewCell {
    
    let addButton : UIButton = {
       let button = UIButton(type: .system)
        button.layer.cornerRadius = 12
        button.layer.masksToBounds = true
        button.layer.borderColor = UIColor.gray.cgColor
        button.layer.borderWidth = 1
        button.tintColor = .gray
        return button
    }()
    
    let createButton : UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named : "add")?.withRenderingMode(.alwaysOriginal), for: .normal)
        button.imageView?.contentMode = .scaleAspectFill
        return button
    }()
    
    func setupView(){
        addSubview(addButton)
        addSubview(createButton)
        
        addButton.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        createButton.centerXAnchor.constraint(equalTo: addButton.centerXAnchor).isActive = true
        createButton.centerYAnchor.constraint(equalTo: addButton.centerYAnchor).isActive = true
        createButton.anchor(top: nil, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 24, height: 24)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
