//
//  HomeDiscussionCarousel.swift
//  pursue
//
//  Created by Jaylen Sanders on 1/19/18.
//  Copyright © 2018 Glory. All rights reserved.
//

import UIKit
import iCarousel

class HomeDiscussionCarousel : UICollectionViewCell, HomeImageEngagements, iCarouselDataSource, iCarouselDelegate {
    
    var accessHomeController : HomeController?
    var homeDelegate : HomeRowImageEngagements?
    
    lazy var carouselView : iCarousel = {
        let ic = iCarousel()
        return ic
    }()
    
    let imageNames = ["ferrari", "pagani", "travel", "contacts", "3d-touch"]
    let homeDescriptions = ["iChat App", "New York Exchange", "Travel App", "Contact Page", "Settings 3d touch"]
    
    func homeTapped() {
        homeDelegate?.homeRowImageTapped()
    }
    
    func homeHeld() {
        homeDelegate?.homeRowImageHeld()
    }
    
    func numberOfItems(in carousel: iCarousel) -> Int {
        if carousel == carouselView {
            return imageNames.count
        } else {
            return homeDescriptions.count
        }
    }
    
    func carousel(_ carousel: iCarousel, viewForItemAt index: Int, reusing view: UIView?) -> UIView {
        var carouselImage = UIImageView()
        carouselImage = UIImageView(frame: CGRect(x: 0, y: 0, width: 325, height: 225))
        carouselImage.image = UIImage(named: imageNames[index])?.withRenderingMode(.alwaysOriginal)
        carouselImage.contentMode = .scaleAspectFill
        carouselImage.layer.cornerRadius = 4
        carouselImage.layer.masksToBounds = true
        
        return carouselImage
    }
    
    func carousel(_ carousel: iCarousel, valueFor option: iCarouselOption, withDefault value: CGFloat) -> CGFloat {
        if (option == .spacing) {
            return value * 0.6
        }
        
        return value
    }
    
    @objc func toggleLike(label : UILabel, index : Int){
        label.backgroundColor = .clear
        label.text = homeDescriptions[index]
    }
    
    func carousel(_ carousel: iCarousel, didSelectItemAt index: Int) {
        accessHomeController?.handleChangeToDetail(viewType: "isDiscussionDetail")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let guide = safeAreaLayoutGuide
        addSubview(carouselView)
        carouselView.anchor(top: topAnchor, left: guide.leftAnchor, bottom: nil, right: guide.rightAnchor, paddingTop: 24, paddingLeft: 0, paddingBottom: 0, paddingRight: 18, width: 0, height: 235)
        carouselView.dataSource = self
        carouselView.delegate = self
        carouselView.type = .invertedTimeMachine
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
