//
//  ProfileChallengeView.swift
//  Inpursuit
//
//  Created by Jaylen Sanders on 12/28/18.
//  Copyright © 2018 Glory. All rights reserved.
//

import UIKit

class ProfileChallengeView : UICollectionViewController {
    
    let cellId = "cellId"
    
     let imageNames = [UIImage(named : "cafe-768771_1280"), UIImage(named : "gian-cescon-637914-unsplash"), UIImage(named : "IMG_0807"), UIImage(named : "IMG_3935")]
    
    func setupCollectionView(){
        collectionView.register(ProfileChallengeCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.backgroundColor = .clear
        collectionView.isScrollEnabled = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
    }
}

extension ProfileChallengeView : UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 85)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 30.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 30.0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as!ProfileChallengeCell
        cell.photo.image = imageNames[indexPath.item]
        return cell
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }

}
