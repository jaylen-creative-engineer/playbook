//
//  ProfilePursuitCells.swift
//  pursue
//
//  Created by Jaylen Sanders on 3/13/18.
//  Copyright © 2018 Glory. All rights reserved.
//

import UIKit

class ProfilePursuitCells : UICollectionViewCell {
    
    let photoBackground : HomeCellRectangleView = {
        let iv = HomeCellRectangleView()
        iv.layer.cornerRadius = 8
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    let photo : UIImageView = {
        let iv = UIImageView()
        iv.layer.cornerRadius = 8
        iv.layer.masksToBounds = true
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    let detailLabel : UILabel = {
        let label = UILabel()
        label.text = "Have a vision to work towards"
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()
    
    let usernameLabel : UILabel = {
        let label = UILabel()
        label.text = "Test"
        label.font = UIFont.systemFont(ofSize: 10)
        label.textColor = .gray
        return label
    }()
    
    let circleView : UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        view.layer.cornerRadius = 2
        return view
    }()
    
    let daysLabel : UILabel = {
        let label = UILabel()
        label.text = "2 Days"
        label.font = UIFont.systemFont(ofSize: 10)
        label.textColor = .gray
        return label
    }()
    
    let optionButton : UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "options").withRenderingMode(.alwaysTemplate), for: .normal)
        button.imageView?.contentMode = .scaleAspectFill
        button.tintColor = .gray
        return button
    }()
    
    func setupView(){
        addSubview(photoBackground)
        addSubview(photo)
        addSubview(detailLabel)
        addSubview(usernameLabel)
        addSubview(circleView)
        addSubview(daysLabel)
        addSubview(optionButton)
        
        photoBackground.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 210, height: 130)
        photo.anchor(top: photoBackground.topAnchor, left: photoBackground.leftAnchor, bottom: photoBackground.bottomAnchor, right: photoBackground.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        detailLabel.anchor(top: photo.bottomAnchor, left: photo.leftAnchor, bottom: nil, right: nil, paddingTop: 18, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: detailLabel.intrinsicContentSize.width, height: detailLabel.intrinsicContentSize.height)
        usernameLabel.anchor(top: detailLabel.bottomAnchor, left: detailLabel.leftAnchor, bottom: nil, right: nil, paddingTop: 10, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: usernameLabel.intrinsicContentSize.width, height: usernameLabel.intrinsicContentSize.height)
        circleView.anchor(top: nil, left: usernameLabel.rightAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 8, paddingBottom: 0, paddingRight: 0, width: 4, height: 4)
        circleView.centerYAnchor.constraint(equalTo: usernameLabel.centerYAnchor).isActive = true
        daysLabel.anchor(top: usernameLabel.topAnchor, left: circleView.rightAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 8, paddingBottom: 0, paddingRight: 0, width: daysLabel.intrinsicContentSize.width, height: daysLabel.intrinsicContentSize.height)
        optionButton.anchor(top: photo.bottomAnchor, left: nil, bottom: nil, right: photo.rightAnchor, paddingTop: 18, paddingLeft: 0, paddingBottom: 0, paddingRight: 4, width: 8, height: 16)
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
