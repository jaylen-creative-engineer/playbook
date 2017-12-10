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
    
    var delegate : PursuitSelected?
    
    lazy var homePursuitButton : UIButton = {
       let button = UIButton()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handlePursuitTap))
        let longGesture = UILongPressGestureRecognizer(target: self, action: #selector(handlePursuitHold))
        tapGesture.numberOfTapsRequired = 1
        button.addGestureRecognizer(tapGesture)
        button.addGestureRecognizer(longGesture)
        return button
    }()
    
    let homeProgressBar : UIProgressView = {
       let pv = UIProgressView()
        pv.trackTintColor = UIColor.rgb(red: 211, green: 211, blue: 211)
        pv.progress = 0.3
        pv.progressTintColor = UIColor.rgb(red: 0, green: 128, blue: 0)
        pv.translatesAutoresizingMaskIntoConstraints = false
        return pv
    }()
    
    let progressLabel : UILabel = {
       let label = UILabel()
        label.text = "30%"
        label.textColor = UIColor.rgb(red: 0, green: 128, blue: 0)
        label.font = UIFont.boldSystemFont(ofSize: 12)
        return label
    }()
    
    @objc func handlePursuitTap(){
        delegate?.pursuitTapped()
    }
    
    @objc func handlePursuitHold(){
        delegate?.pursuitHeld()
    }
    
    override func setupView() {
        addSubview(homePursuitButton)
        homePursuitButton.addSubview(pursuitImage)
        addSubview(homeProgressBar)
        addSubview(progressLabel)
        
        homePursuitButton.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 24, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 190)
        pursuitImage.anchor(top: homePursuitButton.topAnchor, left: homePursuitButton.leftAnchor, bottom: homePursuitButton.bottomAnchor, right: homePursuitButton.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        progressLabel.anchor(top: pursuitImage.bottomAnchor, left: nil, bottom: nil, right: pursuitImage.rightAnchor, paddingTop: 4, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: progressLabel.intrinsicContentSize.width, height: progressLabel.intrinsicContentSize.height)
        homeProgressBar.anchor(top: nil, left: pursuitImage.leftAnchor, bottom: nil, right: progressLabel.leftAnchor, paddingTop: 4, paddingLeft: 0, paddingBottom: 0, paddingRight: 8, width: 0, height: 3)
        homeProgressBar.centerYAnchor.constraint(equalTo: progressLabel.centerYAnchor).isActive = true
    }
}
