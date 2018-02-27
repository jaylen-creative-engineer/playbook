//
//  CustomSettingsView.swift
//  pursue
//
//  Created by Jaylen Sanders on 2/26/18.
//  Copyright © 2018 Glory. All rights reserved.
//

import UIKit

class CustomSettingsView : UIViewController {
    
    let alertViewGrayColor = UIColor(red: 224.0/255.0, green: 224.0/255.0, blue: 224.0/255.0, alpha: 1)
    let cellId = "cellId"
    
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
    
    lazy var editProfileLabel : UILabel = {
       let label = UILabel()
        label.text = "Edit Profile"
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textAlignment = .left
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleEditClick))
        label.addGestureRecognizer(tap)
        label.isUserInteractionEnabled = true
        return label
    }()
    
    lazy var changeInterestsLabel : UILabel = {
        let label = UILabel()
        label.text = "Change Interests"
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textAlignment = .left
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleChangeToInterests))
        label.addGestureRecognizer(tap)
        label.isUserInteractionEnabled = true
        return label
    }()
    
    lazy var termsLabel : UILabel = {
        let label = UILabel()
        label.text = "Terms Of Service"
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textAlignment = .left
        let tap = UITapGestureRecognizer(target: self, action: #selector(switchToTerms))
        label.addGestureRecognizer(tap)
        label.isUserInteractionEnabled = true
        return label
    }()
    
    lazy var privacyLabel : UILabel = {
        let label = UILabel()
        label.text = "Privacy Policy"
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textAlignment = .left
        let tap = UITapGestureRecognizer(target: self, action: #selector(switchToPolicy))
        label.addGestureRecognizer(tap)
        label.isUserInteractionEnabled = true
        return label
    }()
    
    lazy var logOutLabel : UILabel = {
        let label = UILabel()
        label.text = "Log Out"
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textAlignment = .left
        label.textColor = .gray
        let tap = UITapGestureRecognizer(target: self, action: #selector(logOut))
        label.addGestureRecognizer(tap)
        label.isUserInteractionEnabled = true
        return label
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

    lazy var logOutBackground : UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(logOut), for: .touchUpInside)
        return button
    }()
    
    lazy var cancelButton : UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "cancel").withRenderingMode(.alwaysOriginal), for: .normal)
        button.contentMode = .scaleAspectFill
        button.addTarget(self, action: #selector(handleCancel), for: .touchUpInside)
        return button
    }()
    
    lazy var dismissBackground : UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleCancel), for: .touchUpInside)
        return button
    }()
    
    func addRowsBehindLabel(){
        view.addSubview(editBackground)
        view.addSubview(interestsBackground)
        view.addSubview(termsBackground)
        view.addSubview(policyBackground)
        view.addSubview(logOutBackground)
        
        editBackground.anchor(top: editProfileLabel.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 40)
        interestsBackground.anchor(top: changeInterestsLabel.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 40)
        termsBackground.anchor(top: termsLabel.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 40)
        policyBackground.anchor(top: privacyLabel.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 40)
        logOutBackground.anchor(top: logOutLabel.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 40)
    }
    
    func setupLabels(){
       view.addSubview(editProfileLabel)
        view.addSubview(changeInterestsLabel)
        view.addSubview(termsLabel)
        view.addSubview(privacyLabel)
        view.addSubview(logOutLabel)
        
        editProfileLabel.anchor(top: settingsLabel.bottomAnchor, left: settingsLabel.leftAnchor, bottom: nil, right: nil, paddingTop: 18, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: editProfileLabel.intrinsicContentSize.width, height: editProfileLabel.intrinsicContentSize.height)
        changeInterestsLabel.anchor(top: editProfileLabel.bottomAnchor, left: editProfileLabel.leftAnchor, bottom: nil, right: nil, paddingTop: 32, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: changeInterestsLabel.intrinsicContentSize.width, height: changeInterestsLabel.intrinsicContentSize.height)
        termsLabel.anchor(top: changeInterestsLabel.bottomAnchor, left: editProfileLabel.leftAnchor, bottom: nil, right: nil, paddingTop: 32, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: termsLabel.intrinsicContentSize.width, height: termsLabel.intrinsicContentSize.height)
        privacyLabel.anchor(top: termsLabel.bottomAnchor, left: editProfileLabel.leftAnchor, bottom: nil, right: nil, paddingTop: 32, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: privacyLabel.intrinsicContentSize.width, height: privacyLabel.intrinsicContentSize.height)
        logOutLabel.anchor(top: privacyLabel.bottomAnchor, left: editProfileLabel.leftAnchor, bottom: nil, right: nil, paddingTop: 32, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: logOutLabel.intrinsicContentSize.width, height: logOutLabel.intrinsicContentSize.height)
        addRowsBehindLabel()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isHeroEnabled = true
        view.addSubview(alertView)
        alertView.addSubview(settingsLabel)
        alertView.addSubview(cancelButton)
        view.addSubview(dismissBackground)
        
        alertView.anchor(top: nil, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 375)
        settingsLabel.anchor(top: alertView.topAnchor, left: alertView.leftAnchor, bottom: nil, right: nil, paddingTop: 18, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: settingsLabel.intrinsicContentSize.width, height: settingsLabel.intrinsicContentSize.height)
        cancelButton.anchor(top: settingsLabel.topAnchor, left: nil, bottom: nil, right: alertView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 12, width: 15, height: 15)
        dismissBackground.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: alertView.topAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = true
        setupView()
        animateView()
        setupLabels()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        tabBarController?.tabBar.isHidden = false
        dismiss(animated: true, completion: nil)
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
        let editController = EditProfileController(collectionViewLayout: UICollectionViewFlowLayout())
        present(editController, animated: true, completion: nil)
    }
    
    @objc func logOut(){
        dismiss(animated: true, completion: nil)
        let customAlert = CustomLogOutView()
        customAlert.providesPresentationContextTransitionStyle = true
        customAlert.definesPresentationContext = true
        customAlert.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        customAlert.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        self.showDetailViewController(customAlert, sender: self)
    }
    
}
