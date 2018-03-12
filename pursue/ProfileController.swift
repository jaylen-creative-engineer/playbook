//
//  ProfileContainer.swift
//  pursue
//
//  Created by Jaylen Sanders on 11/27/17.
//  Copyright © 2017 Glory. All rights reserved.
//

import UIKit
import XLActionController
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
    
    let backgroundFill = UIView()
    var user : User?
    var pursuits = [Pursuit]()
    var followers = [Follower]()
    let imageView = UIImageView()
    let profileService = ProfileServices()
    
    private func setupTopBar(){
        view.addSubview(topBackground)
        topBackground.addSubview(optionButton)
        
        topBackground.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: nil, bottom: nil, right: view.safeAreaLayoutGuide.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 12, width: 30, height: 30)
        
        optionButton.anchor(top: nil, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: optionButton.intrinsicContentSize.width, height: optionButton.intrinsicContentSize.height)
        optionButton.centerXAnchor.constraint(equalTo: topBackground.centerXAnchor).isActive = true
        optionButton.centerYAnchor.constraint(equalTo: topBackground.centerYAnchor).isActive = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBarController?.navigationController?.navigationBar.isHidden = true
        collectionView?.register(ProfileAboutRow.self, forCellWithReuseIdentifier: peopleId)

        collectionView?.backgroundColor = .white
        collectionView?.contentInset = UIEdgeInsetsMake(0, 0, 105, 0)
        collectionView?.showsVerticalScrollIndicator = false
 
        imageView.image = #imageLiteral(resourceName: "music").withRenderingMode(.alwaysOriginal)
        imageView.contentMode = .scaleAspectFill
        
        collectionView?.parallaxHeader.view = imageView
        collectionView?.parallaxHeader.height = view.frame.height / 2
        collectionView?.parallaxHeader.minimumHeight = 0
        collectionView?.parallaxHeader.mode = .topFill
        
        setupTopBar()
        getUser()
    }
    
    func getUser(){
//        profileService.getAccount { (user, follower, pursuit) in
//            self.user = user
//            self.followers =
//            self.pursuits = 
//        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
    func showFriendsController(){
        let layout = UICollectionViewFlowLayout()
        let friendsController = FriendsController(collectionViewLayout: layout)
        navigationController?.pushViewController(friendsController, animated: true)
    }
    
    @objc func handleSettings() {
        let customAlert = CustomSettingsView()
        customAlert.providesPresentationContextTransitionStyle = true
        customAlert.definesPresentationContext = true
        customAlert.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        customAlert.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        self.present(customAlert, animated: true, completion: nil)
        
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
        let actionController = SkypeActionController()
        actionController.addAction(Action("Save", style: .default, handler: { action in
            
        }))
        actionController.addAction(Action("Like", style: .default, handler: { action in
            
        }))
        actionController.addAction(Action("Share", style: .default, handler: { action in
            let text = "This is some text that I want to share."
            let textToShare = [ text ]
            let activityViewController = UIActivityViewController(activityItems: textToShare, applicationActivities: nil)
            activityViewController.popoverPresentationController?.sourceView = self.view
            self.present(activityViewController, animated: true, completion: nil)
        }))
        
        actionController.addAction(Action("Cancel", style: .default, handler: {action in
            
        }))
        present(actionController, animated: true, completion: nil)
        
    }
    
    func handleChangeToDetail(viewType : String) {
        let detail = PursuitsDetailController(collectionViewLayout: UICollectionViewFlowLayout())
        navigationController?.pushViewController(detail, animated: true)
    }
}

extension ProfileController {
    
    // MARK: - Setup View
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height - 32)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: peopleId, for: indexPath) as! ProfileAboutRow
        cell.accessProfileController = self
        return cell
    }
}
