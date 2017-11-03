//
//  PostView.swift
//  pursue
//
//  Created by Jaylen Sanders on 10/14/17.
//  Copyright © 2017 Glory. All rights reserved.
//

import UIKit

class PostView : UICollectionViewCell {
        
    let postDescription : UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = "I’m still pretty sick today, I think it would be smart to take at least one more day to get to one hundred percent."
        label.font = UIFont.systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let usernameLabel : UILabel = {
        let label = UILabel()
        label.text = "Test27"
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let fullnameLabel : UILabel = {
        let label = UILabel()
        label.text = "Jaylen Sanders"
        label.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.thin)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let userPhoto : UIImageView = {
        let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "samuel-l")
        iv.layer.cornerRadius = 30
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
        
    }()
    
    let usernameUnderLine = UIView()
    let userstackUnderLine = UIView()
    let userstackTopLine = UIView()
    
    let cellId = "cellId"
    let commentId = "commentId"
    let relatedId = "relatedId"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    
    func userNameSetup(){
        let userInfoStack = UIStackView(arrangedSubviews: [usernameLabel, fullnameLabel])
        userInfoStack.axis = .vertical
        userInfoStack.spacing = 10
        userInfoStack.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(userInfoStack)
        
        userInfoStack.anchor(top: nil, left: userPhoto.rightAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 12, paddingBottom: 0, paddingRight: 12, width: 0, height: 0)
        userInfoStack.centerYAnchor.constraint(equalTo: userPhoto.centerYAnchor).isActive = true
        
    }

    func setupView(){
        backgroundColor = .clear
        
        addSubview(userPhoto)
        addSubview(usernameUnderLine)
        addSubview(postDescription)
        
        userPhoto.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 18, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: 60, height: 60)
        usernameUnderLine.anchor(top: userPhoto.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 18, paddingLeft: 12, paddingBottom: 0, paddingRight: 12, width: 0, height: 0.5)
        postDescription.anchor(top: userPhoto.bottomAnchor, left: userPhoto.leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 6, paddingBottom: 0, paddingRight: 28, width: 0, height: 70)
        userNameSetup()

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
