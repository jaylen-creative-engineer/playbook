//
//  SearchCarousel.swift
//  pursue
//
//  Created by Jaylen Sanders on 8/9/18.
//  Copyright © 2018 Glory. All rights reserved.
//

import UIKit
import Gemini

class SearchCarousel : UICollectionViewCell {
    
    let collectionView : GeminiCollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let collectionView = GeminiCollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.decelerationRate = UIScrollViewDecelerationRateFast
        return collectionView
    }()
    
    let returnCollectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.showsVerticalScrollIndicator = false
        return collectionView
    }()
    
    let images = [#imageLiteral(resourceName: "cars"), #imageLiteral(resourceName: "ferrari"), #imageLiteral(resourceName: "ferrari-f70"), #imageLiteral(resourceName: "fashion-design"), #imageLiteral(resourceName: "comment-1")]
    let detailLabels = ["Pursuits", "People", "Steps", "Principles", "Challenges"]
    let cellId = "cellId"
    let resultId = "resultId"
    var scaleEffect: GeminScaleEffect = .scaleUp
    var accessSearchViewController : CustomSearchView?
    
    func setupCollectionView(){
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(SearchCarouselCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.gemini
            .scaleAnimation()
            .scale(0.85)
            .scaleEffect(scaleEffect)
            .ease(.easeOutQuart)
        addSubview(collectionView)
        collectionView.backgroundColor = .red
        collectionView.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 250)
    }
    
//    func setupResultsCollection(){
//        returnCollectionView.delegate = self
//        returnCollectionView.dataSource = self
//        returnCollectionView.register(SearchResults.self, forCellWithReuseIdentifier: resultId)
//        addSubview(returnCollectionView)
//        returnCollectionView.anchor(top: collectionView.bottomAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 18, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
//    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCollectionView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SearchCarousel : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        collectionView.animateVisibleCells()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 60.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 215, height: 240)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if let cell = cell as? GeminiCell {
            self.collectionView.animateCell(cell)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return detailLabels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! SearchCarouselCell
        cell.detailLabel.text = detailLabels[indexPath.item]
        cell.photo.image = images[indexPath.item]
        self.collectionView.animateCell(cell)
        return cell
    }
}

