//
//  NewHomeCells.swift
//  Inpursuit
//
//  Created by Jaylen Sanders on 1/5/19.
//  Copyright © 2019 Glory. All rights reserved.
//

import UIKit
import iCarousel
import CHIPageControl
import ABSteppedProgressBar

class NewHomeCells : UICollectionViewCell {
    
    var accessHomeViews : HomeViews?
    
    lazy var carouselView : iCarousel = {
        let ic = iCarousel()
        ic.bounces = false
        ic.contentOffset = CGSize(width: 0, height: -2)
        ic.isPagingEnabled = true
        return ic
    }()
    
    let stepProgressView : ABSteppedProgressBar = {
       let view = ABSteppedProgressBar()
        view.numberOfPoints = 2
        view.lineHeight = 3.5
        view.radius = 3.5
        view.progressRadius = 4
        view.progressLineHeight = 2.5
        view.currentIndex = 1
//        progressBar.delegate = self
        view.stepTextColor = UIColor.clear
        view.stepTextFont = UIFont.systemFont(ofSize: 20)
        view.backgroundShapeColor = .darkGray
        view.selectedBackgoundColor = .white
        return view
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
    
    let gradientCard : UIVisualEffectView = {
        let view = UIVisualEffectView()
        view.effect = UIBlurEffect(style: .light)
        view.layer.cornerRadius = 8
        view.layer.masksToBounds = true
        return view
    }()
    
    lazy var saveIcon : UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "bookmark_outline")?.withRenderingMode(.alwaysTemplate), for: .normal)
        button.tintColor = .white
        button.contentMode = .scaleAspectFill
        return button
    }()
    
    lazy var tryIcon : UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "try-icon")?.withRenderingMode(.alwaysTemplate), for: .normal)
        button.tintColor = .white
        button.contentMode = .scaleAspectFill
        return button
    }()
    
    let tryCountLabel : UILabel = {
       let label = UILabel()
        label.text = "0"
        label.font = .systemFont(ofSize: 15)
        label.textColor = .white
        return label
    }()
    
    lazy var responsesIcon : UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "chat_outline")?.withRenderingMode(.alwaysTemplate), for: .normal)
        button.tintColor = .white
        button.contentMode = .scaleAspectFill
        return button
    }()
    
    let responsesCountLabel : UILabel = {
        let label = UILabel()
        label.text = "2 Responses"
        label.font = .systemFont(ofSize: 15)
        label.textColor = .white
        return label
    }()
    
    let userPhoto : UIImageView = {
       let iv = UIImageView()
        iv.image = UIImage(named: "cafe-768771_1280")?.withRenderingMode(.alwaysOriginal)
        iv.contentMode = .scaleAspectFill
        iv.layer.cornerRadius = 25
        iv.layer.masksToBounds = true
//        iv.layer.borderColor = UIColor.white.cgColor
//        iv.layer.borderWidth = 1.5
        return iv
    }()
    
    let usernameLabel : UILabel = {
       let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.text = "Test"
        label.textColor = .white
        return label
    }()
    
    let descriptionLabel : UILabel = {
       let label = UILabel()
        label.textColor = .white
        label.numberOfLines = 1
        label.font = UIFont.systemFont(ofSize: 14)
        label.text = "This is some filler text"
        return label
    }()
    
    var cellIndex : Int = 0
    
    let imageNames = ["cafe-768771_1280", "apartment-architecture-ceiling-259962", "gian-cescon-637914-unsplash", "IMG_0807", "IMG_3935"]
    let profileNames = ["apartment-architecture-ceiling-259962", "cafe-768771_1280", "gian-cescon-637914-unsplash", "IMG_0807", "IMG_3935"]
    let homeDescriptions = ["iChat App","New York Exchange", "Travel App", "Contact Page", "Settings 3d touch"]
    
    func setupCarousels(){
        setupStandardCarousel()
        //        labelSubCarousel()
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
        
        carouselView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 8, width: 0, height: 0)
        pageControl.anchor(top: carouselView.bottomAnchor, left: safeAreaLayoutGuide.leftAnchor, bottom: nil, right: nil, paddingTop: 14, paddingLeft: 16, paddingBottom: 0, paddingRight: 0, width: pageControl.intrinsicContentSize.width, height: 24)
        setupDescriptionCard()
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
    
    func setupDescriptionCard(){
        addSubview(gradientCard)
        addSubview(userPhoto)
        addSubview(usernameLabel)
        addSubview(descriptionLabel)
//        addSubview(stepProgressView)
        
        gradientCard.anchor(top: nil, left: carouselView.leftAnchor, bottom: nil, right: carouselView.rightAnchor, paddingTop: 0, paddingLeft: 18, paddingBottom: 0, paddingRight: 18, width: 0, height: 160)
        gradientCard.centerYAnchor.constraint(equalTo: carouselView.centerYAnchor).isActive = true
//        stepProgressView.anchor(top: gradientCard.topAnchor, left: gradientCard.leftAnchor, bottom: nil, right: gradientCard.rightAnchor, paddingTop: 8, paddingLeft: 8, paddingBottom: 0, paddingRight: 8, width: 0, height: 15)
        userPhoto.anchor(top: gradientCard.topAnchor, left: gradientCard.leftAnchor, bottom: nil, right: nil, paddingTop: 18, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: 50, height: 50)
        usernameLabel.anchor(top: userPhoto.topAnchor, left: userPhoto.rightAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 18, paddingBottom: 0, paddingRight: 0, width: 0, height: 20)
        descriptionLabel.anchor(top: usernameLabel.bottomAnchor, left: usernameLabel.leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 8, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: descriptionLabel.intrinsicContentSize.height)
//        self.stepProgressView.frame = CGRect(x: 0, y: 50, width: 280, height: 100)
//        self.addSubview(self.stepProgressView)
        setupEngagements()
    }
    
    func setupEngagements(){
        addSubview(tryIcon)
        addSubview(tryCountLabel)
        addSubview(responsesIcon)
        addSubview(responsesCountLabel)
        addSubview(saveIcon)
        
        tryIcon.anchor(top: nil, left: userPhoto.leftAnchor, bottom: gradientCard.bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 18, paddingRight: 0, width: 22, height: 22)
        tryCountLabel.centerYAnchor.constraint(equalTo: tryIcon.centerYAnchor).isActive = true
        tryCountLabel.anchor(top: nil, left: tryIcon.rightAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 8, paddingBottom: 0, paddingRight: 0, width: tryCountLabel.intrinsicContentSize.width, height: 16)
        responsesIcon.anchor(top: tryIcon.topAnchor, left: tryCountLabel.rightAnchor, bottom: tryIcon.bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 24, paddingBottom: 0, paddingRight: 0, width: 24, height: 0)
        responsesCountLabel.centerYAnchor.constraint(equalTo: responsesIcon.centerYAnchor).isActive = true
        responsesCountLabel.anchor(top: nil, left: responsesIcon.rightAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 8, paddingBottom: 0, paddingRight: 0, width: responsesCountLabel.intrinsicContentSize.width, height: 16)
        saveIcon.anchor(top: usernameLabel.topAnchor, left: nil, bottom: nil, right: gradientCard.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 12, width: 14, height: 20)
    }
    
    override init(frame: CGRect) {
        super.init(frame : frame)
        setupCarousels()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension NewHomeCells : iCarouselDataSource, iCarouselDelegate {
    
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
            carouselImage = UIImageView(frame: CGRect(x: 0, y: 0, width: frame.width, height: frame.height))
            carouselImage.isUserInteractionEnabled = true
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
            return 0.03
        case .tilt:
            return 0.0
        case .fadeRange:
            return 1.0
        case .visibleItems:
            return CGFloat(imageNames.count)
        default:
            return value
        }
    }
    
    func carouselDidScroll(_ carousel: iCarousel) {
        if carousel == carouselView {
            subCarouselView.scrollOffset = carouselView.scrollOffset
        }
    }
    
//    func carousel(_ carousel: iCarousel, didSelectItemAt index: Int) {
//        accessHomeViews?.changeToDetail()
//    }
    
        @objc func handleLeftTap(){
            carouselView.scrollToItem(at: cellIndex - 1, animated: true)
            cellIndex = cellIndex - 1
    
            if cellIndex < 0 {
                cellIndex = cellIndex + 1
            }
        }
    
        @objc func handleRightTap(){
//            accessHomeViews?.changeToDetail()
    
            carouselView.scrollToItem(at: cellIndex + 1, animated: true)
            cellIndex = cellIndex + 1
    
            if cellIndex > imageNames.count {
                cellIndex = cellIndex - 1
            }
        }
}
