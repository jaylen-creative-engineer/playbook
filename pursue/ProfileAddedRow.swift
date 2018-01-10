//
//  ProfileAddedRow.swift
//  pursue
//
//  Created by Jaylen Sanders on 10/30/17.
//  Copyright © 2017 Glory. All rights reserved.
//

import UIKit

class ProfileAddedRow : PeopleRow {
    
    let addedId = "addedId"
    let profileImageNames = ["samuel-l", "scarlett", "fall", "profile-4", "profile-5"]
    let profileUsernameText = ["Samuel", "Scarlett", "boldceo", "Soulection", "GQ"]
        
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: addedId, for: indexPath) as! PeopleAddedCells
        cell.userPhoto.image = UIImage(named: profileImageNames[indexPath.item])?.withRenderingMode(.alwaysOriginal)
        cell.usernameLabel.text = profileUsernameText[indexPath.item]
        return cell
    }
    
    override func setupView() {
        addSubview(rowLabel)
        addSubview(postCollection)
        
        rowLabel.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight(25))
        
        rowLabel.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 32, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: rowLabel.intrinsicContentSize.width, height: rowLabel.intrinsicContentSize.height)
        postCollection.anchor(top: rowLabel.bottomAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        postCollection.register(PeopleAddedCells.self, forCellWithReuseIdentifier: addedId)
        postCollection.delegate = self
        postCollection.dataSource = self
        postCollection.showsHorizontalScrollIndicator = false
        rowLabel.text = "27 Added"
    }
    
    
}
