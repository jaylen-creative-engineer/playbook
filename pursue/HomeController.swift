//
//  HomeRowContainer.swift
//  pursue
//
//  Created by Jaylen Sanders on 11/27/17.
//  Copyright © 2017 Glory. All rights reserved.
//

import UIKit
import Hero
import Reachability
import KWTransition
import UserNotifications
import NVActivityIndicatorView

class HomeController : UICollectionViewController {
    
    let pursuitId = "pursuitId"
    let challengeId = "challengeId"
    let questionId = "questionId"
    
    func setupCollectionView(){
        collectionView?.backgroundColor = .white
        collectionView.showsVerticalScrollIndicator = false
        collectionView.register(HomePursuit.self, forCellWithReuseIdentifier: pursuitId)
        collectionView.register(HomeChallenge.self, forCellWithReuseIdentifier: challengeId)
        collectionView.register(HomeQuestion.self, forCellWithReuseIdentifier: questionId)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
    }
}

extension HomeController : UICollectionViewDelegateFlowLayout {
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch indexPath.item {
        case 0:
            return CGSize(width: view.frame.width, height: 330)
        case 1:
            return CGSize(width: view.frame.width, height: 230)
        default:
            return CGSize(width: view.frame.width, height: 359)
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 50.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 50.0
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detail = HomeDetailController()
        present(detail, animated: true, completion: nil)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.item {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: pursuitId, for: indexPath) as! HomePursuit
            return cell
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: challengeId, for: indexPath) as! HomeChallenge
            return cell
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: questionId, for: indexPath) as! HomeQuestion
            return cell
        }
    }
}

