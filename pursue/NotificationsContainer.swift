//
//  NotificationsContainer.swift
//  pursue
//
//  Created by Jaylen Sanders on 9/21/18.
//  Copyright © 2018 Glory. All rights reserved.
//

import UIKit

class NotificationsContainer : UICollectionViewCell {
    
    let notificationCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .clear
        cv.showsHorizontalScrollIndicator = false
        cv.isPagingEnabled = true
        cv.alwaysBounceHorizontal = true
        cv.isScrollEnabled = false
        return cv
    }()
    
    let notificationId = "notificationId"
    let chatId = "chatId"
    
    var accessHomeController : HomeController?
    
    func setupView(){
        addSubview(notificationCollectionView)
        notificationCollectionView.dataSource = self
        notificationCollectionView.delegate = self
        notificationCollectionView.register(NotificationsList.self, forCellWithReuseIdentifier: notificationId)
        notificationCollectionView.register(ChatController.self, forCellWithReuseIdentifier: chatId)
        notificationCollectionView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
    }
    
    func scrollToItem(menuIndex : Int) {
       let indexPath = IndexPath(item: menuIndex, section: 0)
       self.notificationCollectionView.selectItem(at: indexPath, animated: true, scrollPosition: .centeredHorizontally)
    }
    
    func handleChangeDetail(){
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension NotificationsContainer : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width, height: frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.item {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: notificationId, for: indexPath) as!  NotificationsList
            return cell
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: chatId, for: indexPath) as! ChatController
            cell.accessNotificationContainer = self
            return cell
        }
    }
}
