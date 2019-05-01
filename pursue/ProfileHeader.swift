//
//  ProfileHeader.swift
//  pursue
//
//  Created by Jaylen Sanders on 6/22/18.
//  Copyright © 2018 Glory. All rights reserved.
//

import UIKit
import Mixpanel
import ParallaxHeader
import Firebase

protocol ProfileHeaderDelegate {
    func handleMessage(for cell : ProfileHeader)
}

class ProfileHeader : UICollectionViewCell {
    
    let profilePicture : UIImageView = {
       let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.layer.cornerRadius = 15
        iv.layer.masksToBounds = true
        iv.image = UIImage(named: "cafe-768771_1280")?.withRenderingMode(.alwaysOriginal)
        return iv
    }()
    
    let addedCount : UILabel = {
       let label = UILabel()
        label.text = "30"
        label.font = UIFont.boldSystemFont(ofSize: 24)
        return label
    }()
    
    let addedLabel : UILabel = {
       let label = UILabel()
        label.text = "Added"
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    let addButton : UIButton = {
       let button = UIButton()
        button.backgroundColor = .darkGray
        button.layer.cornerRadius = 16
        button.layer.masksToBounds = true
        return button
    }()
    
    let usernameLabel : UILabel = {
       let label = UILabel()
        label.text = "Test"
        label.font = UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.init(25))
        label.textAlignment = .left
        return label
    }()
    
    let fullnameLabel : UILabel = {
        let label = UILabel()
        label.text = "Test"
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .darkGray
        label.textAlignment = .left
        return label
    }()
    
    let bioLabel : UILabel = {
       let label = UILabel()
        label.text = "Follow your passion! This app is the reason why I exist and I love achieving my goals."
        label.numberOfLines = 2
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()
    
    let pursuitButton : UIButton = {
       let button = UIButton(type: .system)
        button.tintColor = .darkGray
        button.backgroundColor = .darkGray
        button.layer.cornerRadius = 10
        button.layer.masksToBounds = true
        return button
    }()
    
    let challengeButton : UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .darkGray
        button.backgroundColor = .darkGray
        button.layer.cornerRadius = 10
        button.layer.masksToBounds = true
        return button
    }()
    
    let pursuitImage : UIImageView = {
       let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.layer.cornerRadius = 4
        iv.layer.masksToBounds = true
        iv.image = UIImage(named: "cafe-768771_1280")?.withRenderingMode(.alwaysOriginal)
        return iv
    }()
    
    let pursuitLabel : UILabel = {
        let label = UILabel()
        label.text = "PURSUITS"
        label.font = UIFont.systemFont(ofSize: 12)
        label.textAlignment = .left
        return label
    }()
    
    let pursuitCountLabel : UILabel = {
       let label = UILabel()
        label.text = "30"
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textAlignment = .left
        return label
    }()
    
