//
//  EditProfileController.swift
//  pursue
//
//  Created by Jaylen Sanders on 11/30/17.
//  Copyright © 2017 Glory. All rights reserved.
//

import UIKit
import Alamofire
import Firebase

class EditProfileController : UIViewController {
    
    lazy var backButton : UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "back-arrow").withRenderingMode(.alwaysOriginal), for: .normal)
        button.contentMode = .scaleAspectFill
        button.addTarget(self, action: #selector(handleCancel), for: .touchUpInside)
        return button
    }()

    lazy var saveButton : UIButton = {
       let button = UIButton()
        button.setTitle("Save", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleSubmitUpdate), for: .touchUpInside)
        return button
    }()
    
    let cellId = "cellId"
    
    @objc func handleCamera(){
        let cameraController = SelectCameraController()
        navigationController?.present(cameraController, animated: true, completion: nil)
    }
    
    @objc func handleSubmitUpdate(){
        updateAccount()
        dismiss(animated: true, completion: nil)
    }
    
    
    @objc func handleCancel(){
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getUser()
        
        pageScrollView.contentSize = CGSize(width: view.frame.width, height: view.frame.height + 180)
        setupNavBarWithUser()
        setupProfileSection()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        tabBarController?.tabBar.isHidden = false
    }
    
    var user : User?
    var profileServices = ProfileServices()
    
    func getUser(){
        profileServices.getAccountDetails { (user) in
            DispatchQueue.main.async {
                self.fullnameLabel.text = user.fullname
                self.usernameLabel.text = user.username
                self.bioLabel.text = user.bio
                self.bioLabel.showPlaceholderLabel()
                
                guard let photo = user.photoUrl else { return }
                self.profilePicture.loadImage(urlString: photo)

            }
        }
    }
    
    func goToLogin(){
        let loginController = LoginController()
        navigationController?.present(loginController, animated: true, completion: nil)
    }
    
    func setupNavBarWithUser() {
        let backgroundView = UIView()
        backgroundView.backgroundColor = .white
        
        view.addSubview(backgroundView)
        backgroundView.addSubview(backButton)
        backgroundView.addSubview(saveButton)
        
        backgroundView.anchor(top: view.topAnchor, left: view.safeAreaLayoutGuide.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 80)
        backButton.anchor(top: nil, left: backgroundView.leftAnchor, bottom: backgroundView.bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 12, paddingBottom: 16, paddingRight: 0, width: 20, height: 20)
        saveButton.anchor(top: nil, left: nil, bottom: nil, right: backgroundView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 20, width: saveButton.intrinsicContentSize.width, height: saveButton.intrinsicContentSize.height)
        saveButton.centerYAnchor.constraint(equalTo: backButton.centerYAnchor).isActive = true
    }
    
    lazy var profilePicture : CustomImageView = {
        let iv = CustomImageView()
        iv.contentMode = .scaleAspectFill
        iv.layer.cornerRadius = 60
        iv.layer.masksToBounds = true
        iv.translatesAutoresizingMaskIntoConstraints = false
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleCamera))
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
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleCamera))
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
            let photoUrl = profilePicture.lastURLUsedToLoadImage else { return }
        
        self.profileService.updateAccount(username: username, fullname: fullname, photoUrl: photoUrl, bio: bio)
        self.dismiss(animated: true, completion: nil)
            
