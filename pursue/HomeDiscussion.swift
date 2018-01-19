//
//  HomeDiscussion.swift
//  pursue
//
//  Created by Jaylen Sanders on 12/9/17.
//  Copyright © 2017 Glory. All rights reserved.
//

import UIKit

protocol HomeDiscussionDelegate {
    func homeDiscussionTapped()
    func homeDiscussionHeld()
}

class HomeDiscussion : UICollectionViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, HomeDiscussionCellDelegate {
    
    let rowLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.init(25))
        return label
    }()
    
    let imageNames = ["bunt", "tackle", "vertical", "40yard", "steph"]
    let discussionLabels = ["How to bunt properly?, How to tackle without using my head?", "How to increase my vertical?", "40 yard dash tips?", "How to shoot like Steph?"]
    
    var delegate : HomeDiscussionDelegate?
    
    let cellId = "cellId"
    let peopleId = "peopleId"
    
    let discussionCollection : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.isScrollEnabled = false
        collectionView.showsVerticalScrollIndicator = false
        return collectionView
    }()
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width, height: 190)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! HomeDiscussionCells
        cell.homeDelegate = self
        rowLabel.text = "Discussions"
        return cell
    }
    
    func discussionTapped() {
        delegate?.homeDiscussionTapped()
    }
    
    func discussionHeld() {
        delegate?.homeDiscussionHeld()
    }
    
    func setupView(){
        addSubview(discussionCollection)
        addSubview(rowLabel)
        
        rowLabel.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 18, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: rowLabel.intrinsicContentSize.width, height: rowLabel.intrinsicContentSize.height)
        discussionCollection.anchor(top: rowLabel.bottomAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 18, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        discussionCollection.showsHorizontalScrollIndicator = false
        discussionCollection.register(HomeDiscussionCells.self, forCellWithReuseIdentifier: cellId)
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
