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
        
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: addedId, for: indexPath) as! PeopleAddedCells
        return cell
    }
    
    override func setupView() {
        addSubview(rowLabel)
        addSubview(postCollection)
        rowLabel.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 32, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: rowLabel.intrinsicContentSize.width, height: rowLabel.intrinsicContentSize.height)
        postCollection.anchor(top: rowLabel.bottomAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        postCollection.register(PeopleAddedCells.self, forCellWithReuseIdentifier: addedId)
        postCollection.delegate = self
        postCollection.dataSource = self
        postCollection.showsHorizontalScrollIndicator = false
        rowLabel.text = "27 ADDED"
    }
    
    
}
