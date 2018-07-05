//
//  ChatController.swift
//  pursue
//
//  Created by Jaylen Sanders on 6/28/18.
//  Copyright © 2018 Glory. All rights reserved.
//

import UIKit

class ChatController : UICollectionViewCell {
    
    let cellId = "cellId"
    let messageId = "messageId"
    let twoId = "twoId"
    let groupId = "groupId"
    
    let addCollectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    let messagesCollectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.showsVerticalScrollIndicator = false
        collectionView.isScrollEnabled = false
        return collectionView
    }()
    
    let messagesLabel : UILabel = {
        let label = UILabel()
        label.text = "Messages."
        label.font = UIFont(name: "Lato-Bold", size: 14)
        return label
    }()
    
    let peopleFullname = ["Tom Ford", "Versace", "LVME", "Test", "Lit"]
    let peopleUsernames = ["TomFord123", "Versace", "LVME", "Test", "Lit"]
    let peopleImages = ["comment-1", "comment-4", "comment-7", "clean-2", "clean-3"]
    
    func setupAddCollectionView(){
        addCollectionView.delegate = self
        addCollectionView.dataSource = self
        addCollectionView.register(ChatPeopleCells.self, forCellWithReuseIdentifier: cellId)
        
        addSubview(addCollectionView)
        addCollectionView.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 12, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 200)
        addCollectionView.reloadData()
    }
    
    func setupMessageCollectionView(){
        messagesCollectionView.delegate = self
        messagesCollectionView.dataSource = self
        messagesCollectionView.register(ChatCells.self, forCellWithReuseIdentifier: messageId)
        messagesCollectionView.register(TwoChatCells.self, forCellWithReuseIdentifier: twoId)
        messagesCollectionView.register(GroupChatCells.self, forCellWithReuseIdentifier: groupId)
        addSubview(messagesLabel)
        addSubview(messagesCollectionView)
        messagesLabel.anchor(top: addCollectionView.bottomAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 12, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: messagesLabel.intrinsicContentSize.width, height: messagesLabel.intrinsicContentSize.height)
        messagesCollectionView.anchor(top: messagesLabel.bottomAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 18, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        messagesCollectionView.reloadData()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupAddCollectionView()
        setupMessageCollectionView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ChatController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case addCollectionView:
            return 4
        case messagesCollectionView:
            return 10
        default:
            assert(false, "Not a valid collection")
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case addCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ChatPeopleCells
            cell.profileImage.image = UIImage(named: peopleImages[indexPath.item])
            cell.usernameLabel.text = "Word"
            cell.fullnameLabel.text = peopleFullname[indexPath.item]
            return cell
        case messagesCollectionView:
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
        default:
            assert(false, "Not a valid collection")
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch collectionView {
        case addCollectionView:
            return CGSize(width: 80, height: 200)
        case messagesCollectionView:
            return CGSize(width: frame.width, height: 110)
        default:
            assert(false, "Not a valid collection")
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        switch collectionView {
        case addCollectionView:
            return UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 12)
        default:
            return UIEdgeInsetsMake(0, 0, 0, 0)
        }
    }
}
