//
//  ProfilePursuitsRow.swift
//  pursue
//
//  Created by Jaylen Sanders on 10/26/17.
//  Copyright © 2017 Glory. All rights reserved.
//

import UIKit

protocol ProfilePursuitsRowDelegate {
    func pursuitClicked()
    func pursuitHeld()
}

class ProfilePursuitsRow : ExploreExerciseRow, ProfilePursuitsDelegate {
    
    let profilePursuitsId = "profilePursuitsId"
    var delegate : ProfilePursuitsRowDelegate?
    
    func pursuitClicked() {
        delegate?.pursuitClicked()
    }
    
    override func pursuitHeld() {
        delegate?.pursuitHeld()
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: profilePursuitsId, for: indexPath) as! ProfilePursuitsCells
        cell.delegate = self
        rowLabel.text = "PURSUITS"
        return cell
    }

    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: ((frame.width - 2) / 2) + 125, height: 310)
    }
    
    override func setupView() {
        super.setupView()
        postCollection.register(ProfilePursuitsCells.self, forCellWithReuseIdentifier: profilePursuitsId)
        postCollection.showsHorizontalScrollIndicator = false
    }
    
}
