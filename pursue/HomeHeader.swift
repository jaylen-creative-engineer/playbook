//
//  HomeHeader.swift
//  Inpursuit
//
//  Created by Jaylen Sanders on 12/20/18.
//  Copyright © 2018 Glory. All rights reserved.
//

import UIKit

class HomeHeader : UICollectionViewCell {
    
    let cellId = "cellId"
    
    var headerNames = ["Your Picks", "Trending", "Animals"]
    
    let collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.showsHorizontalScrollIndicator = false
        cv.backgroundColor = .clear
        return cv
    }()
    
    func setupView(){
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(HomeMenuCells.self, forCellWithReuseIdentifier: cellId)
        
        addSubview(collectionView)
        collectionView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        let selectedCell = IndexPath(item: 0, section: 0)
        collectionView.selectItem(at: selectedCell, animated: true, scrollPosition: [])
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension HomeHeader : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return headerNames.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! HomeMenuCells
        cell.sectionLabel.text = headerNames[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let approximateWidthOfLabel = frame.width / 3.5
        let size = CGSize(width: approximateWidthOfLabel, height: .infinity)
        let attributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14)]
        let estimatedFrame = NSString(string: headerNames[indexPath.item]).boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: attributes, context: nil)
        return CGSize(width: estimatedFrame.width + 10, height: 22)
    }
}
