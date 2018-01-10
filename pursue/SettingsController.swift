//
//  SettingsController.swift
//  pursue
//
//  Created by Jaylen Sanders on 11/15/17.
//  Copyright © 2017 Glory. All rights reserved.
//

import UIKit
import FirebaseAuth
import XLActionController

class SettingsController : UICollectionViewController, UICollectionViewDelegateFlowLayout, SettingsHeaderDelegate {
    
    let headerId = "headerId"
    
    let accountLabel : UILabel = {
       let label = UILabel()
        label.text = "ACCOUNT"
        label.font = UIFont.boldSystemFont(ofSize: 12)
        return label
    }()
    
    lazy var editProfileButton : UILabel = {
        let label = UILabel()
        label.text = "Edit Profile"
        label.font = UIFont.boldSystemFont(ofSize: 18)
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleEditClick))
        label.addGestureRecognizer(tap)
        label.isUserInteractionEnabled = true
        return label
    }()
    
    lazy var editNotificationsButton : UILabel = {
        let label = UILabel()
        label.text = "Notifications"
        label.font = UIFont.boldSystemFont(ofSize: 18)
        let tap = UITapGestureRecognizer(target: self, action: #selector(switchToEditNotifications))
        label.addGestureRecognizer(tap)
        label.isUserInteractionEnabled = true
        return label
    }()
    
    lazy var changeInterestsButton : UILabel = {
        let label = UILabel()
        label.text = "Change Interests"
        label.font = UIFont.boldSystemFont(ofSize: 18)
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleChangeToInterests))
        label.addGestureRecognizer(tap)
        label.isUserInteractionEnabled = true
        return label
    }()
    
    lazy var helpButton : UILabel = {
        let label = UILabel()
        label.text = "Help"
        label.font = UIFont.boldSystemFont(ofSize: 18)
        let tap = UITapGestureRecognizer(target: self, action: #selector(switchToHelp))
        label.addGestureRecognizer(tap)
        label.isUserInteractionEnabled = true
        return label
    }()
    
    lazy var termsButton : UILabel = {
        let label = UILabel()
        label.text = "Terms and Services"
        label.font = UIFont.boldSystemFont(ofSize: 18)
        let tap = UITapGestureRecognizer(target: self, action: #selector(switchToTerms))
        label.addGestureRecognizer(tap)
        label.isUserInteractionEnabled = true
        return label
    }()
    
    lazy var privacyButton : UILabel = {
        let label = UILabel()
        label.text = "Privacy Policy"
        label.font = UIFont.boldSystemFont(ofSize: 18)
        let tap = UITapGestureRecognizer(target: self, action: #selector(switchToPolicy))
        label.addGestureRecognizer(tap)
        label.isUserInteractionEnabled = true
        return label
    }()
    
    lazy var deleteButton : UILabel = {
        let label = UILabel()
        label.text = "DELETE ACCOUNT"
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = .gray
        let tap = UITapGestureRecognizer(target: self, action: #selector(deleteAccount))
        label.addGestureRecognizer(tap)
        label.isUserInteractionEnabled = true
        return label
    }()
    
    lazy var logOutButton : UILabel = {
        let label = UILabel()
        label.text = "Log Out"
        label.textColor = .gray
        label.font = UIFont.boldSystemFont(ofSize: 18)
        let tap = UITapGestureRecognizer(target: self, action: #selector(logOut))
        label.addGestureRecognizer(tap)
        label.isUserInteractionEnabled = true
        return label
    }()
    
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
        return button
    }()
    
    lazy var settingsLabel : UIButton = {
        let button = UIButton()
        button.setTitle("Settings", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var editBackground : UIButton = {
       let button = UIButton()
        button.backgroundColor = .clear
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleEditClick), for: .touchUpInside)
        return button
    }()
    
    lazy var interestsBackground : UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleChangeToInterests), for: .touchUpInside)
        return button
    }()
    
    lazy var notificationsBackground : UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(switchToEditNotifications), for: .touchUpInside)
        return button
    }()
    
    lazy var termsBackground : UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(switchToTerms), for: .touchUpInside)
        return button
    }()
    
    lazy var policyBackground : UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(switchToPolicy), for: .touchUpInside)
        return button
    }()
    
    lazy var helpBackground : UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(switchToHelp), for: .touchUpInside)
        return button
    }()
    
    lazy var logOutBackground : UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(logOut), for: .touchUpInside)
        return button
    }()
    
    @objc func switchToHelp(){
        let helpController = HelpController(collectionViewLayout: UICollectionViewFlowLayout())
        navigationController?.pushViewController(helpController, animated: true)
    }
    
    @objc func switchToPolicy(){
        let policyController = PolicyController(collectionViewLayout: UICollectionViewFlowLayout())
        navigationController?.pushViewController(policyController, animated: true)
    }
    
    @objc func switchToTerms(){
        let termsController = TermsController(collectionViewLayout: UICollectionViewFlowLayout())
        navigationController?.pushViewController(termsController, animated: true)
    }
    
    @objc func handleChangeToInterests(){
        let interestsController = InterestsController(collectionViewLayout: UICollectionViewFlowLayout())
        navigationController?.pushViewController(interestsController, animated: true)
    }
    
    @objc func handleEditClick(){
        let editController = EditProfileController(collectionViewLayout: UICollectionViewFlowLayout())
        navigationController?.pushViewController(editController, animated: true)
    }
    
    @objc func switchToEditNotifications(){
        let notificationController = NotificationsController(collectionViewLayout: UICollectionViewFlowLayout())
        navigationController?.pushViewController(notificationController, animated: true)
    }
    
    @objc func handleCancel(){
        navigationController?.popViewController(animated: true)
    }
    
    @objc func deleteAccount(){
        let actionController = SkypeActionController()
        actionController.addAction(Action("DELETE ACCOUNT", style: .default, handler: { action in
        }))
        
        actionController.addAction(Action("CANCEL", style: .cancel, handler: {action in
            
        }))
        present(actionController, animated: true, completion: nil)
    }
    
    @objc func logOut(){
        let actionController = SkypeActionController()
        actionController.addAction(Action("LOG OUT", style: .default, handler: { action in
            do {
                try Auth.auth().signOut()
                
                let loginController = LoginController()
                let navController = UINavigationController(rootViewController: loginController)
                self.present(navController, animated: true, completion: nil)
                
            } catch let signOutErr {
                
                print("Failed to sign out", signOutErr)
            }
        }))

        actionController.addAction(Action("CANCEL", style: .cancel, handler: {action in
            
        }))
        present(actionController, animated: true, completion: nil)

    }
    
    func setupAccountSection(){
        view.addSubview(editProfileButton)
        view.addSubview(changeInterestsButton)
        view.addSubview(editNotificationsButton)
 
        editProfileButton.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: nil, paddingTop: ((view.frame.width / 8) + 85), paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: editProfileButton.intrinsicContentSize.width, height: editProfileButton.intrinsicContentSize.height)
        changeInterestsButton.anchor(top: editProfileButton.bottomAnchor, left: editProfileButton.leftAnchor, bottom: nil, right: nil, paddingTop: 48, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: changeInterestsButton.intrinsicContentSize.width, height: changeInterestsButton.intrinsicContentSize.height)
        editNotificationsButton.anchor(top: changeInterestsButton.bottomAnchor, left: changeInterestsButton.leftAnchor, bottom: nil, right: nil, paddingTop: 48, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: editNotificationsButton.intrinsicContentSize.width, height: editNotificationsButton.intrinsicContentSize.height)
    }
    
    func addRowsBehindLabel(){
        view.addSubview(editBackground)
        view.addSubview(interestsBackground)
        view.addSubview(notificationsBackground)
        view.addSubview(termsBackground)
        view.addSubview(policyBackground)
        view.addSubview(helpBackground)
        view.addSubview(logOutBackground)
        
        editBackground.anchor(top: editProfileButton.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 40)
        interestsBackground.anchor(top: changeInterestsButton.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 40)
        notificationsBackground.anchor(top: editNotificationsButton.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 40)
        termsBackground.anchor(top: termsButton.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 40)
        policyBackground.anchor(top: privacyButton.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 40)
        helpBackground.anchor(top: helpButton.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 40)
        logOutBackground.anchor(top: logOutButton.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 40)
    }
    
    func setupNavBarWithUser() {
        let guide = view.safeAreaLayoutGuide
        
        let backgroundView = UIView()
        backgroundView.backgroundColor = .white
        
        view.addSubview(backgroundView)
        backgroundView.addSubview(backButton)
        backgroundView.addSubview(settingsLabel)
        
        backgroundView.anchor(top: guide.topAnchor, left: guide.leftAnchor, bottom: nil, right: guide.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 45)
        backButton.anchor(top: backgroundView.topAnchor, left: backgroundView.leftAnchor, bottom: nil, right: nil, paddingTop: 16, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: 20, height: 20)
        settingsLabel.anchor(top: nil, left: backButton.rightAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 20, paddingBottom: 0, paddingRight: 0, width: settingsLabel.intrinsicContentSize.width, height: settingsLabel.intrinsicContentSize.height)
        settingsLabel.centerYAnchor.constraint(equalTo: backButton.centerYAnchor).isActive = true
    }
    
    func setupSettingsSection(){
        view.addSubview(termsButton)
        view.addSubview(privacyButton)
        view.addSubview(helpButton)
        view.addSubview(logOutButton)
        
        termsButton.anchor(top: editNotificationsButton.bottomAnchor, left: editNotificationsButton.leftAnchor, bottom: nil, right: nil, paddingTop: 48, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: termsButton.intrinsicContentSize.width, height: termsButton.intrinsicContentSize.height)
        privacyButton.anchor(top: termsButton.bottomAnchor, left: termsButton.leftAnchor, bottom: nil, right: nil, paddingTop: 48, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: privacyButton.intrinsicContentSize.width, height: privacyButton.intrinsicContentSize.height)
        helpButton.anchor(top: privacyButton.bottomAnchor, left: privacyButton.leftAnchor, bottom: nil, right: nil, paddingTop: 48, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: helpButton.intrinsicContentSize.width, height: helpButton.intrinsicContentSize.height)
        logOutButton.anchor(top: helpButton.bottomAnchor, left: helpButton.leftAnchor, bottom: nil, right: nil, paddingTop: 48, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: logOutButton.intrinsicContentSize.width, height: logOutButton.intrinsicContentSize.height)

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.backgroundColor = .white
        collectionView?.contentInset = UIEdgeInsetsMake(85, 0, 105, 0)
        setupAccountSection()
        setupSettingsSection()
        setupNavBarWithUser()
        addRowsBehindLabel()
    }

    func goBack() {
        navigationController?.popViewController(animated: true)
    }
    
}
