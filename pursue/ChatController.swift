//
//  ChatController.swift
//  pursue
//
//  Created by Jaylen Sanders on 6/28/18.
//  Copyright © 2018 Glory. All rights reserved.
//

import UIKit

class ChatController : UICollectionViewCell {
    
    let messageId = "messageId"
    let twoId = "twoId"
    let groupId = "groupId"
    let peopleId = "peopleId"
    
    var accessNotificationContainer : NotificationsContainer?
    
    let messagesCollectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.showsVerticalScrollIndicator = false
        return collectionView
    }()
 
    func setupMessageCollectionView(){
        messagesCollectionView.delegate = self
        messagesCollectionView.dataSource = self
        messagesCollectionView.register(ChatCells.self, forCellWithReuseIdentifier: messageId)
        messagesCollectionView.register(TwoChatCells.self, forCellWithReuseIdentifier: twoId)
        messagesCollectionView.register(GroupChatCells.self, forCellWithReuseIdentifier: groupId)
        
        addSubview(messagesCollectionView)
        messagesCollectionView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        messagesCollectionView.contentInset = UIEdgeInsetsMake(20, 0, 0, 0)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupMessageCollectionView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ChatController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.item {
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: twoId, for: indexPath) as! TwoChatCells
            return cell
        case 2:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: groupId, for: indexPath) as! GroupChatCells
            return cell
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: messageId, for: indexPath) as! ChatCells
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width, height: 110)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: frame.width, height: 130)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        accessNotificationContainer?.handleChangeDetail()
    }
}
