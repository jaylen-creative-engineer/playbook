//
//  HomeDiscussionCells.swift
//  pursue
//
//  Created by Jaylen Sanders on 12/9/17.
//  Copyright © 2017 Glory. All rights reserved.
//

import UIKit

protocol HomeDiscussionCellDelegate {
    func discussionTapped()
    func discussionHeld()
}

class HomeDiscussionCells : UICollectionViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var homeDelegate : HomeDiscussionCellDelegate?
    let cellId = "cellId"
    
    lazy var discussionLabel : UILabel = {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 5
        let label = UILabel()
        label.numberOfLines = 0
        
        let attrString = NSMutableAttributedString(string: "I need some help getting started with marketing my profile on Instagram.")
        attrString.addAttribute(NSAttributedStringKey.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, attrString.length))
        
        label.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight(rawValue: 25))
        label.attributedText = attrString
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleDiscussionTap))
        let longGesture = UILongPressGestureRecognizer(target: self, action: #selector(handleDiscussionHold))
        tapGesture.numberOfTapsRequired = 1
        label.addGestureRecognizer(tapGesture)
        label.addGestureRecognizer(longGesture)
        label.isUserInteractionEnabled = true
        return label

    }()
    
    lazy var discussionSubLabel : UILabel = {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 5
        let label = UILabel()
        label.numberOfLines = 0
        
        let attrString = NSMutableAttributedString(string: "I need some help getting started with marketing my profile on Instagram.")
        attrString.addAttribute(NSAttributedStringKey.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, attrString.length))
        
        label.font = UIFont.systemFont(ofSize: 12)
        label.attributedText = attrString
        label.backgroundColor = .clear
        label.translatesAutoresizingMaskIntoConstraints = false
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleDiscussionTap))
        let longGesture = UILongPressGestureRecognizer(target: self, action: #selector(handleDiscussionHold))
        tapGesture.numberOfTapsRequired = 1
        label.addGestureRecognizer(tapGesture)
        label.addGestureRecognizer(longGesture)
        label.isUserInteractionEnabled = true
        return label
    }()
    
    lazy var userCollectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleDiscussionTap))
        let longGesture = UILongPressGestureRecognizer(target: self, action: #selector(handleDiscussionHold))
        tapGesture.numberOfTapsRequired = 1
        collectionView.addGestureRecognizer(tapGesture)
        collectionView.addGestureRecognizer(longGesture)
        collectionView.isUserInteractionEnabled = true
        return collectionView
    }()
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(0, 4, 0, 0)
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! HomeUserImage
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 40, height: 40)
    }
    
    lazy var discussionBackground : TopRectangleView = {
       let view = TopRectangleView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 4
        view.layer.masksToBounds = true
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleDiscussionTap))
        let longGesture = UILongPressGestureRecognizer(target: self, action: #selector(handleDiscussionHold))
        tapGesture.numberOfTapsRequired = 1
        view.addGestureRecognizer(tapGesture)
        view.addGestureRecognizer(longGesture)
        view.isUserInteractionEnabled = true
        return view
    }()
    
    @objc func handleDiscussionTap(){
        homeDelegate?.discussionTapped()
    }
    
    @objc func handleDiscussionHold(){
        homeDelegate?.discussionHeld()
    }
    
    func setupView(){
        addSubview(discussionLabel)
        addSubview(discussionSubLabel)
        addSubview(userCollectionView)
        
        discussionLabel.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 12, paddingBottom: 0, paddingRight: 12, width: 0, height: 55)
        discussionSubLabel.anchor(top: discussionLabel.bottomAnchor, left: discussionLabel.leftAnchor, bottom: nil, right: discussionLabel.rightAnchor, paddingTop: 2, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 45)
        userCollectionView.anchor(top: discussionSubLabel.bottomAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 2, paddingLeft: 4, paddingBottom: 0, paddingRight: 0, width: 220, height: 60)
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        userCollectionView.register(HomeUserImage.self, forCellWithReuseIdentifier: cellId)
        userCollectionView.delegate = self
        userCollectionView.dataSource = self
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
