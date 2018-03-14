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
    let peopleId = "peopleId"
    var accessHomeController : HomeController?
    let homeServices = HomeServices()
    
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
    
    func optionClicked(){
        accessHomeController?.showOptionClicked()
    }
    
    func showPeople(){
        accessHomeController?.showPeople()
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
    
    func imageView(){
        accessHomeController?.imageView(isExplore: false)
    }
    
    func getContent(){
//        homeServices.getPursuits { (pursuit, steps, principles) in
//            <#code#>
//        }
    }
    
    func getUserPursuits(){
//        homeServices.getUserPursuits { (<#Pursuit#>, <#Post#>, <#Steps#>, <#Principles#>) in
//            <#code#>
//        }
    }
    
    func pursuitView(){
    }
    
    func principleView(){
    }
    
    func setupCollectionView(){
        addSubview(homeCollection)
        homeCollection.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        homeCollection.register(HomeRow.self, forCellWithReuseIdentifier: cellId)
        homeCollection.register(HomeSteps.self, forCellWithReuseIdentifier: pursuitId)
        homeCollection.register(HomePrinciples.self, forCellWithReuseIdentifier: principleId)
        homeCollection.register(HomePeople.self, forCellWithReuseIdentifier: peopleId)
    }
    
    func homeRowScrolled(for cell: HomeRow) {
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
        switch indexPath.item {
        case 0:
            return CGSize(width: frame.width, height: 510)
        case 1:
            return CGSize(width: frame.width, height: 430)
        case 2:
            return CGSize(width: frame.width, height: 390)
        case 3:
            return CGSize(width: frame.width, height: 390)
        default:
            assert(false, "Not a valid row")
        }

    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.item {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! HomeRow
            cell.homeDelegate = self
            cell.accessHomeController = self
            return cell
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: pursuitId, for: indexPath) as! HomeSteps
            cell.pursuitsDelegate = self
            cell.accessHomeController = self
            return cell
        case 2:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: principleId, for: indexPath) as! HomePrinciples
            cell.principlesDelegate = self
            cell.accessHomeController = self
            return cell
        case 3:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: peopleId, for: indexPath) as! HomePeople
            cell.accessHomeController = self
            return cell
        default:
            assert(false, "Not a valid row")
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: frame.width, height: 135)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
}
