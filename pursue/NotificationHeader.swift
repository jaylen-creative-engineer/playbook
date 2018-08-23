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
    
    lazy var searchIcon : UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "search_selected").withRenderingMode(.alwaysTemplate), for: .normal)
        button.tintColor = UIColor.gray
        button.imageView?.contentMode = .scaleAspectFill
        button.addTarget(self, action: #selector(openSearchModal), for: .touchUpInside)
        return button
    }()
    
    lazy var profilePhoto : UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "steph").withRenderingMode(.alwaysOriginal), for: .normal)
        button.imageView?.contentMode = .scaleAspectFill
        button.addTarget(self, action: #selector(handleProfile), for: .touchUpInside)
        button.layer.cornerRadius = 12
        button.layer.masksToBounds = true
        return button
    }()
    
    let imageCollectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()

    @objc func openSearchModal(){
        accessNotificationController?.openSearchModal()
        Analytics.logEvent("Change to search screen", parameters: nil)
    }
    
    @objc func handleProfile(){
        accessNotificationController?.goToProfile()
    }
    
    func setupCollectionView(){
        imageCollectionView.delegate = self
        imageCollectionView.dataSource = self
        imageCollectionView.register(PostNotification.self, forCellWithReuseIdentifier: cellId)
        imageCollectionView.register(NotificationRowHeader.self, forSupplementaryViewOfKind: UICollectionElementKindSectionFooter, withReuseIdentifier: headerId)
        
        addSubview(imageCollectionView)
        imageCollectionView.anchor(top: notificationLabel.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 12, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 280)
    }
    
    func setupView(){
        addSubview(notificationLabel)
        addSubview(profilePhoto)
        addSubview(searchIcon)
        addSubview(messageLabel)
        
        notificationLabel.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 12, paddingBottom: 5, paddingRight: 0, width: notificationLabel.intrinsicContentSize.width, height: notificationLabel.intrinsicContentSize.height)
        profilePhoto.anchor(top: nil, left: nil, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 12, width: 24, height: 24)
        profilePhoto.centerYAnchor.constraint(equalTo: notificationLabel.centerYAnchor).isActive = true
        searchIcon.anchor(top: nil, left: nil, bottom: nil, right: profilePhoto.leftAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 24, width: 17.18, height: 18)
        searchIcon.centerYAnchor.constraint(equalTo: notificationLabel.centerYAnchor).isActive = true
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
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(0, 12, 0, 18)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width / 2, height: 240)
    }
}
