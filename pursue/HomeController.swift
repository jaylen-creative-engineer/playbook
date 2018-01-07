//
//  HomeController.swift
//  pursue
//
//  Created by Jaylen Sanders on 9/11/17.
//  Copyright © 2017 Glory. All rights reserved.
//

import UIKit
import XLActionController
import Firebase

class HomeController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    let cellId = "cellId"
    let secondaryId = "secondaryId"
    let customRowId = "customRowId"
    let headerId = "headerId"
    var delegate : HomeHeaderDelegate?
    
    lazy var menuBar: MenuBar = {
        let mb = MenuBar()
        mb.homeController = self
        return mb
    }()
    
    lazy var floatingCamera : UIButton = {
       let button = UIButton()
        button.backgroundColor = .white
        button.layer.cornerRadius = 30
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(switchToCamera), for: .touchUpInside)
        return button
    }()
    
    lazy var cameraIcon : UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "camera_icon")?.withRenderingMode(.alwaysOriginal)
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFill
        iv.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(switchToCamera)))
        return iv
    }()
    
    func homeDiscussionTapped() {
        let layout = UICollectionViewFlowLayout()
        let profileDiscussionController = DiscussionDetailController(collectionViewLayout: layout)
        navigationController?.pushViewController(profileDiscussionController, animated: true)
    }
    
    func homeDiscussionHeld() {
        let actionController = SkypeActionController()
        actionController.addAction(Action("SAVE", style: .default, handler: { action in
            // do something useful
        }))
        actionController.addAction(Action("LIKE", style: .default, handler: { action in
            // do something useful
        }))
        actionController.addAction(Action("SHARE", style: .default, handler: { action in
            // do something useful
        }))
        actionController.addAction(Action("CANCEL", style: .default, handler: {action in
            
        }))
        present(actionController, animated: true, completion: nil)
    }
    
    func categoryClicked() {
        let layout = UICollectionViewFlowLayout()
        let categoryDetailController = CategoryDetailController(collectionViewLayout: layout)
        navigationController?.pushViewController(categoryDetailController, animated: true)
    }
    
    func rowImageHeld() {
        let actionController = SkypeActionController()
        actionController.addAction(Action("SAVE", style: .default, handler: { action in
            // do something useful
        }))
        actionController.addAction(Action("LIKE", style: .default, handler: { action in
            // do something useful
        }))
        actionController.addAction(Action("SHARE", style: .default, handler: { action in
            // do something useful
        }))
        actionController.addAction(Action("CANCEL", style: .default, handler: {action in
            
        }))
        present(actionController, animated: true, completion: nil)
    }
    
    func principleTapped() {
        let layout = UICollectionViewFlowLayout()
        let principleDetailController = PrincipleDetailController(collectionViewLayout: layout)
        navigationController?.pushViewController(principleDetailController, animated: true)
    }
    
    func principleHeld() {
        let actionController = SkypeActionController()
        actionController.addAction(Action("SAVE", style: .default, handler: { action in
            // do something useful
        }))
        actionController.addAction(Action("LIKE", style: .default, handler: { action in
            // do something useful
        }))
        actionController.addAction(Action("SHARE", style: .default, handler: { action in
            // do something useful
        }))
        actionController.addAction(Action("CANCEL", style: .default, handler: {action in
            
        }))
        present(actionController, animated: true, completion: nil)
    }
    
    func rowImageTapped() {
        let layout = UICollectionViewFlowLayout()
        let postDetailController = PostDetailController(collectionViewLayout: layout)
        navigationController?.pushViewController(postDetailController, animated: true)
    }
    
    func feedChangeTapped() {
        let layout = UICollectionViewFlowLayout()
        let feedController = FeedController(collectionViewLayout: layout)
        navigationController?.pushViewController(feedController, animated: true)
    }
    
    func pursuitClicked() {
        let layout = UICollectionViewFlowLayout()
        let pursuitDetailController = PursuitsDetailController(collectionViewLayout: layout)
        navigationController?.pushViewController(pursuitDetailController, animated: true)
    }
    
    func showPrinciplesFeed() {
        let layout = UICollectionViewFlowLayout()
        let feedController = FeedController(collectionViewLayout: layout)
        navigationController?.pushViewController(feedController, animated: true)
    }
    
    func pursuitHeld() {
        let actionController = SkypeActionController()
        actionController.addAction(Action("SAVE", style: .default, handler: { action in
            // do something useful
        }))
        actionController.addAction(Action("LIKE", style: .default, handler: { action in
            // do something useful
        }))
        actionController.addAction(Action("SHARE", style: .default, handler: { action in
            // do something useful
        }))
        actionController.addAction(Action("CANCEL", style: .default, handler: {action in
            
        }))
        present(actionController, animated: true, completion: nil)
    }
    
    lazy var profileLauncher: CategoryDetailController = {
        let launcher = CategoryDetailController()
        launcher.homeController = self
        return launcher
    }()
    
    func showUserProfile() {
        scrollToMenuIndex(menuIndex: 2)
    }
    
    @objc func switchToCamera() {
        let layout = UICollectionViewFlowLayout()
        let cameraController = SelectCameraController(collectionViewLayout: layout)
        navigationController?.present(cameraController, animated: true, completion: nil)
    }
    
    let exploreId = "exploreId"
    let profileId = "profileId"
    
    private func setupFloatingCamera(){
        let guide = view.safeAreaLayoutGuide
        view.addSubview(floatingCamera)
        floatingCamera.addSubview(cameraIcon)
        
        floatingCamera.anchor(top: nil, left: nil, bottom: guide.bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 12, paddingRight: 0, width: 60, height: 60)
        floatingCamera.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        cameraIcon.anchor(top: nil, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 25, height: 25)
        cameraIcon.centerXAnchor.constraint(equalTo: floatingCamera.centerXAnchor).isActive = true
        cameraIcon.centerYAnchor.constraint(equalTo: floatingCamera.centerYAnchor).isActive = true
    }
    
    private func setupMenuBar() {
        let guide = view.safeAreaLayoutGuide
       view.addSubview(menuBar)
       menuBar.anchor(top: guide.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 55)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.isNavigationBarHidden = true
        setupCollectionView()
        setupMenuBar()
        setupFloatingCamera()
        scrollToMenuIndex(menuIndex: 1)
        
        if Auth.auth().currentUser == nil {
            DispatchQueue.main.async {
                let loginController = LoginController()
                let navController = UINavigationController(rootViewController: loginController)
                self.present(navController, animated: true, completion: nil)
                
            }
            return
        }
    }

    func setupCollectionView(){
        if let flowLayout = collectionView?.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.scrollDirection = .horizontal
            flowLayout.minimumLineSpacing = 0
        }
        
        collectionView?.backgroundColor = .white
        collectionView?.isScrollEnabled = false
        collectionView?.register(HomeRowContainer.self, forCellWithReuseIdentifier: cellId)
        collectionView?.register(ExploreContainer.self, forCellWithReuseIdentifier: exploreId)
        collectionView?.register(ProfileContainer.self, forCellWithReuseIdentifier: profileId)
        collectionView?.isPagingEnabled = true
    }
    
    func scrollToMenuIndex(menuIndex: Int) {
        let indexPath = IndexPath(item: menuIndex, section: 0)
        collectionView?.scrollToItem(at: indexPath, at: [], animated: false)
    }
    
    func showChat() {
        let layout = UICollectionViewLayout()
        let messageController = MessagesController(collectionViewLayout: layout)
        navigationController?.pushViewController(messageController, animated: true)
    }
    
    func showSettings() {
        let layout = UICollectionViewLayout()
        let settingsController = SettingsController(collectionViewLayout: layout)
        navigationController?.pushViewController(settingsController, animated: true)
    }
    
    // MARK: - Setup View
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch indexPath.item {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: exploreId, for: indexPath) as! ExploreContainer
            cell.homeController = self
            return cell
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! HomeRowContainer
            cell.homeController = self
            return cell
        case 2:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: profileId, for: indexPath) as! ProfileContainer
            cell.homeController = self
            return cell
        default:
            assert(false)
        }
    }
    
    func handleChangeToFeed(viewType : String) {
        switch viewType {
        case "isPrinciplesFeed":
            let feed = FeedController(collectionViewLayout: UICollectionViewFlowLayout())
            feed.principleView()
            navigationController?.pushViewController(feed, animated: true)
        case "isPursuitFeed":
            let feed = FeedController(collectionViewLayout: UICollectionViewFlowLayout())
            feed.pursuitView()
            navigationController?.pushViewController(feed, animated: true)
        case "isImageFeed":
            let feed = FeedController(collectionViewLayout: UICollectionViewFlowLayout())
            feed.imageView()
            navigationController?.pushViewController(feed, animated: true)
        case "isDiscussionFeed":
            let feed = FeedController(collectionViewLayout: UICollectionViewFlowLayout())
            feed.discussionView()
            navigationController?.pushViewController(feed, animated: true)
        default:
            let feed = FeedController(collectionViewLayout: UICollectionViewFlowLayout())
            navigationController?.pushViewController(feed, animated: true)
        }
    }
    
}
