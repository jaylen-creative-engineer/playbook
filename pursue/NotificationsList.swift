//
//  NotificationsContainer.swift
//  pursue
//
//  Created by Jaylen Sanders on 9/10/18.
//  Copyright © 2018 Glory. All rights reserved.
//

import UIKit


class NotificationsList : UICollectionViewCell {
    
    let postId = "postId"
    let followId = "followId"
    let likedId = "likedId"
    let commentId = "commentId"
    let standardId = "standardId"
    let principleId = "principleId"
    let headerId = "headerId"
    
    let collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.showsVerticalScrollIndicator = false
        return collectionView
    }()
    
    func setupView(){
        addSubview(collectionView)
        
        collectionView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(PursuitNotification.self, forCellWithReuseIdentifier: postId)
        collectionView.register(StandardNotification.self, forCellWithReuseIdentifier: standardId)
        collectionView.register(FollowedNotification.self, forCellWithReuseIdentifier: followId)
        collectionView.register(NotificationRowHeader.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerId)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension NotificationsList : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: frame.width, height: 40)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath) as! NotificationRowHeader
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.item {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: postId, for: indexPath) as! PursuitNotification
            return cell
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: followId, for: indexPath) as! FollowedNotification
            return cell
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: standardId, for: indexPath) as! StandardNotification
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10.0
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width, height: 90)
        
    }
}
