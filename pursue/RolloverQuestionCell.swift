//
//  RolloverQuestionCell.swift
//  Inpursuit
//
//  Created by Jaylen Sanders on 1/12/19.
//  Copyright © 2019 Glory. All rights reserved.
//

import UIKit
import iCarousel
import CHIPageControl

class RolloverQuestionCell : UICollectionViewCell, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UICollectionViewDelegate {
    
    let headerId = "headerId"
    let cellId = "cellId"
    let tableId = "tableId"
    
    let questionsLabel : UILabel = {
       let label = UILabel()
        label.text = "QUESTIONS"
        label.font = UIFont.boldSystemFont(ofSize: 12)
        return label
    }()
    
    let imageNames = ["cafe-768771_1280", "apartment-architecture-ceiling-259962", "gian-cescon-637914-unsplash", "IMG_0807", "IMG_3935"]
    let profileNames = ["apartment-architecture-ceiling-259962", "cafe-768771_1280", "gian-cescon-637914-unsplash", "IMG_0807", "IMG_3935"]
    let homeDescriptions = ["iChat App","New York Exchange", "Travel App", "Contact Page", "Settings 3d touch"]
    
    lazy var pageControl: CHIPageControlAleppo = {
        let pc = CHIPageControlAleppo()
        pc.radius = 3
        pc.currentPageTintColor = .black
        pc.numberOfPages = imageNames.count
        pc.tintColor = .gray
        return pc
    }()
    
    lazy var carouselView : iCarousel = {
        let ic = iCarousel()
        ic.bounces = false
        ic.contentOffset = CGSize(width: 4, height: -2)
        ic.isPagingEnabled = true
        return ic
    }()
    
    let collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.isScrollEnabled = false
        cv.showsVerticalScrollIndicator = false
        cv.backgroundColor = .clear
        return cv
    }()
    
    let viewMoreButton : UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("VIEW MORE", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 12)
        return button
    }()
    
    let answersLabel : UILabel = {
        let label = UILabel()
        label.text = "ANSWERS"
        label.font = UIFont.boldSystemFont(ofSize: 12)
        return label
    }()
    
    let scrollView : UIScrollView = {
        let sv = UIScrollView()
        sv.backgroundColor = .red
        sv.showsHorizontalScrollIndicator = false
        sv.showsVerticalScrollIndicator = false
        sv.backgroundColor = .white
        sv.isPagingEnabled = true
        sv.isDirectionalLockEnabled = true
        return sv
    }()
    
    var headers = [UIView]()
    
    func setupCollectionView(){
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(RolloverAnswerCell.self, forCellWithReuseIdentifier: cellId)

        addSubview(questionsLabel)
        addSubview(viewMoreButton)
        addSubview(collectionView)
        addSubview(answersLabel)

        questionsLabel.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 18, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: questionsLabel.intrinsicContentSize.width, height: 14)
        viewMoreButton.anchor(top: nil, left: nil, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 18, paddingRight: 18, width: viewMoreButton.intrinsicContentSize.width, height: 14)
        setupStandardCarousel()
        answersLabel.anchor(top: carouselView.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 32, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: answersLabel.intrinsicContentSize.width, height: 16)
        answersLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        collectionView.anchor(top: answersLabel.bottomAnchor, left: leftAnchor, bottom: viewMoreButton.topAnchor, right: rightAnchor, paddingTop: 12, paddingLeft: 0, paddingBottom: 18, paddingRight: 0, width: 0, height: 0)
       
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        setupCollectionView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (frame.width / 2) - 18, height: 252)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10.0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10.0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! RolloverAnswerCell
        return cell
    }

}

extension RolloverQuestionCell : iCarouselDataSource, iCarouselDelegate {
    
    func numberOfItems(in carousel: iCarousel) -> Int {
        return imageNames.count

    }
    
