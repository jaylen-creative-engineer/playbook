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
    
    let nameLabel : UITextView = {
       let tv = UITextView()
        tv.text = "NAME"
        tv.font = UIFont.boldSystemFont(ofSize: 14)
        tv.textColor = .black
        return tv
    }()
    
    let fullnameLabel : UITextField = {
       let tv = UITextField()
        tv.textColor = .black
        tv.font = UIFont.boldSystemFont(ofSize: 16)
        tv.attributedPlaceholder = NSAttributedString(string: "Full Name", attributes: [NSAttributedStringKey.foregroundColor: UIColor.black])
        return tv
    }()
    
    let usernameLabel : UITextField = {
        let tv = UITextField()
        tv.font = UIFont.boldSystemFont(ofSize: 16)
        tv.attributedPlaceholder = NSAttributedString(string: "Username", attributes: [NSAttributedStringKey.foregroundColor: UIColor.black])
        tv.textColor = .black
        return tv
    }()
    
    let bioLabel : BioInputTextView = {
        let tv = BioInputTextView()
        tv.isScrollEnabled = false
        tv.font = UIFont.boldSystemFont(ofSize: 16)
        return tv
    }()
    
    let currentLabel : UITextField = {
        let tv = UITextField()
        tv.font = UIFont.boldSystemFont(ofSize: 16)
        tv.attributedPlaceholder = NSAttributedString(string: "Current Password", attributes: [NSAttributedStringKey.foregroundColor: UIColor.black])
        tv.textColor = .black
        return tv
    }()
    
    let confirmLabel : UITextField = {
        let tv = UITextField()
        tv.font = UIFont.boldSystemFont(ofSize: 16)
        tv.attributedPlaceholder = NSAttributedString(string: "Confirm Password", attributes: [NSAttributedStringKey.foregroundColor: UIColor.black])
        tv.textColor = .black
        return tv
    }()
    
    let updateLabel : UITextField = {
        let tv = UITextField()
        tv.font = UIFont.boldSystemFont(ofSize: 16)
        tv.attributedPlaceholder = NSAttributedString(string: "Update Password", attributes: [NSAttributedStringKey.foregroundColor: UIColor.black])
        tv.textColor = .black
        return tv
    }()
    
    let deleteLabel : UIButton = {
        let button = UIButton()
        button.setTitle("Delete Account", for: .normal)
        button.setTitleColor(.gray, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        return button
    }()
    
    lazy var saveButton : UIButton = {
       let button = UIButton()
        button.setTitle("Save", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var pictureButton : CardView = {
       let view = CardView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 20
        view.translatesAutoresizingMaskIntoConstraints = false
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleCamera))
        tap.numberOfTapsRequired = 1
        view.addGestureRecognizer(tap)
        return view
    }()
    
    lazy var cameraIcon : UIImageView = {
       let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "camera_icon")
        iv.contentMode = .scaleAspectFill
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    @objc func handleCamera(){
        let layout = UICollectionViewFlowLayout()
        let cameraController = SelectCameraController(collectionViewLayout: layout)
        navigationController?.present(cameraController, animated: true, completion: nil)
    }
    
    @objc func handleCancel(){
        navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.backgroundColor = .white
        setupNavBarWithUser()
    }
    
    func setupProfileSection(){
        let guide = view.safeAreaLayoutGuide
        view.addSubview(profilePicture)
        view.addSubview(fullnameLabel)
        view.addSubview(usernameLabel)
        view.addSubview(bioLabel)
        view.addSubview(currentLabel)
        view.addSubview(confirmLabel)
        view.addSubview(updateLabel)
        view.addSubview(deleteLabel)
        view.addSubview(pictureButton)
        view.addSubview(cameraIcon)
        
        profilePicture.anchor(top: backButton.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 24, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 120, height: 120)
        profilePicture.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        pictureButton.anchor(top: nil, left: nil, bottom: profilePicture.bottomAnchor, right: profilePicture.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 40, height: 40)
        cameraIcon.anchor(top: nil, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 20, height: 20)
        cameraIcon.centerYAnchor.constraint(equalTo: pictureButton.centerYAnchor).isActive = true
        cameraIcon.centerXAnchor.constraint(equalTo: pictureButton.centerXAnchor).isActive = true
        
        fullnameLabel.anchor(top: profilePicture.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 48, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: 0, height: fullnameLabel.intrinsicContentSize.height)
        usernameLabel.anchor(top: fullnameLabel.bottomAnchor, left: fullnameLabel.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 42, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0
            , height: usernameLabel.intrinsicContentSize.height)
        bioLabel.anchor(top: usernameLabel.bottomAnchor, left: usernameLabel.leftAnchor, bottom: nil, right: guide.rightAnchor, paddingTop: 42, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0
            , height: bioLabel.intrinsicContentSize.height)
        currentLabel.anchor(top: bioLabel.bottomAnchor, left: bioLabel.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 42, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: currentLabel.intrinsicContentSize.height)
        confirmLabel.anchor(top: currentLabel.bottomAnchor, left: currentLabel.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 42, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: confirmLabel.intrinsicContentSize.height)
        updateLabel.anchor(top: confirmLabel.bottomAnchor, left: confirmLabel.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 42, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: updateLabel.intrinsicContentSize.height)
        deleteLabel.anchor(top: updateLabel.bottomAnchor, left: updateLabel.leftAnchor, bottom: nil, right: nil, paddingTop: 42, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: deleteLabel.intrinsicContentSize.width, height: deleteLabel.intrinsicContentSize.height)
    }
    
    
    
    func setupNavBarWithUser() {
        let backgroundView = UIView()
        backgroundView.backgroundColor = .white
        
        view.addSubview(backgroundView)
        backgroundView.addSubview(backButton)
        backgroundView.addSubview(saveButton)
        
        backgroundView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 90)
        backButton.anchor(top: nil, left: backgroundView.leftAnchor, bottom: backgroundView.bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 12, paddingBottom: 16, paddingRight: 0, width: 20, height: 20)
        saveButton.anchor(top: nil, left: nil, bottom: nil, right: backgroundView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 20, width: saveButton.intrinsicContentSize.width, height: saveButton.intrinsicContentSize.height)
        saveButton.centerYAnchor.constraint(equalTo: backButton.centerYAnchor).isActive = true
        setupProfileSection()
        collectionView?.contentInset = UIEdgeInsetsMake(0, 0, 85, 0)
    }
}
