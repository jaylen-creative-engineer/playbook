//
//  HomeChallengeCell.swift
//  Inpursuit
//
//  Created by Jaylen Sanders on 12/20/18.
//  Copyright © 2018 Glory. All rights reserved.
//

import UIKit

class HomeChallengeCell : UICollectionViewCell {
    
    let profilePicture : UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "gian-cescon-637914-unsplash")?.withRenderingMode(.alwaysOriginal)
        iv.contentMode = .scaleAspectFill
        iv.layer.cornerRadius = 8
        iv.layer.masksToBounds = true
        return iv
    }()
    
    let usernameLabel : UILabel = {
        let label = UILabel()
        label.text = "Test"
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textAlignment = .left
        return label
    }()
    
    let progressCountLabel : UILabel = {
        let label = UILabel()
        label.text = "38%"
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.textColor = UIColor.rgb(red: 139, green: 144, blue: 163)
        return label
    }()
    
    let progressBar : UIProgressView = {
        let pv = UIProgressView()
        pv.progress = 0.38
        pv.progressTintColor = UIColor.rgb(red: 170, green: 176, blue: 197)
        pv.trackTintColor = UIColor.rgb(red: 230, green: 232, blue: 238)
        pv.layer.cornerRadius = 2
        pv.layer.masksToBounds = true
        return pv
    }()
    
    let challengeImageView : UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "apartment-architecture-ceiling-259962")?.withRenderingMode(.alwaysOriginal)
        iv.contentMode = .scaleAspectFill
        iv.layer.cornerRadius = 10
        iv.layer.masksToBounds = true
        return iv
    }()
    
    let challengeLabel : UILabel = {
        let label = UILabel()
        label.text = "Run for 12mi per day"
        label.numberOfLines = 2
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.textColor = .white
        return label
    }()
    
    let overlayView : UIView = {
       let view = UIView()
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = true
        return view
    }()
    
    func setupView(){
        addSubview(profilePicture)
        addSubview(usernameLabel)
        addSubview(progressCountLabel)
        addSubview(progressBar)
        addSubview(challengeImageView)
        addSubview(overlayView)
        addSubview(challengeLabel)
        
        profilePicture.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 36, height: 36)
        usernameLabel.anchor(top: profilePicture.topAnchor, left: profilePicture.rightAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 8, paddingBottom: 0, paddingRight: 12, width: 0, height: 16)
        progressCountLabel.anchor(top: usernameLabel.bottomAnchor, left: usernameLabel.leftAnchor, bottom: nil, right: nil, paddingTop: 2, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: progressCountLabel.intrinsicContentSize.width, height: 16)
        progressBar.centerYAnchor.constraint(equalTo: progressCountLabel.centerYAnchor).isActive = true
        progressBar.anchor(top: nil, left: progressCountLabel.rightAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 6, paddingBottom: 0, paddingRight: 0, width: 0, height: 2)
        challengeImageView.anchor(top: profilePicture.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 16, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 140)
        overlayView.anchor(top: challengeImageView.topAnchor, left: challengeImageView.leftAnchor, bottom: challengeImageView.bottomAnchor, right: challengeImageView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        challengeLabel.anchor(top: nil, left: challengeImageView.leftAnchor, bottom: challengeImageView.bottomAnchor, right: challengeImageView.rightAnchor, paddingTop: 0, paddingLeft: 6, paddingBottom: 12, paddingRight: 8, width: 0, height: 0)
        challengeLabel.heightAnchor.constraint(lessThanOrEqualToConstant: 42).isActive = true
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        overlayView.applyGradient(colours: [.clear, UIColor.init(white: 0.25, alpha: 0.8)], locations: [0.1, 0.7])
    }
   
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
       
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
