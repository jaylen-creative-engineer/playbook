//
//  RolloverTryCell.swift
//  Inpursuit
//
//  Created by Jaylen Sanders on 1/12/19.
//  Copyright © 2019 Glory. All rights reserved.
//

import UIKit

class RolloverTryCell : UICollectionViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    let peopleTryingLabel : UILabel = {
       let label = UILabel()
        label.text = "PEOPLE TRYING THIS"
        label.font = UIFont.boldSystemFont(ofSize: 12)
        return label
    }()
    
    let collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        
       let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .clear
        cv.showsVerticalScrollIndicator = false
        cv.isScrollEnabled = false
        return cv
    }()
    
    let viewMoreButton : UIButton = {
       let button = UIButton(type: .system)
        button.setTitle("VIEW MORE", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 12)
        return button
    }()
    
    let cellId = "cellId"
    
    func setupView(){
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(RolloverTry.self, forCellWithReuseIdentifier: cellId)
        
        addSubview(peopleTryingLabel)
        addSubview(viewMoreButton)
        addSubview(collectionView)
        
        peopleTryingLabel.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 18, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: peopleTryingLabel.intrinsicContentSize.width, height: 14)
        viewMoreButton.anchor(top: nil, left: nil, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 18, paddingRight: 18, width: viewMoreButton.intrinsicContentSize.width, height: 14)
         collectionView.anchor(top: peopleTryingLabel.bottomAnchor, left: leftAnchor, bottom: viewMoreButton.topAnchor, right: rightAnchor, paddingTop: 24, paddingLeft: 0, paddingBottom: 18, paddingRight: 0, width: 0, height: 0)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        setupView()
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
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! RolloverTry
        return cell
    }
}
