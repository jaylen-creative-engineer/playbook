//
//  ProfileContainer.swift
//  pursue
//
//  Created by Jaylen Sanders on 11/27/17.
//  Copyright © 2017 Glory. All rights reserved.
//

import UIKit

class ProfileContainer : UICollectionViewCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
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
        
        profileCollection.register(ProfileAboutRow.self, forCellWithReuseIdentifier: cellId)
        profileCollection.register(ProfilePursuitsRow.self, forCellWithReuseIdentifier: pursuitsId)
        profileCollection.register(ProfilePostRow.self, forCellWithReuseIdentifier: postId)
        profileCollection.register(ProfileAddedRow.self, forCellWithReuseIdentifier: addedId)
        profileCollection.register(ProfilePrincipleRow.self, forCellWithReuseIdentifier: principleId)
        
        profileCollection.contentInset = UIEdgeInsetsMake(55, 0, 0, 0)
        
        addSubview(profileCollection)
        profileCollection.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup View
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        switch indexPath.item {
        case 0:
            return CGSize(width: frame.width, height: 264)
        case 1:
            return CGSize(width: frame.width, height: 435)
        case 2:
            return CGSize(width: frame.width, height: 260)
        case 3:
            return CGSize(width: frame.width, height: 350)
        case 4:
            return CGSize(width: frame.width, height: 360)
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
            let aboutCell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ProfileAboutRow
            return aboutCell
        case 1:
            let postCell = collectionView.dequeueReusableCell(withReuseIdentifier: postId, for: indexPath) as! ProfilePostRow
            return postCell
        case 2:
            let addedCell = collectionView.dequeueReusableCell(withReuseIdentifier: addedId, for: indexPath) as! ProfileAddedRow
            return addedCell
        case 3:
            let pursuitCell = collectionView.dequeueReusableCell(withReuseIdentifier: pursuitsId, for: indexPath) as! ProfilePursuitsRow
            return pursuitCell
        case 4:
            let principleCell = collectionView.dequeueReusableCell(withReuseIdentifier: principleId, for: indexPath) as! ProfilePrincipleRow
            return principleCell
        default:
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: pursuitsId, for: indexPath) as! ProfilePursuitsRow
            return cell
        }
    }
    
}
