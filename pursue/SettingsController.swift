//
//  SettingsController.swift
//  pursue
//
//  Created by Jaylen Sanders on 11/15/17.
//  Copyright © 2017 Glory. All rights reserved.
//

import UIKit
import FirebaseAuth

class SettingsController : UICollectionViewController, UICollectionViewDelegateFlowLayout, SettingsHeaderDelegate {
    
    let headerId = "headerId"
    
    let accountLabel : UILabel = {
       let label = UILabel()
        label.text = "ACCOUNT"
        label.font = UIFont.boldSystemFont(ofSize: 12)
        return label
    }()
    
    let settingsLabel : UILabel = {
        let label = UILabel()
        label.text = "SETTINGS"
        label.font = UIFont.boldSystemFont(ofSize: 12)
        return label
    }()
    
    lazy var editProfileButton : UILabel = {
        let label = UILabel()
        label.text = "Edit Profile"
        label.font = UIFont.systemFont(ofSize: 18)
        let tap = UITapGestureRecognizer(target: self, action: #selector(switchToEditProfile))
        label.addGestureRecognizer(tap)
        label.isUserInteractionEnabled = true
        return label
    }()
    
    lazy var editNotificationsButton : UILabel = {
        let label = UILabel()
        label.text = "Notifactions"
        label.font = UIFont.systemFont(ofSize: 18)
        let tap = UITapGestureRecognizer(target: self, action: #selector(switchToEditNotifications))
        label.addGestureRecognizer(tap)
        label.isUserInteractionEnabled = true
        return label
    }()
    
    lazy var changeInterestsButton : UILabel = {
        let label = UILabel()
        label.text = "Change Interests"
        label.font = UIFont.systemFont(ofSize: 18)
        let tap = UITapGestureRecognizer(target: self, action: #selector(switchToInterests))
        label.addGestureRecognizer(tap)
        label.isUserInteractionEnabled = true
        return label
    }()
    
    lazy var termsButton : UILabel = {
        let label = UILabel()
        label.text = "Terms and Services"
        label.font = UIFont.systemFont(ofSize: 18)
        let tap = UITapGestureRecognizer(target: self, action: #selector(switchToEditProfile))
        label.addGestureRecognizer(tap)
        label.isUserInteractionEnabled = true
        return label
    }()
    
    lazy var privacyButton : UILabel = {
        let label = UILabel()
        label.text = "Privacy Policy"
        label.font = UIFont.systemFont(ofSize: 18)
        let tap = UITapGestureRecognizer(target: self, action: #selector(switchToEditProfile))
        label.addGestureRecognizer(tap)
        label.isUserInteractionEnabled = true
        return label
    }()
    
    lazy var logOutButton : UILabel = {
        let label = UILabel()
        label.text = "Log Out"
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 18)
        let tap = UITapGestureRecognizer(target: self, action: #selector(logOut))
        label.addGestureRecognizer(tap)
        label.isUserInteractionEnabled = true
        return label
    }()
    
    @objc func switchToInterests(){
        let signupController = InterestsController(collectionViewLayout: UICollectionViewFlowLayout())
        navigationController?.pushViewController(signupController, animated: true)
    }
    
   @objc func switchToEditProfile(){
        
    }
    
    @objc func switchToEditNotifications(){
        
    }
    
    @objc func logOut(){
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
    
    func setupAccountSection(){
        view.addSubview(editProfileButton)
        view.addSubview(changeInterestsButton)
        view.addSubview(editNotificationsButton)
 
        editProfileButton.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: nil, paddingTop: ((view.frame.width / 8) + 45), paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: editProfileButton.intrinsicContentSize.width, height: editProfileButton.intrinsicContentSize.height)
        changeInterestsButton.anchor(top: editProfileButton.bottomAnchor, left: editProfileButton.leftAnchor, bottom: nil, right: nil, paddingTop: 32, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: changeInterestsButton.intrinsicContentSize.width, height: changeInterestsButton.intrinsicContentSize.height)
        editNotificationsButton.anchor(top: changeInterestsButton.bottomAnchor, left: changeInterestsButton.leftAnchor, bottom: nil, right: nil, paddingTop: 32, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: editNotificationsButton.intrinsicContentSize.width, height: editNotificationsButton.intrinsicContentSize.height)
    }
    
    func setupSettingsSection(){
        view.addSubview(termsButton)
        view.addSubview(privacyButton)
        view.addSubview(logOutButton)
        
        termsButton.anchor(top: editNotificationsButton.bottomAnchor, left: editNotificationsButton.leftAnchor, bottom: nil, right: nil, paddingTop: 32, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: termsButton.intrinsicContentSize.width, height: termsButton.intrinsicContentSize.height)
        privacyButton.anchor(top: termsButton.bottomAnchor, left: termsButton.leftAnchor, bottom: nil, right: nil, paddingTop: 32, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: privacyButton.intrinsicContentSize.width, height: privacyButton.intrinsicContentSize.height)
        logOutButton.anchor(top: privacyButton.bottomAnchor, left: privacyButton.leftAnchor, bottom: nil, right: nil, paddingTop: 32, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: logOutButton.intrinsicContentSize.width, height: logOutButton.intrinsicContentSize.height)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.backgroundColor = .white
        collectionView?.register(SettingsHeader.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerId)
        setupAccountSection()
        setupSettingsSection()
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: (view.frame.width / 8) + 5)
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath) as! SettingsHeader
        header.settingsHeaderDelegate = self
        return header
    }
    
    func goBack() {
        navigationController?.popViewController(animated: true)
    }
    
}
