//
//  HomeContainer.swift
//  pursue
//
//  Created by Jaylen Sanders on 2/14/18.
//  Copyright © 2018 Glory. All rights reserved.
//

import UIKit
import XLActionController

class HomeContainer : UICollectionViewCell, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource, HomeRowImageEngagements, HomePursuitsRowDelegate, HomePrinciplesDelegate {
    
    let secondaryId = "secondaryId"
    let customRowId = "customRowId"
    let pursuitId = "pursuitId"
    let principleId = "principleId"
    let imageCarouselId = "imageCarouselId"
    let pursuitCarouselId = "pursuitCarouselId"
    let principleCarouselId = "principleCarouselId"
    let discussionCarouselId = "discussionCarouselId"
    let imageDetailViewId = "imageDetailViewId"
    let cellId = "cellId"
    var accessHomeController : HomeController?
    
    let homeCollection : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.showsVerticalScrollIndicator = false
        return collectionView
    }()
    
    var isImageView = true
    var isPursuitView = false
    var isPrinciplesView = false
    var isDiscussionView = false
    var isExploreImageView = false
    
    func homeDiscussionTapped() {
        accessHomeController?.handleChangeToDetail(viewType: "isDiscussionDetail")
    }
    
    func homeDiscussionHeld() {
        accessHomeController?.homeDiscussionHeld()
    }
    
    func principleTapped() {
        accessHomeController?.handleChangeToDetail(viewType: "isPrinciplesDetail")
    }
    
    func principleHeld() {
        accessHomeController?.principleHeld()
    }
    
    func homeRowImageTapped() {
        accessHomeController?.handleChangeToDetail(viewType: "isImageDetail")
    }
    
    func homeRowImageHeld() {
        accessHomeController?.homeRowImageHeld()
    }
    
    func pursuitClicked() {
        accessHomeController?.handleChangeToDetail(viewType: "isPursuitDetail")
    }
    
    func pursuitHeld() {
        accessHomeController?.pursuitHeld()
    }
    
    func handleChangeToDetail(viewType : String) {
        switch viewType {
        case "isPrinciplesDetail":
            accessHomeController?.handleChangeToDetail(viewType: "isPrinciplesDetail")
        case "isPursuitDetail":
            accessHomeController?.handleChangeToDetail(viewType: "isPursuitDetail")
        case "isImageDetail":
            accessHomeController?.handleChangeToDetail(viewType: "isImageDetail")
        case "isDiscussionDetail":
            accessHomeController?.handleChangeToDetail(viewType: "isDiscussionDetail")
        default:
            assert(false, "Not a valid view type")
        }
    }
    
    func imageView(isExplore : Bool){
        if isExplore == true {
            accessHomeController?.imageView(isExplore: true)
        } else {
            accessHomeController?.imageView(isExplore: false)
        }
    }
    
    func pursuitView(){
        accessHomeController?.pursuitView()
    }
    
    func principleView(){
        accessHomeController?.principleView()
    }
    
    func setupCollectionView(){
        addSubview(homeCollection)
        homeCollection.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        homeCollection.register(HomeRow.self, forCellWithReuseIdentifier: cellId)
        homeCollection.register(HomePursuits.self, forCellWithReuseIdentifier: pursuitId)
        homeCollection.register(HomePrinciples.self, forCellWithReuseIdentifier: principleId)
        homeCollection.register(HomePrincipleCarousel.self, forCellWithReuseIdentifier: principleCarouselId)
        homeCollection.register(HomePursuitCarousel.self, forCellWithReuseIdentifier: pursuitCarouselId)
        homeCollection.register(HomeImageCarousel.self, forCellWithReuseIdentifier: imageCarouselId)
        homeCollection.register(HomeImageDetailView.self, forCellWithReuseIdentifier: imageDetailViewId)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        homeCollection.delegate = self
        homeCollection.dataSource = self
        setupCollectionView()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension HomeContainer {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch true {
        case isImageView:
            switch indexPath.item {
            case 0:
                return CGSize(width: frame.width, height: 510)
            case 1:
                return CGSize(width: frame.width, height: 390)
            case 2:
                return CGSize(width: frame.width, height: 430)
            default:
                assert(false, "Not a valid row")
            }
        case isExploreImageView:
            switch indexPath.item {
            case 0:
                return CGSize(width: frame.width, height: 510)
            case 1:
                return CGSize(width: frame.width, height: 390)
            case 2:
                return CGSize(width: frame.width, height: 430)
            default:
                assert(false, "Not a valid row")
            }
        case isPursuitView:
            switch indexPath.item {
            case 0:
                return CGSize(width: frame.width, height: 350)
            case 1:
                return CGSize(width: frame.width, height: 390)
            case 2:
                return CGSize(width: frame.width, height: 535)
            default:
                assert(false, "Not a valid row")
            }
        case isPrinciplesView:
            switch indexPath.item {
            case 0:
                return CGSize(width: frame.width, height: 400)
            case 1:
                return CGSize(width: frame.width, height: 430)
            case 2:
                return CGSize(width: frame.width, height: 535)
            default:
                assert(false, "Not a valid row")
            }
        default:
            assert(false, "Not a valid view")
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch true {
        case isImageView:
            switch indexPath.item {
            case 0:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! HomeRow
                cell.homeDelegate = self
                cell.accessHomeController = self
                return cell
            case 1:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: principleId, for: indexPath) as! HomePrinciples
                cell.principlesDelegate = self
                cell.accessHomeController = self
                return cell
            case 2:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: pursuitId, for: indexPath) as! HomePursuits
                cell.pursuitsDelegate = self
                cell.accessHomeController = self
                return cell
            default:
                assert(false, "Not a valid row")
            }
        case isExploreImageView:
            switch indexPath.item {
            case 0:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: imageCarouselId, for: indexPath) as! HomeImageCarousel
                cell.accessHomeController = self
                return cell
            case 1:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: principleId, for: indexPath) as! HomePrinciples
                cell.principlesDelegate = self
                cell.accessHomeController = self
                return cell
            case 2:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: pursuitId, for: indexPath) as! HomePursuits
                cell.pursuitsDelegate = self
                cell.accessHomeController = self
                return cell
            default:
                assert(false, "Not a valid row")
            }
        case isPursuitView:
            switch indexPath.item {
            case 0:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: pursuitCarouselId, for: indexPath) as! HomePursuitCarousel
                cell.accessHomeController = self
                return cell
            case 1:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: principleId, for: indexPath) as! HomePrinciples
                cell.principlesDelegate = self
                cell.accessHomeController = self
                return cell
            case 2:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: imageDetailViewId, for: indexPath) as! HomeImageDetailView
                cell.accessHomeController = self
                return cell
            default:
                assert(false, "Not a valid row")
            }
        case isPrinciplesView:
            switch indexPath.item {
            case 0:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: principleCarouselId, for: indexPath) as! HomePrincipleCarousel
                cell.accessHomeController = self
                return cell
            case 1:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: pursuitId, for: indexPath) as! HomePursuits
                cell.pursuitsDelegate = self
                cell.accessHomeController = self
                return cell
            case 2:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: imageDetailViewId, for: indexPath) as! HomeImageDetailView
                cell.accessHomeController = self
                return cell
            default:
                assert(false, "Not a valid row")
            }
            
        default:
            assert(false, "Not a valid view")
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: frame.width, height: (frame.height / 5.5) + 20)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
}
