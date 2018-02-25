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
    func homeRowScrolled(for cell : HomeRow)
}

class HomeRow: UICollectionViewCell, iCarouselDataSource, iCarouselDelegate {
    
    var accessHomeController : HomeContainer?
    var homeDelegate : HomeRowImageEngagements?
    let pursuitId = "pursuitId"
    let principleId = "principleId"
    let stepId = "stepId"
    
    let homeImageNames = ["movie-app", "messenger-app", "workout", "wim-hof", "meditation"]
    let homePursuitDescriptions = ["Movie App", "Messenger App", "Gain 15 Pounds", "Wim Hof Breathing", "Guided Meditation"]
    
    lazy var carouselView : iCarousel = {
       let ic = iCarousel()
        return ic
    }()
    
    lazy var subCarouselView : iCarousel = {
      let ic = iCarousel()
        return ic
    }()
    
    var isLiked = false
    
    let imageNames = ["ferrari", "pagani", "travel", "contacts", "3d-touch"]
    let homeDescriptions = ["iChat App", "New York Exchange", "Travel App", "Contact Page", "Settings 3d touch"]

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
    
    func homeTapped() {
    }
    
    func homeHeld() {
    }
    
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
            carouselImage = UIImageView(frame: CGRect(x: 0, y: 0, width: 400, height: 100))
            
            let shadowLabel = UILabel()
            shadowLabel.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight(25))
            shadowLabel.textAlignment = .justified
            shadowLabel.numberOfLines = 2
            shadowLabel.sizeToFit()
            
            carouselImage.addSubview(shadowLabel)
            shadowLabel.anchor(top: nil, left: carouselImage.leftAnchor, bottom: carouselImage.bottomAnchor, right: carouselImage.rightAnchor, paddingTop: 0, paddingLeft: 24, paddingBottom: 0, paddingRight: 24, width: 0, height: 70)
            toggleLike(label: shadowLabel, index: index)
            return carouselImage
        case carouselView:
            carouselImage = UIImageView(frame: CGRect(x: 0, y: 0, width: 325, height: 400))
            
            carouselImage.image = UIImage(named: imageNames[index])?.withRenderingMode(.alwaysOriginal)
            carouselImage.contentMode = .scaleAspectFill
            carouselImage.layer.cornerRadius = 4
            carouselImage.layer.masksToBounds = true
            
            let blueView = UIView()
            blueView.backgroundColor = .blue
            blueView.translatesAutoresizingMaskIntoConstraints = false
            
            let redView = UIView()
            redView.backgroundColor = .red
            redView.translatesAutoresizingMaskIntoConstraints = false
            
            carouselImage.addSubview(blueView)
            carouselImage.addSubview(redView)
            blueView.anchor(top: carouselImage.topAnchor, left: carouselImage.leftAnchor, bottom: carouselImage.bottomAnchor, right: carouselImage.centerXAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
            redView.anchor(top: carouselImage.topAnchor, left: carouselImage.centerXAnchor, bottom: carouselImage.bottomAnchor, right: carouselImage.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
            return carouselImage
        default:
            return carouselImage
        }

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
            homeDelegate?.homeRowScrolled(for: self)
            subCarouselView.scrollOffset = carouselView.scrollOffset
        }
    }
    
    func carousel(_ carousel: iCarousel, didSelectItemAt index: Int) {
        accessHomeController?.handleChangeToDetail(viewType: "isImageDetail")
    }

    func setupCarousels(){
        setupStandardCarousel()
        labelSubCarousel()
    }
    
    func setupStandardCarousel(){
        carouselView.dataSource = self
        carouselView.delegate = self
        carouselView.type = .invertedTimeMachine
        
        let guide = safeAreaLayoutGuide
        addSubview(carouselView)
        carouselView.anchor(top: topAnchor, left: guide.leftAnchor, bottom: nil, right: guide.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 28, width: 0, height: 412)
    }
    
    func labelSubCarousel(){
        subCarouselView.dataSource = self
        subCarouselView.delegate = self
        subCarouselView.isScrollEnabled = false
        subCarouselView.type = .invertedCylinder
        subCarouselView.backgroundColor = .clear
        subCarouselView.isVertical = true
        
        let guide = safeAreaLayoutGuide
        addSubview(subCarouselView)
        subCarouselView.anchor(top: carouselView.bottomAnchor, left: guide.leftAnchor, bottom: nil, right: guide.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 60)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCarousels()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


