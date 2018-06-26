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
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Test"
        return label
    }()
    
    let commentText : UITextView = {
        let label = UITextView()
        label.isScrollEnabled = false
        label.font = UIFont.systemFont(ofSize: 10)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let peopleBackground : PlayView = {
        let view = PlayView()
        view.backgroundColor = .black
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let userPhoto : UIImageView = {
        let iv = UIImageView()
        iv.layer.cornerRadius = 25
        iv.contentMode = .scaleAspectFill
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
        
    }()
    
    func setupView(){
        addSubview(peopleBackground)
//        addSubview(userPhoto)
        addSubview(usernameLabel)
        addSubview(commentText)
        
        peopleBackground.anchor(top: safeAreaLayoutGuide.topAnchor, left: safeAreaLayoutGuide.leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: 30, height: 30)
//        userPhoto.anchor(top: peopleBackground.topAnchor, left: peopleBackground.leftAnchor, bottom: peopleBackground.bottomAnchor, right: peopleBackground.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        usernameLabel.anchor(top: peopleBackground.topAnchor, left: peopleBackground.rightAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: usernameLabel.intrinsicContentSize.width, height: usernameLabel.intrinsicContentSize.height)
        commentText.anchor(top: usernameLabel.bottomAnchor, left: usernameLabel.leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 10, paddingLeft: 0, paddingBottom: 0, paddingRight: 12, width: commentText.intrinsicContentSize.width, height: 70)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
