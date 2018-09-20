//
//  ViewController.swift
//  pursue
//
//  Created by Jaylen Sanders on 9/11/17.
//  Copyright © 2017 Glory. All rights reserved.
//

import UIKit
import Firebase

class SignupController: UICollectionViewController, UICollectionViewDelegateFlowLayout, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    // MARK: - Manage User Photo
    
    let cellId = "cellId"
    let nameId = "nameId"
    let usernameId = "usernameId"
    let passwordId = "passwordId"
    let pictureId = "pictureId"
    let interestId = "interestId"
    let principleId = "principleId"
    
    @objc func handlePlusPhoto(){
        
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = true
        
        present(imagePickerController, animated: true, completion: nil)
    }
    
    func dismissImagePicker() {
        dismiss(animated: true, completion: nil)
    }
    
    var profileImage : UIImage?
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let originalImage = info["UIImagePickerControllerOriginalImage"] as? UIImage {
            profileImage = originalImage.withRenderingMode(.alwaysOriginal)
            collectionView?.reloadData()
            
        } else if let editedImage = info["UIImagePickerControllerEditedImage"] as? UIImage {
            profileImage = editedImage.withRenderingMode(.alwaysOriginal)
            collectionView?.reloadData()
        }

        dismissImagePicker()
    }
    
    // MARK: - Handle User Text Fields
    
    let emailTextField : UITextField = {
        let tf = UITextField()
        tf.font = UIFont.systemFont(ofSize: 14)
        tf.textColor = .black
        
        let attributes = [ NSAttributedStringKey.foregroundColor: UIColor.black,
                           NSAttributedStringKey.font : UIFont.systemFont(ofSize: 14)]
        tf.attributedPlaceholder = NSAttributedString(string: "Email", attributes:attributes)
        return tf
    }()
    
    
    let usernameTextField : UITextField = {
        let tf = UITextField()
        tf.font = UIFont.systemFont(ofSize: 14)
        tf.textColor = .black
        
        let attributes = [ NSAttributedStringKey.foregroundColor: UIColor.black,
                           NSAttributedStringKey.font : UIFont.systemFont(ofSize: 14)]
        tf.attributedPlaceholder = NSAttributedString(string: "Username", attributes:attributes)
        return tf
    }()
    
    let fullnameTextField : UITextField = {
        let tf = UITextField()
        tf.font = UIFont.boldSystemFont(ofSize: 14)
        tf.textColor = .black
        
        let attributes = [ NSAttributedStringKey.foregroundColor: UIColor.black,
                           NSAttributedStringKey.font : UIFont.systemFont(ofSize: 14)]
        tf.attributedPlaceholder = NSAttributedString(string: "Full Name", attributes:attributes)
        return tf
    }()
    
    let passwordTextField : UITextField = {
        let tf = UITextField()
        tf.font = UIFont.systemFont(ofSize: 14)
        tf.textColor = .black
        
        let attributes = [ NSAttributedStringKey.foregroundColor: UIColor.black,
                           NSAttributedStringKey.font : UIFont.systemFont(ofSize: 14)]
        tf.attributedPlaceholder = NSAttributedString(string: "Password", attributes:attributes)
        tf.isSecureTextEntry = true
        return tf
    }()
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    // MARK: - Handle User Sign Up
    
    let profileService = ProfileServices()
    var user : User?
    var firebaseImageUrl : String?
    var loggedinUserId : String?
    
    @objc func addUserToFirebase(){
        
        guard let email = emailTextField.text, email.count > 0 else { return }
        guard let password = passwordTextField.text, password.count > 0 else { return }
        
        DispatchQueue.main.async {
            Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
                if let err = error {
                    print("Failed to create user", err)
                    return
                }
                
                self.loggedinUserId = user?.user.uid
            }
        }
    }

    @objc func handleSignup(){
        guard let email = emailTextField.text, email.count > 0 else { return }
        guard let username = usernameTextField.text, username.count > 0 else { return }
        guard let password = passwordTextField.text, password.count > 0 else { return }
        guard let fullname = fullnameTextField.text, fullname.count > 0 else { return }
        guard let image = self.profileImage else { return }
        guard let uploadData = UIImageJPEGRepresentation(image, 0.3) else { return }
        
        let filename = NSUUID().uuidString
        let ref = Storage.storage().reference().child("profile-images").child(filename)
        
        DispatchQueue.main.async {
            ref.putData(uploadData, metadata: nil, completion: { (metadata, err) in
                
                if let err = err {
                    print("Failed to upload", err)
                }
                
                ref.downloadURL(completion: { (url, err) in
                    if err != nil {
                        print(err ?? "")
                    }
                    
                    guard let photoUrl = url?.absoluteString else { return }
                    self.profileService.createAccount(email: email, username: username, fullname: fullname, photoUrl: photoUrl, bio: nil)
                    self.profileService.getUserId(username: username)
                })
            })
        }
        
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
        pv.progress = 0.16
        return pv
    }()
    
    private let pageControl: UIPageControl = {
        let pc = UIPageControl()
        pc.currentPage = 1
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
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.addTarget(self, action: #selector(handleNext), for: .touchUpInside)
        return button
    }()
    
    lazy var loginButton : UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("SIGN UP", for: .normal)
        button.backgroundColor = UIColor.gray
        button.layer.cornerRadius = 28
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.init(25))
        button.setTitleColor(.white, for: .normal)
        button.layer.borderColor = UIColor.gray.cgColor
        button.layer.borderWidth = 1
        button.isEnabled = false
        button.addTarget(self, action: #selector(handleSignup), for: .touchUpInside)
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
        collectionView?.register(InterestsCell.self, forCellWithReuseIdentifier: interestId)
        collectionView?.isPagingEnabled = true
        collectionView?.backgroundColor = .white
        collectionView?.showsHorizontalScrollIndicator = false
    }
    
    var current: Int = 2
    var countTracker : Int = 1
    
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
            countTracker = countTracker + 1
        } else {
            countTracker = countTracker + 1
        }
        
        switch countTracker {
        case 4:
            addUserToFirebase()
        case 5:
            loginButton.backgroundColor = .black
            loginButton.layer.borderColor = UIColor.black.cgColor
            loginButton.isEnabled = true
            collectionView?.isScrollEnabled = true
            addUserToFirebase()
            handleSignup()
            
        case 6:
            let appDelegate = UIApplication.shared.delegate! as! AppDelegate
            appDelegate.window = UIWindow()
            appDelegate.window?.rootViewController = MainTabController()
            appDelegate.window?.makeKeyAndVisible()
            nextButton.isUserInteractionEnabled = false
            self.dismiss(animated: true, completion: nil)
        default:
            loginButton.backgroundColor = .gray
            loginButton.layer.borderColor = UIColor.gray.cgColor
            loginButton.isEnabled = false
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
        progressControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: -5).isActive = true
        cancelButton.anchor(top: progressControl.bottomAnchor, left: view.safeAreaLayoutGuide.leftAnchor, bottom: nil, right: nil, paddingTop: 18, paddingLeft: 18, paddingBottom: 0, paddingRight: 0, width: 15, height: 15)
        nextButton.anchor(top: nil, left: nil, bottom: nil, right: view.safeAreaLayoutGuide.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 12, width: nextButton.intrinsicContentSize.width, height: nextButton.intrinsicContentSize.height)
        nextButton.centerYAnchor.constraint(equalTo: cancelButton.centerYAnchor).isActive = true
        loginButton.anchor(top: nil, left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 12, paddingBottom: 12, paddingRight: 12, width: 0, height: 60)
    }
    
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
            cell.accessSignupController = self
            return cell
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: nameId, for: indexPath) as! NameCell
            cell.accessSignupController = self
            return cell
        case 2:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: usernameId, for: indexPath) as! UsernameCell
            cell.accessSignupController = self
            return cell
        case 3:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: passwordId, for: indexPath) as! PasswordCell
            cell.accessSignupController = self
            return cell
        case 4:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: pictureId, for: indexPath) as! ProfilePictureCell
            cell.accessSignupController = self
            if profileImage != nil {
                cell.profilePicture.setImage(profileImage, for: .normal)
                cell.profilePicture.layer.borderColor = UIColor.clear.cgColor
                cell.addIcon.isHidden = true
            }
            return cell
//        case 5:
//            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: interestId, for: indexPath) as! InterestsCell
//            if loggedinUserId != nil {
//                cell.userId = loggedinUserId
//            }
//            return cell
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

