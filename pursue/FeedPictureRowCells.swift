//
//  FeedPictureRowCells.swift
//  pursue
//
//  Created by Jaylen Sanders on 10/30/17.
//  Copyright © 2017 Glory. All rights reserved.
//

import UIKit

class FeedPictureRowCells : UICollectionViewCell {
    
    let usernameLabel : UILabel = {
        let label = UILabel()
        label.text = "Test27"
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let timeDetail : UILabel = {
        let label = UILabel()
        label.text = "6 minutes ago"
        label.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.thin)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let postLabel : UILabel = {
        let label = UILabel()
        label.text = "I just wanted you guys to see what I did yesterday."
        label.font = UIFont.systemFont(ofSize: 20, weight: UIFont.Weight(rawValue: 25))
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        return label
    }()
    
    let postDetailLabel : UILabel = {
        let label = UILabel()
        label.text = "I just wanted you guys to see what I did yesterday."
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
    
    let cardImage : UIImageView = {
        let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "trees")
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
    }()
    
    let cardButton : UIButton = {
        let button = UIButton()
        return button
    }()
    
    func setupCardView(){
        addSubview(cardButton)
        cardButton.addSubview(cardImage)
        
        cardButton.anchor(top: userPhoto.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 24, paddingLeft: 12, paddingBottom: 0, paddingRight: 12, width: 0, height: 425)
        cardImage.anchor(top: cardButton.topAnchor, left: cardButton.leftAnchor, bottom: cardButton.bottomAnchor, right: cardButton.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
    }
    
    func setupView(){
        addSubview(userPhoto)
        addSubview(usernameLabel)
        
        let userInfoStack = UIStackView(arrangedSubviews: [usernameLabel,timeDetail])
        userInfoStack.axis = .vertical
        userInfoStack.spacing = 10
        userInfoStack.translatesAutoresizingMaskIntoConstraints = false
        addSubview(userInfoStack)
        
        userInfoStack.anchor(top: nil, left: userPhoto.rightAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 12, paddingBottom: 0, paddingRight: 12, width: 0, height: 0)
        userInfoStack.centerYAnchor.constraint(equalTo: userPhoto.centerYAnchor).isActive = true
        userPhoto.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 12, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: 60, height: 60)
        
        setupCardView()
        
        addSubview(postLabel)
        addSubview(postDetailLabel)
        
        postLabel.anchor(top: cardButton.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 16, paddingLeft: 12, paddingBottom: 0, paddingRight: 12, width: 0, height: 48)
        postDetailLabel.anchor(top: postLabel.bottomAnchor, left: postLabel.leftAnchor, bottom: nil, right: postLabel.rightAnchor, paddingTop: 8, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: postDetailLabel.intrinsicContentSize.width, height: postDetailLabel.intrinsicContentSize.height)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
