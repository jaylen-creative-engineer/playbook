//
//  FriendsCells.swift
//  pursue
//
//  Created by Jaylen Sanders on 2/27/18.
//  Copyright © 2018 Glory. All rights reserved.
//

import UIKit

class FriendsCells : UICollectionViewCell {
    
    let userPhoto : UIImageView = {
        let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "samuel-l").withRenderingMode(.alwaysOriginal)
        iv.contentMode = .scaleAspectFill
        iv.layer.masksToBounds = true
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.layer.cornerRadius = 30
        return iv
    }()
    
    let usernameLabel : UILabel = {
       let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.text = "TomDoe01"
        return label
    }()
    
    let fullnameLabel : UILabel = {
       let label = UILabel()
        label.text = "Tom Doe"
        label.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.init(25))
        return label
    }()
    
    lazy var followBackground : CardView = {
       let button = CardView()
        button.backgroundColor = .white
        button.layer.cornerRadius = 20
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isUserInteractionEnabled = true
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(toggleFollow))
        tap.numberOfTapsRequired = 1
        button.addGestureRecognizer(tap)
        return button
    }()
    
    lazy var addIcon : UIImageView = {
       let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "add-profile").withRenderingMode(.alwaysTemplate)
        iv.tintColor = .black
        iv.contentMode = .scaleAspectFill
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.isUserInteractionEnabled = true
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(toggleFollow))
        tap.numberOfTapsRequired = 1
        iv.addGestureRecognizer(tap)
        return iv
    }()
    
    var isLiked = true
    
    @objc func toggleFollow(){
        isLiked = !isLiked
        if isLiked == true {
            addIcon.tintColor = .white
            followBackground.backgroundColor = .black
        } else {
            addIcon.tintColor = .black
            followBackground.backgroundColor = .white
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(userPhoto)
        addSubview(fullnameLabel)
        addSubview(usernameLabel)
        addSubview(followBackground)
        followBackground.addSubview(addIcon)
        
        userPhoto.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 12, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: 60, height: 60)
        fullnameLabel.anchor(top: userPhoto.topAnchor, left: userPhoto.rightAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: fullnameLabel.intrinsicContentSize.width, height: fullnameLabel.intrinsicContentSize.height)
        usernameLabel.anchor(top: fullnameLabel.bottomAnchor, left: fullnameLabel.leftAnchor, bottom: nil, right: nil, paddingTop: 8, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: usernameLabel.intrinsicContentSize.width, height: usernameLabel.intrinsicContentSize.height)
        followBackground.anchor(top: topAnchor, left: nil, bottom: nil, right: rightAnchor, paddingTop: 12, paddingLeft: 0, paddingBottom: 0, paddingRight: 12, width: 40, height: 40)
        addIcon.anchor(top: nil, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 15, height: 15)
        addIcon.centerXAnchor.constraint(equalTo: followBackground.centerXAnchor).isActive = true
        addIcon.centerYAnchor.constraint(equalTo: followBackground.centerYAnchor).isActive = true
        toggleFollow()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
