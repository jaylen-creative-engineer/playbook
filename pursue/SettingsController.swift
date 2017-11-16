//
//  SettingsController.swift
//  pursue
//
//  Created by Jaylen Sanders on 11/15/17.
//  Copyright © 2017 Glory. All rights reserved.
//

import UIKit

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
        label.font = UIFont.systemFont(ofSize: 24)
        let tap = UITapGestureRecognizer(target: self, action: #selector(switchToEditProfile))
        label.addGestureRecognizer(tap)
        label.isUserInteractionEnabled = true
        return label
    }()
    
    lazy var editNotificationsButton : UILabel = {
        let label = UILabel()
        label.text = "Edit Notifactions"
        label.font = UIFont.systemFont(ofSize: 24)
        let tap = UITapGestureRecognizer(target: self, action: #selector(switchToEditNotifications))
        label.addGestureRecognizer(tap)
        label.isUserInteractionEnabled = true
        return label
    }()
    
    lazy var changeInterestsButton : UILabel = {
        let label = UILabel()
        label.text = "Change Interests"
        label.font = UIFont.systemFont(ofSize: 24)
        let tap = UITapGestureRecognizer(target: self, action: #selector(switchToEditNotifications))
        label.addGestureRecognizer(tap)
        label.isUserInteractionEnabled = true
        return label
    }()
    
    lazy var termsButton : UILabel = {
        let label = UILabel()
        label.text = "Terms and Services"
        label.font = UIFont.systemFont(ofSize: 24)
        let tap = UITapGestureRecognizer(target: self, action: #selector(switchToEditProfile))
        label.addGestureRecognizer(tap)
        label.isUserInteractionEnabled = true
        return label
    }()
    
    lazy var privacyButton : UILabel = {
        let label = UILabel()
        label.text = "Privacy Policy"
        label.font = UIFont.systemFont(ofSize: 24)
        let tap = UITapGestureRecognizer(target: self, action: #selector(switchToEditProfile))
        label.addGestureRecognizer(tap)
        label.isUserInteractionEnabled = true
        return label
    }()
    
    lazy var logOutButton : UILabel = {
        let label = UILabel()
        label.text = "Log Out"
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 24)
        let tap = UITapGestureRecognizer(target: self, action: #selector(logOut))
        label.addGestureRecognizer(tap)
        label.isUserInteractionEnabled = true
        return label
    }()
    
   @objc func switchToEditProfile(){
        
    }
    
    @objc func switchToEditNotifications(){
        
    }
    
    @objc func logOut(){
        
    }
    
    func setupAccountSection(){
        view.addSubview(accountLabel)
        view.addSubview(editProfileButton)
        view.addSubview(changeInterestsButton)
        view.addSubview(editNotificationsButton)
        
        accountLabel.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: nil, paddingTop: ((view.frame.width / 8) + 45), paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: accountLabel.intrinsicContentSize.width, height: accountLabel.intrinsicContentSize.height)
        editProfileButton.anchor(top: accountLabel.bottomAnchor, left: accountLabel.leftAnchor, bottom: nil, right: nil, paddingTop: 28, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: editProfileButton.intrinsicContentSize.width, height: editProfileButton.intrinsicContentSize.height)
        changeInterestsButton.anchor(top: editProfileButton.bottomAnchor, left: editProfileButton.leftAnchor, bottom: nil, right: nil, paddingTop: 24, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: changeInterestsButton.intrinsicContentSize.width, height: changeInterestsButton.intrinsicContentSize.height)
        editNotificationsButton.anchor(top: changeInterestsButton.bottomAnchor, left: changeInterestsButton.leftAnchor, bottom: nil, right: nil, paddingTop: 24, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: editNotificationsButton.intrinsicContentSize.width, height: editNotificationsButton.intrinsicContentSize.height)
    }
    
    func setupSettingsSection(){
        view.addSubview(settingsLabel)
        view.addSubview(termsButton)
        view.addSubview(privacyButton)
        view.addSubview(logOutButton)
        
        settingsLabel.anchor(top: editNotificationsButton.bottomAnchor, left: editNotificationsButton.leftAnchor, bottom: nil, right: nil, paddingTop: 54, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: settingsLabel.intrinsicContentSize.width, height: settingsLabel.intrinsicContentSize.height)
        termsButton.anchor(top: settingsLabel.bottomAnchor, left: settingsLabel.leftAnchor, bottom: nil, right: nil, paddingTop: 28, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: termsButton.intrinsicContentSize.width, height: termsButton.intrinsicContentSize.height)
        privacyButton.anchor(top: termsButton.bottomAnchor, left: termsButton.leftAnchor, bottom: nil, right: nil, paddingTop: 24, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: privacyButton.intrinsicContentSize.width, height: privacyButton.intrinsicContentSize.height)
        logOutButton.anchor(top: privacyButton.bottomAnchor, left: privacyButton.leftAnchor, bottom: nil, right: nil, paddingTop: 24, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: logOutButton.intrinsicContentSize.width, height: logOutButton.intrinsicContentSize.height)
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
