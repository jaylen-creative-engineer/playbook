//
//  HomeImageCarousel.swift
//  pursue
//
//  Created by Jaylen Sanders on 1/19/18.
//  Copyright © 2018 Glory. All rights reserved.
//

import UIKit
import iCarousel

class HomeImageCarousel : UICollectionViewCell, HomeImageEngagements, iCarouselDataSource, iCarouselDelegate {
    
    var accessHomeController : HomeController?
    var categoryDetailController : CategoryDetailController?
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
        if carousel == carouselView {
            return imageNames.count
        } else {
            return homeDescriptions.count
        }
    }
    
    func carousel(_ carousel: iCarousel, viewForItemAt index: Int, reusing view: UIView?) -> UIView {
        var carouselImage = UIImageView()
        
        if carousel == subCarouselView {
            carouselImage = UIImageView(frame: CGRect(x: 0, y: 40, width: 400, height: 100))
            carouselImage.contentMode = .scaleAspectFill
            carouselImage.layer.cornerRadius = 4
            carouselImage.layer.masksToBounds = true
            
            let shadowLabel = UILabel()
            shadowLabel.font = UIFont.systemFont(ofSize: 18, weight: UIFont.Weight(25))
            shadowLabel.textAlignment = .justified
            shadowLabel.numberOfLines = 2
            shadowLabel.sizeToFit()
            
            carouselImage.addSubview(shadowLabel)
            shadowLabel.anchor(top: nil, left: carouselImage.leftAnchor, bottom: carouselImage.bottomAnchor, right: carouselImage.rightAnchor, paddingTop: 0, paddingLeft: 24, paddingBottom: 0, paddingRight: 24, width: 0, height: 70)
            toggleLike(label: shadowLabel, index: index)
            
        } else if carousel == carouselView{
            carouselImage = UIImageView(frame: CGRect(x: 0, y: 0, width: 300, height: 400))
            carouselImage.image = UIImage(named: imageNames[index])?.withRenderingMode(.alwaysOriginal)
            carouselImage.contentMode = .scaleAspectFill
            carouselImage.layer.cornerRadius = 4
            carouselImage.layer.masksToBounds = true
        }
        
        return carouselImage
    }
    
    func carousel(_ carousel: iCarousel, valueFor option: iCarouselOption, withDefault value: CGFloat) -> CGFloat {
        if (option == .spacing) {
            return value * 0.6
        }  else if carousel == subCarouselView {
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
    
    func carousel(_ carousel: iCarousel, didSelectItemAt index: Int) {
        accessHomeController?.handleChangeToDetail(viewType: "isImageDetail")
        categoryDetailController?.handleChangeToDetail(viewType: "isImageDetail")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let guide = safeAreaLayoutGuide
        addSubview(carouselView)
        addSubview(subCarouselView)
        subCarouselView.backgroundColor = .clear
        carouselView.anchor(top: topAnchor, left: guide.leftAnchor, bottom: nil, right: guide.rightAnchor, paddingTop: 12, paddingLeft: 0, paddingBottom: 0, paddingRight: 28, width: 0, height: 412)
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
