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
        iv.image = #imageLiteral(resourceName: "trees")
        iv.contentMode = .scaleAspectFill
        iv.layer.masksToBounds = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleHomeTap))
        let longGesture = UILongPressGestureRecognizer(target: self, action: #selector(handleHomeHold))
        tapGesture.numberOfTapsRequired = 1
        iv.addGestureRecognizer(tapGesture)
        iv.addGestureRecognizer(longGesture)
        iv.isUserInteractionEnabled = true
        return iv
    }()
    
    let profileDiscussionLabel : UILabel = {
        let label = UILabel()
        label.text = "Battle"
        label.numberOfLines = 2
        label.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight(rawValue: 25))
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
        addSubview(profileDiscussionImage)
        addSubview(profileDiscussionLabel)
 
         profileDiscussionImage.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 190)
        profileDiscussionLabel.anchor(top: profileDiscussionImage.bottomAnchor, left: profileDiscussionImage.leftAnchor, bottom: nil, right: profileDiscussionImage.rightAnchor, paddingTop: 20, paddingLeft: 0, paddingBottom: 0, paddingRight: 8, width: 0, height: 14)
    }
}
