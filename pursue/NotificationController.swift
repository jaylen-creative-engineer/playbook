//
//  NotificationController.swift
//  pursue
//
//  Created by Jaylen Sanders on 1/24/18.
//  Copyright © 2018 Glory. All rights reserved.
//

import UIKit

class NotificationController : UICollectionViewCell {
   
    let followId = "followId"
    let pursuitId = "pursuitId"
    let likeId = "likeId"
    let commentId = "commentId"
    let stepId = "stepId"
    let principleId = "principleId"
 
    let collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.showsVerticalScrollIndicator = false
        collectionView.isScrollEnabled = true
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCollectionView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    
    func setupCollectionView(){
        addSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.anchor(top: safeAreaLayoutGuide.topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 80, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        collectionView.register(FollowedNotification.self, forCellWithReuseIdentifier: followId)
        collectionView.register(PursuitNotification.self, forCellWithReuseIdentifier: pursuitId)
        collectionView.register(LikedNotification.self, forCellWithReuseIdentifier: likeId)
        collectionView.register(CommentNotification.self, forCellWithReuseIdentifier: commentId)
        collectionView.register(StepNotification.self, forCellWithReuseIdentifier: stepId)
        collectionView.register(PrincipleNotification.self, forCellWithReuseIdentifier: principleId)
    }
    
}

extension NotificationController : UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch indexPath.item {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: followId, for: indexPath) as! FollowedNotification
            return cell
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: commentId, for: indexPath) as! CommentNotification
            return cell
        case 2:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: stepId, for: indexPath) as! StepNotification
            return cell
        case 3:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: principleId, for: indexPath) as! PrincipleNotification
            return cell
        case 4:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: likeId, for: indexPath) as! LikedNotification
            return cell
        case 5:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: pursuitId, for: indexPath) as! PursuitNotification
            return cell
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: principleId, for: indexPath) as! PrincipleNotification
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch indexPath.item {
        case 1:
            return CGSize(width: frame.width, height: 110)
        case 2:
            return CGSize(width: frame.width, height: 150)
        case 3:
            return CGSize(width: frame.width, height: 150)
        case 5:
            return CGSize(width: frame.width, height: 290)
        default:
            return CGSize(width: frame.width, height: 90)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
}
