//
//  ProfilePursuitsRow.swift
//  pursue
//
//  Created by Jaylen Sanders on 10/26/17.
//  Copyright © 2017 Glory. All rights reserved.
//

import UIKit

class ProfilePursuitsRow : ExploreExerciseRow {
    
    let profilePursuitsId = "profilePursuitsId"
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: profilePursuitsId, for: indexPath) as! ProfilePursuitsCells
        rowLabel.text = "PURSUITS"
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: ((frame.width - 2) / 2) + 145, height: ((frame.width - 2) / 2) + 30)
    }
    
    override func setupView() {
        super.setupView()
        postCollection.register(ProfilePursuitsCells.self, forCellWithReuseIdentifier: profilePursuitsId)
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
