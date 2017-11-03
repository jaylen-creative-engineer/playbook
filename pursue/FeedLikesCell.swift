//
//  FeedLikesCell.swift
//  pursue
//
//  Created by Jaylen Sanders on 10/30/17.
//  Copyright © 2017 Glory. All rights reserved.
//

import UIKit

class FeedLikesCell : PeopleRowCells {
    
    override func setupView() {
        super.setupView()
        usernameLabel.isHidden = true
        userPhoto.layer.cornerRadius = 20
        userPhoto.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 40, height: 40)
    }
}
