//
//  ViewController.swift
//  pursue
//
//  Created by Jaylen Sanders on 9/11/17.
//  Copyright © 2017 Glory. All rights reserved.
//

import UIKit
import Alamofire
import Firebase

class SignupController: UICollectionViewController, UICollectionViewDelegateFlowLayout, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    // MARK: - Manage User Photo
    
    let plusPhotoButton : UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "plus_photo").withRenderingMode(.alwaysTemplate), for: .normal)
        button.tintColor = .black
        button.addTarget(self, action: #selector(handlePlusPhoto), for: .touchUpInside)
        return button
    }()
    
    @objc func handlePlusPhoto(){
        
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = true
        
        present(imagePickerController, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let originalImage = info["UIImagePickerControllerOriginalImage"] as? UIImage {
            
            plusPhotoButton.setImage(originalImage.withRenderingMode(.alwaysOriginal), for: .normal)
            
        } else if let editedImage = info["UIImagePickerControllerEditedImage"] as? UIImage {
            
            plusPhotoButton.setImage(editedImage.withRenderingMode(.alwaysOriginal), for: .normal)
        }
        
        plusPhotoButton.layer.cornerRadius = plusPhotoButton.frame.width/2
        plusPhotoButton.layer.masksToBounds = true
        plusPhotoButton.layer.borderColor = UIColor.black.cgColor
        
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Handle User Text Fields
    
    let emailTextField : UITextField = {
        let tf = UITextField()
        tf.font = UIFont.systemFont(ofSize: 14)
        tf.textColor = .black
        
        let attributes = [ NSAttributedStringKey.foregroundColor: UIColor.black,
                           NSAttributedStringKey.font : UIFont.systemFont(ofSize: 14)]
        tf.attributedPlaceholder = NSAttributedString(string: "Email", attributes:attributes)
        tf.addTarget(self, action: #selector(handleTextInputChange), for: .editingChanged)
        return tf
    }()
    
    
    let usernameTextField : UITextField = {
        let tf = UITextField()
        tf.font = UIFont.systemFont(ofSize: 14)
        tf.textColor = .black
        
        let attributes = [ NSAttributedStringKey.foregroundColor: UIColor.black,
                           NSAttributedStringKey.font : UIFont.systemFont(ofSize: 14)]
        tf.attributedPlaceholder = NSAttributedString(string: "Username", attributes:attributes)
        tf.addTarget(self, action: #selector(handleTextInputChange), for: .editingChanged)
        return tf
    }()
    
    let fullnameTextField : UITextField = {
        let tf = UITextField()
        tf.font = UIFont.boldSystemFont(ofSize: 14)
        tf.textColor = .black
        
        let attributes = [ NSAttributedStringKey.foregroundColor: UIColor.black,
                           NSAttributedStringKey.font : UIFont.systemFont(ofSize: 14)]
        tf.attributedPlaceholder = NSAttributedString(string: "Full Name", attributes:attributes)
        tf.addTarget(self, action: #selector(handleTextInputChange), for: .editingChanged)
        return tf
    }()
    
    let passwordTextField : UITextField = {
        let tf = UITextField()
        tf.font = UIFont.systemFont(ofSize: 14)
        tf.textColor = .black
        
        let attributes = [ NSAttributedStringKey.foregroundColor: UIColor.black,
                           NSAttributedStringKey.font : UIFont.systemFont(ofSize: 14)]
        tf.attributedPlaceholder = NSAttributedString(string: "Password", attributes:attributes)
        tf.addTarget(self, action: #selector(handleTextInputChange), for: .editingChanged)
        tf.isSecureTextEntry = true
        return tf
    }()
    
    let reentryPasswordTextField : UITextField = {
        let tf = UITextField()
        tf.font = UIFont.systemFont(ofSize: 14)
        tf.textColor = .black
        
        let attributes = [ NSAttributedStringKey.foregroundColor: UIColor.black,
                           NSAttributedStringKey.font : UIFont.systemFont(ofSize: 14)]
        tf.attributedPlaceholder = NSAttributedString(string: "Re-enter Password", attributes:attributes)
        tf.addTarget(self, action: #selector(handleTextInputChange), for: .editingChanged)
        tf.isSecureTextEntry = true
        return tf
    }()
    
    let haveAccountLabel : UILabel = {
       let label = UILabel()
        label.text = "Have an account?"
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    private func setupInputFields() {
        view.addSubview(fullnameTextField)
        
        let fullnameUnderline = UIView()
        fullnameUnderline.backgroundColor = .black
        
        view.addSubview(fullnameUnderline)
        fullnameTextField.anchor(top: plusPhotoButton.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 54, paddingLeft: 32, paddingBottom: 0, paddingRight: 32, width: 0, height: fullnameTextField.intrinsicContentSize.height)
        fullnameUnderline.anchor(top: fullnameTextField.bottomAnchor, left: fullnameTextField.leftAnchor, bottom: nil, right: fullnameTextField.rightAnchor, paddingTop: 24, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0.5)
        
        view.addSubview(emailTextField)
        emailTextField.anchor(top: fullnameUnderline.bottomAnchor, left: fullnameUnderline.leftAnchor, bottom: nil, right: fullnameTextField.rightAnchor, paddingTop: 48, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: emailTextField.intrinsicContentSize.height)
        
        let emailUnderline = UIView()
        emailUnderline.backgroundColor = .black
        
        view.addSubview(emailUnderline)
        emailUnderline.anchor(top: emailTextField.bottomAnchor, left: emailTextField.leftAnchor, bottom: nil, right: emailTextField.rightAnchor, paddingTop: 24, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0.5)
        
        view.addSubview(usernameTextField)
        usernameTextField.anchor(top: emailUnderline.bottomAnchor, left: fullnameUnderline.leftAnchor, bottom: nil, right: fullnameTextField.rightAnchor, paddingTop: 48, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: usernameTextField.intrinsicContentSize.height)
        
        let usernameUnderline = UIView()
        usernameUnderline.backgroundColor = .black
        
        view.addSubview(usernameUnderline)
        usernameUnderline.anchor(top: usernameTextField.bottomAnchor, left: usernameTextField.leftAnchor, bottom: nil, right: usernameTextField.rightAnchor, paddingTop: 24, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0.5)
        
        view.addSubview(passwordTextField)
         passwordTextField.anchor(top: usernameUnderline.bottomAnchor, left: fullnameUnderline.leftAnchor, bottom: nil, right: fullnameTextField.rightAnchor, paddingTop: 48, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: passwordTextField.intrinsicContentSize.height)
        
        let passwordUnderline = UIView()
        passwordUnderline.backgroundColor = .black
        
        view.addSubview(passwordUnderline)
        passwordUnderline.anchor(top: passwordTextField.bottomAnchor, left: passwordTextField.leftAnchor, bottom: nil, right: passwordTextField.rightAnchor, paddingTop: 24, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0.5)
        switchToLogin()
    }
    
    func switchToLogin(){
        view.addSubview(haveAccountLabel)
        view.addSubview(loginButton)
        
        let guide = view.safeAreaLayoutGuide
        
        haveAccountLabel.anchor(top: nil, left: passwordTextField.leftAnchor, bottom: guide.bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 24, paddingRight: 0, width: haveAccountLabel.intrinsicContentSize.width, height: haveAccountLabel.intrinsicContentSize.height)
        loginButton.anchor(top: nil, left: haveAccountLabel.rightAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 6, paddingBottom: 0, paddingRight: 0, width: loginButton.intrinsicContentSize.width, height: loginButton.intrinsicContentSize.height)
        loginButton.centerYAnchor.constraint(equalTo: haveAccountLabel.centerYAnchor).isActive = true
        signupButton()
    }
        
    func signupButton() {
        view.addSubview(signUpButton)
        view.addSubview(signupArrow)
        let guide = view.safeAreaLayoutGuide
        
        signUpButton.anchor(top: nil, left: nil, bottom: guide.bottomAnchor, right: guide.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 12, width: 60, height: 60)
        signupArrow.anchor(top: nil, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 25, height: 25)
        signupArrow.centerYAnchor.constraint(equalTo: signUpButton.centerYAnchor).isActive = true
        signupArrow.centerXAnchor.constraint(equalTo: signUpButton.centerXAnchor).isActive = true
    }
    
    // MARK: - Handle User Sign Up
    
    lazy var signUpButton : UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor.black
        button.layer.cornerRadius = 30
        button.layer.borderWidth = 1
        button.addTarget(self, action: #selector(handleSignup), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isEnabled = false
        return button
    }()
    
    lazy var signupArrow : UIImageView = {
       let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "forward").withRenderingMode(.alwaysOriginal)
        iv.contentMode = .scaleAspectFill
        
        let tap = UITapGestureRecognizer(target: self, action:  #selector(handleSignup))
        tap.numberOfTapsRequired = 1
        iv.addGestureRecognizer(tap)
        return iv
    }()
    
    @objc func handleTextInputChange () {
        let isFormValid = emailTextField.text?.count ?? 0 > 0 &&
            usernameTextField.text?.count ?? 0 > 0 &&
            passwordTextField.text?.count ?? 0 > 0
        
        if isFormValid {
            signUpButton.isEnabled = true
            signUpButton.backgroundColor = UIColor.black
            signUpButton.titleLabel?.textColor = .white
        } else {
            signUpButton.isEnabled = false
            signUpButton.backgroundColor = UIColor.black
            signUpButton.titleLabel?.textColor = .white
        }
    }
    
    let alreadyHaveAccountButton : UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("LOG IN", for: .normal)
        button.backgroundColor = UIColor.white
        button.layer.cornerRadius = 17
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.setTitleColor(.black, for: .normal)
        button.layer.borderColor = UIColor.black.cgColor
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.borderWidth = 1
        button.addTarget(self, action: #selector(handleAlreadyHaveAccount), for: .touchUpInside)
        return button
    }()
    
    let profileService = ProfileServices()
    
    @objc func handleAlreadyHaveAccount() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func handleSignup(){
        guard let email = emailTextField.text, email.count > 0 else { return }
        guard let username = usernameTextField.text, username.count > 0 else { return }
        guard let password = passwordTextField.text, password.count > 0 else { return }
        guard let fullname = fullnameTextField.text, fullname.count > 0 else { return }
        
        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            if let err = error {
                print("Failed to create user", err)
                return
            }
            
            guard let image = self.plusPhotoButton.imageView?.image else { return }
            guard let uploadData = UIImageJPEGRepresentation(image, 0.3) else { return }
            
            let filename = NSUUID().uuidString
            Storage.storage().reference().child("profile-images").child(filename).putData(uploadData, metadata: nil, completion: { (metadata, err) in
                
                if let err = err {
                    print("Failed to upload", err)
                }
                
                guard let profileImageURL = metadata?.downloadURL()?.absoluteString else { return }
                
                self.profileService.createAccount(email: email, username: username, fullname: fullname, photoUrl: profileImageURL, bio: nil)
                self.showInterestsController()
            })
        }
    }
    
    
    func showInterestsController(){
        let layout = UICollectionViewFlowLayout()
        let interestsController = InterestsController(collectionViewLayout: layout)
        interestsController.viewType = "signupInterest"
        self.navigationController?.pushViewController(interestsController, animated: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupIntro()

    }
    
    private let progressControl: UIProgressView = {
        let pv = UIProgressView()
        pv.progressTintColor = .black
        pv.translatesAutoresizingMaskIntoConstraints = false
        pv.trackTintColor = .clear
        pv.progress = 0.20
        return pv
    }()
    
    private let pageControl: UIPageControl = {
        let pc = UIPageControl()
        pc.currentPage = 0
        pc.numberOfPages = 4
        pc.currentPageIndicatorTintColor = .black
        pc.pageIndicatorTintColor = .lightGray
        return pc
    }()
    
    lazy var cancelButton : UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "cancel").withRenderingMode(.alwaysOriginal), for: .normal)
        button.contentMode = .scaleAspectFill
        button.addTarget(self, action: #selector(handleDismiss), for: .touchUpInside)
        return button
    }()
    
    lazy var nextButton : UIButton = {
        let button = UIButton()
        button.setTitle("Next", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.addTarget(self, action: #selector(handleNext), for: .touchUpInside)
        return button
    }()
    
    lazy var loginButton : UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("LOGIN", for: .normal)
        button.backgroundColor = UIColor.gray
        button.layer.cornerRadius = 28
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.setTitleColor(.white, for: .normal)
        button.layer.borderColor = UIColor.gray.cgColor
        button.layer.borderWidth = 1
        button.isEnabled = false
        return button
    }()
    
    func setupIntro(){
        setupControls()
        if let flowLayout = collectionView?.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.scrollDirection = .horizontal
            flowLayout.minimumLineSpacing = 0
        }
        
        collectionView?.register(EmailCell.self, forCellWithReuseIdentifier: cellId)
        collectionView?.register(NameCell.self, forCellWithReuseIdentifier: nameId)
        collectionView?.register(UsernameCell.self, forCellWithReuseIdentifier: usernameId)
        collectionView?.register(PasswordCell.self, forCellWithReuseIdentifier: passwordId)
        collectionView?.register(ProfilePictureCell.self, forCellWithReuseIdentifier: pictureId)
        collectionView?.isPagingEnabled = true
        collectionView?.backgroundColor = .white
        collectionView?.isScrollEnabled = false
        collectionView?.showsHorizontalScrollIndicator = false
    }
    
    var current: Int = 2
    
    @objc private func handleNext() {
        let nextIndex = Int(pageControl.currentPage + 1)
        let indexPath = IndexPath(item: nextIndex, section: 0)
        pageControl.currentPage = nextIndex
        progressControl.progress = Float(nextIndex / pageControl.numberOfPages)
        
        let i = current
        let max = 5
        
        if i <= max {
            let ratio = Float(i) / Float(max)
            progressControl.progress = Float(ratio)
            current = current + 1
        }
        
        if pageControl.currentPage == 3 && nextIndex == 4 {
            loginButton.backgroundColor = .black
            loginButton.layer.borderColor = UIColor.black.cgColor
            loginButton.isEnabled = true
            nextButton.isHidden = true
        } else {
            loginButton.backgroundColor = .gray
            loginButton.layer.borderColor = UIColor.gray.cgColor
            loginButton.isEnabled = false
            nextButton.isHidden = false
        }
        collectionView?.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    
    @objc func handleDismiss(){
        dismiss(animated: true, completion: nil)
    }
    
    func setupControls(){
        view.addSubview(progressControl)
        view.addSubview(cancelButton)
        view.addSubview(nextButton)
        view.addSubview(loginButton)
        progressControl.anchor(top: view.topAnchor, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: view.frame.width, height: 10)
        cancelButton.anchor(top: progressControl.bottomAnchor, left: view.safeAreaLayoutGuide.leftAnchor, bottom: nil, right: nil, paddingTop: 18, paddingLeft: 18, paddingBottom: 0, paddingRight: 0, width: 15, height: 15)
        nextButton.anchor(top: nil, left: nil, bottom: nil, right: view.safeAreaLayoutGuide.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 12, width: nextButton.intrinsicContentSize.width, height: nextButton.intrinsicContentSize.height)
        nextButton.centerYAnchor.constraint(equalTo: cancelButton.centerYAnchor).isActive = true
        loginButton.anchor(top: nil, left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 12, paddingBottom: 12, paddingRight: 12, width: 0, height: 60)
    }
    
    let cellId = "cellId"
    let nameId = "nameId"
    let usernameId = "usernameId"
    let passwordId = "passwordId"
    let pictureId = "pictureId"
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.item {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! EmailCell
            return cell
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: nameId, for: indexPath) as! NameCell
            return cell
        case 2:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: usernameId, for: indexPath) as! UsernameCell
            return cell
        case 3:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: passwordId, for: indexPath) as! PasswordCell
            return cell
        case 4:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: pictureId, for: indexPath) as! ProfilePictureCell
            return cell
        default:
            assert(false, "Not a valid cell")
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height)
    }
    
}

extension SignupController {
    
    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        let x = targetContentOffset.pointee.x
        
        pageControl.currentPage = Int(x / view.frame.width)
        
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        
        coordinator.animate(alongsideTransition: { (_) in
            self.collectionViewLayout.invalidateLayout()
            
            if self.pageControl.currentPage == 0 {
                self.collectionView?.contentOffset = .zero
            } else {
                let indexPath = IndexPath(item: self.pageControl.currentPage, section: 0)
                self.collectionView?.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
            }
            
        }) { (_) in
            
        }
    }
}

