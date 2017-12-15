//
//  ExploreDiscussion.swift
//  pursue
//
//  Created by Jaylen Sanders on 12/9/17.
//  Copyright © 2017 Glory. All rights reserved.
//

import UIKit

protocol ExploreDiscussionDelegate {
    func exploreDiscussionTapped()
    func exploreDiscussionHeld()
}

class ExploreDiscussion : UICollectionViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, ExploreDiscussionCellDelegate {
    
    var exploreDiscussionDelegate : ExploreDiscussionDelegate?
    
    let rowLabel : UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 12)
        return label
    }()
    
    let cellId = "cellId"
    let peopleId = "peopleId"
    
    let discussionCollection : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    lazy var moreButton : UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "right-arrow-1").withRenderingMode(.alwaysOriginal), for: .normal)
        return button
    }()
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: ((frame.width - 2) / 3), height: ((frame.width - 2) / 3) + 5)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ExploreDiscussionCells
        rowLabel.text = "ANIMAL DISCUSSIONS"
        cell.exploreDelegate = self
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(0, 12, 0, 12)
    }
    
    func discussionHeld() {
        exploreDiscussionDelegate?.exploreDiscussionHeld()
    }
    
    func discussionTapped() {
        exploreDiscussionDelegate?.exploreDiscussionTapped()
    }
    
    func setupView(){
        addSubview(discussionCollection)
        addSubview(rowLabel)
        addSubview(moreButton)
        rowLabel.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 32, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: rowLabel.intrinsicContentSize.width, height: rowLabel.intrinsicContentSize.height)
        moreButton.anchor(top: rowLabel.topAnchor, left: nil, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 20, width: 24, height: 12)
        discussionCollection.anchor(top: rowLabel.bottomAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        discussionCollection.showsHorizontalScrollIndicator = false
        discussionCollection.register(ExploreDiscussionCells.self, forCellWithReuseIdentifier: cellId)
        discussionCollection.dataSource = self
        discussionCollection.delegate = self
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
