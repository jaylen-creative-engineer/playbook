//
//  EditProfileController.swift
//  pursue
//
//  Created by Jaylen Sanders on 11/30/17.
//  Copyright © 2017 Glory. All rights reserved.
//

import UIKit

class EditProfileController : UICollectionViewController {
    
    lazy var backButton : UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "back-arrow").withRenderingMode(.alwaysOriginal), for: .normal)
        button.contentMode = .scaleAspectFill
        button.addTarget(self, action: #selector(handleCancel), for: .touchUpInside)
        return button
    }()
    
    lazy var profilePicture : UIImageView = {
       let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "samuel-l")
        iv.contentMode = .scaleAspectFill
        iv.layer.cornerRadius = 60
        iv.layer.masksToBounds = true
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    let nameLabel : UILabel = {
       let label = UILabel()
        label.text = "NAME"
        label.font = UIFont.boldSystemFont(ofSize: 14)
        return label
    }()
    
    let fullnameLabel : UILabel = {
       let tv = UILabel()
        tv.text = "FULL NAME"
        tv.font = UIFont.boldSystemFont(ofSize: 16)
        return tv
    }()
    
    let usernameLabel : UILabel = {
        let tv = UILabel()
        tv.text = "USERNAME"
        tv.font = UIFont.boldSystemFont(ofSize: 16)
        return tv
    }()
    
    let bioLabel : UILabel = {
        let tv = UILabel()
        tv.text = "CREATE BIO"
        tv.font = UIFont.boldSystemFont(ofSize: 16)
        return tv
    }()
    
    let currentLabel : UILabel = {
        let tv = UILabel()
        tv.text = "CURRENT PASSWORD"
        tv.font = UIFont.boldSystemFont(ofSize: 16)
        return tv
    }()
    
    let confirmLabel : UILabel = {
        let tv = UILabel()
        tv.text = "CONFIRM PASSWORD"
        tv.font = UIFont.boldSystemFont(ofSize: 16)
        return tv
    }()
    
    let updateLabel : UILabel = {
        let tv = UILabel()
        tv.text = "UPDATE PASSWORD"
        tv.font = UIFont.boldSystemFont(ofSize: 16)
        return tv
    }()
    
    let deleteLabel : UILabel = {
        let tv = UILabel()
        tv.text = "DELETE ACCOUNT"
        tv.textColor = .gray
        tv.font = UIFont.boldSystemFont(ofSize: 16)
        return tv
    }()
    
    @objc func handleCancel(){
        navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.backgroundColor = .white
        setupNavBarWithUser()
    }
    
    func setupProfileSection(){
        view.addSubview(profilePicture)
        view.addSubview(fullnameLabel)
        view.addSubview(usernameLabel)
        view.addSubview(bioLabel)
        view.addSubview(currentLabel)
        view.addSubview(confirmLabel)
        view.addSubview(updateLabel)
        view.addSubview(deleteLabel)
        
        profilePicture.anchor(top: backButton.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 24, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 120, height: 120)
        profilePicture.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        fullnameLabel.anchor(top: profilePicture.bottomAnchor, left: view.leftAnchor, bottom: nil, right: nil, paddingTop: 32, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: fullnameLabel.intrinsicContentSize.width, height: fullnameLabel.intrinsicContentSize.height)
        usernameLabel.anchor(top: fullnameLabel.bottomAnchor, left: fullnameLabel.leftAnchor, bottom: nil, right: nil, paddingTop: 42, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: usernameLabel.intrinsicContentSize.width
            , height: usernameLabel.intrinsicContentSize.height)
        bioLabel.anchor(top: usernameLabel.bottomAnchor, left: usernameLabel.leftAnchor, bottom: nil, right: nil, paddingTop: 42, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: bioLabel.intrinsicContentSize.width
            , height: bioLabel.intrinsicContentSize.height)
        currentLabel.anchor(top: bioLabel.bottomAnchor, left: bioLabel.leftAnchor, bottom: nil, right: nil, paddingTop: 42, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: currentLabel.intrinsicContentSize.width, height: currentLabel.intrinsicContentSize.height)
        confirmLabel.anchor(top: currentLabel.bottomAnchor, left: currentLabel.leftAnchor, bottom: nil, right: nil, paddingTop: 42, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: confirmLabel.intrinsicContentSize.width, height: confirmLabel.intrinsicContentSize.height)
        updateLabel.anchor(top: confirmLabel.bottomAnchor, left: confirmLabel.leftAnchor, bottom: nil, right: nil, paddingTop: 42, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: updateLabel.intrinsicContentSize.width, height: updateLabel.intrinsicContentSize.height)
        deleteLabel.anchor(top: updateLabel.bottomAnchor, left: updateLabel.leftAnchor, bottom: nil, right: nil, paddingTop: 42, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: deleteLabel.intrinsicContentSize.width, height: deleteLabel.intrinsicContentSize.height)
    }
    
    
    
    func setupNavBarWithUser() {
        let guide = view.safeAreaLayoutGuide
        
        let backgroundView = UIView()
        backgroundView.backgroundColor = .white
        
        view.addSubview(backgroundView)
        backgroundView.addSubview(backButton)
        
        backgroundView.anchor(top: guide.topAnchor, left: guide.leftAnchor, bottom: nil, right: guide.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 45)
        backButton.anchor(top: backgroundView.topAnchor, left: backgroundView.leftAnchor, bottom: nil, right: nil, paddingTop: 20, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: 20, height: 20)
        setupProfileSection()
    }
}
