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
//        iv.image = #imageLiteral(resourceName: "music").withRenderingMode(.alwaysOriginal)
        iv.clipsToBounds = true
        return iv
    }()
    
    @objc func handleShowSearch(){
        let layout = UICollectionViewFlowLayout()
        let searchController = SearchController(collectionViewLayout: layout)
        navigationController?.present(searchController, animated: true, completion: nil)
    }
    
    let backgroundFill = UIView()
    
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
 
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "music").withRenderingMode(.alwaysOriginal)
        imageView.contentMode = .scaleAspectFill
        
        collectionView?.parallaxHeader.view = imageView
        collectionView?.parallaxHeader.height = view.frame.height / 2
        collectionView?.parallaxHeader.minimumHeight = 0
        collectionView?.parallaxHeader.mode = .topFill
        
        setupTopBar()
        getUser()
    }
    
    var user : User?

    
    func getUser(){
        
        let url = "https://pursuit-jaylenhu27.c9users.io/user"
        var parameters = Alamofire.Parameters()
        guard let userId = Auth.auth().currentUser?.uid else { return }
        parameters["userId"] = userId
        
        Alamofire.request(url, method: .get, parameters: parameters, encoding: URLEncoding.default).responseJSON { response in
            switch response.result {
            case .success:
                guard let dictionaries = response.result.value as? [Dictionary<String,AnyObject>] else { return }
                for dictionary in dictionaries {
                    let person = User(dictionary: dictionary)
                    self.user = person
                    self.collectionView?.reloadData()
                }
            case .failure:
                print("Failure: \(response.result.isSuccess)")
            }
            
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
    
    func profileDiscussionTapped() {
        handleChangeToDetail(viewType: "isDiscussionDetail")
    }
    
    func profileDiscussionHeld() {
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
    
    
    @objc func handleSettings() {
        let customAlert = CustomSettingsView()
        customAlert.providesPresentationContextTransitionStyle = true
        customAlert.definesPresentationContext = true
        customAlert.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        customAlert.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        self.present(customAlert, animated: true, completion: nil)
        
    }
    
    func showNotifications() {
        let layout = UICollectionViewLayout()
        let notificationController = NotificationController(collectionViewLayout: layout)
        navigationController?.pushViewController(notificationController, animated: true)
    }

    func pursuitClicked() {
        handleChangeToDetail(viewType: "isPursuitDetail")
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
    
    func profilePrincipleTapped() {
        handleChangeToDetail(viewType: "isPrinciplesDetail")
    }
    
    func profilePrincipleHeld() {
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
    
    func handleChangeToDetail(viewType : String) {
        switch viewType {
        case "isPrinciplesDetail":
            let detail = PursuitsDetailController(collectionViewLayout: UICollectionViewFlowLayout())
            detail.principleView()
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
            let feed = HomeController(collectionViewLayout: UICollectionViewFlowLayout())
            feed.principleView()
            navigationController?.pushViewController(feed, animated: true)
        case "isPursuitFeed":
            let feed = HomeController(collectionViewLayout: UICollectionViewFlowLayout())
            feed.pursuitView()
            navigationController?.pushViewController(feed, animated: true)
        case "isImageFeed":
            let feed = HomeController(collectionViewLayout: UICollectionViewFlowLayout())
            feed.imageView(isExplore: true)
            navigationController?.pushViewController(feed, animated: true)
        default:
            assert(false, "Not a valid view type")
        }
    }
    
    var headerHeight : CGFloat?
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
        return cell
    }
}
