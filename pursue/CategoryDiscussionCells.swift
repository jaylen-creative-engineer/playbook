//
//  CategoryDiscussionCells.swift
//  pursue
//
//  Created by Jaylen Sanders on 12/11/17.
//  Copyright © 2017 Glory. All rights reserved.
//

import UIKit

protocol CategoryDiscussionCellDelegate {
    func discussionCellTapped()
    func discussionCellHeld()
}

class CategoryDiscussionCells : HomeDiscussionCells {
    
    var discussionDelegate : CategoryDiscussionCellDelegate?
    
    lazy var categoryDiscussionImage : UIImageView = {
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
    
    @objc override func handleDiscussionTap(){
        discussionDelegate?.discussionCellTapped()
    }
    
    @objc override func handleDiscussionHold(){
        discussionDelegate?.discussionCellHeld()
    }
    
    override func setupView() {
        super.setupView()
        addSubview(categoryDiscussionImage)
        categoryDiscussionImage.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 190)
    }
}
