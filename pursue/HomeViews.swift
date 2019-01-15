//
//  HomeViews.swift
//  Inpursuit
//
//  Created by Jaylen Sanders on 12/28/18.
//  Copyright © 2018 Glory. All rights reserved.
//

import UIKit

class HomeViews : UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    let conflictId = "conflictId"
    let postId = "postId"
    let daysId = "daysId"
    let challengeId = "challengeId"
    let carouselId = "carouselId"
    let standardId = "standardId"
    
    func setupCollectionView(){
        collectionView?.register(HomeConflictCell.self, forCellWithReuseIdentifier: conflictId)
        collectionView?.register(HomePostCells.self, forCellWithReuseIdentifier: postId)
        collectionView?.register(HomeChallengeCell.self, forCellWithReuseIdentifier: challengeId)
        collectionView?.register(HomeCarousel.self, forCellWithReuseIdentifier: carouselId)
        collectionView.register(HomeStandardCell.self, forCellWithReuseIdentifier: standardId)
        collectionView?.backgroundColor = UIColor.rgb(red: 243, green: 243, blue: 249)
        collectionView?.showsVerticalScrollIndicator = false
        collectionView?.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 350, right: 0)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
    }
    
    func changeToDetail(){
        let detail = DetailController()
        present(detail, animated: true, completion: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 150)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        present(DetailController(), animated: true, completion: nil)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.item {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: standardId, for: indexPath) as! HomeStandardCell
            return cell
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: challengeId, for: indexPath) as! HomeChallengeCell
            return cell
        case 2:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: conflictId, for: indexPath) as! HomeConflictCell
            return cell
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: standardId, for: indexPath) as! HomeStandardCell
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch indexPath.item {
        case 0:
            return CGSize(width: view.frame.width, height: 640)
        case 1:
            return CGSize(width: view.frame.width, height: 400)
        case 2:
            return CGSize(width: view.frame.width, height: 280)
        default:
            return CGSize(width: view.frame.width, height: 640)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 25.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 25.0
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
}
