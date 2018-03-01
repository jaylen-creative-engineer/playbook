//
//  PursuitPrinciple.swift
//  pursue
//
//  Created by Jaylen Sanders on 12/12/17.
//  Copyright © 2017 Glory. All rights reserved.
//

import UIKit

class PursuitPrinciple : UICollectionViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    let pursuitPrincipleId = "pursuitPrincipleId"
    
    let principleDetailCollection : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: pursuitPrincipleId, for: indexPath) as! PursuitPrincipleCells
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: ((frame.width - 2) / 2), height: ((frame.width - 2) / 3) + 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(0, 12, 0, 12)
    }
    
    let principlesLabel : UILabel = {
       let label = UILabel()
        label.text = "Principles"
        label.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight(rawValue: 25))
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        principleDetailCollection.register(PursuitPrincipleCells.self, forCellWithReuseIdentifier: pursuitPrincipleId)
        principleDetailCollection.delegate = self
        principleDetailCollection.dataSource = self
        principleDetailCollection.showsHorizontalScrollIndicator = false
        setupView()
    }
    
    func setupView() {
        addSubview(principlesLabel)
        addSubview(principleDetailCollection)
        
        principlesLabel.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: principlesLabel.intrinsicContentSize.width, height: 18)
        principleDetailCollection.anchor(top: principlesLabel.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 230)

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
