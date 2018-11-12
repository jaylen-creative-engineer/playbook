//
//  FriendsCells.swift
//  pursue
//
//  Created by Jaylen Sanders on 2/27/18.
//  Copyright © 2018 Glory. All rights reserved.
//

import UIKit

class FriendsCells : UICollectionViewCell {
    
    var added : User? {
        didSet {
            guard let image = added?.photoUrl else { return }
            userPhoto.loadImageUsingCacheWithUrlString(image)
            usernameLabel.text = added?.username
            fullnameLabel.text = added?.fullname
            
        }
    }
    
    let userPhoto : UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.layer.masksToBounds = true
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.layer.cornerRadius = 30
        return iv
    }()
    
    let usernameLabel : UILabel = {
       let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 12)
        return label
    }()
    
    let fullnameLabel : UILabel = {
       let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.init(25))
        return label
    }()

    
    var isLiked = true
    var accessFriendsController : FriendsController?
    
    fileprivate func setupView() {
        addSubview(userPhoto)
        addSubview(fullnameLabel)
        addSubview(usernameLabel)
        
        userPhoto.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 12, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: 60, height: 60)
        fullnameLabel.anchor(top: userPhoto.topAnchor, left: userPhoto.rightAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: fullnameLabel.intrinsicContentSize.width, height: fullnameLabel.intrinsicContentSize.height)
        usernameLabel.anchor(top: fullnameLabel.bottomAnchor, left: fullnameLabel.leftAnchor, bottom: nil, right: nil, paddingTop: 8, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: usernameLabel.intrinsicContentSize.width, height: usernameLabel.intrinsicContentSize.height)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
