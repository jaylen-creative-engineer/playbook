//
//  HomeContainer.swift
//  Inpursuit
//
//  Created by Jaylen Sanders on 12/23/18.
//  Copyright © 2018 Glory. All rights reserved.
//

import UIKit
import iCarousel
import CHIPageControl
import PinterestLayout

class HomeContainer : UICollectionViewCell {
    
    let challengeId = "challengeId"
    let pinterestId = "pinterestId"
    let teamId = "teamId"
    let postId = "postId"
    let pursuitId = "pursuitId"
    let conflictId = "conflictId"
    let daysId = "daysId"
    let standardId = "standardId"
    let carouselId = "carouselId"
    
    let containerCollectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.showsVerticalScrollIndicator = false
        collectionView.isScrollEnabled = true
        return collectionView
    }()
    
    let standardCellBackgroundView : HomeCellConflictShadowView = {
        let view = HomeCellConflictShadowView()
        view.backgroundColor = .white
        return view
    }()
    
    let standardUsernameLabel : UILabel = {
        let label = UILabel()
        label.text = "Test"
        label.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.init(25))
        return label
    }()
    
    let standardUserPhoto : UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.layer.cornerRadius = 15
        iv.layer.masksToBounds = true
        iv.image = UIImage(named: "cafe-768771_1280")?.withRenderingMode(.alwaysOriginal)
        return iv
    }()
    
    let standardDetailCollectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    let standardImageView : UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "cafe-768771_1280")?.withRenderingMode(.alwaysOriginal)
        iv.contentMode = .scaleAspectFill
        iv.layer.masksToBounds = true
        iv.layer.cornerRadius = 12
        return iv
    }()
    
    let pinterestPostBackground : HomeCellConflictShadowView = {
        let view = HomeCellConflictShadowView()
        view.backgroundColor = .white
        return view
    }()
    
    let trendingPostLabel : UILabel = {
        let label = UILabel()
        label.text = "Recent Posts"
        label.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.init(25))
        return label
    }()
    
    let pinterestCollectionView : UICollectionView = {
        let layout = PinterestLayout()
        layout.numberOfColumns = 2
        layout.cellPadding = 10
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isScrollEnabled = false
        return collectionView
    }()
    
    lazy var carouselView : iCarousel = {
        let ic = iCarousel()
        ic.bounces = false
        ic.contentOffset = CGSize(width: 4, height: -2)
        ic.isPagingEnabled = true
        return ic
    }()
    
    lazy var subCarouselView : iCarousel = {
        let ic = iCarousel()
        return ic
    }()
    
    lazy var pageControl: CHIPageControlAleppo = {
        let pc = CHIPageControlAleppo()
        pc.radius = 3
        pc.currentPageTintColor = .black
        pc.numberOfPages = imageNames.count
        pc.tintColor = .gray
        return pc
    }()
    
    let conflictCollectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    let conflictLabel : UILabel = {
        let label = UILabel()
        label.text = "Conflict"
        label.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.init(25))
        return label
    }()
    
    let conflictCellBackgroundView : HomeCellConflictShadowView = {
        let view = HomeCellConflictShadowView()
        view.backgroundColor = .white
        return view
    }()
    
    let challengeCollectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    let challengeLabel : UILabel = {
        let label = UILabel()
        label.text = "Cooking Challenges"
        label.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.init(25))
        return label
    }()
    
    let challengeCellBackgroundView : HomeCellConflictShadowView = {
        let view = HomeCellConflictShadowView()
        view.backgroundColor = .white
        return view
    }()

    var cellIndex : Int = 0
    
    let imageNames = ["cafe-768771_1280", "apartment-architecture-ceiling-259962", "gian-cescon-637914-unsplash", "IMG_0807", "IMG_3935"]
    let profileNames = ["apartment-architecture-ceiling-259962", "cafe-768771_1280", "gian-cescon-637914-unsplash", "IMG_0807", "IMG_3935"]
    let homeDescriptions = ["iChat App","New York Exchange", "Travel App", "Contact Page", "Settings 3d touch"]
    
    let scrollView : UIScrollView = {
       let sv = UIScrollView()
        sv.showsVerticalScrollIndicator = false
        return sv
    }()
    
