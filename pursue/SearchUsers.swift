//
//  SearchUsers.swift
//  pursue
//
//  Created by Jaylen Sanders on 2/15/18.
//  Copyright © 2018 Glory. All rights reserved.
//

import UIKit

class SearchUsers : UICollectionViewCell {
    
    lazy var userPhoto : UIImageView = {
        let iv = UIImageView()
        iv.layer.cornerRadius = 30
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.image = #imageLiteral(resourceName: "samuel-l").withRenderingMode(.alwaysOriginal)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleProfileTap))
        tapGesture.numberOfTapsRequired = 1
        iv.addGestureRecognizer(tapGesture)
        iv.isUserInteractionEnabled = true
        return iv
    }()
    
    let usernameLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        return label
    }()
    
    let usersLabel : UILabel = {
       let label = UILabel()
        label.text = "Users"
        label.font = UIFont.boldSystemFont(ofSize: 14)
        return label
    }()
    
    @objc func handleProfileTap(){
        
    }
    
    func setupUserPhoto(){
        addSubview(usersLabel)
        addSubview(userPhoto)
        addSubview(usernameLabel)
        
        usersLabel.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: usersLabel.intrinsicContentSize.width, height: 16)
        userPhoto.anchor(top: nil, left: leftAnchor, bottom: bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: 60, height: 60)
        usernameLabel.anchor(top: userPhoto.topAnchor, left: userPhoto.rightAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: usernameLabel.intrinsicContentSize.width, height: usernameLabel.intrinsicContentSize.height)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUserPhoto()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
