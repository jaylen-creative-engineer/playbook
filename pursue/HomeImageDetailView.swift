//
//  HomeImageDetailView.swift
//  pursue
//
//  Created by Jaylen Sanders on 1/19/18.
//  Copyright © 2018 Glory. All rights reserved.
//

import UIKit

class HomeImageDetailView : UICollectionViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, HomeImageEngagements {
    
    var pursuitsDelegate : HomePursuitsRowDelegate?
    var accessHomeController : HomeContainer?
    let homeCellId = "homeCellId"
    
    let rowLabel : UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.init(25))
        label.text = "Posts"
        label.textAlignment = .left
        return label
    }()
    
    let homeImageNames = ["movie-app", "messenger-app", "workout", "wim-hof", "meditation"]
    let homePursuitDescriptions = ["Movie App", "Messenger App", "Gain 15 Pounds", "Wim Hof Breathing", "Guided Meditation"]
    
    let homePursuitsCollection : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.isScrollEnabled = false
        return collectionView
    }()
    
    func homeTapped() {
        accessHomeController?.handleChangeToDetail(viewType: "isImageDetail")
    }
    
    func homeHeld() {
        pursuitsDelegate?.pursuitHeld()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width, height: 155)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(0, 12, 0, 12)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        accessHomeController?.handleChangeToDetail(viewType: "isImageDetail")
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: homeCellId, for: indexPath) as! HomeRowCells
        cell.delegate = self
        cell.postImage.image = UIImage(named: homeImageNames[indexPath.item])?.withRenderingMode(.alwaysOriginal)
        cell.homeMainDescription.text = homePursuitDescriptions[indexPath.item]
        return cell
    }
    
    func setupView() {
        addSubview(rowLabel)
        addSubview(homePursuitsCollection)
        
        rowLabel.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 24, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: 0, height: 20)
        homePursuitsCollection.anchor(top: rowLabel.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 12, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 500)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        
        homePursuitsCollection.register(HomeRowCells.self, forCellWithReuseIdentifier: homeCellId)
        homePursuitsCollection.delegate = self
        homePursuitsCollection.dataSource = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
