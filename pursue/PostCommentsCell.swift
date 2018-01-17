//
//  PostCommentsCell.swift
//  pursue
//
//  Created by Jaylen Sanders on 10/16/17.
//  Copyright © 2017 Glory. All rights reserved.
//

import UIKit

class PostCommentsCell : UICollectionViewCell {
    let usernameLabel : UILabel = {
        let label = UILabel()
        label.text = "Test27"
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let commentText : UILabel = {
        let label = UILabel()
        label.text = "Keep up the great work."
        label.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.thin)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let userPhoto : UIImageView = {
        let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "samuel-l")
        iv.layer.cornerRadius = 25
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
        
    }()
    
    func setupView(){
        addSubview(userPhoto)
        
        let userInfoStack = UIStackView(arrangedSubviews: [usernameLabel, commentText])
        userInfoStack.axis = .vertical
        userInfoStack.spacing = 10
        userInfoStack.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(userInfoStack)
        
        userPhoto.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: 50, height: 50)
        userInfoStack.anchor(top: userPhoto.topAnchor, left: userPhoto.rightAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 12, paddingBottom: 0, paddingRight: 12, width: 0, height: 0)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
