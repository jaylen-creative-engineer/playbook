//
//  HomePursuitsCells.swift
//  pursue
//
//  Created by Jaylen Sanders on 12/6/17.
//  Copyright © 2017 Glory. All rights reserved.
//

import UIKit

protocol PursuitSelected {
    func pursuitTapped()
    func pursuitHeld()
}

class HomePursuitsCells : ProfilePursuitsCells {
    
    var homePursuitDelegate : PursuitSelected?
    
    let homeProgressBar : UIProgressView = {
       let pv = UIProgressView()
        pv.trackTintColor = UIColor.rgb(red: 211, green: 211, blue: 211)
        pv.progress = 0.3
        pv.progressTintColor = UIColor.rgb(red: 0, green: 128, blue: 0)
        pv.translatesAutoresizingMaskIntoConstraints = false
        return pv
    }()
    
    lazy var homePursuitLabel : UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight(rawValue: 25))
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleHomeTap))
        let longGesture = UILongPressGestureRecognizer(target: self, action: #selector(handleHomeHold))
        tapGesture.numberOfTapsRequired = 1
        label.addGestureRecognizer(tapGesture)
        label.addGestureRecognizer(longGesture)
        return label
    }()
    
    let progressLabel : UILabel = {
       let label = UILabel()
        label.text = "30%"
        label.textColor = UIColor.rgb(red: 0, green: 128, blue: 0)
        label.font = UIFont.boldSystemFont(ofSize: 12)
        return label
    }()
    
    lazy var homePursuitImage : UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.layer.masksToBounds = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handlePursuitTap))
        let longGesture = UILongPressGestureRecognizer(target: self, action: #selector(handlePursuitHold))
        tapGesture.numberOfTapsRequired = 1
        iv.addGestureRecognizer(tapGesture)
        iv.addGestureRecognizer(longGesture)
        iv.isUserInteractionEnabled = true
        return iv
    }()
    
    @objc func handlePursuitTap(){
        homePursuitDelegate?.pursuitTapped()
    }
    
    @objc func handlePursuitHold(){
        homePursuitDelegate?.pursuitHeld()
    }
    
    override func setupView() {
        
        addSubview(homePursuitImage)
        addSubview(progressLabel)
        addSubview(homeProgressBar)
        addSubview(homePursuitLabel)

        homePursuitImage.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 24, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 190)
        progressLabel.anchor(top: homePursuitImage.bottomAnchor, left: nil, bottom: nil, right: homePursuitImage.rightAnchor, paddingTop: 4, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: progressLabel.intrinsicContentSize.width, height: progressLabel.intrinsicContentSize.height)
        homeProgressBar.anchor(top: nil, left: homePursuitImage.leftAnchor, bottom: nil, right: progressLabel.leftAnchor, paddingTop: 4, paddingLeft: 0, paddingBottom: 0, paddingRight: 8, width: 0, height: 3)
        homeProgressBar.centerYAnchor.constraint(equalTo: progressLabel.centerYAnchor).isActive = true
        homePursuitLabel.anchor(top: homePursuitImage.bottomAnchor, left: homePursuitImage.leftAnchor, bottom: nil, right: homePursuitImage.rightAnchor, paddingTop: 20, paddingLeft: 0, paddingBottom: 0, paddingRight: 8, width: 0, height: homePursuitLabel.intrinsicContentSize.height)
    }
}
