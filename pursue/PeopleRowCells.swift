//
//  PeopleRowCells.swift
//  pursue
//
//  Created by Jaylen Sanders on 10/23/17.
//  Copyright © 2017 Glory. All rights reserved.
//

import UIKit

protocol PeopleRowCellDelegate {
    func profileTapped()
}

class PeopleRowCells : UICollectionViewCell {
    
    var user : SearchedUsers? {
        didSet {
            guard let photo = user?.photoUrl else { return }
            userPhoto.loadImage(urlString: photo)
            usernameLabel.text = user?.username
        }
    }
    
    lazy var userPhoto : CustomImageView = {
        let iv = CustomImageView()
        iv.layer.cornerRadius = 40
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
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        return label
    }()
    
    @objc func handleProfileTap(){
    }
    
    func setupView(){
        addSubview(userPhoto)
        addSubview(usernameLabel)
        userPhoto.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 80, height: 80)
        usernameLabel.anchor(top: userPhoto.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 16, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: usernameLabel.intrinsicContentSize.width, height: usernameLabel.intrinsicContentSize.height)
        usernameLabel.centerXAnchor.constraint(equalTo: userPhoto.centerXAnchor).isActive = true
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
