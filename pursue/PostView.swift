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
    
    lazy var likeIcon : UIButton = {
        let button = UIButton()
        button.contentMode = .scaleAspectFill
        button.tintColor = .black
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(toggleLike), for: .touchUpInside)
        return button
    }()
    
    let likeCounter : UILabel = {
        let label = UILabel()
        label.text = "132"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var commentIcon : UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "comment").withRenderingMode(.alwaysTemplate), for: .normal)
        button.contentMode = .scaleAspectFill
        button.tintColor = .gray
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
   
    lazy var saveIcon : UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "add").withRenderingMode(.alwaysTemplate), for: .normal)
        button.contentMode = .scaleAspectFill
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(toggleSave), for: .touchUpInside)
        return button
    }()
    
    let usernameUnderLine = UIView()
    let userstackUnderLine = UIView()
    let userstackTopLine = UIView()
    
    let cellId = "cellId"
    let commentId = "commentId"
    let relatedId = "relatedId"
    var isLiked = false
    var isSaved = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    @objc func toggleSave(){
        isSaved = !isSaved
        
        if isSaved == true {
            saveIcon.tintColor = .black
        } else {
            saveIcon.tintColor = .gray
        }
    }
    
    @objc func toggleLike(){
    isLiked = !isLiked
        likeIcon.setImage(isLiked == true ? #imageLiteral(resourceName: "like_selected").withRenderingMode(.alwaysTemplate) : #imageLiteral(resourceName: "like_unselected").withRenderingMode(.alwaysOriginal), for: .normal)
        
        if isLiked == true {
            likeCounter.font = UIFont.boldSystemFont(ofSize: 16)
        } else {
            likeCounter.font = UIFont.systemFont(ofSize: 16)
        }
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
    
    func setupEngagements(){
        addSubview(likeIcon)
        addSubview(likeCounter)
        addSubview(commentIcon)
        addSubview(saveIcon)
        
        likeIcon.anchor(top: postDescription.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 20, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 35, height: 30)
        likeIcon.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        likeCounter.anchor(top: likeIcon.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 4, paddingLeft: 4, paddingBottom: 0, paddingRight: 0, width: likeCounter.intrinsicContentSize.width, height: likeCounter.intrinsicContentSize.height)
        likeCounter.centerXAnchor.constraint(equalTo: likeIcon.centerXAnchor).isActive = true
        commentIcon.anchor(top: likeIcon.topAnchor, left: likeIcon.rightAnchor, bottom: nil, right: nil, paddingTop: 8, paddingLeft: 48, paddingBottom: 0, paddingRight: 0, width: 20, height: 18)
        saveIcon.anchor(top: likeIcon.topAnchor, left: nil, bottom: nil, right: likeIcon.leftAnchor, paddingTop: 8, paddingLeft: 0, paddingBottom: 0, paddingRight: 52, width: 22, height: 22)
        toggleLike()
        toggleSave()
    }

    func setupView(){
        addSubview(userPhoto)
        addSubview(usernameUnderLine)
        addSubview(postDescription)
        
        userPhoto.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: 60, height: 60)
        usernameUnderLine.anchor(top: userPhoto.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 18, paddingLeft: 12, paddingBottom: 0, paddingRight: 12, width: 0, height: 0.5)
        postDescription.anchor(top: userPhoto.bottomAnchor, left: userPhoto.leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 6, paddingBottom: 0, paddingRight: 28, width: 0, height: 70)
        userNameSetup()
        setupEngagements()

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
