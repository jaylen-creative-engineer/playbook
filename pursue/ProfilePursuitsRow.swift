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
    let imageNames = ["winter", "fall", "home-remodel", "food"]
    let profileLabelText = ["Winter Fashion", "Fall Fasion", "Home", "Food"]
    var delegate : ProfilePursuitsRowDelegate?
    
    func pursuitClicked() {
        delegate?.pursuitClicked()
    }
    
    override func pursuitHeld() {
        delegate?.pursuitHeld()
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: profilePursuitsId, for: indexPath) as! ProfilePursuitsCells
        cell.delegate = self
        cell.pursuitImage.image = UIImage(named: imageNames[indexPath.item])?.withRenderingMode(.alwaysOriginal)
        cell.pursuitLabel.text = profileLabelText[indexPath.item]
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
