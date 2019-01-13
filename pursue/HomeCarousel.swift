//
//  HomeCarousel.swift
//  Inpursuit
//
//  Created by Jaylen Sanders on 12/23/18.
//  Copyright © 2018 Glory. All rights reserved.
//

import UIKit
import iCarousel
import CHIPageControl

class HomeCarousel : UICollectionViewCell {
    
    var accessHomeViews : HomeViews?
    
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
    
    var cellIndex : Int = 0
    
    let imageNames = ["cafe-768771_1280", "apartment-architecture-ceiling-259962", "gian-cescon-637914-unsplash", "IMG_0807", "IMG_3935"]
    let profileNames = ["apartment-architecture-ceiling-259962", "cafe-768771_1280", "gian-cescon-637914-unsplash", "IMG_0807", "IMG_3935"]
    let homeDescriptions = ["iChat App","New York Exchange", "Travel App", "Contact Page", "Settings 3d touch"]
    
    override init(frame: CGRect) {
        super.init(frame : frame)
        setupCarousels()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension HomeCarousel : iCarouselDataSource, iCarouselDelegate {
    
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
            
            if !imageNames.isEmpty {
                carouselImage.image = UIImage(named: imageNames[index])
            }
            
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
    
    func carousel(_ carousel: iCarousel, didSelectItemAt index: Int) {
        accessHomeViews?.changeToDetail()
    }
    
//    @objc func handleLeftTap(){
//        carouselView.scrollToItem(at: cellIndex - 1, animated: true)
//        cellIndex = cellIndex - 1
//
//        if cellIndex < 0 {
//            cellIndex = cellIndex + 1
//        }
//    }
//
//    @objc func handleRightTap(){
//        accessHomeViews?.changeToDetail()
//
////        carouselView.scrollToItem(at: cellIndex + 1, animated: true)
////        cellIndex = cellIndex + 1
////
////        if cellIndex > imageNames.count {
////            cellIndex = cellIndex - 1
////        }
//    }
    
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
        
        addSubview(carouselView)
        addSubview(pageControl)
        
        carouselView.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 18, paddingLeft: 0, paddingBottom: 0, paddingRight: 8, width: 0, height: 385)
        pageControl.anchor(top: carouselView.bottomAnchor, left: safeAreaLayoutGuide.leftAnchor, bottom: nil, right: nil, paddingTop: 14, paddingLeft: 16, paddingBottom: 0, paddingRight: 0, width: pageControl.intrinsicContentSize.width, height: 24)
    }
    
    func labelSubCarousel(){
        subCarouselView.dataSource = self
        subCarouselView.delegate = self
        subCarouselView.isScrollEnabled = false
        subCarouselView.type = .linear
        subCarouselView.backgroundColor = .clear
        subCarouselView.isVertical = true
        
        addSubview(subCarouselView)
        subCarouselView.anchor(top: pageControl.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 60)
        
    }
}
