//
//  PursuitNotification.swift
//  pursue
//
//  Created by Jaylen Sanders on 2/28/18.
//  Copyright © 2018 Glory. All rights reserved.
//

import UIKit

class PursuitNotification : UICollectionViewCell {
    
    let peopleBackground : CardView = {
        let view = CardView()
        view.layer.cornerRadius = 25
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let userPhoto : UIImageView = {
        let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "samuel-l").withRenderingMode(.alwaysOriginal)
        iv.contentMode = .scaleAspectFill
        iv.layer.masksToBounds = true
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.layer.cornerRadius = 25
        return iv
    }()
    
    
    let contributionLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Lato-Semibold", size: 12)
        label.text = "Contributed to your pursuit: Try to do it this way"
        return label
    }()
    
    let usernameLabel : UILabel = {
        let label = UILabel()
        label.text = "TomDoe"
        label.font = UIFont(name: "Lato-Bold", size: 14)
        return label
    }()
    
    let timeLabel : UILabel = {
        let label = UILabel()
        label.text = "June 3, 2018"
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()
    
    let savedImageView : UIImageView = {
        let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "cars").withRenderingMode(.alwaysOriginal)
        iv.contentMode = .scaleAspectFill
        iv.layer.cornerRadius = 4
        iv.layer.masksToBounds = true
        return iv
    }()
    
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
        iv.image = #imageLiteral(resourceName: "campus").withRenderingMode(.alwaysOriginal)
        return iv
    }()
    
    let solutionLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Lato-Semibold", size: 12)
        label.text = "Hold your breath for four, release for four and breath in for four"
        label.numberOfLines = 2
        return label
    }()
    
    let responderNameLabel : UILabel = {
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
        label.font = UIFont(name: "Lato-Semibold", size: 10)
        return label
    }()
    
    let declineLabel : UILabel = {
        let label = UILabel()
        label.text = "Decline"
        label.textColor = .red
        label.font = UIFont(name: "Lato-Semibold", size: 10)
        return label
    }()
    
    func setupView(){
        addSubview(userPhoto)
        addSubview(usernameLabel)
        addSubview(contributionLabel)
        addSubview(timeLabel)
        addSubview(savedImageView)
        
        userPhoto.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 8, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: 50, height: 50)
        usernameLabel.anchor(top: userPhoto.topAnchor, left: userPhoto.rightAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: usernameLabel.intrinsicContentSize.width, height: usernameLabel.intrinsicContentSize.height)
        contributionLabel.anchor(top: usernameLabel.bottomAnchor, left: usernameLabel.leftAnchor, bottom: nil, right: safeAreaLayoutGuide.rightAnchor, paddingTop: 8, paddingLeft: 0, paddingBottom: 0, paddingRight: 10, width: contributionLabel.intrinsicContentSize.width, height: contributionLabel.intrinsicContentSize.height)
        timeLabel.anchor(top: contributionLabel.bottomAnchor, left: contributionLabel.leftAnchor, bottom: nil, right: nil, paddingTop: 8, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: timeLabel.intrinsicContentSize.width, height: timeLabel.intrinsicContentSize.height)
    }
    
    func setupSoltuionCard(){
        addSubview(cardBackground)
        addSubview(card)
        addSubview(photo)
        addSubview(solutionLabel)
        addSubview(responderNameLabel)
        addSubview(upVotesLabel)
        addSubview(acceptLabel)
        addSubview(declineLabel)
        
        cardBackground.anchor(top: timeLabel.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 18, paddingLeft: 12, paddingBottom: 0, paddingRight: 12, width: 0, height: 125)
        card.anchor(top: cardBackground.topAnchor, left: cardBackground.leftAnchor, bottom: cardBackground.bottomAnchor, right: cardBackground.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 280)
        photo.anchor(top: card.topAnchor, left: card.leftAnchor, bottom: card.bottomAnchor, right: nil, paddingTop: 8, paddingLeft: 8, paddingBottom: 8, paddingRight: 0, width: 80, height: 0)
        solutionLabel.anchor(top: photo.topAnchor, left: photo.rightAnchor, bottom: nil, right: card.rightAnchor, paddingTop: 0, paddingLeft: 8, paddingBottom: 0, paddingRight: 12, width: 0, height: (solutionLabel.intrinsicContentSize.height * 2) + 5)
        responderNameLabel.anchor(top: solutionLabel.bottomAnchor, left: solutionLabel.leftAnchor, bottom: nil, right: nil, paddingTop: 8, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: responderNameLabel.intrinsicContentSize.width, height: responderNameLabel.intrinsicContentSize.height)
        upVotesLabel.anchor(top: responderNameLabel.bottomAnchor, left: responderNameLabel.leftAnchor, bottom: nil, right: nil, paddingTop: 8, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: upVotesLabel.intrinsicContentSize.width, height: upVotesLabel.intrinsicContentSize.height)
        acceptLabel.anchor(top: upVotesLabel.bottomAnchor, left: upVotesLabel.leftAnchor, bottom: nil, right: nil, paddingTop: 8, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: acceptLabel.intrinsicContentSize.width, height: acceptLabel.intrinsicContentSize.height)
        declineLabel.anchor(top: acceptLabel.topAnchor, left: acceptLabel.rightAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 8, paddingBottom: 0, paddingRight: 0, width: declineLabel.intrinsicContentSize.width, height: declineLabel.intrinsicContentSize.height)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupSoltuionCard()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
