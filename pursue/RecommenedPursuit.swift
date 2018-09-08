//
//  MyPursuitStoryRow.swift
//  pursue
//
//  Created by Jaylen Sanders on 9/6/18.
//  Copyright © 2018 Glory. All rights reserved.
//

import UIKit

class RecommenedPursuit : UICollectionViewCell {
    
    let storyId = "storyId"
    
    let postCollectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    let myPursuitsLabel : UILabel = {
        let label = UILabel()
        label.text = "Pursuits You May Like"
        label.font = UIFont(name: "Lato-Bold", size: 13)
        return label
    }()
    
    let todayLabel : UILabel = {
        let label = UILabel()
        label.text = "Today's Picks"
        label.font = UIFont(name: "Lato-Bold", size: 13)
        return label
    }()
    
    func setupPostCollectionView(){
        postCollectionView.delegate = self
        postCollectionView.dataSource = self
        postCollectionView.register(RecommenedPursuitCell.self, forCellWithReuseIdentifier: storyId)
        addSubview(myPursuitsLabel)
        addSubview(postCollectionView)
        addSubview(todayLabel)
        
        
        myPursuitsLabel.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 32, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: myPursuitsLabel.intrinsicContentSize.width, height: 15)
        postCollectionView.anchor(top: myPursuitsLabel.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 18, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 500)
        todayLabel.anchor(top: postCollectionView.bottomAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 32, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: todayLabel.intrinsicContentSize.width, height: 15)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupPostCollectionView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension RecommenedPursuit : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: storyId, for: indexPath) as! RecommenedPursuitCell
        //        cell.interestsLabel.text = interestsLabel[indexPath.row]
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(0, 12, 0, -12)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 320, height: 465)
    }
}
