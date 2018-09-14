//
//  FollowedNotification.swift
//  pursue
//
//  Created by Jaylen Sanders on 2/28/18.
//  Copyright © 2018 Glory. All rights reserved.
//

import UIKit

class FollowedNotification : UICollectionViewCell {
    
    let userPhoto : UIImageView = {
        let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "samuel-l").withRenderingMode(.alwaysOriginal)
        iv.contentMode = .scaleAspectFill
        iv.layer.masksToBounds = true
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.layer.cornerRadius = 32.5
        return iv
    }()
    
    let followLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Lato-Semibold", size: 12)
        label.text = "Test added you."
        label.numberOfLines = 2
        return label
    }()
    
    let usernameLabel : UILabel = {
        let label = UILabel()
        label.text = "TomDoe"
        label.font = UIFont(name: "Lato-Bold", size: 14)
        return label
    }()
    
    let timeLabel : UILabel = {
        let label = UILabel()
        label.text = "21 hours ago"
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()
    
    let followButton : UIButton = {
       let button = UIButton()
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.borderWidth = 1.5
        button.layer.cornerRadius = 8
        button.layer.masksToBounds = true
        return button
    }()
    
    func setupView(){
        let userStackView = UIStackView(arrangedSubviews: [followLabel, timeLabel])
        userStackView.axis = .vertical
        userStackView.distribution = .fillEqually
        userStackView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(userPhoto)
        addSubview(userStackView)
        
        userPhoto.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 8, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: 65, height: 65)
        userStackView.anchor(top: nil, left: userPhoto.rightAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 12, paddingBottom: 0, paddingRight: 12, width: 0, height: 50)
        userStackView.centerYAnchor.constraint(equalTo: userPhoto.centerYAnchor).isActive = true
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
