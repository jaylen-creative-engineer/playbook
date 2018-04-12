//
//  HomeContainer.swift
//  pursue
//
//  Created by Jaylen Sanders on 2/14/18.
//  Copyright © 2018 Glory. All rights reserved.
//

import UIKit
import XLActionController

class HomeContainer : UICollectionViewCell, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource, HomeRowImageEngagements  {
    
    let secondaryId = "secondaryId"
    let customRowId = "customRowId"
    let pursuitId = "pursuitId"
    let principleId = "principleId"
    let imageCarouselId = "imageCarouselId"
    let pursuitCarouselId = "pursuitCarouselId"
    let principleCarouselId = "principleCarouselId"
    let discussionCarouselId = "discussionCarouselId"
    let imageDetailViewId = "imageDetailViewId"
    let detailId = "detailId"
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
    
    var home : Home?
    
    func getContent(){
        homeServices.getPursuits { (home) in
            DispatchQueue.main.async {
                self.home = home
                self.homeCollection.reloadData()
            }
        }
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
        homeCollection.register(HomeDetails.self, forCellWithReuseIdentifier: detailId)
    }
    
    func homeRowScrolled(for cell: HomeRow) {
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        homeCollection.delegate = self
        homeCollection.dataSource = self
        setupCollectionView()
        getContent()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

extension HomeContainer {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch indexPath.item {
        case 0:
            return CGSize(width: frame.width, height: 475)
        case 1:
            return CGSize(width: frame.width, height: frame.height * 2)
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
            cell.home = home
            return cell
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: detailId, for: indexPath) as! HomeDetails
            return cell
        default:
            assert(false, "Not a valid row")
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: frame.width, height: 135)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
}
