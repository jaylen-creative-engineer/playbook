//
//  DiscussionDetailController.swift
//  pursue
//
//  Created by Jaylen Sanders on 12/9/17.
//  Copyright © 2017 Glory. All rights reserved.
//

import UIKit
import XLActionController

class DiscussionDetailController : UICollectionViewController, UICollectionViewDelegateFlowLayout, DiscussionDetailDelegate {
    
    let headerId = "headerId"
    let commentId = "commentId"
    let likeId = "likeId"
    let postId = "postId"
    let relatedId = "relatedId"
    let principleId = "principleId"
    let pursuitsId = "pursuitsId"
    var isAboutView = true
    var isCommentsView = false
    var isPursuitsView = false
    var isPrinciplesView = false
    
    lazy var backButton : UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "back-arrow").withRenderingMode(.alwaysOriginal), for: .normal)
        button.addTarget(self, action: #selector(dismissView), for: .touchUpInside)
        return button
    }()
    
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
    
    func goBack() {
        navigationController?.popViewController(animated: true)
    }
    
    func pursuitsActive() {
        isAboutView = false
        isCommentsView = false
        isPursuitsView = true
        isPrinciplesView = false
        collectionView?.reloadData()
    }
    
    func principlesActive() {
        isAboutView = false
        isCommentsView = false
        isPursuitsView = false
        isPrinciplesView = true
        collectionView?.reloadData()
    }
    
    func changeAbout() {
        isAboutView = true
        isCommentsView = false
        isPursuitsView = false
        isPrinciplesView = false
        collectionView?.reloadData()
    }
    
    func changeComment() {
        isAboutView = false
        isCommentsView = true
        isPursuitsView = false
        isPrinciplesView = false
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
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let isTrue = true
        
        switch isTrue {
        case isAboutView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: postId, for: indexPath) as! PostView
            return cell
        case isCommentsView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: commentId, for: indexPath) as! PostComments
            return cell
        case isPursuitsView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: pursuitsId, for: indexPath) as! DiscussionPursuitsView
            return cell
        case isPrinciplesView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: principleId, for: indexPath) as! PursuitDiscussion
            return cell
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: postId, for: indexPath) as! PostView
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width - 10, height: (view.frame.height / 2) + 100)
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath) as! DiscussionDetailHeader
        header.delegate = self
        header.detailController = self
        return header
    }
    
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
    
    func setupNavBar(){
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
    
    func showUserProfile(){
    
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
        collectionView?.register(PostComments.self, forCellWithReuseIdentifier: commentId)
        collectionView?.register(DiscussionPursuitsView.self, forCellWithReuseIdentifier: pursuitsId)
        collectionView?.register(PursuitDiscussion.self, forCellWithReuseIdentifier: principleId)
        collectionView?.register(DiscussionDetailHeader.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerId)
        collectionView?.backgroundColor = .white
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        setupView()
    }
}
