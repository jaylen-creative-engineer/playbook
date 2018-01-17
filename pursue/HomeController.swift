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
    var messageController : MessagesController?
    var categoryDetailController : CategoryDetailController?
    
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
        handleChangeToDetail(viewType: "isDiscussionDetail")
    }
    
    func homeDiscussionHeld() {
        let actionController = SkypeActionController()
        actionController.addAction(Action("Save", style: .default, handler: { action in
            // do something useful
        }))
        actionController.addAction(Action("Like", style: .default, handler: { action in
            // do something useful
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
    
    func categoryClicked() {
        let layout = UICollectionViewFlowLayout()
        let categoryDetailController = CategoryDetailController(collectionViewLayout: layout)
        navigationController?.pushViewController(categoryDetailController, animated: true)
    }
    
    func rowImageHeld() {
        let actionController = SkypeActionController()
        actionController.addAction(Action("Save", style: .default, handler: { action in
            // do something useful
        }))
        actionController.addAction(Action("Like", style: .default, handler: { action in
            // do something useful
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
    
    func principleTapped() {
        handleChangeToDetail(viewType: "isPrinciplesDetail")
    }
    
    func principleHeld() {
        let actionController = SkypeActionController()
        actionController.addAction(Action("Save", style: .default, handler: { action in
            // do something useful
        }))
        actionController.addAction(Action("Like", style: .default, handler: { action in
            // do something useful
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
    
    func rowImageTapped() {
        handleChangeToDetail(viewType: "isImageDetail")
    }
    
    func feedChangeTapped() {
        let layout = UICollectionViewFlowLayout()
        let feedController = FeedController(collectionViewLayout: layout)
        navigationController?.pushViewController(feedController, animated: true)
    }
    
    func pursuitClicked() {
       handleChangeToDetail(viewType: "isPursuitDetail")
    }
    
    func showPrinciplesFeed() {
        let layout = UICollectionViewFlowLayout()
        let feedController = FeedController(collectionViewLayout: layout)
        navigationController?.pushViewController(feedController, animated: true)
    }
    
    func pursuitHeld() {
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
        setupMenuBar()
        setupCollectionView()
        setupFloatingCamera()
        scrollToMenuIndex(menuIndex: 1)
        
        categoryDetailController?.homeController = self
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
        present(MessagesController(), animated: true) {
            self.messageController?.fetchUserAndSetupNavBarTitle()
        }
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
    
    func handleChangeToDetail(viewType : String) {
        switch viewType {
        case "isPrinciplesDetail":
            let detail = PursuitsDetailController(collectionViewLayout: UICollectionViewFlowLayout())
            detail.principleView()
            print("isPrinciple")
            navigationController?.pushViewController(detail, animated: true)
        case "isPursuitDetail":
            let detail = PursuitsDetailController(collectionViewLayout: UICollectionViewFlowLayout())
            detail.pursuitView()
            navigationController?.pushViewController(detail, animated: true)
        case "isImageDetail":
            let detail = PursuitsDetailController(collectionViewLayout: UICollectionViewFlowLayout())
            detail.imageView()
            navigationController?.pushViewController(detail, animated: true)
        case "isDiscussionDetail":
            let detail = PursuitsDetailController(collectionViewLayout: UICollectionViewFlowLayout())
            detail.discussionView()
            navigationController?.pushViewController(detail, animated: true)
        default:
            assert(false, "Not a valid view type")
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
