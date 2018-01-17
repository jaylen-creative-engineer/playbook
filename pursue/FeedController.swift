//
//  FeedController.swift
//  pursue
//
//  Created by Jaylen Sanders on 10/30/17.
//  Copyright © 2017 Glory. All rights reserved.
//

import UIKit
import XLActionController

class FeedController : UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    let headerId = "headerId"
    let rowId = "rowId"
    let pictureId = "pictureId"
    let challengeId = "challengeId"
    let pursuitId = "pursuitId"
    let principleId = "principleId"
    let discussionId = "discussionId"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.backgroundColor = .white
       setupTopBar()
        collectionView?.register(FeedRow.self, forCellWithReuseIdentifier: rowId)
        collectionView?.register(FeedPursuit.self, forCellWithReuseIdentifier: pursuitId)
        collectionView?.register(FeedPrinciple.self, forCellWithReuseIdentifier: principleId)
        collectionView?.register(FeedDiscussion.self, forCellWithReuseIdentifier: discussionId)
        collectionView?.contentInset = UIEdgeInsetsMake(55, 0, 105, 0)
    }
    
    var isImageView = false
    var isPursuitView = false
    var isPrinciplesView = false
    var isDiscussionView = false
   
    func imageView(){
        isImageView = true
        isPursuitView = false
        isPrinciplesView = false
        isDiscussionView = false
        
        collectionView?.reloadData()
    }
    
    func pursuitView(){
        isImageView = false
        isPursuitView = true
        isPrinciplesView = false
        isDiscussionView = false
        
        collectionView?.reloadData()
    }
    
    func principleView(){
        isImageView = false
        isPursuitView = false
        isPrinciplesView = true
        isDiscussionView = false
        collectionView?.reloadData()
    }
    
    func discussionView(){
        isImageView = false
        isPursuitView = false
        isPrinciplesView = false
        isDiscussionView = true
        collectionView?.reloadData()
    }
    
    
    func imageClicked() {
        let layout = UICollectionViewFlowLayout()
        let pursuitDetailController = PursuitsDetailController(collectionViewLayout: layout)
        navigationController?.pushViewController(pursuitDetailController, animated: true)
    }
    
    func imageHeld() {
        let actionController = SkypeActionController()
        actionController.addAction(Action("Save", style: .default, handler: { action in
            // do something useful
        }))
        actionController.addAction(Action("Like", style: .default, handler: { action in
            // do something useful
        }))
        actionController.addAction(Action("Share", style: .default, handler: { action in
            // do something useful
        }))
        actionController.addAction(Action("Cancel", style: .default, handler: {action in
            
        }))
        present(actionController, animated: true, completion: nil)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 12
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        let viewType = true
        
        switch viewType {
        case isImageView:
            return 6
        default:
            return 6
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        let viewType = true
        
        switch viewType {
        case isImageView:
            return 6
        default:
            return 6
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(0, 12, 0, 12)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let viewType = true
        
        switch viewType {
        case isImageView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: rowId, for: indexPath) as! FeedRow
            cell.feedController = self
            return cell
        case isPursuitView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: pursuitId, for: indexPath) as! FeedPursuit
            cell.feedController = self
            return cell
        case isPrinciplesView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: principleId, for: indexPath) as! FeedPrinciple
            cell.feedController = self
            return cell
        case isDiscussionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: discussionId, for: indexPath) as! FeedDiscussion
            cell.feedController = self
            return cell
        default:
            assert(false, "Not a valid feed type")
        }
        
    }
    
    @objc func goBack() {
        navigationController?.popViewController(animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let viewType = true
        
        switch viewType {
        case isImageView:
            let width = (view.frame.width / 4) + 75
            return CGSize(width: width, height: width + 85)
        case isPursuitView:
            let width = (view.frame.width / 3)
            return CGSize(width: width + 40, height: width + 45)
        case isPrinciplesView:
            let width = (view.frame.width / 3)
            return CGSize(width: width + 40, height: width + 55)
        case isDiscussionView:
            let width = (view.frame.width / 3) + 40
            return CGSize(width: width, height: width - 35)
        default:
            let width = (view.frame.width - 2) / 3
            return CGSize(width: width - 12, height: width + 120)
        }
    }
    
    lazy var categoryBackIcon : UIButton = {
        let button = UIButton()
        button.setBackgroundImage(#imageLiteral(resourceName: "back-arrow").withRenderingMode(.alwaysOriginal), for: .normal)
        button.addTarget(self, action: #selector(goBack), for: .touchUpInside)
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
    
    let pageTitle : UILabel = {
        let label = UILabel()
        label.text = "Feed"
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    @objc func exploreActive(){
        homeIcon.tintColor = UIColor.rgb(red: 128, green: 128, blue: 128)
        exploreIcon.tintColor = UIColor.black
    }
    
    @objc func homeActive(){
        homeIcon.tintColor = UIColor.black
        exploreIcon.tintColor = UIColor.rgb(red: 128, green: 128, blue: 128)
    }
    
    
    @objc func profileActive(){
    }
    
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

}
