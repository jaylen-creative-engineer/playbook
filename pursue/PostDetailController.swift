//
//  PostDetail.swift
//  pursue
//
//  Created by Jaylen Sanders on 10/12/17.
//  Copyright © 2017 Glory. All rights reserved.
//

import UIKit
import XLActionController

class PostDetailController : UICollectionViewController, UICollectionViewDelegateFlowLayout, PostDetailHeaderDelegate {
    
    let headerId = "headerId"
    let commentId = "commentId"
    let likeId = "likeId"
    let postId = "postId"
    let relatedId = "relatedId"
    var isAboutView = true
    var isCommentsView = false
    var isRelatedView = false
    var isLikesView = false
    
    func goBack() {
        navigationController?.popViewController(animated: true)
    }
    
    func didChangeToCommentsView() {
        isAboutView = false
        isCommentsView = true
        isRelatedView = false
        isLikesView = false
        
        collectionView?.reloadData()
    }
    
    func didChangeToLikesView() {
        isAboutView = false
        isCommentsView = false
        isRelatedView = false
        isLikesView = true
        
        collectionView?.reloadData()
    }
    
    func didChangeToRelatedView() {
        isAboutView = false
        isCommentsView = false
        isRelatedView = true
        isLikesView = false
        
        collectionView?.reloadData()
    }
    
    func didChangeToAboutView() {
        isAboutView = true
        isCommentsView = false
        isRelatedView = false
        isLikesView = false
        
        collectionView?.reloadData()
    }
    
    func changeToExplore() {
        let layout = UICollectionViewFlowLayout()
        let goToHomeController = HomeController(collectionViewLayout: layout)
        goToHomeController.scrollToMenuIndex(menuIndex: 0)
        navigationController?.pushViewController(goToHomeController, animated: true)
    }
    
    func changeToHome() {
        let layout = UICollectionViewFlowLayout()
        let goToHomeController = HomeController(collectionViewLayout: layout)
        goToHomeController.scrollToMenuIndex(menuIndex: 1)
        navigationController?.pushViewController(goToHomeController, animated: true)
    }
    
    func changeToProfile() {
        let layout = UICollectionViewFlowLayout()
        let goToHomeController = HomeController(collectionViewLayout: layout)
        goToHomeController.scrollToMenuIndex(menuIndex: 2)
        navigationController?.pushViewController(goToHomeController, animated: true)
    }
    
