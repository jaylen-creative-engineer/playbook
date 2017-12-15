//
//  NewMessageController.swift
//  pursue
//
//  Created by Jaylen Sanders on 9/17/17.
//  Copyright © 2017 Glory. All rights reserved.
//

import UIKit
import Firebase

class NewMessageController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    let cellId = "cellId"
    
    var users = [User]()
    var messagesController: MessagesController?
    
    
    lazy var backButton : UIButton = {
        let button = UIButton()
        button.setTitle("CANCEL", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.addTarget(self, action: #selector(handleCancel), for: .touchUpInside)
        return button
    }()
    
    func setupNavBarWithUser() {
        let guide = view.safeAreaLayoutGuide
        
        view.addSubview(backButton)
        backButton.anchor(top: guide.topAnchor, left: guide.leftAnchor, bottom: nil, right: nil, paddingTop: 20, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: backButton.intrinsicContentSize.width, height: backButton.intrinsicContentSize.height)
        
    }
    
    func fetchUser() {
        Database.database().reference().child("users").observe(.childAdded, with: { (snapshot) in
            
            if var dictionary = snapshot.value as? [String: AnyObject] {
                
                let user = User(uid: snapshot.key,dictionary: dictionary)
                
                guard let userId = Auth.auth().currentUser?.uid else { return }
                
                if user.uid == userId {
                    
                    dictionary.removeValue(forKey: snapshot.key)
                    
                } else {
                    
                    self.users.append(user)
                }
                
                
                DispatchQueue.main.async(execute: {
                    self.collectionView?.reloadData()
                })
            }
            
        }, withCancel: nil)
    }
    
    @objc func handleCancel() {
        navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.register(UserCell.self, forCellWithReuseIdentifier: cellId)
        collectionView?.contentInset = UIEdgeInsetsMake(55, 0, 0, 0)
        navigationController?.navigationBar.isHidden = true
        fetchUser()
        setupNavBarWithUser()
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return users.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 100)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let user = self.users[indexPath.row]
        let chatLogController = ChatLogController(collectionViewLayout: UICollectionViewFlowLayout())
        chatLogController.user = user
        self.navigationController?.pushViewController(chatLogController, animated: true)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! UserCell
        
        let user = users[indexPath.row]
        cell.textLabel.text = user.username
        cell.detailTextLabel.text = user.fullname
        cell.profileImageView.loadImageUsingCacheWithUrlString(user.profileImageURL)
        
        return cell
    }
}