    let challengeImage : UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.layer.cornerRadius = 4
        iv.layer.masksToBounds = true
        iv.image = UIImage(named: "cafe-768771_1280")?.withRenderingMode(.alwaysOriginal)
        return iv
    }()
    
    let challengeLabel : UILabel = {
        let label = UILabel()
        label.text = "CHALLENGES"
        label.font = UIFont.systemFont(ofSize: 12)
        label.textAlignment = .left
        return label
    }()
    
    let challengeCountLabel : UILabel = {
        let label = UILabel()
        label.text = "30"
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textAlignment = .left
        return label
    }()
    
    func setupToggleView(){
        addSubview(pursuitButton)
        addSubview(challengeButton)
        
        pursuitButton.addSubview(pursuitImage)
        pursuitButton.addSubview(pursuitLabel)
        pursuitButton.addSubview(pursuitCountLabel)
        
        challengeButton.addSubview(challengeImage)
        challengeButton.addSubview(challengeLabel)
        challengeButton.addSubview(challengeCountLabel)
        
        pursuitButton.anchor(top: bioLabel.bottomAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 24, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: 118, height: 130)
        challengeButton.anchor(top: pursuitButton.topAnchor, left: pursuitButton.rightAnchor, bottom: pursuitButton.bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 18, paddingBottom: 0, paddingRight: 0, width: 118, height: 0)
        pursuitImage.anchor(top: pursuitButton.topAnchor, left: pursuitButton.leftAnchor, bottom: nil, right: nil, paddingTop: 8, paddingLeft: 8, paddingBottom: 0, paddingRight: 0, width: 31, height: 36)
        pursuitLabel.anchor(top: pursuitImage.bottomAnchor, left: pursuitButton.leftAnchor, bottom: nil, right: pursuitButton.rightAnchor, paddingTop: 24, paddingLeft: 8, paddingBottom: 0, paddingRight: 8, width: 0, height: 14)
        pursuitCountLabel.anchor(top: pursuitLabel.bottomAnchor, left: pursuitLabel.leftAnchor, bottom: nil, right: pursuitButton.rightAnchor, paddingTop: 4, paddingLeft: 0, paddingBottom: 0, paddingRight: 6, width: 0, height: 20)
        challengeImage.anchor(top: challengeButton.topAnchor, left: challengeButton.leftAnchor, bottom: nil, right: nil, paddingTop: 8, paddingLeft: 8, paddingBottom: 0, paddingRight: 0, width: 31, height: 36)
        challengeLabel.anchor(top: challengeImage.bottomAnchor, left: challengeButton.leftAnchor, bottom: nil, right: challengeButton.rightAnchor, paddingTop: 24, paddingLeft: 8, paddingBottom: 0, paddingRight: 8, width: 0, height: 14)
        challengeCountLabel.anchor(top: challengeLabel.bottomAnchor, left: challengeLabel.leftAnchor, bottom: nil, right: challengeButton.rightAnchor, paddingTop: 4, paddingLeft: 0, paddingBottom: 0, paddingRight: 6, width: 0, height: 20)
    }
    
    func setupUserDetails(){
        addSubview(usernameLabel)
        addSubview(fullnameLabel)
        addSubview(bioLabel)
        
        usernameLabel.anchor(top: profilePicture.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 24, paddingLeft: 12, paddingBottom: 0, paddingRight: 18, width: 0, height: 20)
        fullnameLabel.anchor(top: usernameLabel.bottomAnchor, left: usernameLabel.leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 8, paddingLeft: 0, paddingBottom: 0, paddingRight: 18, width: 0, height: 14)
        bioLabel.anchor(top: fullnameLabel.bottomAnchor, left: fullnameLabel.leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 18, paddingLeft: 0, paddingBottom: 0, paddingRight: 12, width: 0, height: 0)
        bioLabel.heightAnchor.constraint(lessThanOrEqualToConstant: 42).isActive = true
    }
    
    func setupView(){
        addSubview(profilePicture)
        addSubview(addedCount)
        addSubview(addedLabel)
        addSubview(addButton)
        
        profilePicture.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 24, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: 96, height: 96)
        addedCount.anchor(top: profilePicture.topAnchor, left: profilePicture.rightAnchor, bottom: nil, right: nil, paddingTop: 12, paddingLeft: 16, paddingBottom: 0, paddingRight: 0, width: addedCount.intrinsicContentSize.width, height: 26)
        addedLabel.anchor(top: nil, left: addedCount.rightAnchor, bottom: addedCount.bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 4, paddingBottom: 2, paddingRight: 0, width: addedLabel.intrinsicContentSize.width, height: 18)
        addButton.anchor(top: addedLabel.bottomAnchor, left: profilePicture.rightAnchor, bottom: nil, right: nil, paddingTop: 12, paddingLeft: 8, paddingBottom: 0, paddingRight: 0, width: 120, height: 34)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupUserDetails()
        setupToggleView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

