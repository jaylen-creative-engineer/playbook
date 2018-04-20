//
//  CreateAlertViewCell.swift
//  pursue
//
//  Created by Jaylen Sanders on 3/20/18.
//  Copyright © 2018 Glory. All rights reserved.
//

import UIKit

class CreateAlertViewCell : UICollectionViewCell {
    
    lazy var backgroundContainer : UIView = {
        let view = UIView()
        view.layer.cornerRadius = 4
        view.layer.masksToBounds = true
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.borderWidth = 1.5
        return view
    }()
    
    lazy var pursuitImageView : CustomImageView = {
        let iv = CustomImageView()
        iv.contentMode = .scaleAspectFill
        iv.layer.cornerRadius = 4
        iv.layer.masksToBounds = true
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    lazy var addPictureTitle : UIButton = {
       let button = UIButton()
        button.setTitle("Create Pursuit", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 12)
        return button
    }()
    
    func setupView(){
        addSubview(backgroundContainer)
        backgroundContainer.addSubview(pursuitImageView)
        backgroundContainer.addSubview(addPictureTitle)
        
        backgroundContainer.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 330, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 175)
        pursuitImageView.anchor(top: backgroundContainer.topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 8, paddingRight: 0, width: 0, height: 150)
        addPictureTitle.centerXAnchor.constraint(equalTo: pursuitImageView.centerXAnchor).isActive = true
        addPictureTitle.centerYAnchor.constraint(equalTo: pursuitImageView.centerYAnchor).isActive = true
        addPictureTitle.anchor(top: nil, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: addPictureTitle.intrinsicContentSize.width, height: addPictureTitle.intrinsicContentSize.height)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
