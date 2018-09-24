//
//  DetailSolutionCells.swift
//  pursue
//
//  Created by Jaylen Sanders on 6/26/18.
//  Copyright © 2018 Glory. All rights reserved.
//

import UIKit

class DetailSolutionCells : UICollectionViewCell {
    
    let cardBackground : SolutionCardView = {
       let view = SolutionCardView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let card : UIButton = {
       let button = UIButton()
        button.backgroundColor = .white
        button.layer.cornerRadius = 4
        button.layer.masksToBounds = true
        return button
    }()
    
    let photo : UIImageView = {
       let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.layer.cornerRadius = 4
        iv.layer.masksToBounds = true
        return iv
    }()
    
    let solutionLabel : UILabel = {
       let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.text = "Hold your breath for four, release for four and breath in for four"
        label.numberOfLines = 2
        return label
    }()
    
    let usernameLabel : UILabel = {
       let label = UILabel()
        label.text = "Test"
        label.font = UIFont.systemFont(ofSize: 10)
        return label
    }()
    
    let upVotesLabel : UILabel = {
       let label = UILabel()
        label.text = "30 Upvotes"
        label.font = UIFont.systemFont(ofSize: 10)
        return label
    }()
    
    let acceptLabel : UILabel = {
       let label = UILabel()
        label.text = "Accept"
        label.textColor = .green
        label.font = UIFont.boldSystemFont(ofSize: 10)
        return label
    }()
    
    let declineLabel : UILabel = {
        let label = UILabel()
        label.text = "Decline"
        label.textColor = .red
        label.font = UIFont.boldSystemFont(ofSize: 10)
        return label
    }()
    
    let upVoteBackground : UIView = {
       let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    
    let likeButton : UIButton = {
       let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 10
        button.layer.masksToBounds = true
        button.backgroundColor = .white
        return button
    }()
    
    let thumbsUpImage : UIImageView = {
       let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "thumbs-up").withRenderingMode(.alwaysOriginal)
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    func setupView(){
        addSubview(cardBackground)
        addSubview(card)
        addSubview(photo)
        addSubview(solutionLabel)
        addSubview(usernameLabel)
        addSubview(upVotesLabel)
        addSubview(acceptLabel)
        addSubview(declineLabel)
        addSubview(upVoteBackground)
        addSubview(thumbsUpImage)
        
        cardBackground.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 12, paddingBottom: 0, paddingRight: 12, width: 0, height: 145)
        card.anchor(top: cardBackground.topAnchor, left: cardBackground.leftAnchor, bottom: cardBackground.bottomAnchor, right: cardBackground.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 180)
        photo.anchor(top: card.topAnchor, left: card.leftAnchor, bottom: card.bottomAnchor, right: nil, paddingTop: 8, paddingLeft: 8, paddingBottom: 8, paddingRight: 0, width: 100, height: 0)
        solutionLabel.anchor(top: photo.topAnchor, left: photo.rightAnchor, bottom: nil, right: card.rightAnchor, paddingTop: 0, paddingLeft: 8, paddingBottom: 0, paddingRight: 12, width: 0, height: (solutionLabel.intrinsicContentSize.height * 2) + 5)
        usernameLabel.anchor(top: solutionLabel.bottomAnchor, left: solutionLabel.leftAnchor, bottom: nil, right: nil, paddingTop: 8, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: usernameLabel.intrinsicContentSize.width, height: usernameLabel.intrinsicContentSize.height)
        upVotesLabel.anchor(top: usernameLabel.bottomAnchor, left: usernameLabel.leftAnchor, bottom: nil, right: nil, paddingTop: 8, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: upVotesLabel.intrinsicContentSize.width, height: upVotesLabel.intrinsicContentSize.height)
        acceptLabel.anchor(top: upVotesLabel.bottomAnchor, left: upVotesLabel.leftAnchor, bottom: nil, right: nil, paddingTop: 8, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: acceptLabel.intrinsicContentSize.width, height: acceptLabel.intrinsicContentSize.height)
        declineLabel.anchor(top: acceptLabel.topAnchor, left: acceptLabel.rightAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 8, paddingBottom: 0, paddingRight: 0, width: declineLabel.intrinsicContentSize.width, height: declineLabel.intrinsicContentSize.height)
        upVoteBackground.anchor(top: nil, left: nil, bottom: card.bottomAnchor, right: card.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 10, paddingRight: 10, width: 30, height: 30)
        thumbsUpImage.anchor(top: nil, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 14, height: 14)
        thumbsUpImage.centerXAnchor.constraint(equalTo: upVoteBackground.centerXAnchor).isActive = true
        thumbsUpImage.centerYAnchor.constraint(equalTo: upVoteBackground.centerYAnchor).isActive = true
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
