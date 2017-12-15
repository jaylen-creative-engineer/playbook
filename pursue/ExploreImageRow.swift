//
//  ExploreRow.swift
//  pursue
//
//  Created by Jaylen Sanders on 10/23/17.
//  Copyright © 2017 Glory. All rights reserved.
//

import UIKit

protocol ExploreImageDelegate {
    func imageTapped()
    func imageHeld()
}

class ExploreImageRow : UICollectionViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, ExerciseImageCellDelegate {
    
    var exploreDelegate : ExploreImageDelegate?
    
    let rowLabel : UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.text = "ANIMALS"
        label.font = UIFont.boldSystemFont(ofSize: 12)
        return label
    }()

    lazy var moreButton : UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "right-arrow-1").withRenderingMode(.alwaysOriginal), for: .normal)
        return button
    }()
    
    let cellId = "cellId"
    let peopleId = "peopleId"
    
    let postCollection : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (frame.width / 2) - 55, height: frame.height)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ExerciseImageCells
        cell.exerciseImageDelegate = self
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(0, 12, 0, 12)
    }
    
    func imageCellTapped() {
        exploreDelegate?.imageTapped()
    }
    
    func imageCellHeld() {
        exploreDelegate?.imageHeld()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)        
        addSubview(postCollection)
        addSubview(rowLabel)
        addSubview(moreButton)
        
        rowLabel.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 40, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: rowLabel.intrinsicContentSize.width, height: rowLabel.intrinsicContentSize.height)
        postCollection.anchor(top: rowLabel.bottomAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 32, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        moreButton.anchor(top: rowLabel.topAnchor, left: nil, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 20, width: 24, height: 12)
        postCollection.showsHorizontalScrollIndicator = false
        postCollection.register(ExerciseImageCells.self, forCellWithReuseIdentifier: cellId)
        postCollection.delegate = self
        postCollection.dataSource = self
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
