//
//  HomePursuits.swift
//  pursue
//
//  Created by Jaylen Sanders on 12/6/17.
//  Copyright © 2017 Glory. All rights reserved.
//

import UIKit

protocol HomePursuitsRowDelegate {
    func showPursuitsFeed()
    func pursuitClicked()
    func pursuitHeld()
}

class HomePursuits : UICollectionViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, PursuitSelected {
    
    var pursuitsDelegate : HomePursuitsRowDelegate?
    let homeCellId = "homeCellId"
    
    let rowLabel : UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.init(25))
        label.text = "Your Pursuits"
        label.textAlignment = .left
        return label
    }()
    
    let homeImageNames = ["movie-app", "messenger-app", "workout", "wim-hof", "meditation"]
    let homePursuitDescriptions = ["Movie App", "Messenger App", "Gain 15 Pounds", "Wim Hof Breathing", "Guided Meditation"]

    lazy var homeMoreButton : UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "right-arrow-1").withRenderingMode(.alwaysOriginal), for: .normal)
        button.addTarget(self, action: #selector(handlePursuitsChange), for: .touchUpInside)
        return button
    }()
    
    let homePursuitsCollection : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    @objc func handlePursuitsChange(){
        pursuitsDelegate?.showPursuitsFeed()
    }
    
    func pursuitTapped() {
        pursuitsDelegate?.pursuitClicked()
    }
    
    func pursuitHeld() {
        pursuitsDelegate?.pursuitHeld()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: ((frame.width - 2) / 2) + 125, height: 300)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(0, 12, 0, 12)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: homeCellId, for: indexPath) as! HomePursuitsCells
        cell.homePursuitImage.image = UIImage(named: homeImageNames[indexPath.item])?.withRenderingMode(.alwaysOriginal)
        cell.homePursuitLabel.text = homePursuitDescriptions[indexPath.item]
        cell.homePursuitDelegate = self
        return cell
    }
    
     func setupView() {
        addSubview(rowLabel)
        addSubview(homePursuitsCollection)
        addSubview(homeMoreButton)
        
        rowLabel.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 24, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: 0, height: 20)
        homePursuitsCollection.anchor(top: rowLabel.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 24, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 275)
        homeMoreButton.anchor(top: rowLabel.topAnchor, left: nil, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 20, width: 24, height: 12)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        
        homePursuitsCollection.register(HomePursuitsCells.self, forCellWithReuseIdentifier: homeCellId)
        homePursuitsCollection.delegate = self
        homePursuitsCollection.dataSource = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
