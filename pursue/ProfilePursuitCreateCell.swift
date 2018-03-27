//
//  ProfilePursuitCreateCell.swift
//  pursue
//
//  Created by Jaylen Sanders on 3/27/18.
//  Copyright © 2018 Glory. All rights reserved.
//

import UIKit


class ProfilePursuitCreateCell : UICollectionViewCell {
    
    lazy var backgroundContainer : UIView = {
        let view = UIView()
        view.layer.cornerRadius = 4
        view.layer.masksToBounds = true
        view.backgroundColor = .black
        return view
    }()
    
    lazy var createPursuitLabel : UILabel = {
       let label = UILabel()
        label.text = "Begin a new pursuit"
        label.font = .boldSystemFont(ofSize: 14)
        label.textColor = .white
        label.numberOfLines = 2
        return label
    }()
    
    lazy var createButton : UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 15
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.white.cgColor
        return button
    }()
    
    lazy var addIcon : UIImageView = {
       let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "add").withRenderingMode(.alwaysTemplate)
        iv.tintColor = .white
        iv.contentMode = .scaleAspectFill
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    func setupView(){
        addSubview(backgroundContainer)
        addSubview(createPursuitLabel)
        addSubview(createButton)
        addSubview(addIcon)
        
        backgroundContainer.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 225, height: 305)
        createPursuitLabel.anchor(top: backgroundContainer.topAnchor, left: leftAnchor, bottom: nil, right: backgroundContainer.rightAnchor, paddingTop: 18, paddingLeft: 8, paddingBottom: 0, paddingRight: 8, width: createPursuitLabel.intrinsicContentSize.width, height: 65)
        createButton.anchor(top: createPursuitLabel.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 18, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 30, height: 30)
        createButton.centerXAnchor.constraint(equalTo: createPursuitLabel.centerXAnchor).isActive = true
        addIcon.anchor(top: nil, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 15, height: 15)
        addIcon.centerXAnchor.constraint(equalTo: createButton.centerXAnchor).isActive = true
        addIcon.centerYAnchor.constraint(equalTo: createButton.centerYAnchor).isActive = true
        
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
