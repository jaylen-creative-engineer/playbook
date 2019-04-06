//
//  ProfileChallengeCell.swift
//  Inpursuit
//
//  Created by Jaylen Sanders on 12/29/18.
//  Copyright © 2018 Glory. All rights reserved.
//

import UIKit

class ProfileChallengeCell : UICollectionViewCell {
    
    let cellBackgroundView : HomeCellRectangleView = {
        let view = HomeCellRectangleView()
        view.backgroundColor = .white
        return view
    }()
    
    let challengeImage : UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.image = UIImage(named: "cafe-768771_1280")?.withRenderingMode(.alwaysOriginal)
        iv.layer.masksToBounds = true
        return iv
    }()
    
    let challengeDescription : UILabel = {
        let label = UILabel()
        label.text = "This is a description"
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textAlignment = .left
        return label
    }()
    
    let userPhoto : UIImageView = {
        let iv = UIImageView()
        iv.layer.cornerRadius = 17
        iv.layer.masksToBounds = true
        iv.image = UIImage(named: "cafe-768771_1280")?.withRenderingMode(.alwaysOriginal)
        return iv
    }()
    
    let usernameLabel : UILabel = {
        let label = UILabel()
        label.text = "Test"
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()
    
    let userPhotoBackground : ProfileChallengeUserPhotoView = {
        let view = ProfileChallengeUserPhotoView()
        view.backgroundColor = .white
        return view
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        challengeImage.roundCorners(corners: [.topLeft, .topRight], radius: 12.0)
    }
    
    func setupView(){
        addSubview(cellBackgroundView)
        addSubview(challengeImage)
        addSubview(userPhotoBackground)
        addSubview(userPhoto)
        addSubview(challengeDescription)
        addSubview(usernameLabel)
        
        cellBackgroundView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        challengeImage.anchor(top: cellBackgroundView.topAnchor, left: cellBackgroundView.leftAnchor, bottom: nil, right: cellBackgroundView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: (frame.height / 1.3) - 20)
        userPhotoBackground.anchor(top: nil, left: nil, bottom: nil, right: challengeImage.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 8, width: 34, height: 34)
        userPhotoBackground.centerYAnchor.constraint(equalTo: challengeImage.bottomAnchor).isActive = true
        userPhoto.anchor(top: userPhotoBackground.topAnchor, left: userPhotoBackground.leftAnchor, bottom: userPhotoBackground.bottomAnchor, right: userPhotoBackground.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        challengeDescription.anchor(top: userPhoto.bottomAnchor, left: cellBackgroundView.leftAnchor, bottom: nil, right: cellBackgroundView.rightAnchor, paddingTop: 4, paddingLeft: 12, paddingBottom: 0, paddingRight: 12, width: 0, height: 18)
        usernameLabel.anchor(top: challengeDescription.bottomAnchor, left: cellBackgroundView.leftAnchor, bottom: nil, right: cellBackgroundView.rightAnchor, paddingTop: 4, paddingLeft: 12, paddingBottom: 0, paddingRight: 12, width: 0, height: 16)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
