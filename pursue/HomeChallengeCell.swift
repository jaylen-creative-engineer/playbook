//
//  HomeChallengeCell.swift
//  Inpursuit
//
//  Created by Jaylen Sanders on 12/20/18.
//  Copyright © 2018 Glory. All rights reserved.
//

import UIKit

class HomeChallengeCell : UICollectionViewCell {
    
    let collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    let challengeLabel : UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.text = "Cooking Challenges"
        label.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.init(25))
        return label
    }()
    
    let cellBackgroundView : HomeCellConflictShadowView = {
        let view = HomeCellConflictShadowView()
        view.backgroundColor = .white
        return view
    }()
    
    let cellId = "cellId"
    
    func setupCollectionView(){
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(HomeChallenge.self, forCellWithReuseIdentifier: cellId)
        
        addSubview(cellBackgroundView)
        addSubview(challengeLabel)
        addSubview(collectionView)
        
        cellBackgroundView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 12, paddingBottom: 0, paddingRight: 12, width: 0, height: 0)
        challengeLabel.anchor(top: cellBackgroundView.topAnchor, left: cellBackgroundView.leftAnchor, bottom: nil, right: nil, paddingTop: 18, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: challengeLabel.intrinsicContentSize.width, height: 18)
        collectionView.anchor(top: challengeLabel.bottomAnchor, left: leftAnchor, bottom: cellBackgroundView.bottomAnchor, right: rightAnchor, paddingTop: 24, paddingLeft: 0, paddingBottom: 20, paddingRight: 0, width: 0, height: 0)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCollectionView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension HomeChallengeCell : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width - 24, height: 280)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 35.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 35.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 24)
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! HomeChallenge
        return cell
    }
}
