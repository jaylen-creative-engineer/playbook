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

class ProfileController : UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    let peopleId = "peopleId"
    let pursuitsId = "pursuitsId"
    let principleId = "principleId"
    let headerId = "headerId"
    let stepId = "stepId"
    
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
    var pursuits : [Pursuit]?
    var followers : [Follower]?
    let profileService = ProfileServices()
    
    func changeToInterests(){
        let interest = InterestsController(collectionViewLayout: UICollectionViewFlowLayout())
        navigationController?.pushViewController(interest, animated: true)
    }
    
    func goToNotifications(){
        let view = NotificationsContainer(collectionViewLayout: UICollectionViewFlowLayout())
        navigationController?.pushViewController(view, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBarController?.navigationController?.navigationBar.isHidden = true
        collectionView?.register(ProfileHeader.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerId)
        collectionView?.register(ProfilePursuit.self, forCellWithReuseIdentifier: pursuitsId)
        collectionView?.backgroundColor = .white
        collectionView?.showsVerticalScrollIndicator = false
        getUser()
    }
    
    var pursuit : Pursuit?
    func getUser(){
        profileService.getAccount { (user) in
            DispatchQueue.main.async {
                self.followers = user.followees
                self.pursuits = user.pursuits
                
//                self.user = user
//                guard let photoUrl = user.photoUrl else { return }
//                self.imageView.loadImage(urlString: photoUrl)
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
    
    func profilePostTapped() {
        handleChangeToDetail(viewType: "isImageDetail")
    }
    
    func profilePostHeld() {
        
    }
    
    func handleChangeToDetail(viewType : String) {
        let detail = PostDetailController()
        navigationController?.pushViewController(detail, animated: true)
    }
}

extension ProfileController {
        
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: (view.frame.height / 2) + 55)
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let cell = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath) as! ProfileHeader
        cell.accessProfileController = self
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height / 2.5)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: pursuitsId, for: indexPath) as! ProfilePursuit
        return cell
    }
}