    let cellId = "cellId"
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height)
    }
    
    lazy var homeIcon : UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(#imageLiteral(resourceName: "home").withRenderingMode(.alwaysTemplate), for: .normal)
        button.contentMode = .scaleAspectFit
        button.addTarget(self, action: #selector(homeActive), for: .touchUpInside)
        button.tintColor = UIColor.rgb(red: 128, green: 128, blue: 128)
        return button
    }()
    
    lazy var exploreIcon : UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(#imageLiteral(resourceName: "explore_icon").withRenderingMode(.alwaysTemplate), for: .normal)
        button.contentMode = .scaleAspectFit
        button.addTarget(self, action: #selector(exploreActive), for: .touchUpInside)
        button.tintColor = UIColor.rgb(red: 128, green: 128, blue: 128)
        return button
    }()
    
    lazy var profileIcon : UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(#imageLiteral(resourceName: "samuel-l").withRenderingMode(.alwaysOriginal), for: .normal)
        button.contentMode = .scaleAspectFit
        button.layer.cornerRadius = 12.5
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(profileActive), for: .touchUpInside)
        button.tintColor = UIColor.rgb(red: 128, green: 128, blue: 128)
        return button
    }()
    
    lazy var backButton : UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "back-arrow").withRenderingMode(.alwaysOriginal), for: .normal)
        button.addTarget(self, action: #selector(dismissView), for: .touchUpInside)
        return button
    }()
    
    @objc func exploreActive(){
        changeToExplore()
        homeIcon.tintColor = UIColor.rgb(red: 128, green: 128, blue: 128)
        exploreIcon.tintColor = UIColor.black
    }
    
    @objc func homeActive(){
        changeToHome()
        homeIcon.tintColor = UIColor.black
        exploreIcon.tintColor = UIColor.rgb(red: 128, green: 128, blue: 128)
    }
    
    
    @objc func profileActive(){
        changeToProfile()
    }
    
    
    @objc func dismissView(){
        goBack()
    }
    
    func setupTopNavBar(){
        let backgroundBar = UIView()
        backgroundBar.backgroundColor = .white
        
        view.addSubview(backgroundBar)
        backgroundBar.addSubview(backButton)
        backgroundBar.addSubview(profileIcon)
        backgroundBar.addSubview(homeIcon)
        backgroundBar.addSubview(exploreIcon)
        
        backgroundBar.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 88)
        backButton.anchor(top: nil, left: backgroundBar.leftAnchor, bottom: backgroundBar.bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 12, paddingBottom: 16, paddingRight: 0, width: 20, height: 20)
        profileIcon.anchor(top: nil, left: nil, bottom: nil, right: backgroundBar.rightAnchor, paddingTop: 8, paddingLeft: 0, paddingBottom: 0, paddingRight: 18, width: 25.5, height: 25)
        profileIcon.centerYAnchor.constraint(equalTo: backButton.centerYAnchor).isActive = true
        homeIcon.anchor(top: nil, left: nil, bottom: nil, right: profileIcon.leftAnchor, paddingTop: 8, paddingLeft: 0, paddingBottom: 0, paddingRight: 24, width: 28, height: 25)
        homeIcon.centerYAnchor.constraint(equalTo: backButton.centerYAnchor).isActive = true
        exploreIcon.anchor(top: nil, left: nil, bottom: nil, right: homeIcon.leftAnchor, paddingTop: 8, paddingLeft: 0, paddingBottom: 0, paddingRight: 24, width: 25, height: 25)
        exploreIcon.centerYAnchor.constraint(equalTo: backButton.centerYAnchor).isActive = true
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let isTrue = true
        
        switch isTrue {
        case isAboutView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: postId, for: indexPath) as! PostView
            return cell
        case isCommentsView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: commentId, for: indexPath) as! PostComments
            cell.accessDetailController = self
            return cell
        case isLikesView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: likeId, for: indexPath) as! PostLikes
            cell.accessDetailController = self
            return cell
        case isRelatedView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: relatedId, for: indexPath) as! RelatedPost
            cell.accessDetailController = self
            return cell
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: postId, for: indexPath) as! PostView
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width - 10, height: (view.frame.height / 2) - 5)
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath) as! PostDetailHeader
        header.postDetailDelegate = self
        header.postDetailController = self
        return header
    }
    
    func handleMessage(for cell: PostDetailHeader) {
        let messageController = MessagesController()
        let navController = UINavigationController(rootViewController: messageController)
        present(navController, animated: true, completion: nil)
    }
    
    func showUserProfile(){
//        let userProfileController = ProfileController(collectionViewLayout: UICollectionViewFlowLayout())
//        navigationController?.pushViewController(userProfileController, animated: true)
    }
    
    func showPostDetail(){
        let layout = UICollectionViewFlowLayout()
        let postDetilController = PostDetailController(collectionViewLayout: layout)
        navigationController?.pushViewController(postDetilController, animated: true)
    }
    
    func reportPost() {
        let actionController = SkypeActionController()
        actionController.addAction(Action("REPORT", style: .default, handler: { action in
            // do something useful
        }))
        actionController.addAction(Action("CANCEL", style: .default, handler: {action in
            
        }))
        present(actionController, animated: true, completion: nil)
    }
    
    func setupView(){
        collectionView?.register(PostView.self, forCellWithReuseIdentifier: postId)
        collectionView?.register(PostLikes.self, forCellWithReuseIdentifier: likeId)
        collectionView?.register(RelatedPost.self, forCellWithReuseIdentifier: relatedId)
        collectionView?.register(PostComments.self, forCellWithReuseIdentifier: commentId)
        collectionView?.register(PostDetailHeader.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerId)
        collectionView?.backgroundColor = .white
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTopNavBar()
        setupView()
    }
}
