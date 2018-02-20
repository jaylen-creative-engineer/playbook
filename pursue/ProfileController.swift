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

class ProfileController : UICollectionViewController, UICollectionViewDelegateFlowLayout, ProfileHeaderDelegate, ProfilePursuitsRowDelegate, ProfilePostDelegate, ProfilePrincipleDelegate, ProfileDiscussionDelegate {
        
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
    
    lazy var cameraIcon : UIImageView = {
        let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "add").withRenderingMode(.alwaysOriginal)
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFill
        iv.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(switchToCamera)))
        return iv
    }()
    
    lazy var homeIcon : UIImageView = {
        let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "Pursuit-typed").withRenderingMode(.alwaysOriginal)
        iv.contentMode = .scaleAspectFill
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    lazy var searchIcon : UIImageView = {
        let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "search_selected").withRenderingMode(.alwaysOriginal)
        iv.contentMode = .scaleAspectFill
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.isUserInteractionEnabled = true
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleShowSearch))
        tap.numberOfTapsRequired = 1
        iv.addGestureRecognizer(tap)
        return iv
    }()
    
    @objc func handleShowSearch(){
        let layout = UICollectionViewFlowLayout()
        let searchController = SearchController(collectionViewLayout: layout)
        navigationController?.present(searchController, animated: true, completion: nil)
    }
    
    @objc func switchToCamera() {
        let layout = UICollectionViewFlowLayout()
        let cameraController = SelectCameraController(collectionViewLayout: layout)
        navigationController?.present(cameraController, animated: true, completion: nil)
    }
    
    let backgroundFill = UIView()
    
    private func setupTopBar(){
        let guide = view.safeAreaLayoutGuide
        view.addSubview(backgroundFill)
        view.addSubview(homeIcon)
        view.addSubview(cameraIcon)
        view.addSubview(searchIcon)
        
        backgroundFill.backgroundColor = .white
        backgroundFill.anchor(top: view.topAnchor, left: guide.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: (view.frame.height / 8.5) - 5)
        homeIcon.anchor(top: nil, left: backgroundFill.leftAnchor, bottom: backgroundFill.bottomAnchor, right: nil, paddingTop: 8, paddingLeft: 28, paddingBottom: 14, paddingRight: 0, width: 50, height: 18)
        cameraIcon.anchor(top: nil, left: nil, bottom: backgroundFill.bottomAnchor, right: backgroundFill.rightAnchor, paddingTop: 8, paddingLeft: 0, paddingBottom: 14, paddingRight: 22, width: 18, height: 16)
        searchIcon.anchor(top: nil, left: nil, bottom: backgroundFill.bottomAnchor, right: cameraIcon.leftAnchor, paddingTop: 8, paddingLeft: 0, paddingBottom: 14, paddingRight: 24, width: 18, height: 16)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBarController?.navigationController?.navigationBar.isHidden = true
        collectionView?.register(ProfilePursuitsRow.self, forCellWithReuseIdentifier: pursuitsId)
        collectionView?.register(ProfilePostRow.self, forCellWithReuseIdentifier: postId)
        collectionView?.register(ProfileAddedRow.self, forCellWithReuseIdentifier: addedId)
        collectionView?.register(ProfilePrincipleRow.self, forCellWithReuseIdentifier: principleId)
        collectionView?.register(ProfileDiscussion.self, forCellWithReuseIdentifier: discussionId)
        collectionView?.register(ProfileHeader.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerId)
        collectionView?.backgroundColor = .white
        collectionView?.contentInset = UIEdgeInsetsMake(0, 0, 105, 0)
        
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
    
    func handleSettings() {
        let layout = UICollectionViewLayout()
        let settingsController = SettingsController(collectionViewLayout: layout)
        navigationController?.pushViewController(settingsController, animated: true)
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
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath) as! ProfileHeader
        header.user = user
        header.delegate = self
        header.accessProfileController = self
        
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if let user = self.user {
            let approximateWidthOfBio = view.frame.width - 24 - 8
            let size = CGSize(width: approximateWidthOfBio, height: .infinity)
            let attributes = [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 12)]
            let estimatedFrame = NSString(string: user.bio).boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: attributes, context: nil)
            return CGSize(width: view.frame.width, height: estimatedFrame.height + 270)
        }
        
        return CGSize(width: view.frame.width, height: (view.frame.height / 2.5) - 15)
    }
    
    // MARK: - Setup View
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        switch indexPath.item {
        case 0:
            return CGSize(width: view.frame.width, height: 445)
        case 1:
            return CGSize(width: view.frame.width, height: 205)
        case 2:
            return CGSize(width: view.frame.width, height: 370)
        case 3:
            return CGSize(width: view.frame.width, height: 330)
        default:
            assert(false, "Not a valid cell")
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(24, 0, 0, 0)
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch indexPath.item {
        case 0:
            let postCell = collectionView.dequeueReusableCell(withReuseIdentifier: postId, for: indexPath) as! ProfilePostRow
            postCell.delegate = self
            postCell.accessProfileController = self
            return postCell
            
        case 1:
            let addedCell = collectionView.dequeueReusableCell(withReuseIdentifier: addedId, for: indexPath) as! ProfileAddedRow
            return addedCell
        case 2:
            let pursuitCell = collectionView.dequeueReusableCell(withReuseIdentifier: pursuitsId, for: indexPath) as! ProfilePursuitsRow
            pursuitCell.delegate = self
            pursuitCell.accessProfileController = self
            return pursuitCell
        case 3:
            let principleCell = collectionView.dequeueReusableCell(withReuseIdentifier: principleId, for: indexPath) as! ProfilePrincipleRow
            principleCell.delegate = self
            principleCell.accessProfileController = self
            return principleCell
        default:
            assert(false, "Not a valid row")
        }
    }
}