    func carousel(_ carousel: iCarousel, viewForItemAt index: Int, reusing view: UIView?) -> UIView {
        let carouselImage = DetailQuestionBackground(frame: CGRect(x: 0, y: 0, width: frame.width - 24, height: 250))
        carouselImage.isUserInteractionEnabled = true
        carouselImage.layer.masksToBounds = true
        carouselImage.contentMode = .scaleAspectFill
        
        if !imageNames.isEmpty {
            carouselImage.image = UIImage(named: imageNames[index])
        }
        
        let overlayView = UIView()
        overlayView.backgroundColor = UIColor.init(white: 0.4, alpha: 0.6)
        overlayView.translatesAutoresizingMaskIntoConstraints = false
        overlayView.layer.cornerRadius = 8
        overlayView.layer.masksToBounds = true
        
        let questionDescriptionLabel = UILabel()
        questionDescriptionLabel.text = "This is filler text"
        questionDescriptionLabel.textColor = .white
        questionDescriptionLabel.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.init(25))
        
        let solvedButton = UIButton()
        solvedButton.layer.cornerRadius = 4
        solvedButton.layer.masksToBounds = true
        solvedButton.backgroundColor = .white
        solvedButton.setTitle("Solved", for: .normal)
        solvedButton.contentHorizontalAlignment = .center
        solvedButton.contentVerticalAlignment = .center
        solvedButton.setTitleColor(.black, for: .normal)
        solvedButton.titleLabel?.font = UIFont.systemFont(ofSize: 12, weight: UIFont.Weight.init(25))
        
        let timeAgoLabel = UILabel()
        timeAgoLabel.text = "3 Days Ago"
        timeAgoLabel.font = UIFont.boldSystemFont(ofSize: 16)
        timeAgoLabel.textColor = .white
        
        carouselImage.addSubview(overlayView)
        carouselImage.addSubview(timeAgoLabel)
        carouselImage.addSubview(questionDescriptionLabel)
        carouselImage.addSubview(solvedButton)
        
        overlayView.anchor(top: carouselImage.topAnchor, left: carouselImage.leftAnchor, bottom: carouselImage.bottomAnchor, right: carouselImage.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        timeAgoLabel.anchor(top: nil, left: overlayView.leftAnchor, bottom: overlayView.bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 12, paddingBottom: 24, paddingRight: 0, width: timeAgoLabel.intrinsicContentSize.width, height: 18)
        questionDescriptionLabel.anchor(top: nil, left: overlayView.leftAnchor, bottom: timeAgoLabel.topAnchor, right: overlayView.rightAnchor, paddingTop: 0, paddingLeft: 12, paddingBottom: 8, paddingRight: 12, width: 0, height: 0)
        questionDescriptionLabel.heightAnchor.constraint(lessThanOrEqualToConstant: 44).isActive = true
        solvedButton.anchor(top: overlayView.topAnchor, left: overlayView.leftAnchor, bottom: nil, right: nil, paddingTop: 12, paddingLeft: 18, paddingBottom: 0, paddingRight: 0, width: solvedButton.intrinsicContentSize.width + 15, height: 24)
        
        return carouselImage
        
    }
    

    func carousel(_ carousel: iCarousel, valueFor option: iCarouselOption, withDefault value: CGFloat) -> CGFloat {

        switch option {
        case .spacing:
            return 1.15
        case .visibleItems:
            return CGFloat(imageNames.count)
        default:
            return value
        }
    }
    
    func carouselDidScroll(_ carousel: iCarousel) {
        if carousel == carouselView {
//            subCarouselView.scrollOffset = carouselView.scrollOffset
        }
    }
    
    func carousel(_ carousel: iCarousel, didSelectItemAt index: Int) {
//        accessHomeViews?.changeToDetail()
    }
    
    func carouselCurrentItemIndexDidChange(_ carousel: iCarousel) {
        let currentIndex = carouselView.currentItemIndex
        pageControl.set(progress: currentIndex, animated: true)
    }
    
    
    func setupStandardCarousel(){
        carouselView.dataSource = self
        carouselView.delegate = self
        carouselView.type = .linear
        
        addSubview(carouselView)
//        addSubview(pageControl)
        
        carouselView.anchor(top: questionsLabel.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 18, paddingLeft: 0, paddingBottom: 0, paddingRight: 8, width: 0, height: 250)
//        pageControl.anchor(top: carouselView.bottomAnchor, left: safeAreaLayoutGuide.leftAnchor, bottom: nil, right: nil, paddingTop: 14, paddingLeft: 16, paddingBottom: 0, paddingRight: 0, width: pageControl.intrinsicContentSize.width, height: 24)
    }
}

