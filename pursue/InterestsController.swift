//
//  InterestsController.swift
//  pursue
//
//  Created by Jaylen Sanders on 11/3/17.
//  Copyright © 2017 Glory. All rights reserved.
//

import UIKit

class InterestsController : UICollectionViewController, UICollectionViewDelegateFlowLayout, SelectToProfile {
    
    let headerId = "headerId"
    let listId = "listId"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.register(SelectInterestsHeader.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerId)
        collectionView?.register(SelectInterestsList.self, forCellWithReuseIdentifier: listId)
        collectionView?.backgroundColor = .white
    }
    
    func switchToProfile() {
        guard let mainTabBarController = UIApplication.shared.keyWindow?.rootViewController as? MainTabController
            else { return }
        mainTabBarController.setupViewControllers()
        self.dismiss(animated: true, completion: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: (view.frame.width / 8) - 5)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 12
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 70)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: listId, for: indexPath) as! SelectInterestsList
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath) as! SelectInterestsHeader
        header.delegate = self
        return header
    }
}
