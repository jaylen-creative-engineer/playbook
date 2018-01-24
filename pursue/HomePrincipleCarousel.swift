//
//  HomePrincipleCarousel.swift
//  pursue
//
//  Created by Jaylen Sanders on 1/19/18.
//  Copyright © 2018 Glory. All rights reserved.
//

import UIKit
import iCarousel

class HomePrincipleCarousel : UICollectionViewCell, HomeImageEngagements, iCarouselDataSource, iCarouselDelegate {
    
    var accessHomeController : HomeController?
    var homeDelegate : HomeRowImageEngagements?
    
    var itemView : UIImageView = {
        let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "ferrari")
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    lazy var carouselView : iCarousel = {
        let ic = iCarousel()
        return ic
    }()
    
    lazy var subCarouselView : iCarousel = {
        let ic = iCarousel()
        return ic
    }()
    
    let imageNames = ["ferrari", "pagani", "travel", "contacts", "3d-touch"]
    let homeDescriptions = ["iChat App", "New York Exchange", "Travel App", "Contact Page", "Settings 3d touch"]
    var items: [Int] = []
    
    func homeTapped() {
        homeDelegate?.homeRowImageTapped()
    }
    
    func homeHeld() {
        homeDelegate?.homeRowImageHeld()
    }
    
    func numberOfItems(in carousel: iCarousel) -> Int {
        return 5
    }
    
    func carousel(_ carousel: iCarousel, viewForItemAt index: Int, reusing view: UIView?) -> UIView {
        var carouselImage = UIImageView()

        if carousel == carouselView {
            carouselImage = UIImageView(frame: CGRect(x: 0, y: 0, width: 320, height: 310))
            carouselImage.image = UIImage(named: imageNames[index])?.withRenderingMode(.alwaysOriginal)
            carouselImage.contentMode = .scaleAspectFill
            carouselImage.layer.cornerRadius = 4
            carouselImage.layer.masksToBounds = true
        } else if carousel == subCarouselView {
            carouselImage = UIImageView(frame: CGRect(x: 0, y: 40, width: 400, height: 100))
            
            let shadowLabel = UILabel()
            shadowLabel.font = UIFont.systemFont(ofSize: 18, weight: UIFont.Weight(25))
            shadowLabel.textAlignment = .justified
            shadowLabel.numberOfLines = 2
            shadowLabel.sizeToFit()
            
            carouselImage.addSubview(shadowLabel)
            shadowLabel.anchor(top: nil, left: carouselImage.leftAnchor, bottom: carouselImage.bottomAnchor, right: carouselImage.rightAnchor, paddingTop: 0, paddingLeft: 24, paddingBottom: 0, paddingRight: 24, width: 0, height: 70)
            toggleLike(label: shadowLabel, index: index)
        }
        
       
        return carouselImage
    }
    
    func carousel(_ carousel: iCarousel, valueFor option: iCarouselOption, withDefault value: CGFloat) -> CGFloat {
        if (option == .spacing) {
            return value * 0.6
        } else if carousel == subCarouselView {
            return value * 0.6
        }
        
        return value
    }
    
    @objc func toggleLike(label : UILabel, index : Int){
        label.backgroundColor = .clear
        label.text = homeDescriptions[index]
    }
    
    
    func carouselDidScroll(_ carousel: iCarousel) {
        if carousel == carouselView {
            subCarouselView.scrollOffset = carouselView.scrollOffset
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let guide = safeAreaLayoutGuide
        addSubview(carouselView)
        addSubview(subCarouselView)
        carouselView.anchor(top: topAnchor, left: guide.leftAnchor, bottom: nil, right: guide.rightAnchor, paddingTop: 32, paddingLeft: 0, paddingBottom: 0, paddingRight: 18, width: 0, height: 280)
        subCarouselView.anchor(top: carouselView.bottomAnchor, left: guide.leftAnchor, bottom: nil, right: guide.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 60)
        carouselView.dataSource = self
        carouselView.delegate = self
        subCarouselView.dataSource = self
        subCarouselView.delegate = self
        carouselView.type = .invertedTimeMachine
        subCarouselView.type = .invertedCylinder
        subCarouselView.backgroundColor = .clear
        subCarouselView.isVertical = true
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
