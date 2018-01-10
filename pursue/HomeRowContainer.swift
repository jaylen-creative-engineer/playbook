//
//  HomeRowContainer.swift
//  pursue
//
//  Created by Jaylen Sanders on 11/27/17.
//  Copyright © 2017 Glory. All rights reserved.
//

import UIKit


class HomeRowContainer : UICollectionViewCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, HomeRowImageEngagements, HomePursuitsRowDelegate, HomePrinciplesDelegate, HomeDiscussionDelegate {
    
    let cellId = "cellId"
    let secondaryId = "secondaryId"
    let customRowId = "customRowId"
    let pursuitId = "pursuitId"
    let principleId = "principleId"
    var homeController : HomeController?
    let discussionId = "discussionId"
    
    let homeCollection : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        homeCollection.delegate = self
        homeCollection.dataSource = self
        
        homeCollection.register(HomeRow.self, forCellWithReuseIdentifier: cellId)
        homeCollection.register(HomePursuits.self, forCellWithReuseIdentifier: pursuitId)
        homeCollection.register(HomePrinciples.self, forCellWithReuseIdentifier: principleId)
        homeCollection.register(HomeDiscussion.self, forCellWithReuseIdentifier: discussionId)
        homeCollection.contentInset = UIEdgeInsetsMake(55, 0, 125, 0)
        addSubview(homeCollection)
        homeCollection.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup View
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func homeDiscussionFeed(){
        homeController?.handleChangeToFeed(viewType: "isDiscussionFeed")
    }
    
    func homeDiscussionTapped() {
        homeController?.homeDiscussionTapped()
    }
    
    func homeDiscussionHeld() {
        homeController?.homeDiscussionHeld()
    }
    
    func principleTapped() {
        homeController?.principleTapped()
    }
    
    func principleHeld() {
        homeController?.principleHeld()
    }
    
    func showPrinciplesFeed(){
        homeController?.handleChangeToFeed(viewType: "isPrinciplesFeed")
    }
    
    func showPursuitsFeed() {
        homeController?.handleChangeToFeed(viewType: "isPursuitFeed")
    }
    
    func homeRowImageTapped() {
        homeController?.rowImageTapped()
    }
    
    func homeRowImageHeld() {
        homeController?.rowImageHeld()
    }
    
    func handleChangeToFeed() {
        homeController?.handleChangeToFeed(viewType: "isImageFeed")
    }
    
    func pursuitClicked() {
        homeController?.pursuitClicked()
    }
    
    func pursuitHeld() {
        homeController?.pursuitHeld()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch indexPath.item {
        case 0:
            return CGSize(width: frame.width, height: 375)
        case 1:
            return CGSize(width: frame.width, height: 340)
        case 2:
            return CGSize(width: frame.width, height: 470)
        case 3:
            return CGSize(width: frame.width, height: 250)
        default:
            return CGSize(width: frame.width, height: 430)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.item {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: pursuitId, for: indexPath) as! HomePursuits
            cell.pursuitsDelegate = self
            return cell
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: principleId, for: indexPath) as! HomePrinciples
            cell.principlesDelegate = self
            return cell
        case 2:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! HomeRow
            cell.homeDelegate = self
            return cell
        case 3:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: discussionId, for: indexPath) as! HomeDiscussion
            cell.delegate = self
            return cell
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! HomeRow
            cell.homeDelegate = self
            return cell
        }
       
    }
    
}
