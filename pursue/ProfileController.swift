//
//  ProfileController.swift
//  pursue
//
//  Created by Jaylen Sanders on 9/11/17.
//  Copyright © 2017 Glory. All rights reserved.
//

import UIKit
import Firebase

class ProfileController: UICollectionViewController, UICollectionViewDelegateFlowLayout, ProfileHeaderDelegate, SettingsDelegate {
    
    let cellId = "cellId"
    let headerId = "headerId"
    let pursuitsId = "pursuitsId"
    let postId = "postId"
    var user : User?
    var userId : String?
    let addedId = "addedId"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.isHidden = true
        
        
        collectionView?.backgroundColor = .white
        collectionView?.register(ProfileAboutRow.self, forCellWithReuseIdentifier: cellId)
        collectionView?.register(ProfilePursuitsRow.self, forCellWithReuseIdentifier: pursuitsId)
        collectionView?.register(ProfileHeader.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerId)
        collectionView?.register(ProfilePostRow.self, forCellWithReuseIdentifier: postId)
        collectionView?.register(ProfileAddedRow.self, forCellWithReuseIdentifier: addedId)
        fetchUser()

    }
    
    // MARK: - Get Logged In User
    
    fileprivate func fetchUser() {
        let uid = userId ?? (Auth.auth().currentUser?.uid ?? "")
        
        Database.fetchUserWithUID(uid: uid) { (user) in
            self.user = user
            self.collectionView?.reloadData()
        }
        
    }
    
    func settingLogOut(for cell: ProfileAboutRow) {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        alertController.addAction(UIAlertAction(title: "Log Out", style: .destructive, handler: { (_) in
            
            do {
                try Auth.auth().signOut()
                
                let loginController = LoginController()
                let navController = UINavigationController(rootViewController: loginController)
                self.present(navController, animated: true, completion: nil)
                
            } catch let signOutErr {
                
                print("Failed to sign out", signOutErr)
            }
        }))
        
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
    
    // MARK: - Setup View
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: (view.frame.width / 8) + 5)
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath) as! ProfileHeader
        header.user = self.user
        header.profileDelegate = self
        return header
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell : UICollectionViewCell
        switch indexPath.item {
        case 0:
            let aboutCell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ProfileAboutRow
            aboutCell.delegate = self
            return aboutCell
        case 1:
            let postCell = collectionView.dequeueReusableCell(withReuseIdentifier: postId, for: indexPath) as! ProfilePostRow
            postCell.accessProfileController = self
            return postCell
        case 2:
            let addedCell = collectionView.dequeueReusableCell(withReuseIdentifier: addedId, for: indexPath) as! ProfileAddedRow
            addedCell.accessProfileController = self
            return addedCell
        case 3:
            let pursuitCell = collectionView.dequeueReusableCell(withReuseIdentifier: pursuitsId, for: indexPath) as! ProfilePursuitsRow
            pursuitCell.accessProfileController = self
            return pursuitCell
        default:
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: pursuitsId, for: indexPath) as! ProfilePursuitsRow
            return cell
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        switch indexPath.item {
        case 0:
            return CGSize(width: view.frame.width, height: 264)
        case 1:
            return CGSize(width: view.frame.width, height: 435)
        case 2:
            return CGSize(width: view.frame.width, height: 260)
        case 3:
            return CGSize(width: view.frame.width, height: 350)
        default:
            return CGSize(width: view.frame.width, height: 264)
        }
    }
        
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    
    func showUserProfile(){
        let userProfileController = ProfileController(collectionViewLayout: UICollectionViewFlowLayout())
        navigationController?.pushViewController(userProfileController, animated: true)
    }
    
    func showChallengesDetail(){
        
    }
    
    func showPursuitsDetail(){
        let pursuits = PursuitsDetailController(collectionViewLayout: UICollectionViewFlowLayout())
        navigationController?.pushViewController(pursuits, animated: true)
    }
    
    func showPostDetailForPost(){
        let layout = UICollectionViewFlowLayout()
        let postDetilController = PostDetailController(collectionViewLayout: layout)
        navigationController?.pushViewController(postDetilController, animated: true)
    }
    
    func handleMessage(for cell: ProfileHeader) {
        let messageController = MessagesController()
        let navController = UINavigationController(rootViewController: messageController)
        present(navController, animated: true, completion: nil)
    }
}
