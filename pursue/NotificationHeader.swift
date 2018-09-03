//
//  NotificationHeader.swift
//  pursue
//
//  Created by Jaylen Sanders on 8/22/18.
//  Copyright © 2018 Glory. All rights reserved.
//

import UIKit
import Firebase


class NotificationHeader : UICollectionViewCell {
    
    var accessNotificationController : NotificationsContainer?
    let cellId = "cellId"
    let headerId = "headerId"
    
    let notificationLabel : UILabel = {
        let label = UILabel()
        label.text = "NOTIFICATIONS"
        label.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.init(25))
        return label
    }()
    
    let messageLabel : UILabel = {
       let label = UILabel()
        label.text = "Messages"
        label.font = .boldSystemFont(ofSize: 14)
        return label
    }()
    
    let imageCollectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()

    func setupCollectionView(){
        imageCollectionView.delegate = self
        imageCollectionView.dataSource = self
        imageCollectionView.register(PostNotification.self, forCellWithReuseIdentifier: cellId)
        imageCollectionView.register(NotificationRowHeader.self, forSupplementaryViewOfKind: UICollectionElementKindSectionFooter, withReuseIdentifier: headerId)
        addSubview(imageCollectionView)
        imageCollectionView.anchor(top: notificationLabel.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 12, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 265)
    }
    
    func setupView(){
        addSubview(notificationLabel)
        addSubview(messageLabel)
        
        notificationLabel.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 12, paddingBottom: 5, paddingRight: 0, width: notificationLabel.intrinsicContentSize.width, height: notificationLabel.intrinsicContentSize.height)
        setupCollectionView()
        messageLabel.anchor(top: nil, left: leftAnchor, bottom: bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 12, paddingBottom: 12, paddingRight: 0, width: messageLabel.intrinsicContentSize.width, height: messageLabel.intrinsicContentSize.height)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension NotificationHeader : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! PostNotification
        if indexPath.item != 0 {
            cell.dayLabel.isHidden = true
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(0, 12, 0, 18)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width / 2, height: 260)
    }
}
