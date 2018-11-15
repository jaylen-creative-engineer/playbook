//
//  DetailRelatedCells.swift
//  pursue
//
//  Created by Jaylen Sanders on 9/8/18.
//  Copyright © 2018 Glory. All rights reserved.
//

import UIKit

class DetailSavedCells : UICollectionViewCell  {
    
    var post : Post? {
        didSet {
            guard let image = post?.thumbnailUrl else { return }
            guard let profilePicture = post?.userPhotourl else { return }
            photo.loadImageUsingCacheWithUrlString(image)
            userPhoto.loadImageUsingCacheWithUrlString(profilePicture)
            usernameLabel.text = post?.username
            postLabel.text = post?.description
        }
    }
    
    let photo : UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = .blue
        iv.layer.cornerRadius = 4
        iv.clipsToBounds = true
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    let userPhoto : UIImageView = {
       let iv = UIImageView()
        iv.layer.cornerRadius = 15
        iv.layer.masksToBounds = true
        return iv
    }()
    
    let usernameLabel : UILabel = {
       let label = UILabel()
        label.font = UIFont(name: "Lato-Semibold", size: 12)
        return label
    }()
    
    let postLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.numberOfLines = 1
        return label
    }()
    
    func setupView(){
        addSubview(photo)
        addSubview(userPhoto)
        addSubview(usernameLabel)
        addSubview(postLabel)

        photo.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 210)
        userPhoto.anchor(top: photo.bottomAnchor, left: photo.leftAnchor, bottom: nil, right: nil, paddingTop: 12, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 30, height: 30)
        usernameLabel.anchor(top: userPhoto.topAnchor, left: userPhoto.rightAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 8, paddingBottom: 0, paddingRight: 0, width: usernameLabel.intrinsicContentSize.width, height: 14)
        postLabel.anchor(top: usernameLabel.bottomAnchor, left: usernameLabel.leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 8, paddingLeft: 0, paddingBottom: 0, paddingRight: 6, width: 0, height: 0)
        postLabel.heightAnchor.constraint(lessThanOrEqualToConstant: 30).isActive = true
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        hero.isEnabled = true
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
