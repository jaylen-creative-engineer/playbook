//
//  HomeContainer.swift
//  pursue
//
//  Created by Jaylen Sanders on 2/14/18.
//  Copyright © 2018 Glory. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class HomeContainer : UICollectionViewCell, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource, HomeRowImageEngagements, NVActivityIndicatorViewable {
    
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
    var homePostContent = [Home]()
    
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
//        let indicator = NVActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 80, height: 80))
//        indicator.type = .ballClipRotatePulse
//        indicator.color = .black
//        indicator.padding = 20
//
//        addSubview(indicator)
//        indicator.anchor(top: topAnchor, left: nil, bottom: nil, right: nil, paddingTop: 124, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
//        indicator.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
//        indicator.startAnimating()
        
        homeServices.getPursuits { (home) in
            DispatchQueue.main.async {
                home.forEach({ (value) in
//                    indicator.isHidden = true
                    self.homePostContent.append(value)
                    self.homeCollection.reloadData()
                })
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
        return CGSize(width: frame.width, height: frame.height * 2)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! HomeRow
        cell.homeDelegate = self
        cell.accessHomeController = self
        if !homePostContent.isEmpty {
            homePostContent.forEach { (value) in
                cell.home = value
            }
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: frame.width, height: 135)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
}
