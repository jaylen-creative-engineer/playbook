//
//  ExploreChallengeRowCells.swift
//  pursue
//
//  Created by Jaylen Sanders on 10/24/17.
//  Copyright © 2017 Glory. All rights reserved.
//

import UIKit

protocol ExploreExerciseCellsDelegate {
    func pursuitTapped()
    func pursuitHeld()
}
class ExploreExercisesRowCells  : UICollectionViewCell {
    
    var exploreExereciseDelegate : ExploreExerciseCellsDelegate?
    
    let exploreLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight(rawValue: 25))
        return label
    }()
    
    lazy var exploreImage : UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.layer.masksToBounds = true
        iv.translatesAutoresizingMaskIntoConstraints = false
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handlePursuitTap))
        let longGesture = UILongPressGestureRecognizer(target: self, action: #selector(handlePursuitHold))
        tapGesture.numberOfTapsRequired = 1
        iv.addGestureRecognizer(tapGesture)
        iv.addGestureRecognizer(longGesture)
        iv.isUserInteractionEnabled = true
        return iv
    }()
    
    let exploreProgressLabel : UILabel = {
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
        return pv
    }()
    
    @objc func handlePursuitTap(){
        exploreExereciseDelegate?.pursuitTapped()
    }
    
    @objc func handlePursuitHold(){
        exploreExereciseDelegate?.pursuitHeld()
    }
    
    func setupView(){
        addSubview(exploreImage)
        addSubview(exploreLabel)
        addSubview(progressBar)
        addSubview(exploreProgressLabel)
        
        exploreImage.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 24, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 250, height: 145)
        exploreLabel.anchor(top: exploreImage.bottomAnchor, left: exploreImage.leftAnchor, bottom: nil, right: exploreImage.rightAnchor, paddingTop: 16, paddingLeft: 0, paddingBottom: 0, paddingRight: 8, width: 0, height: exploreLabel.intrinsicContentSize.height)
        exploreProgressLabel.anchor(top: exploreImage.bottomAnchor, left: nil, bottom: nil, right: exploreImage.rightAnchor, paddingTop: 4, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: exploreProgressLabel.intrinsicContentSize.width, height: exploreProgressLabel.intrinsicContentSize.height)
        progressBar.anchor(top: nil, left: exploreImage.leftAnchor, bottom: nil, right: exploreProgressLabel.leftAnchor, paddingTop: 4, paddingLeft: 0, paddingBottom: 0, paddingRight: 8, width: 0, height: 3)
        progressBar.centerYAnchor.constraint(equalTo: exploreProgressLabel.centerYAnchor).isActive = true
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

