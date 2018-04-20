//
//  ProfileContainer.swift
//  pursue
//
//  Created by Jaylen Sanders on 11/27/17.
//  Copyright © 2017 Glory. All rights reserved.
//

import UIKit
import Alamofire
import Firebase
import ParallaxHeader

class ProfileController : UICollectionViewController, UICollectionViewDelegateFlowLayout {
        
    let cellId = "cellId"
    let secondaryId = "secondaryId"
    let customRowId = "customRowId"
    let peopleId = "peopleId"
    let principleId = "principleId"
    let exerciseId = "exerciseId"
    let categoryId = "categoryId"
    let pursuitsId = "pursuitsId"
    let postId = "postId"
    let addedId = "addedId"
    let headerId = "headerId"
    let discussionId = "discussionId"
    let parallaxId = "parallaxId"
    
    lazy var optionButton : UIButton = {
        let button = UIButton()
        button.setTitle("•••", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(handleSettings), for: .touchUpInside)
        return button
    }()
    
    
    let topBackground : UIView = {
       let view = UIView()
        view.backgroundColor = UIColor.init(white: 0.8, alpha: 0.3)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 15
        return view
    }()
    
    let photoImageView : UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
    }()
    
    let imageView : CustomImageView = {
        let iv = CustomImageView()
        iv.clipsToBounds = true
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    let backgroundFill = UIView()
    var user : User?
    var pursuits : [Pursuit]?
    var followers : [Follower]?
    let profileService = ProfileServices()
    
    private func setupTopBar(){
        view.addSubview(topBackground)
        topBackground.addSubview(optionButton)
        
        topBackground.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: nil, bottom: nil, right: view.safeAreaLayoutGuide.rightAnchor, paddingTop: 12, paddingLeft: 0, paddingBottom: 0, paddingRight: 12, width: 30, height: 30)
        optionButton.anchor(top: nil, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: optionButton.intrinsicContentSize.width, height: optionButton.intrinsicContentSize.height)
        optionButton.centerXAnchor.constraint(equalTo: topBackground.centerXAnchor).isActive = true
        optionButton.centerYAnchor.constraint(equalTo: topBackground.centerYAnchor).isActive = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBarController?.navigationController?.navigationBar.isHidden = true
        collectionView?.register(ProfileAboutRow.self, forCellWithReuseIdentifier: peopleId)
        collectionView?.register(ProfilePursuit.self, forCellWithReuseIdentifier: pursuitsId)
        collectionView?.backgroundColor = .white
        collectionView?.contentInset = UIEdgeInsetsMake(0, 0, 105, 0)
        collectionView?.showsVerticalScrollIndicator = false
        collectionView?.parallaxHeader.view = imageView
        collectionView?.parallaxHeader.height = view.frame.height / 2
        collectionView?.parallaxHeader.minimumHeight = 0
        collectionView?.parallaxHeader.mode = .topFill
        
        setupTopBar()
        getUser()
    }
    
    var pursuit : Pursuit?
    func getUser(){
        profileService.getAccount { (user) in
            DispatchQueue.main.async {
                self.followers = user.followees
                self.pursuits = user.pursuits
                
                self.user = user
                guard let photoUrl = user.photoUrl else { return }
                self.imageView.loadImage(urlString: photoUrl)
                self.collectionView?.reloadData()
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
        dismiss(animated: true, completion: nil)
    }
    
    func showFriendsController(){
        let layout = UICollectionViewFlowLayout()
        let friendsController = FriendsController(collectionViewLayout: layout)
        navigationController?.pushViewController(friendsController, animated: true)
    }
    
    func showCamera(){
        let cameraController = SelectCameraController()
        present(cameraController, animated: true, completion: nil)
    }
    
    @objc func handleSettings() {
        let customAlert = CustomSettingsView()
        customAlert.providesPresentationContextTransitionStyle = true
        customAlert.definesPresentationContext = true
        customAlert.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        customAlert.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        self.showDetailViewController(customAlert, sender: self)
        
    }
    
    func showNotifications() {
        let layout = UICollectionViewFlowLayout()
        let notificationController = NotificationController(collectionViewLayout: layout)
        navigationController?.pushViewController(notificationController, animated: true)
    }
    
    func profilePostTapped() {
        handleChangeToDetail(viewType: "isImageDetail")
    }
    
    func profilePostHeld() {
        
    }
    
    func handleChangeToDetail(viewType : String) {
        let detail = PursuitsDetailController(collectionViewLayout: UICollectionViewFlowLayout())
        navigationController?.pushViewController(detail, animated: true)
    }
}

extension ProfileController {
    
    // MARK: - Setup View
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch indexPath.item {
        case 0:
            if let bio = user?.bio {
                let approximateWidthOfBio = view.frame.width - 28
                let size = CGSize(width: approximateWidthOfBio, height: .infinity)
                let attributes = [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 12)]
                let estimatedFrame = NSString(string: bio).boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: attributes, context: nil)
                return CGSize(width: view.frame.width, height: estimatedFrame.height + 120)
            }
            return CGSize(width: view.frame.width, height: 155)
        case 1:
            return CGSize(width: view.frame.width, height: 465)
        default:
            assert(false, "Not a valid row")
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.item {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: peopleId, for: indexPath) as! ProfileAboutRow
            cell.accessProfileController = self
            cell.user = user
            return cell
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: pursuitsId, for: indexPath) as! ProfilePursuit
            cell.accessProfileController = self
            cell.user = user
            return cell
        default:
            assert(false, "Not a valid row")
        }
    }
}
