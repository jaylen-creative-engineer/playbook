//
//  SearchCarouselCell.swift
//  pursue
//
//  Created by Jaylen Sanders on 8/12/18.
//  Copyright © 2018 Glory. All rights reserved.
//

import UIKit

class SearchPursuits : UICollectionViewCell {
    
    var pursuits : [Post]? {
        didSet {
            guard let pursuitsContent = pursuits else { return }
            pursuitsData = pursuitsContent
            collectionView.reloadData()
        }
    }
    
    var pursuitsData = [Post]()
    let cellId = "cellId"
    
    let pursuitsLabel : UILabel = {
       let label = UILabel()
        label.text = "Pursuits"
        label.font = UIFont.boldSystemFont(ofSize: 14)
        return label
    }()
    
    let collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    func setupView(){
        addSubview(pursuitsLabel)
        addSubview(collectionView)
        
        pursuitsLabel.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: pursuitsLabel.intrinsicContentSize.width, height: 16)
        collectionView.anchor(top: pursuitsLabel.bottomAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 24, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(SearchPursuitsCells.self, forCellWithReuseIdentifier: cellId)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SearchPursuits : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! SearchPursuitsCells
        if !pursuitsData.isEmpty {
            cell.post = pursuitsData[indexPath.item]
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if !pursuitsData.isEmpty {
            return pursuitsData.count
        }
        
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.init(top: 0, left: 12, bottom: 0, right: 12)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (frame.width / 1.4) - 20, height: (frame.height / 1.2))
    }
}
