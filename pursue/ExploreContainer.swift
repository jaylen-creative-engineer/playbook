//
//  ExploreContainer.swift
//  pursue
//
//  Created by Jaylen Sanders on 11/27/17.
//  Copyright © 2017 Glory. All rights reserved.
//

import UIKit

class ExploreContainer : UICollectionViewCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, ExploreDiscussionDelegate, ExploreExerciseDelegate, ExplorePrincipleDelegate, ExploreImageDelegate, ExploreCategoryDelegate, PeopleRowDelegate {
    
    let cellId = "cellId"
    let secondaryId = "secondaryId"
    let customRowId = "customRowId"
    let peopleId = "peopleId"
    let principleId = "principleId"
    let exerciseId = "exerciseId"
    let categoryId = "categoryId"
    let discussionId = "discussionId"
    
    let exploreCollection : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    var homeController : HomeController?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        exploreCollection.delegate = self
        exploreCollection.dataSource = self
        exploreCollection.contentInset = UIEdgeInsetsMake(65, 0, 105, 0)
        
        exploreCollection.register(ExploreImageRow.self, forCellWithReuseIdentifier: cellId)
        exploreCollection.register(PeopleRow.self, forCellWithReuseIdentifier: peopleId)
        exploreCollection.register(ExplorePrinciplesRow.self, forCellWithReuseIdentifier: principleId)
        exploreCollection.register(ExploreExerciseRow.self, forCellWithReuseIdentifier: exerciseId)
        exploreCollection.register(ExploreCategoryRow.self, forCellWithReuseIdentifier: categoryId)
        exploreCollection.register(ExploreDiscussion.self, forCellWithReuseIdentifier: discussionId)
        addSubview(exploreCollection)
        exploreCollection.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup View
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if section == 0 {
            return UIEdgeInsetsMake(0, 0, 0, 0)
        } else {
            return UIEdgeInsetsMake(32, 0, 0, 0)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch indexPath.item {
        case 0:
            return CGSize(width: frame.width, height: 187)
        case 1:
            return CGSize(width: frame.width, height: 330)
        case 2:
            return CGSize(width: frame.width, height: 345)
        case 3:
            return CGSize(width: frame.width, height: 300)
        case 4:
            return CGSize(width: frame.width, height: 230)
        case 5:
            return CGSize(width: frame.width, height: 410)
        default:
            return CGSize(width: frame.width, height: 260)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }
    
    func exploreCategoryTapped() {
        homeController?.categoryClicked()
    }
    
    func imageTapped() {
        homeController?.rowImageTapped()
    }
    
    func imageHeld() {
        homeController?.rowImageHeld()
    }
    
    func explorePrincipleTapped() {
        homeController?.principleTapped()
    }
    
    func explorePrincipleHeld() {
        homeController?.pursuitHeld()
    }
    
    func exploreDiscussionTapped() {
        homeController?.homeDiscussionTapped()
    }
    
    func exploreDiscussionHeld() {
        homeController?.homeDiscussionHeld()
    }
    
    func explorePursuitHeld() {
        homeController?.pursuitHeld()
    }
    
    func explorePursuitTapped() {
        homeController?.pursuitClicked()
    }
    
    func profileTapped() {
        homeController?.showUserProfile()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell : UICollectionViewCell
        switch indexPath.item {
        case 0:
            let categoryCell = collectionView.dequeueReusableCell(withReuseIdentifier: categoryId, for: indexPath) as! ExploreCategoryRow
            categoryCell.exploreDelegate = self
            return categoryCell
        case 1:
            let pursuitCell = collectionView.dequeueReusableCell(withReuseIdentifier: exerciseId, for: indexPath) as! ExploreExerciseRow
            pursuitCell.exploreDelegate = self
            return pursuitCell
        case 2:
            let principleCell = collectionView.dequeueReusableCell(withReuseIdentifier: principleId, for: indexPath) as! ExplorePrinciplesRow
            principleCell.exploreDelegate = self
            return principleCell
        case 3:
            let discussionCell = collectionView.dequeueReusableCell(withReuseIdentifier: discussionId, for: indexPath) as! ExploreDiscussion
            discussionCell.exploreDiscussionDelegate = self
            return discussionCell
        case 4:
            let peopleCell = collectionView.dequeueReusableCell(withReuseIdentifier: peopleId, for: indexPath) as! PeopleRow
            peopleCell.peopleDelegate = self
            return peopleCell
        case 5:
            let imageCell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ExploreImageRow
            imageCell.exploreDelegate = self
            return imageCell
        default:
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: exerciseId, for: indexPath) as! ExploreExerciseRow
            return cell
        }
    }
    
}
