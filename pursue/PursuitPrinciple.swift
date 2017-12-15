//
//  PursuitPrinciple.swift
//  pursue
//
//  Created by Jaylen Sanders on 12/12/17.
//  Copyright © 2017 Glory. All rights reserved.
//

import UIKit

class PursuitPrinciple : HomePrinciples {
    
    let pursuitPrincipleId = "pursuitPrincipleId"
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: pursuitPrincipleId, for: indexPath) as! PursuitPrincipleCells
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: ((frame.width - 2) / 2) + 55, height: ((frame.width - 2) / 2) + 50)
    }

    
    override func setupView() {
        super.setupView()
        homeMoreButton.isHidden = true
        moreButton.isHidden = true
        postCollection.register(PursuitPrincipleCells.self, forCellWithReuseIdentifier: pursuitPrincipleId)
        addSubview(postCollection)
        postCollection.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        postCollection.contentInset = UIEdgeInsetsMake(0, 0, 70, 0)
    }
}
