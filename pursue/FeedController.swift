//
//  FeedController.swift
//  pursue
//
//  Created by Jaylen Sanders on 10/30/17.
//  Copyright © 2017 Glory. All rights reserved.
//

import UIKit

class FeedController : UICollectionViewController, UICollectionViewDelegateFlowLayout, FeedDelegate {
    
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
        default:
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: rowId, for: indexPath) as! FeedRow
            return cell
        }
        
    }
    
    func goBack() {
        navigationController?.popViewController(animated: true)
    }
    
    func handleMessage(for cell: FeedHeader) {
        let messageController = MessagesController()
        let navController = UINavigationController(rootViewController: messageController)
        present(navController, animated: true, completion: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch indexPath.item {
        case 0:
            return CGSize(width: view.frame.width, height: 350)
        
        default:
            return CGSize(width: view.frame.width, height: 350)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: (view.frame.width / 8) + 5)
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath) as! FeedHeader
        header.feedDelegate = self
        return header
    }

}
