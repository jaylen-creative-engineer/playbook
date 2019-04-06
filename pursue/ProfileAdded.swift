//
//  ProfileAdded.swift
//  Inpursuit
//
//  Created by Jaylen Sanders on 1/10/19.
//  Copyright © 2019 Glory. All rights reserved.
//

import UIKit

class ProfileAdded  : UICollectionViewCell {
    
    let addedLabel : UILabel = {
        let label = UILabel()
        label.text = "Added"
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    
    let addedCountLabel : UILabel = {
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
        collectionView.register(ProfileAddedCells.self, forCellWithReuseIdentifier: cellId)
        
        addSubview(collectionView)
        collectionView.anchor(top: addedLabel.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 6, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 150)
    }
    
    func setupView(){
        addSubview(addedLabel)
        addSubview(addedCountLabel)
        
        addedLabel.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: addedLabel.intrinsicContentSize.width, height: 20)
        addedCountLabel.anchor(top: nil, left: addedLabel.rightAnchor, bottom: addedLabel.bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 6, paddingBottom: 1.5, paddingRight: 0, width: addedCountLabel.intrinsicContentSize.width, height: 16)
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

extension ProfileAdded : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ProfileAddedCells
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (frame.width / 3.5) - 10, height: 130)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 12)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10.0
    }
    
}
