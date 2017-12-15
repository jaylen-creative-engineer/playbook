//
//  ExploreDiscussionCells.swift
//  pursue
//
//  Created by Jaylen Sanders on 12/9/17.
//  Copyright © 2017 Glory. All rights reserved.
//

import UIKit

protocol ExploreDiscussionCellDelegate {
    func discussionTapped()
    func discussionHeld()
}

class ExploreDiscussionCells : UICollectionViewCell {
    
    var exploreDelegate : ExploreDiscussionCellDelegate?
    
    let discussionLabel : UILabel = {
        let label = UILabel()
        label.text = "Battle"
        label.numberOfLines = 2
        label.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight(rawValue: 25))
        return label
    }()
    
    lazy var discussionImage : UIImageView = {
        let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "trees")
        iv.contentMode = .scaleAspectFill
        iv.layer.masksToBounds = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleDiscussionTap))
        let longGesture = UILongPressGestureRecognizer(target: self, action: #selector(handleDiscussionHold))
        tapGesture.numberOfTapsRequired = 1
        iv.addGestureRecognizer(tapGesture)
        iv.addGestureRecognizer(longGesture)
        iv.isUserInteractionEnabled = true
        return iv
    }()
    
    @objc func handleDiscussionTap(){
        exploreDelegate?.discussionTapped()
    }
    
    @objc func handleDiscussionHold(){
        exploreDelegate?.discussionHeld()
    }
    
    
    func setupCardDetails(){
        addSubview(discussionLabel)
        discussionLabel.anchor(top: discussionImage.bottomAnchor, left: discussionImage.leftAnchor, bottom: nil, right: discussionImage.rightAnchor, paddingTop: 20, paddingLeft: 0, paddingBottom: 0, paddingRight: 8, width: 0, height: 14)
    }
    
    func setupView(){
        addSubview(discussionImage)
        discussionImage.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 135)
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

