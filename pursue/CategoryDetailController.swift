//
//  CategoryDetailController.swift
//  pursue
//
//  Created by Jaylen Sanders on 10/26/17.
//  Copyright © 2017 Glory. All rights reserved.
//

import UIKit
import XLActionController

class CategoryDetailController : UICollectionViewController, UICollectionViewDelegateFlowLayout, CategoryHeaderDelegate {
    
    let headerId = "headerId"
    let cellId = "cellId"
    let peopleId = "peopleId"
    let exerciseId = "exerciseId"
    let challengeId = "challengeId"
    let toolId = "toolId"
    let categoryId = "cateogryId"
    let principleId = "principleId"
    let discussionId = "discussionId"
    var categoryDelegate : CategoryHeaderDelegate?
    
    let pageTitle : UILabel = {
        let label = UILabel()
        label.text = "ANIMALS"
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let titleUnderline : UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        return view
    }()
    
    lazy var categoryBackIcon : UIButton = {
        let button = UIButton()
        button.setBackgroundImage(#imageLiteral(resourceName: "back-arrow").withRenderingMode(.alwaysOriginal), for: .normal)
        button.addTarget(self, action: #selector(handleBack), for: .touchUpInside)
        return button
    }()
    
    lazy var homeIcon : UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(#imageLiteral(resourceName: "home").withRenderingMode(.alwaysTemplate), for: .normal)
        button.contentMode = .scaleAspectFit
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(homeActive), for: .touchUpInside)
        button.tintColor = UIColor.rgb(red: 128, green: 128, blue: 128)
        return button
    }()
    
    lazy var exploreIcon : UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(#imageLiteral(resourceName: "explore_icon").withRenderingMode(.alwaysTemplate), for: .normal)
        button.contentMode = .scaleAspectFit
        button.translatesAutoresizingMaskIntoConstraints = false
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
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(profileActive), for: .touchUpInside)
        button.tintColor = UIColor.rgb(red: 128, green: 128, blue: 128)
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
    
    @objc func handleBack(){
        goBack()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView?.backgroundColor = .white
        collectionView?.register(CategoryHeaderRow.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerId)
        collectionView?.register(CategoryImageRow.self, forCellWithReuseIdentifier: cellId)
        collectionView?.register(CategoryPeopleRow.self, forCellWithReuseIdentifier: peopleId)
        collectionView?.register(CategoryExerciseRow.self, forCellWithReuseIdentifier: exerciseId)
        collectionView?.register(CategoryPrincipleRow.self, forCellWithReuseIdentifier: principleId)
        collectionView?.register(CategoryDiscussionRow.self, forCellWithReuseIdentifier: discussionId)
        collectionView?.contentInset = UIEdgeInsetsMake(45, 0, 85, 0)
        self.navigationController?.isNavigationBarHidden = true
        
        setupTopBar()
    }
    
    // MARK: - Setup Views
    
    private func setupTopBar(){
        let backgroundFill = UIView()
        backgroundFill.backgroundColor = .white
        
        view.addSubview(backgroundFill)
        view.addSubview(categoryBackIcon)
        view.addSubview(pageTitle)
        
        backgroundFill.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 90)
        categoryBackIcon.anchor(top: nil, left: backgroundFill.leftAnchor, bottom: backgroundFill.bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 12, paddingBottom: 16, paddingRight: 0, width: 20, height: 20)
        pageTitle.anchor(top: nil, left: categoryBackIcon.rightAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 20, paddingBottom: 0, paddingRight: 0, width: 90, height: pageTitle.intrinsicContentSize.height)
        pageTitle.centerYAnchor.constraint(equalTo: categoryBackIcon.centerYAnchor).isActive = true
        
        view.addSubview(profileIcon)
        view.addSubview(homeIcon)
        view.addSubview(exploreIcon)
        
        profileIcon.anchor(top: nil, left: nil, bottom: nil, right: backgroundFill.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 18, width: 25.5, height: 25)
        profileIcon.centerYAnchor.constraint(equalTo: pageTitle.centerYAnchor).isActive = true
        homeIcon.anchor(top: nil, left: nil, bottom: nil, right: profileIcon.leftAnchor, paddingTop: 8, paddingLeft: 0, paddingBottom: 0, paddingRight: 24, width: 28, height: 25)
        homeIcon.centerYAnchor.constraint(equalTo: pageTitle.centerYAnchor).isActive = true
        exploreIcon.anchor(top: nil, left: nil, bottom: nil, right: homeIcon.leftAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 24, width: 25, height: 25)
        exploreIcon.centerYAnchor.constraint(equalTo: pageTitle.centerYAnchor).isActive = true
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if section == 0 {
            return UIEdgeInsetsMake(0, 0, 0, 0)
        } else {
            return UIEdgeInsetsMake(32, 0, 0, 0)
        }
    }
    
    
    
