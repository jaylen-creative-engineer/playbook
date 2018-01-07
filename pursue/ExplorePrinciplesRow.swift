//
//  ChallengesRow.swift
//  pursue
//
//  Created by Jaylen Sanders on 10/23/17.
//  Copyright © 2017 Glory. All rights reserved.
//

import UIKit

protocol ExplorePrincipleDelegate {
    func explorePrincipleTapped()
    func explorePrincipleHeld()
}

class ExplorePrinciplesRow : UICollectionViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, ExplorePrincipleCellsDelegate {
    
    var exploreDelegate : ExplorePrincipleDelegate?
    
    let rowLabel : UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 12, weight: UIFont.Weight.init(25))
        return label
    }()
    
    lazy var moreButton : UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "right-arrow-1").withRenderingMode(.alwaysOriginal), for: .normal)
        return button
    }()
    
    let cellId = "cellId"
    let peopleId = "peopleId"
    let exploreImageNames = ["mel-robbins", "menu-numbers", "go-back", "change-location"]
    let exploreLabelText = ["Show value upfront", "Organize and label menu categories", "Allow users to go back easily in one step.", "Make it easy to manually change location."]
    
    let postCollection : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (frame.width / 2) + 20, height: ((frame.width - 2) / 2) + 80)
    }
    
    func explorePrincipleTapped() {
        exploreDelegate?.explorePrincipleTapped()
    }
    
    func explorePrincipleHeld() {
        exploreDelegate?.explorePrincipleHeld()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ExplorePrincipleCells
        cell.explorePrincipleDelegate = self
        cell.exploreImage.image = UIImage(named: exploreImageNames[indexPath.item])?.withRenderingMode(.alwaysOriginal)
        cell.exploreLabel.text = exploreLabelText[indexPath.item]
        rowLabel.text = "DESIGN PRINCIPLES"
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(0, 12, 0, 12)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(postCollection)
        addSubview(rowLabel)
        addSubview(moreButton)
        rowLabel.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 32, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: rowLabel.intrinsicContentSize.width, height: rowLabel.intrinsicContentSize.height)
        postCollection.anchor(top: rowLabel.bottomAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 18, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        moreButton.anchor(top: rowLabel.topAnchor, left: nil, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 20, width: 24, height: 12)
        postCollection.showsHorizontalScrollIndicator = false
        postCollection.register(ExplorePrincipleCells.self, forCellWithReuseIdentifier: cellId)
        postCollection.dataSource = self
        postCollection.delegate = self
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
