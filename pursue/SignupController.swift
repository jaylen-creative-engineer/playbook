//
//  ViewController.swift
//  pursue
//
//  Created by Jaylen Sanders on 9/11/17.
//  Copyright © 2017 Glory. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseStorage

class SignupController: UICollectionViewController, UICollectionViewDelegateFlowLayout, UIImagePickerControllerDelegate, UINavigationControllerDelegate, NameDelegate, EmailDelegate, UsernameDelegate, ProfilePictureDelegate, InterestsDelegate {
    
    // MARK: - Manage User Photo
    
    let cellId = "cellId"
    let nameId = "nameId"
    let usernameId = "usernameId"
    let passwordId = "passwordId"
    let pictureId = "pictureId"
    let interestId = "interestId"
    let principleId = "principleId"
    
    let pictureBigLabel : UILabel = {
        let label = UILabel()
        label.text = "Upload Picture."
        label.font = UIFont.systemFont(ofSize: 24, weight: UIFont.Weight.init(25))
        return label
    }()
    
    let enterPicturePrompt : UILabel = {
        let label = UILabel()
        label.text = "Please upload your profile picture"
        label.font = UIFont.boldSystemFont(ofSize: 14)
        return label
    }()
    
    lazy var profilePicture : UIButton = {
        let iv = UIButton()
        iv.contentMode = .scaleAspectFill
        iv.layer.cornerRadius = 60
        iv.layer.masksToBounds = true
        iv.layer.borderColor = UIColor.black.cgColor
        iv.layer.borderWidth = 2
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.addTarget(self, action: #selector(handlePlusPhoto), for: .touchUpInside)
        return iv
    }()
    
    lazy var addIcon : UIImageView = {
        let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "add").withRenderingMode(.alwaysOriginal)
        iv.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(handlePlusPhoto))
        tap.numberOfTapsRequired = 1
        iv.addGestureRecognizer(tap)
        return iv
    }()
    
    lazy var nextButton : UIButton = {
        let button = UIButton()
        button.setTitle("Next", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.addTarget(self, action: #selector(handleNext), for: .touchUpInside)
        button.contentHorizontalAlignment = .right
        button.contentVerticalAlignment = .center
        return button
    }()
    
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
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        // Local variable inserted by Swift 4.2 migrator.
        let info = convertFromUIImagePickerControllerInfoKeyDictionary(info)

        if let originalImage = info["UIImagePickerControllerOriginalImage"] as? UIImage {
            DispatchQueue.main.async {
                self.profilePicture.setImage(originalImage.withRenderingMode(.alwaysOriginal), for: .normal)
                self.addIcon.isHidden = true
                self.profileImage = originalImage.withRenderingMode(.alwaysOriginal)
            }
        } else if let editedImage = info["UIImagePickerControllerEditedImage"] as? UIImage {
            DispatchQueue.main.async {
                self.profilePicture.setImage(editedImage.withRenderingMode(.alwaysOriginal), for: .normal)
                self.addIcon.isHidden = true
                self.profileImage = editedImage.withRenderingMode(.alwaysOriginal)
            }
        }

        dismissImagePicker()
    }
    
    // MARK: - Handle User Text Fields
    
    let emailTextField : UITextField = {
        let tf = UITextField()
        tf.font = UIFont.systemFont(ofSize: 14)
        tf.textColor = .black
        
        let attributes = [ NSAttributedString.Key.foregroundColor: UIColor.black,
                           NSAttributedString.Key.font : UIFont.systemFont(ofSize: 14)]
        tf.attributedPlaceholder = NSAttributedString(string: "Email", attributes:attributes)
        return tf
    }()
    
    
    let usernameTextField : UITextField = {
        let tf = UITextField()
        tf.font = UIFont.systemFont(ofSize: 14)
        tf.textColor = .black
        
        let attributes = [ NSAttributedString.Key.foregroundColor: UIColor.black,
                           NSAttributedString.Key.font : UIFont.systemFont(ofSize: 14)]
        tf.attributedPlaceholder = NSAttributedString(string: "Username", attributes:attributes)
        return tf
    }()
    
    let fullnameTextField : UITextField = {
        let tf = UITextField()
        tf.font = UIFont.boldSystemFont(ofSize: 14)
        tf.textColor = .black
        
        let attributes = [ NSAttributedString.Key.foregroundColor: UIColor.black,
                           NSAttributedString.Key.font : UIFont.systemFont(ofSize: 14)]
        tf.attributedPlaceholder = NSAttributedString(string: "Full Name", attributes:attributes)
        return tf
    }()
    
    let passwordTextField : UITextField = {
        let tf = UITextField()
        tf.font = UIFont.systemFont(ofSize: 14)
        tf.textColor = .black
        
        let attributes = [ NSAttributedString.Key.foregroundColor: UIColor.black,
                           NSAttributedString.Key.font : UIFont.systemFont(ofSize: 14)]
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

    @objc func handleSignup(){
        
        guard let email = emailTextField.text, email.count > 0 else { return }
        guard let username = usernameTextField.text, username.count > 0 else { return }
        guard let password = passwordTextField.text, password.count > 0 else { return }
        guard let fullname = fullnameTextField.text, fullname.count > 0 else { return }
        
        if self.profileImage == nil {
            self.profileService.updateAccountWithPlaceholderImage(username: username, fullname: fullname, bio: nil)
            let appDelegate = UIApplication.shared.delegate! as! AppDelegate
            appDelegate.window = UIWindow()
            appDelegate.window?.rootViewController = MainTabController()
            appDelegate.window?.makeKeyAndVisible()
            self.dismiss(animated: true, completion: nil)
            
        } else {
            self.profileService.updateAccount(username: username, fullname: fullname, photoUrl: self.profileImage, bio: nil)
            let appDelegate = UIApplication.shared.delegate! as! AppDelegate
            appDelegate.window = UIWindow()
            appDelegate.window?.rootViewController = MainTabController()
            appDelegate.window?.makeKeyAndVisible()
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    var loggedInUserId : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupIntro()
        
        let center = NotificationCenter.default
        center.addObserver(self, selector: #selector(keyboardWillBeShown(note:)), name: UIApplication.keyboardWillShowNotification, object: nil)
        center.addObserver(self, selector: #selector(keyboardWillBeHidden(note:)), name: UIApplication.keyboardWillHideNotification, object: nil)

    }
    
    @objc func keyboardWillBeShown(note: Notification) {
        let userInfo = note.userInfo
        let keyboardFrame = userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as! CGRect
        let contentInset = UIEdgeInsets(top: 0.0, left: 0.0, bottom: -keyboardFrame.height, right: 0.0)
        collectionView.contentInset = contentInset
        collectionView.scrollIndicatorInsets = contentInset
        
        UIView.animate(withDuration: 0.5) {
            self.view.layoutIfNeeded()
        }

    }
    
    @objc func keyboardWillBeHidden(note: Notification) {
        let userInfo = note.userInfo
        let keyboardFrame = userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as! CGRect
        let contentInset = UIEdgeInsets(top: 0.0, left: 0.0, bottom: -keyboardFrame.height, right: 0.0)
        collectionView.contentInset = contentInset
        collectionView.scrollIndicatorInsets = contentInset
        
        UIView.animate(withDuration: 0.5) {
            self.view.layoutIfNeeded()
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    private let progressControl: UIProgressView = {
        let pv = UIProgressView()
        pv.progressTintColor = .black
        pv.translatesAutoresizingMaskIntoConstraints = false
        pv.trackTintColor = .clear
//        pv.progress = 0.16
        return pv
    }()
    
    private let pageControl: UIPageControl = {
        let pc = UIPageControl()
        pc.currentPage = 1
        pc.numberOfPages = 5
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
    
    lazy var cancelBackground : UIButton = {
       let button = UIButton()
        button.layer.cornerRadius = 19
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(handleDismiss), for: .touchUpInside)
        return button
    }()
    
    lazy var termsLabel : UILabel = {
        let label = UILabel()
        label.text = "By continuing, you agree to our Privacy Policy and Terms & Conditions."
        let text = (label.text)!
        let underlineAttriString = NSMutableAttributedString(string: text)
        let range1 = (text as NSString).range(of: "Privacy Policy")
        underlineAttriString.addAttribute(NSAttributedString.Key.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: range1)
        let range2 = (text as NSString).range(of: "Terms & Conditions")
        underlineAttriString.addAttribute(NSAttributedString.Key.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: range2)
        label.attributedText = underlineAttriString
        
        label.textAlignment = .center
        label.numberOfLines = 1
        label.font = UIFont.systemFont(ofSize: 11)
        label.isUserInteractionEnabled = true
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTermTap))
        tap.numberOfTapsRequired = 1
        label.addGestureRecognizer(tap)
        return label
    }()
    
    let hiddenButton : UIButton = {
       let button = UIButton()
        return button
    }()
    
    @objc func handleTermTap(gesture : UITapGestureRecognizer) {
        let text = (termsLabel.text)!
        let termsRange = (text as NSString).range(of: "Terms & Conditions")
        let privacyRange = (text as NSString).range(of: "Privacy Policy")
        
        if gesture.didTapAttributedTextInLabel(label: termsLabel, inRange: termsRange) {
            let termsController = TermsController()
            present(termsController, animated: true, completion: nil)
        } else if gesture.didTapAttributedTextInLabel(label: termsLabel, inRange: privacyRange) {
            let policyController = PolicyController()
            present(policyController, animated: true, completion: nil)
        } else {
            print("Tapped none")
        }
    }
    
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
        collectionView?.isSpringLoaded = false
        collectionView?.isPagingEnabled = true
        collectionView?.isScrollEnabled = false
        collectionView?.backgroundColor = .white
        collectionView?.showsHorizontalScrollIndicator = false
    }
    
    var current: Int = 2
    var countTracker : Int = 1
    var isValidUsername = false
    var isValidLogin = false
    
    override func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let currentpage = Int(scrollView.contentOffset.x / scrollView.bounds.width)
        progressControl.progress = Float(currentpage) / Float(pageControl.numberOfPages)
    }
    
    func handleFullnameNext(for cell: NameCell) {
        handleNext()
    }
    
    func handlePasswordKeyboard(for cell: EmailCell) {}
    
    func handleEmailNext(for cell: EmailCell) {
        guard let email = emailTextField.text, email.count > 0 else { return }
        guard let password = passwordTextField.text, password.count > 0 else { return }
        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            if let err = error {
                self.handleError(err)
                return
            }
  
            self.profileService.createAccount(email: email, username: nil, fullname: self.fullnameTextField.text, photoUrl: "https://firebasestorage.googleapis.com/v0/b/inpursuit-production.appspot.com/o/profile_unselected%402x.png?alt=media&token=8e334984-340a-413e-879b-c3ef50c6787b", bio: nil, completion: {
            })
            self.handleNext()
        }
    }
    
    func handleUsernameNext(for cell: UsernameCell) {
        if usernameTextField.hasText {
            let username = self.usernameTextField.text
            let ref = Database.database().reference().child("users")
            
            guard let currentUserId = Auth.auth().currentUser?.uid else { return }
            let dictionaryValues = ["userId": currentUserId]
            let values = [username: dictionaryValues]
            
            ref.observeSingleEvent(of: .value, with: { (snapshot) in
                if snapshot.hasChild(username!) {
                    let alert = UIAlertController(title: "Username", message: "Username is taken. Try again.", preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
                    alert.addAction(okAction)
                    self.present(alert, animated: true, completion: nil)
                } else if !snapshot.hasChild(username!) {
                    ref.updateChildValues(values) { (err, usernameRefCheck) in
                        if let err = err {
                            print(err)
                        }
                        self.handleNext()
                        self.pictureBigLabel.isHidden = false
                        self.enterPicturePrompt.isHidden = false
                        self.profilePicture.isHidden = false
                        self.addIcon.isHidden = false
                        self.nextButton.isHidden = false
                    }
                }
            }, withCancel: nil)
            
        } else {
            print("Username must have text")
        }
    }
    
    func handleProfilePicture(for cell: ProfilePictureCell) {
        handleNext()
    }
    
    func setProfileImage(for cell: ProfilePictureCell) {
        cell.profilePicture.setImage(profileImage?.withRenderingMode(.alwaysOriginal), for: .normal)
    }
    
    var checkSignup = false
    func handleInterestsCell(for cell: InterestsCell) {
        handleSignup()
    }
    
    @objc private func handleNext() {
        pictureBigLabel.isHidden = true
        enterPicturePrompt.isHidden = true
        profilePicture.isHidden = true
        addIcon.isHidden = true
        nextButton.isHidden = true
        
        
        let nextIndex = min(pageControl.currentPage + 1, 4)
        let indexPath = IndexPath(item: nextIndex, section: 0)
        pageControl.currentPage = nextIndex

        if progressControl.progress == 1.0 {
            handleSignup()

            progressControl.progress = progressControl.progress + Float(1)

        } else if progressControl.progress > 1.0 {
            let appDelegate = UIApplication.shared.delegate! as! AppDelegate
            appDelegate.window = UIWindow()
            appDelegate.window?.rootViewController = MainTabController()
            appDelegate.window?.makeKeyAndVisible()
            self.dismiss(animated: true, completion: nil)
        }

        self.progressControl.progress = Float(nextIndex) / Float(self.pageControl.numberOfPages)
        self.collectionView?.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: false)
    }
    
    @objc func handleDismiss(){
        dismiss(animated: true, completion: nil)
    }
    
    func setupAddProfile(){
        pictureBigLabel.isHidden = true
        enterPicturePrompt.isHidden = true
        profilePicture.isHidden = true
        addIcon.isHidden = true
        nextButton.isHidden = true
        
        view.addSubview(pictureBigLabel)
        view.addSubview(enterPicturePrompt)
        view.addSubview(profilePicture)
        profilePicture.addSubview(addIcon)
        view.addSubview(nextButton)
        
        pictureBigLabel.anchor(top: view.topAnchor, left: nil, bottom: nil, right: nil, paddingTop: 64, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: pictureBigLabel.intrinsicContentSize.width, height: pictureBigLabel.intrinsicContentSize.height)
        pictureBigLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        enterPicturePrompt.anchor(top: pictureBigLabel.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 12, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: enterPicturePrompt.intrinsicContentSize.width, height: enterPicturePrompt.intrinsicContentSize.height)
        enterPicturePrompt.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        profilePicture.anchor(top: enterPicturePrompt.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 48, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 120, height: 120)
        profilePicture.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        addIcon.anchor(top: nil, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 30, height: 30)
        addIcon.centerXAnchor.constraint(equalTo: profilePicture.centerXAnchor).isActive = true
        addIcon.centerYAnchor.constraint(equalTo: profilePicture.centerYAnchor).isActive = true
        nextButton.anchor(top: view.topAnchor, left: nil, bottom: nil, right: view.safeAreaLayoutGuide.rightAnchor, paddingTop: 18, paddingLeft: 0, paddingBottom: 0, paddingRight: 12, width: 120, height: 34)
    }
    
    func setupControls(){
        view.addSubview(progressControl)
        view.addSubview(cancelButton)
        view.addSubview(hiddenButton)
        view.addSubview(termsLabel)
        
        progressControl.anchor(top: view.topAnchor, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: view.frame.width, height: 10)
        progressControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: -5).isActive = true
        cancelButton.anchor(top: progressControl.bottomAnchor, left: view.safeAreaLayoutGuide.leftAnchor, bottom: nil, right: nil, paddingTop: 18, paddingLeft: 18, paddingBottom: 0, paddingRight: 0, width: 15, height: 15)
        
        view.addSubview(cancelBackground)
        cancelBackground.centerXAnchor.constraint(equalTo: cancelButton.centerXAnchor).isActive = true
        cancelBackground.centerYAnchor.constraint(equalTo: cancelButton.centerYAnchor).isActive = true
        cancelBackground.anchor(top: nil, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 38, height: 38)
        
        hiddenButton.anchor(top: nil, left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 12, paddingBottom: 12, paddingRight: 12, width: 0, height: 60)
        termsLabel.anchor(top: nil, left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 12, paddingBottom: 18, paddingRight: 12, width: 0, height: 18)
        setupAddProfile()
    }
   
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.item {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: nameId, for: indexPath) as! NameCell
            cell.accessSignupController = self
            cell.delegate = self
            return cell
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! EmailCell
            cell.accessSignupController = self
            cell.delegate = self
            return cell
        case 2:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: usernameId, for: indexPath) as! UsernameCell
            cell.accessSignupController = self
            cell.delegate = self
            return cell
        case 3:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: pictureId, for: indexPath) as!
            ProfilePictureCell
            cell.accessSignupController = self
            cell.delegate = self
            if profileImage != nil {
                cell.profilePicture.setImage(profileImage, for: .normal)
                cell.profilePicture.layer.borderColor = UIColor.clear.cgColor
                cell.addIcon.isHidden = true
            }
            return cell
        case 4:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: interestId, for: indexPath) as! InterestsCell
            cell.delegate = self
            cell.isSignup = true
            return cell
        default:
            assert(false, "Not a valid cell")
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "randomCell", for: indexPath)
        return cell
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
                self.collectionView?.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: false)
            }

        }) { (_) in

        }
    }
}

