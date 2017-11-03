//
//  FeedController.swift
//  pursue
//
//  Created by Jaylen Sanders on 10/30/17.
//  Copyright © 2017 Glory. All rights reserved.
//

import UIKit

class FeedController : UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    let headerId = "headerId"
    let rowId = "rowId"
    let pictureId = "pictureId"
    let challengeId = "challengeId"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.backgroundColor = .white
        collectionView?.register(FeedHeader.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerId)
        collectionView?.register(FeedRow.self, forCellWithReuseIdentifier: rowId)
        collectionView?.register(FeedPictureRow.self, forCellWithReuseIdentifier: pictureId)
        collectionView?.register(FeedChallengeRow.self, forCellWithReuseIdentifier: challengeId)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell : UICollectionViewCell
        switch indexPath.item {
        case 0:
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: rowId, for: indexPath) as! FeedRow
            return cell
        case 1:
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: pictureId, for: indexPath) as! FeedPictureRow
            return cell
        case 2:
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: challengeId, for: indexPath) as! FeedChallengeRow
            return cell
        default:
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: rowId, for: indexPath) as! FeedRow
            return cell
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch indexPath.item {
        case 0:
            return CGSize(width: view.frame.width, height: view.frame.height / 2)
        case 1:
            return CGSize(width: view.frame.width, height: view.frame.height / 1.25)
        case 2:
            return CGSize(width: view.frame.width, height: (view.frame.height / 3) - 30)
        default:
            return CGSize(width: view.frame.width, height: view.frame.height / 2)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: (view.frame.width / 8) + 5)
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath) as! FeedHeader
        return header
    }

}
