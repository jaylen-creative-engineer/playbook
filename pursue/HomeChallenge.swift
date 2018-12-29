//
//  HomeChallenge.swift
//  Inpursuit
//
//  Created by Jaylen Sanders on 12/20/18.
//  Copyright © 2018 Glory. All rights reserved.
//

import UIKit

class HomeChallenge : UICollectionViewCell {
    
    let backgroundCardView : HomeCellRectangleView = {
        let view = HomeCellRectangleView()
        view.backgroundColor = .white
        return view
    }()
    
    let challengeImageView : UIImageView = {
       let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.layer.cornerRadius = 6
        iv.layer.masksToBounds = true
        iv.image = UIImage(named: "cafe-768771_1280")?.withRenderingMode(.alwaysOriginal)
        return iv
    }()
    
    let challengeTitle : UILabel = {
       let label = UILabel()
        label.text = "This is a challenge to do better."
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.numberOfLines = 2
        return label
    }()
    
    let usernameLabel : UILabel = {
        let label = UILabel()
        label.text = "Test"
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    let activeLabel : UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Join", for: .normal)
        button.setTitleColor(.gray, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.contentHorizontalAlignment = .left
        button.contentVerticalAlignment = .top
        return button
    }()
    
    let leaderLabel : UILabel = {
        let label = UILabel()
        label.text = "In The Lead"
        label.font = UIFont.boldSystemFont(ofSize: 15)
        return label
    }()
    
    let leaderNameLabel : UILabel = {
       let label = UILabel()
        label.text = "Tom Doe"
        label.textColor = .darkGray
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    let challengersLabel : UILabel = {
        let label = UILabel()
        label.text = "Active Challengers"
        label.font = UIFont.boldSystemFont(ofSize: 15)
        return label
    }()
    
    let challengersCount : UILabel = {
        let label = UILabel()
        label.text = "30"
        label.textColor = .darkGray
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    let timeLeftForChallenge : UILabel = {
        let label = UILabel()
        label.text = "Time Left For Challenge"
        label.font = UIFont.boldSystemFont(ofSize: 15)
        return label
    }()
    
    let timeLeftCount : UILabel = {
        let label = UILabel()
        label.text = "3 Weeks Left"
        label.textColor = .darkGray
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    func setupCardBottomRows(){
        addSubview(challengersLabel)
        addSubview(challengersCount)
        addSubview(leaderLabel)
        addSubview(leaderNameLabel)
        addSubview(timeLeftForChallenge)
        addSubview(timeLeftCount)
        
        challengersLabel.anchor(top: challengeImageView.bottomAnchor, left: backgroundCardView.leftAnchor, bottom: nil, right: nil, paddingTop: 24, paddingLeft: 8, paddingBottom: 0, paddingRight: 0, width: challengersLabel.intrinsicContentSize.width, height: challengersLabel.intrinsicContentSize.height)
        challengersCount.centerYAnchor.constraint(equalTo: challengersLabel.centerYAnchor).isActive = true
        challengersCount.anchor(top: nil, left: nil, bottom: nil, right: backgroundCardView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 12, width: challengersCount.intrinsicContentSize.width, height: challengersCount.intrinsicContentSize.height)
        leaderLabel.anchor(top: challengersLabel.bottomAnchor, left: backgroundCardView.leftAnchor, bottom: nil, right: nil, paddingTop: 24, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: leaderLabel.intrinsicContentSize.width, height: 16)
        leaderNameLabel.centerYAnchor.constraint(equalTo: leaderLabel.centerYAnchor).isActive = true
        leaderNameLabel.anchor(top: nil, left: nil, bottom: nil, right: backgroundCardView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 12, width: leaderNameLabel.intrinsicContentSize.width, height: leaderNameLabel.intrinsicContentSize.height)
        timeLeftForChallenge.anchor(top: leaderLabel.bottomAnchor, left: backgroundCardView.leftAnchor, bottom: nil, right: nil, paddingTop: 24, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: timeLeftForChallenge.intrinsicContentSize.width, height: timeLeftForChallenge.intrinsicContentSize.height)
        timeLeftCount.centerYAnchor.constraint(equalTo: timeLeftForChallenge.centerYAnchor).isActive = true
        timeLeftCount.anchor(top: nil, left: nil, bottom: nil, right: backgroundCardView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 12, width: timeLeftCount.intrinsicContentSize.width, height: timeLeftCount.intrinsicContentSize.height)
    }
    
    func setupView(){
        addSubview(backgroundCardView)
        addSubview(challengeImageView)
        addSubview(challengeTitle)
        addSubview(usernameLabel)
        addSubview(activeLabel)
        
        backgroundCardView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        challengeImageView.anchor(top: backgroundCardView.topAnchor, left: backgroundCardView.leftAnchor, bottom: nil, right: nil, paddingTop: 18, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: 100, height: 120)
        challengeTitle.anchor(top: challengeImageView.topAnchor, left: challengeImageView.rightAnchor, bottom: nil, right: backgroundCardView.rightAnchor, paddingTop: 0, paddingLeft: 18, paddingBottom: 0, paddingRight: 12, width: 0, height: 0)
        challengeTitle.heightAnchor.constraint(lessThanOrEqualToConstant: 42).isActive = true
        usernameLabel.anchor(top: challengeTitle.bottomAnchor, left: challengeTitle.leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 14, paddingLeft: 0, paddingBottom: 0, paddingRight: 12, width: 0, height: 16)
        activeLabel.anchor(top: usernameLabel.bottomAnchor, left: usernameLabel.leftAnchor, bottom: nil, right: nil, paddingTop: 14, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 140, height: 34)
        setupCardBottomRows()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
