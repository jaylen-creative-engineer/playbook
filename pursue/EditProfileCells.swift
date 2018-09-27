//
//  EditProfileCells.swift
//  pursue
//
//  Created by Jaylen Sanders on 1/11/18.
//  Copyright © 2018 Glory. All rights reserved.
//

import UIKit
import Firebase
import Alamofire
import FirebaseAuth
import FirebaseStorage

class EditProfileCells : UICollectionViewCell {
    
    var accessEditProfileController : EditProfileController?
    
    var user : User? {
        didSet {
            guard let imageUrl = user?.photoUrl else { return }
            profilePicture.loadImageUsingCacheWithUrlString(imageUrl)
            usernameLabel.text = user?.username
            fullnameLabel.text = user?.fullname
            bioLabel.text = user?.bio
        }
    }
    
    let profilePicture : UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.layer.cornerRadius = 60
        iv.layer.masksToBounds = true
        iv.translatesAutoresizingMaskIntoConstraints = false
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(changeProfilePicture))
        tap.numberOfTapsRequired = 1
        iv.addGestureRecognizer(tap)
        return iv
    }()
    
    let fullnameLabel : UITextField = {
        let tv = UITextField()
        tv.textColor = .black
        tv.font = UIFont.systemFont(ofSize: 14)
        tv.attributedPlaceholder = NSAttributedString(string: "Full Name", attributes: [NSAttributedStringKey.foregroundColor: UIColor.black])
        return tv
    }()
    
    let usernameLabel : UITextField = {
        let tv = UITextField()
        tv.font = UIFont.systemFont(ofSize: 14)
        tv.attributedPlaceholder = NSAttributedString(string: "Username", attributes: [NSAttributedStringKey.foregroundColor: UIColor.black])
        tv.textColor = .black
        return tv
    }()
    
    let bioLabel : BioInputTextView = {
        let tv = BioInputTextView()
        tv.isScrollEnabled = false
        tv.font = UIFont.systemFont(ofSize: 14)
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()
    
    func clearCommentTextField() {
        bioLabel.text = nil
        bioLabel.showPlaceholderLabel()
    }
    
    let currentLabel : UITextField = {
        let tv = UITextField()
        tv.font = UIFont.systemFont(ofSize: 14)
        tv.attributedPlaceholder = NSAttributedString(string: "Current Password", attributes: [NSAttributedStringKey.foregroundColor: UIColor.black])
        tv.textColor = .black
        tv.isSecureTextEntry = true
        tv.isUserInteractionEnabled = true
        tv.addTarget(self, action: #selector(updateAccount), for: .editingChanged)
        return tv
    }()
    
    let confirmLabel : UITextField = {
        let tv = UITextField()
        tv.font = UIFont.systemFont(ofSize: 14)
        tv.attributedPlaceholder = NSAttributedString(string: "Confirm Password", attributes: [NSAttributedStringKey.foregroundColor: UIColor.black])
        tv.textColor = .black
        tv.isSecureTextEntry = true
        tv.addTarget(self, action: #selector(updateAccount), for: .editingChanged)
        return tv
    }()
    
    let updateLabel : UITextField = {
        let tv = UITextField()
        tv.font = UIFont.systemFont(ofSize: 14)
        tv.attributedPlaceholder = NSAttributedString(string: "Update Password", attributes: [NSAttributedStringKey.foregroundColor: UIColor.black])
        tv.textColor = .black
        tv.isSecureTextEntry = true
        tv.addTarget(self, action: #selector(updateAccount), for: .editingChanged)
        return tv
    }()
    
    lazy var deleteLabel : UIButton = {
        let button = UIButton()
        button.setTitle("Delete Account", for: .normal)
        button.setTitleColor(.gray, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.addTarget(self, action: #selector(deleteAccount), for: .touchUpInside)
        return button
    }()
    
    let accountLabel : UILabel = {
        let label = UILabel()
        label.text = "Account Info"
        label.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.init(25))
        return label
    }()
    
    let passwordLabel : UILabel = {
        let label = UILabel()
        label.text = "Update Password"
        label.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.init(25))
        return label
    }()
    
    lazy var pictureButton : CardView = {
        let view = CardView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 20
        view.translatesAutoresizingMaskIntoConstraints = false
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(changeProfilePicture))
        tap.numberOfTapsRequired = 1
        view.addGestureRecognizer(tap)
        return view
    }()
    
    lazy var cameraIcon : UIImageView = {
        let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "camera_icon").withRenderingMode(.alwaysOriginal)
        iv.contentMode = .scaleAspectFill
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    let fullnameUnderlineView = UIView()
    let usernameUnderlineView = UIView()
    let bioUnderlineView = UIView()
    let currentUnderlineView = UIView()
    let confirmUnderlineView = UIView()
    let updateUnderlineView = UIView()
    let profileService = ProfileServices()
    
    @objc func updateAccount(){
        let user = Auth.auth().currentUser
        if let update = updateLabel.text, update.count > 0 {
            user?.updatePassword(to: update, completion: { (error) in
                if let error = error {
                    print(error)
                }
            })
        }
        
        guard let username = usernameLabel.text,
            let fullname = fullnameLabel.text,
            let bio = bioLabel.text,
            let image = self.profilePicture.image,
            let uploadData = UIImageJPEGRepresentation(image, 0.3)
            else { return }
        
        let filename = NSUUID().uuidString
        let ref = Storage.storage().reference().child("profile-images").child(filename)
        ref.putData(uploadData, metadata: nil, completion: { (metadata, err) in
            
            if let err = err {
                print("Failed to upload", err)
            }
            
            var profileImageURL = ""
            ref.downloadURL(completion: { (url, error) in
                if let error = error {
                    print(error)
                } else {
                    let stringUrl = url?.absoluteString
                    profileImageURL = stringUrl!
                }
            })
            
            self.profileService.updateAccount(username: username, fullname: fullname, photoUrl: profileImageURL, bio: bio)
        })
    }
    
    @objc func deleteAccount(){
        let user = Auth.auth().currentUser
        user?.delete(completion: { (error) in
            if let error = error {
                print(error)
            } else {
                self.profileService.deleteAccount()
                self.accessEditProfileController?.goToLogin()
            }
        })
    }
    
    @objc func changeProfilePicture(){
        self.accessEditProfileController?.handleCamera()
    }
    
    func setupProfileSection(){
        fullnameUnderlineView.backgroundColor = .black
        usernameUnderlineView.backgroundColor = .black
        bioUnderlineView.backgroundColor = .black
        currentUnderlineView.backgroundColor = .black
        confirmUnderlineView.backgroundColor = .black
        updateUnderlineView.backgroundColor = .black
        
        addSubview(profilePicture)
        addSubview(deleteLabel)
        addSubview(pictureButton)
        addSubview(cameraIcon)
        
        profilePicture.anchor(top: topAnchor, left: nil, bottom: nil, right: nil, paddingTop: 64, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 120, height: 120)
        profilePicture.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        pictureButton.anchor(top: nil, left: nil, bottom: profilePicture.bottomAnchor, right: profilePicture.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 40, height: 40)
        cameraIcon.anchor(top: nil, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 20, height: 20)
        cameraIcon.centerYAnchor.constraint(equalTo: pictureButton.centerYAnchor).isActive = true
        cameraIcon.centerXAnchor.constraint(equalTo: pictureButton.centerXAnchor).isActive = true
        
        updateAccountDetails()
        changePassword()
        
        deleteLabel.anchor(top: updateUnderlineView.bottomAnchor, left: updateLabel.leftAnchor, bottom: nil, right: nil, paddingTop: 42, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: deleteLabel.intrinsicContentSize.width, height: deleteLabel.intrinsicContentSize.height)
    }
    
    func updateAccountDetails(){
        addSubview(accountLabel)
        addSubview(fullnameLabel)
        addSubview(usernameLabel)
        addSubview(bioLabel)
        addSubview(fullnameUnderlineView)
        addSubview(usernameUnderlineView)
        addSubview(bioUnderlineView)
        
        accountLabel.anchor(top: profilePicture.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 48, paddingLeft: 12, paddingBottom: 0, paddingRight: 12, width: 0, height: accountLabel.intrinsicContentSize.height)
        fullnameLabel.anchor(top: accountLabel.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 42, paddingLeft: 12, paddingBottom: 0, paddingRight: 12, width: 0, height: fullnameLabel.intrinsicContentSize.height)
        fullnameUnderlineView.anchor(top: fullnameLabel.bottomAnchor, left: fullnameLabel.leftAnchor, bottom: nil, right: fullnameLabel.rightAnchor, paddingTop: 24, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0.5)
        usernameLabel.anchor(top: fullnameUnderlineView.bottomAnchor, left: fullnameLabel.leftAnchor, bottom: nil, right: fullnameLabel.rightAnchor, paddingTop: 42, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0
            , height: usernameLabel.intrinsicContentSize.height)
        usernameUnderlineView.anchor(top: usernameLabel.bottomAnchor, left: usernameLabel.leftAnchor, bottom: nil, right: usernameLabel.rightAnchor, paddingTop: 24, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0.5)
        bioLabel.anchor(top: usernameUnderlineView.bottomAnchor, left: usernameLabel.leftAnchor, bottom: nil, right: usernameLabel.rightAnchor, paddingTop: 42, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0
            , height: bioLabel.intrinsicContentSize.height)
        bioUnderlineView.anchor(top: bioLabel.bottomAnchor, left: bioLabel.leftAnchor, bottom: nil, right: bioLabel.rightAnchor, paddingTop: 24, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0.5)
        textViewDidChange(bioLabel)
    }
    
    func changePassword(){
        addSubview(passwordLabel)
        addSubview(currentLabel)
        addSubview(confirmLabel)
        addSubview(updateLabel)
        addSubview(currentUnderlineView)
        addSubview(confirmUnderlineView)
        addSubview(updateUnderlineView)
        
        passwordLabel.anchor(top: bioUnderlineView.bottomAnchor, left: bioLabel.leftAnchor, bottom: nil, right: bioLabel.rightAnchor, paddingTop: 42, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: passwordLabel.intrinsicContentSize.height)
        currentLabel.anchor(top: passwordLabel.bottomAnchor, left: bioLabel.leftAnchor, bottom: nil, right: bioLabel.rightAnchor, paddingTop: 42, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: currentLabel.intrinsicContentSize.height)
        currentUnderlineView.anchor(top: currentLabel.bottomAnchor, left: currentLabel.leftAnchor, bottom: nil, right: currentLabel.rightAnchor, paddingTop: 24, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0.5)
        confirmLabel.anchor(top: currentUnderlineView.bottomAnchor, left: currentLabel.leftAnchor, bottom: nil, right: currentUnderlineView.rightAnchor, paddingTop: 42, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: confirmLabel.intrinsicContentSize.height)
        confirmUnderlineView.anchor(top: confirmLabel.bottomAnchor, left: confirmLabel.leftAnchor, bottom: nil, right: confirmLabel.rightAnchor, paddingTop: 24, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0.5)
        updateLabel.anchor(top: confirmUnderlineView.bottomAnchor, left: confirmLabel.leftAnchor, bottom: nil, right: confirmUnderlineView.rightAnchor, paddingTop: 42, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: updateLabel.intrinsicContentSize.height)
        
        updateUnderlineView.anchor(top: updateLabel.bottomAnchor, left: updateLabel.leftAnchor, bottom: nil, right: updateLabel.rightAnchor, paddingTop: 24, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0.5)
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupProfileSection()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension EditProfileCells : UITextViewDelegate {
    
    func textViewDidChange(_ textView: UITextView) {
        let size = CGSize(width: frame.width - 24, height: .infinity)
        let estimatedSize = textView.sizeThatFits(size)
        
        textView.constraints.forEach { (constraint) in
            if constraint.firstAttribute == .height {
                constraint.constant = estimatedSize.height
            }
        }
    }
}
