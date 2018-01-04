//
//  CategoryDiscussionCells.swift
//  pursue
//
//  Created by Jaylen Sanders on 12/11/17.
//  Copyright © 2017 Glory. All rights reserved.
//

import UIKit

protocol CategoryDiscussionCellDelegate {
    func discussionCellTapped()
    func discussionCellHeld()
}

class CategoryDiscussionCells : HomeDiscussionCells {
    
    var discussionDelegate : CategoryDiscussionCellDelegate?
    
    lazy var categoryDiscussionBackground : TopRectangleView = {
        let view = TopRectangleView()
        view.backgroundColor = .white
        return view
    }()
    
    let categoryDiscussionLabel : UILabel = {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 5
        let label = UILabel()
        label.numberOfLines = 0
        
        let attrString = NSMutableAttributedString(string: "I need some help getting started with marketing my profile on Instagram.")
        attrString.addAttribute(NSAttributedStringKey.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, attrString.length))
        
        label.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight(rawValue: 25))
        label.attributedText = attrString
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        return label
        
    }()
    
    let categoryDiscussionSubLabel : UILabel = {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 5
        let label = UILabel()
        label.numberOfLines = 0
        
        let attrString = NSMutableAttributedString(string: "I need some help getting started with marketing my profile on Instagram.")
        attrString.addAttribute(NSAttributedStringKey.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, attrString.length))
        
        label.font = UIFont.systemFont(ofSize: 14)
        label.attributedText = attrString
        label.backgroundColor = .clear
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let categoryUserCollectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        
        return collectionView
    }()
    
    @objc override func handleDiscussionTap(){
        discussionDelegate?.discussionCellTapped()
    }
    
    @objc override func handleDiscussionHold(){
        discussionDelegate?.discussionCellHeld()
    }
    
    override func setupView() {
        super.setupView()
        addSubview(categoryDiscussionBackground)
        addSubview(categoryDiscussionLabel)
        addSubview(categoryDiscussionSubLabel)
        addSubview(categoryUserCollectionView)
        
        categoryDiscussionBackground.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 8, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 315, height: 175)
        categoryDiscussionLabel.anchor(top: categoryDiscussionBackground.topAnchor, left: categoryDiscussionBackground.leftAnchor, bottom: nil, right: categoryDiscussionBackground.rightAnchor, paddingTop: 8, paddingLeft: 8, paddingBottom: 0, paddingRight: 8, width: 0, height: 55)
        categoryDiscussionSubLabel.anchor(top: categoryDiscussionLabel.bottomAnchor, left: categoryDiscussionLabel.leftAnchor, bottom: nil, right: categoryDiscussionBackground.rightAnchor, paddingTop: 4, paddingLeft: 0, paddingBottom: 0, paddingRight: 8, width: 0, height: 45)
        categoryUserCollectionView.anchor(top: categoryDiscussionSubLabel.bottomAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 4, paddingLeft: 4, paddingBottom: 0, paddingRight: 0, width: 220, height: 60)
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        categoryUserCollectionView.register(HomeUserImage.self, forCellWithReuseIdentifier: cellId)
        categoryUserCollectionView.delegate = self
        categoryUserCollectionView.dataSource = self
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
