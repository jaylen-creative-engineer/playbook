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
    func homeDiscussionFeed()
}

class HomeDiscussion : UICollectionViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, HomeDiscussionCellDelegate {
    
    let rowLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: UIFont.Weight.init(25))
        return label
    }()
    let imageNames = ["bunt", "tackle", "vertical", "40yard", "steph"]
    let discussionLabels = ["How to bunt properly?, How to tackle without using my head?", "How to increase my vertical?", "40 yard dash tips?", "How to shoot like Steph?"]
    
    var delegate : HomeDiscussionDelegate?
    
    let cellId = "cellId"
    let peopleId = "peopleId"
    
    let discussionCollection : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.showsVerticalScrollIndicator = false
        return collectionView
    }()
    
    lazy var moreButton : UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "right-arrow-1").withRenderingMode(.alwaysOriginal), for: .normal)
        button.addTarget(self, action: #selector(handleDiscussionFeed), for: .touchUpInside)
        return button
    }()
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 320, height: ((frame.width - 2) / 2) + 15)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! HomeDiscussionCells
        cell.homeDelegate = self
        rowLabel.text = "SPORTS DISCUSSIONS"
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(0, 12, 0, 12)
    }
    
    func discussionTapped() {
        delegate?.homeDiscussionTapped()
    }
    
    func discussionHeld() {
        delegate?.homeDiscussionHeld()
    }
    
    func handleDiscussionFeed(){
        delegate?.homeDiscussionFeed()
    }
    
    func setupView(){
        addSubview(discussionCollection)
        addSubview(rowLabel)
        addSubview(moreButton)
        rowLabel.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 32, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: rowLabel.intrinsicContentSize.width, height: 22)
        moreButton.anchor(top: rowLabel.topAnchor, left: nil, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 20, width: 24, height: 12)
        discussionCollection.anchor(top: rowLabel.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 16, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 215)
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
