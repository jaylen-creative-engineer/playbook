//
//  HomeRow.swift
//  pursue
//
//  Created by Jaylen Sanders on 9/21/17.
//  Copyright © 2017 Glory. All rights reserved.
//

import UIKit
import iCarousel

protocol HomeRowImageEngagements {
    func homeRowImageTapped()
    func homeRowImageHeld()
}

class HomeRow: UICollectionViewCell, HomeImageEngagements, iCarouselDataSource, iCarouselDelegate {
    
    var accessHomeController : HomeController?
    var homeDelegate : HomeRowImageEngagements?
    
    var itemView : UIImageView = {
        let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "ferrari")
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    var carouselView : iCarousel = {
       let ic = iCarousel()
        return ic
    }()
    
    var imageLabel : UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 50)
        label.tag = 1
        return label
    }()
    
    let imageNames = ["ferrari", "pagani", "travel", "contacts", "3d-touch"]
    let homeDescriptions = ["iChat App", "New York Exchange", "Travel App", "Contact Page", "Settings 3d touch"]
    var items: [Int] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        items = [0, 1, 2, 3, 4, 5]
    }
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
        let tempView = UIView(frame: CGRect(x: 0, y: 0, width: 300, height: 400))
        tempView.backgroundColor = .blue
        tempView.layer.cornerRadius = 4
        tempView.layer.masksToBounds = true
        
        let carouselImage = UIImageView()
        carouselImage.image = #imageLiteral(resourceName: "ferrari-f70")
        carouselImage.contentMode = .scaleAspectFill
        
//        tempView.addSubview(carouselImage)
//        carouselImage.anchor(top: tempView.topAnchor, left: tempView.leftAnchor, bottom: tempView.bottomAnchor, right: tempView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        return tempView
    }
    
    func carousel(_ carousel: iCarousel, valueFor option: iCarouselOption, withDefault value: CGFloat) -> CGFloat {
        if (option == .spacing) {
            return value * 1.2
        }
        
        return value
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let guide = safeAreaLayoutGuide
        addSubview(carouselView)
        carouselView.anchor(top: topAnchor, left: guide.leftAnchor, bottom: bottomAnchor, right: guide.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        carouselView.dataSource = self
        carouselView.delegate = self
        carouselView.type = .invertedTimeMachine
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
