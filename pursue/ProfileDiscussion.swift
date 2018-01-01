//
//  ProfileDiscussion.swift
//  pursue
//
//  Created by Jaylen Sanders on 12/9/17.
//  Copyright © 2017 Glory. All rights reserved.
//

import UIKit

protocol ProfileDiscussionDelegate {
    func profileDiscussionTapped()
    func profileDiscussionHeld()
}

class ProfileDiscussion : HomeDiscussion, ProfileDiscussionCellsDelegate {
    
    let profileDiscussionId = "profileDiscussionId"
    
    var profileDelegate : ProfileDiscussionDelegate?
    let profileImageNames = ["social-marketing", "google-adds", "content-marketing", "seo"]
    let profileLabelText = ["Instagram Marketing", "Using Google Ads", "Content Marketing", "SEO Little Known Tricks"]
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: profileDiscussionId, for: indexPath) as! ProfileDiscussionCells
        cell.delegate = self
        cell.profileDiscussionLabel.text = profileLabelText[indexPath.item]
        cell.profileDiscussionImage.image = UIImage(named: profileImageNames[indexPath.item])?.withRenderingMode(.alwaysOriginal)
        rowLabel.text = "DISCUSSIONS"
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    override func discussionTapped() {
        profileDelegate?.profileDiscussionTapped()
    }
    
    override func discussionHeld() {
        profileDelegate?.profileDiscussionHeld()
    }
    
    override func setupView() {
        super.setupView()
        addSubview(rowLabel)
        rowLabel.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 24, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: rowLabel.intrinsicContentSize.width, height: rowLabel.intrinsicContentSize.height)
        discussionCollection.register(ProfileDiscussionCells.self, forCellWithReuseIdentifier: profileDiscussionId)
    }
}
