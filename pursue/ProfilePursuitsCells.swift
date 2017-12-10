//
//  ProfilePursuitsCells.swift
//  pursue
//
//  Created by Jaylen Sanders on 10/26/17.
//  Copyright © 2017 Glory. All rights reserved.
//

import UIKit

class ProfilePursuitsCells : UICollectionViewCell {
    
    let pursuitButton : UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor.init(white: 0.4, alpha: 0.05)
        return button
    }()
    
    let pursuitLabel : UILabel = {
        let label = UILabel()
        label.text = "Battle"
        label.numberOfLines = 2
        label.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight(rawValue: 25))
        return label
    }()
    
    let pursuitImage : UIImageView = {
        let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "backpack")
        iv.contentMode = .scaleAspectFill
        iv.layer.masksToBounds = true
        return iv
    }()
    
    let profileProgressLabel : UILabel = {
        let label = UILabel()
        label.text = "30%"
        label.textColor = UIColor.rgb(red: 0, green: 128, blue: 0)
        label.font = UIFont.boldSystemFont(ofSize: 12)
        return label
    }()
    
    let progressBar : UIProgressView = {
        let pv = UIProgressView()
        pv.trackTintColor = UIColor.rgb(red: 211, green: 211, blue: 211)
        pv.progress = 0.3
        pv.progressTintColor = UIColor.rgb(red: 0, green: 128, blue: 0)
        pv.translatesAutoresizingMaskIntoConstraints = false
        return pv
    }()
    
    func setupCardDetails(){
        addSubview(pursuitLabel)
        pursuitLabel.anchor(top: pursuitImage.bottomAnchor, left: pursuitImage.leftAnchor, bottom: nil, right: pursuitImage.rightAnchor, paddingTop: 20, paddingLeft: 0, paddingBottom: 0, paddingRight: 8, width: 0, height: 14)
    }
    
    func setupView(){
        addSubview(pursuitButton)
        pursuitButton.addSubview(pursuitImage)
        addSubview(profileProgressLabel)
        addSubview(progressBar)
        
        pursuitButton.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 32, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 190)
        pursuitImage.anchor(top: pursuitButton.topAnchor, left: pursuitButton.leftAnchor, bottom: pursuitButton.bottomAnchor, right: pursuitButton.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        profileProgressLabel.anchor(top: pursuitImage.bottomAnchor, left: nil, bottom: nil, right: pursuitImage.rightAnchor, paddingTop: 4, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: profileProgressLabel.intrinsicContentSize.width, height: profileProgressLabel.intrinsicContentSize.height)
        progressBar.anchor(top: nil, left: pursuitImage.leftAnchor, bottom: nil, right: profileProgressLabel.leftAnchor, paddingTop: 4, paddingLeft: 0, paddingBottom: 0, paddingRight: 8, width: 0, height: 3)
        progressBar.centerYAnchor.constraint(equalTo: profileProgressLabel.centerYAnchor).isActive = true
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupCardDetails()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