//    func setupContainerView(){
//        containerCollectionView.delegate = self
//        containerCollectionView.dataSource = self
//    }
    
    func setupChallengeView(){
        challengeCollectionView.delegate = self
        challengeCollectionView.dataSource = self
        challengeCollectionView.register(HomeChallenge.self, forCellWithReuseIdentifier: challengeId)
        
        scrollView.addSubview(challengeCellBackgroundView)
        scrollView.addSubview(challengeLabel)
        scrollView.addSubview(challengeCollectionView)
        
        challengeCellBackgroundView.anchor(top: conflictCellBackgroundView.bottomAnchor, left: scrollView.leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 24, paddingLeft: 12, paddingBottom: 0, paddingRight: 12, width: 0, height: 380)
        challengeLabel.anchor(top: challengeCellBackgroundView.topAnchor, left: challengeCellBackgroundView.leftAnchor, bottom: nil, right: nil, paddingTop: 18, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: challengeLabel.intrinsicContentSize.width, height: 18)
        challengeCollectionView.anchor(top: challengeLabel.bottomAnchor, left: leftAnchor, bottom: challengeCellBackgroundView.bottomAnchor, right: rightAnchor, paddingTop: 24, paddingLeft: 0, paddingBottom: 20, paddingRight: 0, width: 0, height: 0)
    }
    
    func setupConflictView(){
        conflictCollectionView.delegate = self
        conflictCollectionView.dataSource = self
        conflictCollectionView.register(HomeConflict.self, forCellWithReuseIdentifier: conflictId)
        
        scrollView.addSubview(conflictCellBackgroundView)
        scrollView.addSubview(conflictLabel)
        scrollView.addSubview(conflictCollectionView)
        
        conflictCellBackgroundView.anchor(top: standardCellBackgroundView.bottomAnchor, left: scrollView.leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 24, paddingLeft: 12, paddingBottom: 0, paddingRight: 12, width: 0, height: 280)
        conflictLabel.anchor(top: conflictCellBackgroundView.topAnchor, left: conflictCellBackgroundView.leftAnchor, bottom: nil, right: nil, paddingTop: 18, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: conflictLabel.intrinsicContentSize.width, height: 18)
        conflictCollectionView.anchor(top: conflictLabel.bottomAnchor, left: scrollView.leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 24, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 170)
    }
    
    func setupStandardView(){
        standardDetailCollectionView.delegate = self
        standardDetailCollectionView.dataSource = self
        standardDetailCollectionView.register(HomeStandard.self, forCellWithReuseIdentifier: standardId)
        
        scrollView.addSubview(standardCellBackgroundView)
        scrollView.addSubview(standardUserPhoto)
        scrollView.addSubview(standardUsernameLabel)
        scrollView.addSubview(standardImageView)
        scrollView.addSubview(standardDetailCollectionView)
        
        standardCellBackgroundView.anchor(top: pinterestPostBackground.bottomAnchor, left: scrollView.leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 24, paddingLeft: 12, paddingBottom: 0, paddingRight: 12, width: 0, height: 640)
        
        standardUserPhoto.anchor(top: standardCellBackgroundView.topAnchor, left: standardCellBackgroundView.leftAnchor, bottom: nil, right: nil, paddingTop: 18, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: 30, height: 30)
        standardUsernameLabel.centerYAnchor.constraint(equalTo: standardUserPhoto.centerYAnchor).isActive = true
        standardUsernameLabel.anchor(top: nil, left: standardUserPhoto.rightAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 8, paddingBottom: 0, paddingRight: 0, width: 0, height: 16)
        standardImageView.anchor(top: standardUserPhoto.bottomAnchor, left: standardCellBackgroundView.leftAnchor, bottom: nil, right: standardCellBackgroundView.rightAnchor, paddingTop: 18, paddingLeft: 12, paddingBottom: 0, paddingRight: 12, width: 0, height: 355)
        standardDetailCollectionView.anchor(top: standardImageView.bottomAnchor, left: scrollView.leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 24, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 170)
    }
    
    func setupScrollView(){
        addSubview(scrollView)
        scrollView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        scrollView.contentSize = CGSize(width: frame.width, height: frame.height * 6)
        setupScrollView()
        setupCarousels()
        setupPinterestsView()
        setupStandardView()
        setupConflictView()
        setupChallengeView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension HomeContainer : PinterestLayoutDelegate {
    
    func setupPinterestsView(){
        scrollView.addSubview(pinterestPostBackground)
        scrollView.addSubview(trendingPostLabel)
        
        pinterestPostBackground.anchor(top: subCarouselView.bottomAnchor, left: scrollView.leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 24, paddingLeft: 12, paddingBottom: 0, paddingRight: 12, width: 0, height: 596)
        trendingPostLabel.anchor(top: pinterestPostBackground.topAnchor, left: pinterestPostBackground.leftAnchor, bottom: nil, right: nil, paddingTop: 18, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: trendingPostLabel.intrinsicContentSize.width, height: 18)
        setupPinterestsCollectionView()
    }
   
    func setupPinterestsCollectionView(){
        pinterestCollectionView.delegate = self
        pinterestCollectionView.dataSource = self
        if let layout = pinterestCollectionView.collectionViewLayout as? PinterestLayout {
            layout.delegate = self
        }
        
        pinterestCollectionView.register(HomePinterestCell.self, forCellWithReuseIdentifier: pinterestId)
        
        scrollView.addSubview(pinterestCollectionView)
        pinterestCollectionView.anchor(top: trendingPostLabel.bottomAnchor, left: pinterestPostBackground.leftAnchor, bottom: pinterestPostBackground.bottomAnchor, right: pinterestPostBackground.rightAnchor, paddingTop: 24, paddingLeft: 0, paddingBottom: 20, paddingRight: 0, width: 0, height: 0)
    }
    
    func collectionView(collectionView: UICollectionView, heightForImageAtIndexPath indexPath: IndexPath, withWidth: CGFloat) -> CGFloat {
        if indexPath.item % 2 != 0 {
            return 120
        } else {
            return 115
        }
    }
    
    func collectionView(collectionView: UICollectionView, heightForAnnotationAtIndexPath indexPath: IndexPath, withWidth: CGFloat) -> CGFloat {
        if indexPath.item % 2 != 0 {
            return 120
        } else {
            return 115
        }
    }
}

extension HomeContainer : iCarouselDataSource, iCarouselDelegate {
    
    func numberOfItems(in carousel: iCarousel) -> Int {
        switch carousel {
        case carouselView:
            return imageNames.count
        case subCarouselView:
            return homeDescriptions.count
        default:
            assert(false, "Not a valid cell")
        }
    }
    
    func carousel(_ carousel: iCarousel, viewForItemAt index: Int, reusing view: UIView?) -> UIView {
        var carouselImage = UIImageView()
        
        switch carousel {
        case subCarouselView:
            carouselImage = UIImageView(frame: CGRect(x: 0, y: 0, width: 400, height: 60))
            
            let postLabel = UILabel()
            postLabel.font = UIFont.boldSystemFont(ofSize: 14)
            postLabel.textAlignment = .right
            postLabel.numberOfLines = 1
            postLabel.text = homeDescriptions[index]
            
            let usernameLabel = UILabel()
            usernameLabel.font = UIFont.boldSystemFont(ofSize: 12)
            usernameLabel.textAlignment = .right
            usernameLabel.numberOfLines = 1
            usernameLabel.text = imageNames[index]
            
            let profilePicture = UIImageView()
            profilePicture.contentMode = .scaleAspectFill
            profilePicture.translatesAutoresizingMaskIntoConstraints = false
            profilePicture.layer.cornerRadius = 15
            profilePicture.layer.masksToBounds = true
            profilePicture.image = UIImage(named: profileNames[index])?.withRenderingMode(.alwaysOriginal)
            
            carouselImage.addSubview(postLabel)
            carouselImage.addSubview(usernameLabel)
            carouselImage.addSubview(profilePicture)
            
            profilePicture.anchor(top: carouselImage.topAnchor, left: nil, bottom: nil, right: carouselImage.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 12, width: 30, height: 30)
            postLabel.anchor(top: profilePicture.topAnchor, left: nil, bottom: nil, right: profilePicture.leftAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 18, width: 0, height: 16)
            postLabel.widthAnchor.constraint(lessThanOrEqualToConstant: 180).isActive = true
            usernameLabel.anchor(top: postLabel.bottomAnchor, left: postLabel.leftAnchor, bottom: nil, right: profilePicture.leftAnchor, paddingTop: 8, paddingLeft: 0, paddingBottom: 0, paddingRight: 18, width: usernameLabel.intrinsicContentSize.width, height: 14)
            return carouselImage
        case carouselView:
            carouselImage = UIImageView(frame: CGRect(x: 0, y: 0, width: frame.width - 18, height: 385))
            carouselImage.isUserInteractionEnabled = true
            carouselImage.layer.cornerRadius = 12
            carouselImage.layer.masksToBounds = true
            carouselImage.contentMode = .scaleAspectFill
            
            let postLabel = UILabel()
            postLabel.font = UIFont.boldSystemFont(ofSize: 14)
            postLabel.textAlignment = .justified
            postLabel.numberOfLines = 1
            
            let usernameLabel = UILabel()
            usernameLabel.font = UIFont.boldSystemFont(ofSize: 12)
            usernameLabel.textAlignment = .justified
            usernameLabel.numberOfLines = 1
            
            let profilePicture = UIImageView()
            profilePicture.contentMode = .scaleAspectFill
            profilePicture.translatesAutoresizingMaskIntoConstraints = false
            profilePicture.layer.cornerRadius = 25
            profilePicture.layer.masksToBounds = true
            
            let leftButton = UIButton()
            leftButton.translatesAutoresizingMaskIntoConstraints = false
            leftButton.isUserInteractionEnabled = true
            leftButton.addTarget(self, action: #selector(handleLeftTap), for: .touchUpInside)
            
            let rightButton = UIButton()
            rightButton.translatesAutoresizingMaskIntoConstraints = false
            rightButton.isUserInteractionEnabled = true
            rightButton.addTarget(self, action: #selector(handleRightTap), for: .touchUpInside)
            
            
            carouselImage.addSubview(leftButton)
            carouselImage.addSubview(rightButton)
            
            if !imageNames.isEmpty {
                carouselImage.image = UIImage(named: imageNames[index])
            }
            
            leftButton.anchor(top: carouselImage.topAnchor, left: carouselImage.leftAnchor, bottom: carouselImage.bottomAnchor, right: carouselImage.centerXAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
            rightButton.anchor(top: carouselImage.topAnchor, left: carouselImage.centerXAnchor, bottom: carouselImage.bottomAnchor, right: carouselImage.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
            return carouselImage
        default:
            return carouselImage
        }
        
    }
    
    
    func carousel(_ carousel: iCarousel, valueFor option: iCarouselOption, withDefault value: CGFloat) -> CGFloat {
        
        switch option {
        case .spacing:
            return value * 0.6
        case .fadeMinAlpha:
            if carousel == subCarouselView {
                return 0.2
            } else {
                return value
            }
        case .fadeRange:
            if carousel == subCarouselView {
                return 0.1
            } else {
                return 0.3
            }
        case .visibleItems:
            if carousel == subCarouselView {
                return 1
            } else {
                return CGFloat(imageNames.count)
            }
        default:
            return value
        }
    }
    
    func carouselDidScroll(_ carousel: iCarousel) {
        if carousel == carouselView {
            subCarouselView.scrollOffset = carouselView.scrollOffset
        }
    }
    
    @objc func handleLeftTap(){
        carouselView.scrollToItem(at: cellIndex - 1, animated: true)
        cellIndex = cellIndex - 1
        
        if cellIndex < 0 {
            cellIndex = cellIndex + 1
        }
    }
    
    @objc func handleRightTap(){
        carouselView.scrollToItem(at: cellIndex + 1, animated: true)
        cellIndex = cellIndex + 1
        
        if cellIndex > imageNames.count {
            cellIndex = cellIndex - 1
        }
    }
    
    func setupCarousels(){
        setupStandardCarousel()
        labelSubCarousel()
    }
    
    func carouselCurrentItemIndexDidChange(_ carousel: iCarousel) {
        let currentIndex = carouselView.currentItemIndex
        cellIndex = currentIndex
        pageControl.set(progress: currentIndex, animated: true)
    }
    
    func setupStandardCarousel(){
        carouselView.dataSource = self
        carouselView.delegate = self
        carouselView.type = .invertedTimeMachine
        
        scrollView.addSubview(carouselView)
        scrollView.addSubview(pageControl)
        
        carouselView.anchor(top: scrollView.topAnchor, left: scrollView.leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 8, width: 0, height: 385)
        pageControl.anchor(top: carouselView.bottomAnchor, left: safeAreaLayoutGuide.leftAnchor, bottom: nil, right: nil, paddingTop: 14, paddingLeft: 16, paddingBottom: 0, paddingRight: 0, width: pageControl.intrinsicContentSize.width, height: 24)
    }
    
    func labelSubCarousel(){
        subCarouselView.dataSource = self
        subCarouselView.delegate = self
        subCarouselView.isScrollEnabled = false
        subCarouselView.type = .linear
        subCarouselView.backgroundColor = .clear
        subCarouselView.isVertical = true
        
        scrollView.addSubview(subCarouselView)
        subCarouselView.anchor(top: pageControl.bottomAnchor, left: scrollView.leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 60)
        
    }
}

extension HomeContainer : UICollectionViewDelegateFlowLayout , UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case standardDetailCollectionView:
            return 6
        case pinterestCollectionView:
            return 4
        case conflictCollectionView:
            return 6
        case challengeCollectionView:
            return 6
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: frame.width, height: 80)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch collectionView {
        case standardDetailCollectionView:
            return CGSize(width: 300, height: 120)
        case conflictCollectionView:
            return CGSize(width: (frame.width / 2.8) + 10, height: 170)
        case challengeCollectionView:
            return CGSize(width: frame.width - 24, height: 280)
        default:
            return CGSize(width: 0, height: 0)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        switch collectionView {
        case standardDetailCollectionView:
            return 25.0
        case conflictCollectionView:
            return 25.0
        case challengeCollectionView:
            return 35.0
        default:
            return 0.0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        switch collectionView {
        case standardDetailCollectionView:
            return 25.0
        case conflictCollectionView:
            return 25.0
        case challengeCollectionView:
            return 35.0
        default:
            return 0.0
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell : UICollectionViewCell
        let cellId : String
        
//        switch indexPath.section {
//        case standardDetailCollectionView:
//            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: standardId, for: indexPath) as! HomeStandard
//            return cell
//        case pinterestCollectionView:
//            let cell = pinterestCollectionView.dequeueReusableCell(withReuseIdentifier: pinterestId, for: indexPath) as! HomePinterestCell
//            cell.photo.image = UIImage(named: imageNames[indexPath.item])
//            return cell
//        case conflictCollectionView:
//            let cell = conflictCollectionView.dequeueReusableCell(withReuseIdentifier: conflictId, for: indexPath) as! HomeConflict
//            return cell
//        case challengeCollectionView:
//            let cell = challengeCollectionView.dequeueReusableCell(withReuseIdentifier: challengeId, for: indexPath) as! HomeChallenge
//            return cell
//        default:
//            assert(false, "Not a valid collection")
//        }
        
        if collectionView == standardDetailCollectionView {
            cell = standardDetailCollectionView.dequeueReusableCell(withReuseIdentifier: standardId, for: indexPath) as! HomeStandard
        } else if collectionView == pinterestCollectionView {
            cell = pinterestCollectionView.dequeueReusableCell(withReuseIdentifier: pinterestId, for: indexPath) as! HomePinterestCell
//            cell.photo.image = UIImage(named: imageNames[indexPath.item])
            
        } else if collectionView == conflictCollectionView {
            cell = conflictCollectionView.dequeueReusableCell(withReuseIdentifier: conflictId, for: indexPath) as! HomeConflict
        } else {
            cell = challengeCollectionView.dequeueReusableCell(withReuseIdentifier: challengeId, for: indexPath) as! HomeChallenge
        }
        
        return cell
        
//        switch collectionView {
//        case standardDetailCollectionView:
//            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: standardId, for: indexPath) as! HomeStandard
//            return cell
//        case pinterestCollectionView:
//            let cell = pinterestCollectionView.dequeueReusableCell(withReuseIdentifier: pinterestId, for: indexPath) as! HomePinterestCell
//            cell.photo.image = UIImage(named: imageNames[indexPath.item])
//            return cell
//        case conflictCollectionView:
//            let cell = conflictCollectionView.dequeueReusableCell(withReuseIdentifier: conflictId, for: indexPath) as! HomeConflict
//            return cell
//        case challengeCollectionView:
//            let cell = challengeCollectionView.dequeueReusableCell(withReuseIdentifier: challengeId, for: indexPath) as! HomeChallenge
//            return cell
//        default:
//            assert(false, "Not a valid collection")
//        }
    }
}