//            let image = self.profilePicture.image,
//            let uploadData = UIImageJPEGRepresentation(image, 0.3)
//            else { return }
//
//        let filename = NSUUID().uuidString
//        let ref = Storage.storage().reference().child("profile-images").child(filename)
//        ref.putData(uploadData, metadata: nil, completion: { (metadata, err) in
//
//            if let err = err {
//                print("Failed to upload", err)
//            }
//
//            var profileImageURL = ""
//            ref.downloadURL(completion: { (url, error) in
//                if let error = error {
//                    print(error)
//                } else {
//                    let stringUrl = url?.absoluteString
//                    profileImageURL = stringUrl!
//                }
//            })
//
//            self.profileService.updateAccount(username: username, fullname: fullname, photoUrl: profileImageURL, bio: bio)
//        })
    }
    
    @objc func deleteAccount(){
        let user = Auth.auth().currentUser
        user?.delete(completion: { (error) in
            if let error = error {
                print(error)
            } else {
                self.profileService.deleteAccount()
                self.goToLogin()
            }
        })
    }
    
    
    let pageScrollView : UIScrollView = {
       let scrollView = UIScrollView()
        scrollView.backgroundColor = .white
        scrollView.isScrollEnabled = true
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()
    
    func setupProfileSection(){
        fullnameUnderlineView.backgroundColor = .black
        usernameUnderlineView.backgroundColor = .black
        bioUnderlineView.backgroundColor = .black
        currentUnderlineView.backgroundColor = .black
        confirmUnderlineView.backgroundColor = .black
        updateUnderlineView.backgroundColor = .black
        
        view.addSubview(pageScrollView)
        pageScrollView.addSubview(profilePicture)
        pageScrollView.addSubview(deleteLabel)
        pageScrollView.addSubview(pictureButton)
        pageScrollView.addSubview(cameraIcon)
        
        pageScrollView.anchor(top: backButton.bottomAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        profilePicture.anchor(top: pageScrollView.topAnchor, left: nil, bottom: nil, right: nil, paddingTop: 64, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 120, height: 120)
        profilePicture.centerXAnchor.constraint(equalTo: pageScrollView.centerXAnchor).isActive = true
        
        pictureButton.anchor(top: nil, left: nil, bottom: profilePicture.bottomAnchor, right: profilePicture.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 40, height: 40)
        cameraIcon.anchor(top: nil, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 20, height: 20)
        cameraIcon.centerYAnchor.constraint(equalTo: pictureButton.centerYAnchor).isActive = true
        cameraIcon.centerXAnchor.constraint(equalTo: pictureButton.centerXAnchor).isActive = true
        
        updateAccountDetails()
        changePassword()
        
        deleteLabel.anchor(top: updateUnderlineView.bottomAnchor, left: updateLabel.leftAnchor, bottom: nil, right: nil, paddingTop: 42, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: deleteLabel.intrinsicContentSize.width, height: deleteLabel.intrinsicContentSize.height)
    }
    
    func updateAccountDetails(){
        view.addSubview(accountLabel)
        view.addSubview(fullnameLabel)
        view.addSubview(usernameLabel)
        view.addSubview(bioLabel)
        view.addSubview(fullnameUnderlineView)
        view.addSubview(usernameUnderlineView)
        view.addSubview(bioUnderlineView)
        
        accountLabel.anchor(top: profilePicture.bottomAnchor, left: pageScrollView.leftAnchor, bottom: nil, right: pageScrollView.rightAnchor, paddingTop: 48, paddingLeft: 12, paddingBottom: 0, paddingRight: 12, width: 0, height: accountLabel.intrinsicContentSize.height)
        fullnameLabel.anchor(top: accountLabel.bottomAnchor, left: pageScrollView.leftAnchor, bottom: nil, right: pageScrollView.rightAnchor, paddingTop: 42, paddingLeft: 12, paddingBottom: 0, paddingRight: 12, width: 0, height: fullnameLabel.intrinsicContentSize.height)
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
        view.addSubview(passwordLabel)
        view.addSubview(currentLabel)
        view.addSubview(confirmLabel)
        view.addSubview(updateLabel)
        view.addSubview(currentUnderlineView)
        view.addSubview(confirmUnderlineView)
        view.addSubview(updateUnderlineView)
        
        passwordLabel.anchor(top: bioUnderlineView.bottomAnchor, left: bioLabel.leftAnchor, bottom: nil, right: bioLabel.rightAnchor, paddingTop: 42, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: passwordLabel.intrinsicContentSize.height)
        currentLabel.anchor(top: passwordLabel.bottomAnchor, left: bioLabel.leftAnchor, bottom: nil, right: bioLabel.rightAnchor, paddingTop: 42, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: currentLabel.intrinsicContentSize.height)
        currentUnderlineView.anchor(top: currentLabel.bottomAnchor, left: currentLabel.leftAnchor, bottom: nil, right: currentLabel.rightAnchor, paddingTop: 24, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0.5)
        confirmLabel.anchor(top: currentUnderlineView.bottomAnchor, left: currentLabel.leftAnchor, bottom: nil, right: currentUnderlineView.rightAnchor, paddingTop: 42, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: confirmLabel.intrinsicContentSize.height)
        confirmUnderlineView.anchor(top: confirmLabel.bottomAnchor, left: confirmLabel.leftAnchor, bottom: nil, right: confirmLabel.rightAnchor, paddingTop: 24, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0.5)
        updateLabel.anchor(top: confirmUnderlineView.bottomAnchor, left: confirmLabel.leftAnchor, bottom: nil, right: confirmUnderlineView.rightAnchor, paddingTop: 42, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: updateLabel.intrinsicContentSize.height)
        
        updateUnderlineView.anchor(top: updateLabel.bottomAnchor, left: updateLabel.leftAnchor, bottom: nil, right: updateLabel.rightAnchor, paddingTop: 24, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0.5)
    }
}

extension EditProfileController : UITextViewDelegate {
    
    func textViewDidChange(_ textView: UITextView) {
        let size = CGSize(width: view.frame.width - 24, height: .infinity)
        let estimatedSize = textView.sizeThatFits(size)
        
        textView.constraints.forEach { (constraint) in
            if constraint.firstAttribute == .height {
                constraint.constant = estimatedSize.height
            }
        }
    }
}
