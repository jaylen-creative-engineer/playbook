//
//  SearchPursuits.swift
//  pursue
//
//  Created by Jaylen Sanders on 2/15/18.
//  Copyright © 2018 Glory. All rights reserved.
//

import UIKit

class SearchPursuits : UICollectionViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, PursuitSelected {
    
    var pursuitsDelegate : HomePursuitsRowDelegate?
    var accessHomeController : HomeContainer?
    let homeCellId = "homeCellId"
    
    let rowLabel : UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.init(25))
        label.text = "Steps"
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
    
    func pursuitTapped() {
        pursuitsDelegate?.pursuitClicked()
    }
    
    func pursuitHeld() {
        pursuitsDelegate?.pursuitHeld()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width, height: 105)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(0, 12, 0, 12)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        accessHomeController?.handleChangeToDetail(viewType: "isPursuitDetail")
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: homeCellId, for: indexPath) as! HomeStepCells
        cell.pursuitImage.image = UIImage(named: homeImageNames[indexPath.item])?.withRenderingMode(.alwaysOriginal)
        cell.pursuitLabel.text = homePursuitDescriptions[indexPath.item]
        cell.delegate = self
        return cell
    }
    
    func setupView() {
        addSubview(rowLabel)
        addSubview(homePursuitsCollection)
        
        rowLabel.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 24, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: 0, height: 20)
        homePursuitsCollection.anchor(top: rowLabel.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 12, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 355)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        
        homePursuitsCollection.register(HomeStepCells.self, forCellWithReuseIdentifier: homeCellId)
        homePursuitsCollection.delegate = self
        homePursuitsCollection.dataSource = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
