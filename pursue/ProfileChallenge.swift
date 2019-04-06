//
//  ProfileChallengeView.swift
//  Inpursuit
//
//  Created by Jaylen Sanders on 12/28/18.
//  Copyright © 2018 Glory. All rights reserved.
//

import UIKit

class ProfileChallenge : UICollectionViewCell {
    
    let challengeLabel : UILabel = {
        let label = UILabel()
        label.text = "Challenge"
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    
    let challengeCountLabel : UILabel = {
        let label = UILabel()
        label.text = "3"
        label.textColor = .darkGray
        label.font = UIFont.boldSystemFont(ofSize: 14)
        return label
    }()
    
    let collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .clear
        cv.showsHorizontalScrollIndicator = false
        return cv
    }()
    
    let cellId = "cellId"
    
    func setupCollectionView(){
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(ProfileChallengeCell.self, forCellWithReuseIdentifier: cellId)
        
        addSubview(collectionView)
        collectionView.anchor(top: challengeLabel.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 6, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 240)
    }
    
    func setupView(){
        addSubview(challengeLabel)
        addSubview(challengeCountLabel)
        
        challengeLabel.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: challengeLabel.intrinsicContentSize.width, height: 20)
        challengeCountLabel.anchor(top: nil, left: challengeLabel.rightAnchor, bottom: challengeLabel.bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 6, paddingBottom: 1.5, paddingRight: 0, width: challengeCountLabel.intrinsicContentSize.width, height: 16)
        setupCollectionView()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ProfileChallenge : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ProfileChallengeCell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width / 1.7, height: 200)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 12)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 30.0
    }
    
}
