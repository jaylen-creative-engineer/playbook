//
//  ProfileDiscussionCells.swift
//  pursue
//
//  Created by Jaylen Sanders on 12/9/17.
//  Copyright © 2017 Glory. All rights reserved.
//

import UIKit

protocol ProfileDiscussionCellsDelegate {
    func discussionTapped()
    func discussionHeld()
}
class ProfileDiscussionCells : HomeDiscussionCells {
    
    var delegate : ProfileDiscussionCellsDelegate?
    
    lazy var profileDiscussionImage : UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.layer.masksToBounds = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleHomeTap))
        let longGesture = UILongPressGestureRecognizer(target: self, action: #selector(handleHomeHold))
        tapGesture.numberOfTapsRequired = 1
        iv.addGestureRecognizer(tapGesture)
        iv.addGestureRecognizer(longGesture)
        iv.isUserInteractionEnabled = true
        iv.layer.cornerRadius = 4
        return iv
    }()
    
    let profileDiscussionLabel : UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight(rawValue: 25))
        return label
    }()
    
    @objc func handleHomeTap(){
        delegate?.discussionTapped()
    }
    
    @objc func handleHomeHold(){
        delegate?.discussionHeld()
    }
    
    override func setupView() {
        super.setupView()
        addSubview(discussionBackground)
        addSubview(discussionLabel)
        addSubview(discussionSubLabel)
        addSubview(userCollectionView)
        
        discussionBackground.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 8, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 315, height: 175)
        discussionLabel.anchor(top: discussionBackground.topAnchor, left: discussionBackground.leftAnchor, bottom: nil, right: discussionBackground.rightAnchor, paddingTop: 8, paddingLeft: 8, paddingBottom: 0, paddingRight: 8, width: 0, height: 55)
        discussionSubLabel.anchor(top: discussionLabel.bottomAnchor, left: discussionLabel.leftAnchor, bottom: nil, right: discussionBackground.rightAnchor, paddingTop: 4, paddingLeft: 0, paddingBottom: 0, paddingRight: 8, width: 0, height: 45)
        userCollectionView.anchor(top: discussionSubLabel.bottomAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 4, paddingLeft: 4, paddingBottom: 0, paddingRight: 0, width: 220, height: 60)
    }
}
