//
//  SearchUsers.swift
//  pursue
//
//  Created by Jaylen Sanders on 2/15/18.
//  Copyright © 2018 Glory. All rights reserved.
//

import UIKit

class SearchUsers : UICollectionViewCell {
    
    var searchUser : Search? {
        didSet {
            guard let image = searchUser?.photoUrl else { return }
            userPhoto.loadImageUsingCacheWithUrlString(image)
            usernameLabel.text = searchUser?.username
        }
    }
    
    var accessHomeController : HomeController?
    
    lazy var userPhoto : UIImageView = {
        let iv = UIImageView()
        iv.layer.cornerRadius = 30
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleProfileTap))
        tapGesture.numberOfTapsRequired = 1
        iv.addGestureRecognizer(tapGesture)
        iv.isUserInteractionEnabled = true
        return iv
    }()
    
    let usernameLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
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
//        accessHomeController?.handleChangeToProfile(userId: (searchUser?.userId)!)
    }
    
    func setupUserPhoto(){
        addSubview(usersLabel)
        addSubview(userPhoto)
        addSubview(usernameLabel)
        
        usersLabel.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: usersLabel.intrinsicContentSize.width, height: 16)
        userPhoto.anchor(top: usersLabel.bottomAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 18, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: 60, height: 60)
        usernameLabel.anchor(top: userPhoto.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 8, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: usernameLabel.intrinsicContentSize.width, height: 16)
        usernameLabel.centerXAnchor.constraint(equalTo: userPhoto.centerXAnchor).isActive = true
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUserPhoto()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
