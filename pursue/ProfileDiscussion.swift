//
//  ProfileDiscussion.swift
//  pursue
//
//  Created by Jaylen Sanders on 12/9/17.
//  Copyright © 2017 Glory. All rights reserved.
//

import UIKit

class ProfileDiscussion : HomeDiscussion {
    
    let profileDiscussionId = "profileDiscussionId"
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: profileDiscussionId, for: indexPath) as! ProfileDiscussionCells
        rowLabel.text = "DISCUSSIONS"
        return cell
    }
    
    override func setupView() {
        super.setupView()
        addSubview(rowLabel)
        rowLabel.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 24, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: 140, height: 22)
        discussionCollection.register(ProfileDiscussionCells.self, forCellWithReuseIdentifier: profileDiscussionId)
    }
}
