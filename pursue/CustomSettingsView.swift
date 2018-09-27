//
//  CustomSettingsView.swift
//  pursue
//
//  Created by Jaylen Sanders on 2/26/18.
//  Copyright © 2018 Glory. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FBSDKCoreKit
import GoogleSignIn

class CustomSettingsView : UIViewController {
    
    let alertViewGrayColor = UIColor(red: 224.0/255.0, green: 224.0/255.0, blue: 224.0/255.0, alpha: 1)
    let cellId = "cellId"
    var accessLoginController : LoginController?
    
    lazy var alertView : UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    lazy var settingsLabel : UILabel = {
        let label = UILabel()
        label.text = "Settings"
        label.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.init(25))
        label.textAlignment = .left
        return label
    }()
    
    lazy var editProfileLabel : UIButton = {
        let button = UIButton()
        button.setTitle("Edit Profile", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.titleLabel?.textAlignment = .left
        button.addTarget(self, action: #selector(handleEditClick), for: .touchUpInside)
        return button
    }()
    
    lazy var changeInterestsLabel : UIButton = {
        let button = UIButton()
        button.setTitle("Change Interests", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.titleLabel?.textAlignment = .left
        button.addTarget(self, action: #selector(handleChangeToInterests), for: .touchUpInside)
        return button
    }()
    
    lazy var inviteLabel : UIButton = {
        let button = UIButton()
        button.setTitle("Invite Contacts", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.titleLabel?.textAlignment = .left
        button.addTarget(self, action: #selector(handleChangeToInvite), for: .touchUpInside)
        return button
    }()
    
    lazy var termsLabel : UIButton = {
        let button = UIButton()
        button.setTitle("Terms Of Use", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.titleLabel?.textAlignment = .left
        button.addTarget(self, action: #selector(switchToTerms), for: .touchUpInside)
        return button
    }()
    
    
    lazy var logOutLabel : UIButton = {
        let button = UIButton()
        button.setTitle("Log Out", for: .normal)
        button.setTitleColor(.gray, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.titleLabel?.textAlignment = .left
        button.addTarget(self, action: #selector(logOut), for: .touchUpInside)
        return button
    }()
    
    lazy var dismissBackground : UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleCancel), for: .touchUpInside)
        return button
    }()
    
    lazy var cancelBottomButton : UIButton = {
       let button = UIButton()
        button.setTitle("Cancel", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.init(25))
        button.titleLabel?.textAlignment = .center
        button.addTarget(self, action: #selector(handleCancel), for: .touchUpInside)
        return button
    }()
  
    func setupLabels(){
       view.addSubview(editProfileLabel)
        view.addSubview(changeInterestsLabel)
        view.addSubview(inviteLabel)
        view.addSubview(termsLabel)
        view.addSubview(logOutLabel)
        view.addSubview(cancelBottomButton)
        
        editProfileLabel.anchor(top: settingsLabel.bottomAnchor, left: settingsLabel.leftAnchor, bottom: nil, right: nil, paddingTop: 24, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: editProfileLabel.intrinsicContentSize.width, height: 16)
        changeInterestsLabel.anchor(top: editProfileLabel.bottomAnchor, left: editProfileLabel.leftAnchor, bottom: nil, right: nil, paddingTop: 32, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: changeInterestsLabel.intrinsicContentSize.width, height: 16)
        inviteLabel.anchor(top: changeInterestsLabel.bottomAnchor, left: editProfileLabel.leftAnchor, bottom: nil, right: nil, paddingTop: 32, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: inviteLabel.intrinsicContentSize.width, height: 16)
        termsLabel.anchor(top: inviteLabel.bottomAnchor, left: editProfileLabel.leftAnchor, bottom: nil, right: nil, paddingTop: 32, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: termsLabel.intrinsicContentSize.width, height: 16)
        logOutLabel.anchor(top: termsLabel.bottomAnchor, left: editProfileLabel.leftAnchor, bottom: nil, right: nil, paddingTop: 32, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: logOutLabel.intrinsicContentSize.width, height: 16)
        cancelBottomButton.anchor(top: nil, left: nil, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: cancelBottomButton.intrinsicContentSize.width, height: cancelBottomButton.intrinsicContentSize.height)
        cancelBottomButton.centerXAnchor.constraint(equalTo: alertView.centerXAnchor).isActive = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(alertView)
        alertView.addSubview(settingsLabel)
        view.addSubview(dismissBackground)
        
        alertView.anchor(top: nil, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 380)
        alertView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 10).isActive = true
        settingsLabel.anchor(top: alertView.topAnchor, left: alertView.leftAnchor, bottom: nil, right: nil, paddingTop: 18, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: settingsLabel.intrinsicContentSize.width, height: settingsLabel.intrinsicContentSize.height)
        dismissBackground.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: alertView.topAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        setupLabels()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupView()
        animateView()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        tabBarController?.tabBar.isHidden = false
    }

    @objc func handleCancel(){
        dismiss(animated: true, completion: nil)
    }
    
    func setupView() {
        alertView.layer.cornerRadius = 15
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.4)
    }
    
    func animateView() {
        alertView.alpha = 0;
        self.alertView.frame.origin.y = self.alertView.frame.origin.y + 50
        UIView.animate(withDuration: 0.4, animations: { () -> Void in
            self.alertView.alpha = 1.0;
            self.alertView.frame.origin.y = self.alertView.frame.origin.y - 50
        })
    }
    
    @objc func handleChangeToInvite(){
        let inviteController = InviteController(collectionViewLayout: UICollectionViewFlowLayout())
        present(inviteController, animated: true, completion: nil)
    }
    
    @objc func switchToPolicy(){
        let policyController = PolicyController(collectionViewLayout: UICollectionViewFlowLayout())
        present(policyController, animated: true, completion: nil)
    }
    
    @objc func switchToTerms(){
        let termsController = TermsController(collectionViewLayout: UICollectionViewFlowLayout())
        present(termsController, animated: true, completion: nil)
    }
    
    @objc func handleChangeToInterests(){
        let interestsController = InterestsController(collectionViewLayout: UICollectionViewFlowLayout())
        present(interestsController, animated: true, completion: nil)
    }
    
    @objc func handleEditClick(){
        let editController = EditProfileController()
        present(editController, animated: true, completion: nil)
    }
    
    @objc func logOut(){
        let alert = UIAlertController(title: "Log Out", message: "Are you sure you want to log out?", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "No", style: UIAlertActionStyle.cancel, handler: dismissAlertView))
        alert.addAction(UIAlertAction(title: "Yes", style: UIAlertActionStyle.default, handler: signOut))
        self.present(alert, animated: true, completion: nil)
    }
    
    func signOut(action: UIAlertAction){
        do {
            try Auth.auth().signOut()
            accessLoginController?.facebookSignOut()
            GIDSignIn.sharedInstance().signOut()
            
            let appDelegate = UIApplication.shared.delegate! as! AppDelegate
            appDelegate.window = UIWindow()
            appDelegate.window?.rootViewController = LoginController()
            appDelegate.window?.makeKeyAndVisible()
            self.dismiss(animated: true, completion: nil)

        } catch let signOutErr {
            
            print("Failed to sign out", signOutErr)
        }
    }
    
    func dismissAlertView(action : UIAlertAction) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
