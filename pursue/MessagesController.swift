//
//  MessagesController.swift
//  pursue
//
//  Created by Jaylen Sanders on 9/17/17.
//  Copyright © 2017 Glory. All rights reserved.
//

import UIKit
import Firebase

// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.

fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
    switch (lhs, rhs) {
    case let (l?, r?):
        return l < r
    case (nil, _?):
        return true
    default:
        return false
    }
}

fileprivate func > <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
    switch (lhs, rhs) {
    case let (l?, r?):
        return l > r
    default:
        return rhs < lhs
    }
}

class MessagesController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    let cellId = "cellId"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView?.allowsMultipleSelection = true
        collectionView?.contentInset = UIEdgeInsetsMake(55, 0, 0, 0)
        collectionView?.register(UserCell.self, forCellWithReuseIdentifier: cellId)
        collectionView?.backgroundColor = .white
        fetchUserAndSetupNavBarTitle()
    }
    
    @objc func handleNewMessage() {
        let newMessageController = NewMessageController(collectionViewLayout: UICollectionViewFlowLayout())
        newMessageController.messagesController = self
        navigationController?.pushViewController(newMessageController, animated: true)
    }
    
    
    func showChatControllerForUser(user: User) {
        let chatLogController = ChatLogController(collectionViewLayout: UICollectionViewFlowLayout())
        navigationController?.pushViewController(chatLogController, animated: true)
    }
    
    func fetchUserAndSetupNavBarTitle() {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        Database.database().reference().child("users").child(uid).observeSingleEvent(of: .value, with: { (snapshot) in
            
            if let dictionary = snapshot.value as? [String: AnyObject] {
                let user = User(uid: snapshot.key, dictionary: dictionary)
                self.setupNavBarWithUser()
            }
            
        }, withCancel: nil)
    }
    
    @objc func handleCancel(){
        navigationController?.popViewController(animated: true)
    }
    
    lazy var backButton : UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "back-arrow").withRenderingMode(.alwaysOriginal), for: .normal)
        button.contentMode = .scaleAspectFill
        button.addTarget(self, action: #selector(handleCancel), for: .touchUpInside)
        return button
    }()
    
    lazy var searchButton : UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "search_selected").withRenderingMode(.alwaysOriginal), for: .normal)
        button.contentMode = .scaleAspectFill
        button.addTarget(self, action: #selector(handleNewMessage), for: .touchUpInside)
        return button
    }()
    
    lazy var chatLabel : UIButton = {
        let button = UIButton()
        button.setTitle("CHAT", for: .normal)
        button.addTarget(self, action: #selector(toggleChat), for: .touchUpInside)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var notificationsLabel : UIButton = {
        let button = UIButton()
        button.setTitle("NOTIFICATIONS", for: .normal)
        button.addTarget(self, action: #selector(toggleNotifications), for: .touchUpInside)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        return button
    }()
    
    let backgroundView : UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    @objc func toggleChat(){
        chatLabel.setTitleColor(UIColor.black, for: .normal)
        notificationsLabel.setTitleColor(UIColor.gray, for: .normal)
    }
    
    @objc func toggleNotifications(){
        chatLabel.setTitleColor(UIColor.gray, for: .normal)
        notificationsLabel.setTitleColor(UIColor.black, for: .normal)
    }
    
    var messages = [Message]()
    var messagesDictionary = [String: Message]()
    
    func setupNavBarWithUser() {
        messages.removeAll()
        messagesDictionary.removeAll()
        collectionView?.reloadData()
        observeUserMessages()
        
        view.addSubview(backgroundView)
        backgroundView.addSubview(backButton)
        backgroundView.addSubview(chatLabel)
        backgroundView.addSubview(notificationsLabel)
        backgroundView.addSubview(searchButton)
        
        backgroundView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 90)
        backButton.anchor(top: nil, left: backgroundView.leftAnchor, bottom: backgroundView.bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 12, paddingBottom: 16, paddingRight: 0, width: 20, height: 20)
        searchButton.anchor(top: nil, left: nil, bottom: backgroundView.bottomAnchor, right: backgroundView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 16, paddingRight: 16, width: 20, height: 20)
        chatLabel.anchor(top: nil, left: backButton.rightAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 18, paddingBottom: 16, paddingRight: 0, width: chatLabel.intrinsicContentSize.width + 20, height: chatLabel.intrinsicContentSize.height)
        chatLabel.centerYAnchor.constraint(equalTo: backButton.centerYAnchor).isActive = true
        notificationsLabel.anchor(top: chatLabel.topAnchor, left: chatLabel.rightAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 20, paddingBottom: 0, paddingRight: 0, width: notificationsLabel.intrinsicContentSize.width + 20, height: notificationsLabel.intrinsicContentSize.height)
        toggleChat()
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! UserCell
        let message = messages[indexPath.row]
        cell.message = message
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 100)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let message = messages[indexPath.row]
        
        guard let chatPartnerId = message.chatPartnerId() else { return }
        
        let ref = Database.database().reference().child("users").child(chatPartnerId)
        ref.observeSingleEvent(of: .value, with: { (snapshot) in
            guard let dictionary = snapshot.value as? [String: AnyObject] else {
                return
            }
            
            let user = User(uid: chatPartnerId, dictionary: dictionary)
            self.showChatControllerForUser(user: user)
            
        }, withCancel: nil)
    }
    
    func observeUserMessages() {
        guard let uid = Auth.auth().currentUser?.uid else {
            return
        }
        
        let ref = Database.database().reference().child("user-messages").child(uid)
        ref.observe(.childAdded, with: { (snapshot) in
            
            let userId = snapshot.key
            Database.database().reference().child("user-messages").child(uid).child(userId).observe(.childAdded, with: { (snapshot) in
                
                let messageId = snapshot.key
                self.fetchMessageWithMessageId(messageId)
                
            }, withCancel: nil)
            
        }, withCancel: nil)
        
        ref.observe(.childRemoved, with: { (snapshot) in
            
            self.messagesDictionary.removeValue(forKey: snapshot.key)
            self.attemptReloadOfTable()
            
        }, withCancel: nil)
    }
    
    fileprivate func fetchMessageWithMessageId(_ messageId: String) {
        let messagesReference = Database.database().reference().child("messages").child(messageId)
        
        messagesReference.observeSingleEvent(of: .value, with: { (snapshot) in
            
            if let dictionary = snapshot.value as? [String: AnyObject] {
                let message = Message(dictionary: dictionary)
                
                if let chatPartnerId = message.chatPartnerId() {
                    self.messagesDictionary[chatPartnerId] = message
                }
                
                self.attemptReloadOfTable()
            }
            
        }, withCancel: nil)
    }
    
    fileprivate func attemptReloadOfTable() {
        self.timer?.invalidate()
        
        self.timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(self.handleReloadTable), userInfo: nil, repeats: false)
    }
    
    var timer: Timer?
    
    @objc func handleReloadTable() {
        self.messages = Array(self.messagesDictionary.values)
        self.messages.sort(by: { (message1, message2) -> Bool in
            
            return message1.timestamp?.int32Value > message2.timestamp?.int32Value
        })
        
        DispatchQueue.main.async(execute: {
            self.collectionView?.reloadData()
        })
    }
}