fileprivate func convertFromUIImagePickerControllerInfoKeyDictionary(_ input: [UIImagePickerController.InfoKey: Any]) -> [String: Any] {
	return Dictionary(uniqueKeysWithValues: input.map {key, value in (key.rawValue, value)})
}

extension UITapGestureRecognizer {
    
    func didTapAttributedTextInLabel(label: UILabel, inRange targetRange: NSRange) -> Bool {
        // Create instances of NSLayoutManager, NSTextContainer and NSTextStorage
        let layoutManager = NSLayoutManager()
        let textContainer = NSTextContainer(size: CGSize.zero)
        let textStorage = NSTextStorage(attributedString: label.attributedText!)
        
        // Configure layoutManager and textStorage
        layoutManager.addTextContainer(textContainer)
        textStorage.addLayoutManager(layoutManager)
        
        // Configure textContainer
        textContainer.lineFragmentPadding = 0.0
        textContainer.lineBreakMode = label.lineBreakMode
        textContainer.maximumNumberOfLines = label.numberOfLines
        let labelSize = label.bounds.size
        textContainer.size = labelSize
        
        // Find the tapped character location and compare it to the specified range
        let locationOfTouchInLabel = self.location(in: label)
        let textBoundingBox = layoutManager.usedRect(for: textContainer)
        let textContainerOffset = CGPoint(x: (labelSize.width - textBoundingBox.size.width) * 0.5 - textBoundingBox.origin.x, y: (labelSize.height - textBoundingBox.size.height) * 0.5 - textBoundingBox.origin.y)
        let locationOfTouchInTextContainer = CGPoint(x: locationOfTouchInLabel.x - textContainerOffset.x, y: locationOfTouchInLabel.y - textContainerOffset.y)
        let indexOfCharacter = layoutManager.characterIndex(for: locationOfTouchInTextContainer, in: textContainer, fractionOfDistanceBetweenInsertionPoints: nil)
        
        return NSLocationInRange(indexOfCharacter, targetRange)
    }
    
}
