//
//  ExploreContainer.swift
//  pursue
//
//  Created by Jaylen Sanders on 2/12/18.
//  Copyright © 2018 Glory. All rights reserved.
//

import UIKit

class ExploreContainer : UICollectionViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, ExploreExerciseDelegate, ExplorePrincipleDelegate, ExploreImageDelegate, PeopleRowDelegate  {
    
    let cellId = "cellId"
    let secondaryId = "secondaryId"
    let customRowId = "customRowId"
    let peopleId = "peopleId"
    let principleId = "principleId"
    let exerciseId = "exerciseId"
    let categoryId = "categoryId"
    let discussionId = "discussionId"
    
    var accessExploreController : ExploreController?
    
    let exploreCollection : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.showsVerticalScrollIndicator = false
        return collectionView
    }()
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(32, 0, 0, 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch indexPath.item {
        case 0:
            return CGSize(width: frame.width, height: 460)
        case 1:
            return CGSize(width: frame.width, height: 310)
        case 2:
            return CGSize(width: frame.width, height: 230)
        case 3:
            return CGSize(width: frame.width, height: 345)
        default:
            assert(false, "This is not a valid cell")
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: frame.width, height: (frame.height / 8.5))
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.item {
        case 0:
            let imageCell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ExploreImageRow
            imageCell.exploreDelegate = self
            imageCell.accessExploreController = self
            return imageCell
        case 1:
            let pursuitCell = collectionView.dequeueReusableCell(withReuseIdentifier: exerciseId, for: indexPath) as! ExploreExerciseRow
            pursuitCell.exploreDelegate = self
            pursuitCell.accessExploreController = self
            return pursuitCell
        case 2:
            let peopleCell = collectionView.dequeueReusableCell(withReuseIdentifier: peopleId, for: indexPath) as! PeopleRow
            peopleCell.peopleDelegate = self
            return peopleCell
        case 3:
            let principleCell = collectionView.dequeueReusableCell(withReuseIdentifier: principleId, for: indexPath) as! ExplorePrinciplesRow
            principleCell.exploreDelegate = self
            principleCell.accessExploreController = self
            return principleCell
        default:
            assert(false, "This is not a valid cell")
        }
    }
    
    func setupView(){
        exploreCollection.register(ExploreImageRow.self, forCellWithReuseIdentifier: cellId)
        exploreCollection.register(PeopleRow.self, forCellWithReuseIdentifier: peopleId)
        exploreCollection.register(ExplorePrinciplesRow.self, forCellWithReuseIdentifier: principleId)
        exploreCollection.register(ExploreExerciseRow.self, forCellWithReuseIdentifier: exerciseId)
        exploreCollection.register(ExploreCategoryRow.self, forCellWithReuseIdentifier: categoryId)
        
        
        addSubview(exploreCollection)
        exploreCollection.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
    }
    
    func explorePrincipleTapped() {
        accessExploreController?.explorePrincipleTapped()
    }
    
    func explorePrincipleHeld() {
        accessExploreController?.explorePrincipleHeld()
    }
    
    func explorePursuitTapped() {
        accessExploreController?.explorePursuitTapped()
    }
    
    func explorePursuitHeld() {
        accessExploreController?.explorePursuitHeld()
    }
    
    func profileTapped() {
        accessExploreController?.profileTapped()
    }
    
    func imageTapped() {
        accessExploreController?.imageTapped()
    }
    
    func imageHeld() {
        accessExploreController?.imageHeld()
    }
    
    func handleChangeToFeed(viewType : String) {
        switch viewType {
        case "isPrinciplesFeed":
            accessExploreController?.handleChangeToFeed(viewType: "isPrinciplesFeed")
        case "isPursuitFeed":
            accessExploreController?.handleChangeToFeed(viewType: "isPursuitFeed")
        case "isImageFeed":
            accessExploreController?.handleChangeToFeed(viewType: "isImageFeed")
        default:
            assert(false, "Not a valid view type")
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        exploreCollection.delegate = self
        exploreCollection.dataSource = self
        setupView()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
