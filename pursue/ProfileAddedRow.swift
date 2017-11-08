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
    
    var accessProfileController : ProfileController?
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: addedId, for: indexPath) as! PeopleAddedCells
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        accessProfileController?.showUserProfile()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(postCollection)
        postCollection.anchor(top: rowLabel.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 100)
        
        postCollection.register(PeopleAddedCells.self, forCellWithReuseIdentifier: addedId)
        postCollection.delegate = self
        postCollection.dataSource = self
        
        rowLabel.text = "27 ADDED"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