    var homeController : HomeController?
    
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
    
    func handleMessage(for cell: CategoryHeaderRow) {
        let messageController = MessagesController()
        let navController = UINavigationController(rootViewController: messageController)
        present(navController, animated: true, completion: nil)
    }
    
    func goBack() {
        navigationController?.popViewController(animated: true)
    }
    
    
    func categoryImageTapped() {
        let layout = UICollectionViewFlowLayout()
        let postDetailController = PostDetailController(collectionViewLayout: layout)
        navigationController?.pushViewController(postDetailController, animated: true)
    }
    
    
    func categoryImageHeld() {
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
    
    func pursuitTapped() {
        let layout = UICollectionViewFlowLayout()
        let pursuitDetailController = PursuitsDetailController(collectionViewLayout: layout)
        navigationController?.pushViewController(pursuitDetailController, animated: true)
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
    
    func discussionTapped() {
        let layout = UICollectionViewFlowLayout()
        let profileDiscussionController = DiscussionDetailController(collectionViewLayout: layout)
        navigationController?.pushViewController(profileDiscussionController, animated: true)
    }
    
    func discussionHeld() {
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
        let pursuitDetailController = PursuitsDetailController(collectionViewLayout: layout)
        navigationController?.pushViewController(pursuitDetailController, animated: true)
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
    
    func showPostDetailForPost(){
        let layout = UICollectionViewFlowLayout()
        let postDetailController = PostDetailController(collectionViewLayout: layout)
        navigationController?.pushViewController(postDetailController, animated: true)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.item {
        case 0:
            let pursuitCell = collectionView.dequeueReusableCell(withReuseIdentifier: exerciseId, for: indexPath) as! CategoryExerciseRow
            pursuitCell.categoryDetailController = self
            return pursuitCell
        case 1:
            let principleCell = collectionView.dequeueReusableCell(withReuseIdentifier: principleId, for: indexPath) as! CategoryPrincipleRow
            principleCell.categoryDetailController = self
            return principleCell
        case 2:
            let discussionCell = collectionView.dequeueReusableCell(withReuseIdentifier: discussionId, for: indexPath) as! CategoryDiscussionRow
            discussionCell.categoryDetailController = self
            return discussionCell
        case 3:
            let peopleCell = collectionView.dequeueReusableCell(withReuseIdentifier: peopleId, for: indexPath) as! CategoryPeopleRow
            peopleCell.categoryDetailController = self
            return peopleCell
        case 4:
            let imageCell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! CategoryImageRow
            imageCell.categoryDetailController = self
            return imageCell
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: exerciseId, for: indexPath) as! CategoryExerciseRow
            return cell
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func showCategoryDetailForCateogry(){
        let layout = UICollectionViewFlowLayout()
        let cateogryDetailController = CategoryDetailController(collectionViewLayout: layout)
        navigationController?.pushViewController(cateogryDetailController, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch indexPath.item {
        case 0:
            return CGSize(width: view.frame.width, height: 335)
        case 1:
            return CGSize(width: view.frame.width, height: 310)
        case 2:
            return CGSize(width: view.frame.width, height: 290)
        case 3:
            return CGSize(width: view.frame.width, height: 185)
        case 4:
            return CGSize(width: view.frame.width, height: 445)
        default:
            return CGSize(width: view.frame.width, height: 430)
        }
      }
        
        
    }

