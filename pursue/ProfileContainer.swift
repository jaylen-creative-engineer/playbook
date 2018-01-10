//
//  ProfileContainer.swift
//  pursue
//
//  Created by Jaylen Sanders on 11/27/17.
//  Copyright © 2017 Glory. All rights reserved.
//

import UIKit

class ProfileContainer : UICollectionViewCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, ProfileHeaderDelegate, ProfilePursuitsRowDelegate, ProfilePostDelegate, ProfilePrincipleDelegate, ProfileDiscussionDelegate {
    
    var homeController : HomeController?
    
    let cellId = "cellId"
    let secondaryId = "secondaryId"
    let customRowId = "customRowId"
    let peopleId = "peopleId"
    let principleId = "principleId"
    let exerciseId = "exerciseId"
    let categoryId = "categoryId"
    let pursuitsId = "pursuitsId"
    let postId = "postId"
    let addedId = "addedId"
    let headerId = "headerId"
    let discussionId = "discussionId"
    
    let profileCollection : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        profileCollection.delegate = self
        profileCollection.dataSource = self
        
        profileCollection.register(ProfilePursuitsRow.self, forCellWithReuseIdentifier: pursuitsId)
        profileCollection.register(ProfilePostRow.self, forCellWithReuseIdentifier: postId)
        profileCollection.register(ProfileAddedRow.self, forCellWithReuseIdentifier: addedId)
        profileCollection.register(ProfilePrincipleRow.self, forCellWithReuseIdentifier: principleId)
        profileCollection.register(ProfileDiscussion.self, forCellWithReuseIdentifier: discussionId)
        profileCollection.register(ProfileHeader.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerId)
        
        profileCollection.contentInset = UIEdgeInsetsMake(55, 0, 105, 0)
        
        addSubview(profileCollection)
        profileCollection.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath) as! ProfileHeader
        header.delegate = self
        return header
    }
    
    func profileDiscussionTapped() {
        homeController?.homeDiscussionTapped()
    }
    
    func profileDiscussionHeld() {
        homeController?.homeDiscussionHeld()
    }
    
    func handleSettings() {
        homeController?.showSettings()
    }
    
    func handleMessage() {
        homeController?.showChat()
    }

    func pursuitClicked() {
        homeController?.pursuitClicked()
    }
    
    func pursuitHeld() {
        homeController?.pursuitHeld()
    }
    
    
    func profilePostTapped() {
        homeController?.rowImageTapped()
    }
    
    func profilePostHeld() {
        homeController?.pursuitHeld()
    }
    
    func profilePrincipleTapped() {
        homeController?.principleTapped()
    }
    
    func profilePrincipleHeld() {
        homeController?.principleHeld()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: frame.width, height: 270)
    }
    
    // MARK: - Setup View
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        switch indexPath.item {
        case 0:
            return CGSize(width: frame.width, height: 370)
        case 1:
            return CGSize(width: frame.width, height: 330)
        case 2:
             return CGSize(width: frame.width, height: 320)
        case 3:
            return CGSize(width: frame.width, height: 205)
        case 4:
            return CGSize(width: frame.width, height: 445)
        default:
            return CGSize(width: frame.width, height: 264)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if section == 0 {
            return UIEdgeInsetsMake(0, 0, 0, 0)
        } else {
            return UIEdgeInsetsMake(32, 0, 0, 0)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell : UICollectionViewCell
        switch indexPath.item {
        case 0:
            let pursuitCell = collectionView.dequeueReusableCell(withReuseIdentifier: pursuitsId, for: indexPath) as! ProfilePursuitsRow
            pursuitCell.delegate = self
            return pursuitCell
        case 1:
            let principleCell = collectionView.dequeueReusableCell(withReuseIdentifier: principleId, for: indexPath) as! ProfilePrincipleRow
            principleCell.delegate = self
            return principleCell
        case 2:
            let discussionCell = collectionView.dequeueReusableCell(withReuseIdentifier: discussionId, for: indexPath) as! ProfileDiscussion
            discussionCell.profileDelegate = self
            return discussionCell
        case 3:
            let addedCell = collectionView.dequeueReusableCell(withReuseIdentifier: addedId, for: indexPath) as! ProfileAddedRow
            return addedCell
        case 4:
            let postCell = collectionView.dequeueReusableCell(withReuseIdentifier: postId, for: indexPath) as! ProfilePostRow
            postCell.delegate = self
            return postCell
        default:
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: pursuitsId, for: indexPath) as! ProfilePursuitsRow
            return cell
        }
    }
    
}
