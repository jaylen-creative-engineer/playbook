//
//  ProfileDiscussionCells.swift
//  pursue
//
//  Created by Jaylen Sanders on 12/9/17.
//  Copyright © 2017 Glory. All rights reserved.
//

import UIKit

protocol ProfileDiscussionCellsDelegate {
    func discussionTapped()
    func discussionHeld()
}
class ProfileDiscussionCells : UICollectionViewCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    let cellId = "cellId"
    var delegate : ProfileDiscussionCellsDelegate?
    
    lazy var profileDiscussionImage : UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.layer.masksToBounds = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleHomeTap))
        let longGesture = UILongPressGestureRecognizer(target: self, action: #selector(handleHomeHold))
        tapGesture.numberOfTapsRequired = 1
        iv.addGestureRecognizer(tapGesture)
        iv.addGestureRecognizer(longGesture)
        iv.isUserInteractionEnabled = true
        iv.layer.cornerRadius = 4
        return iv
    }()
    
    let profileDiscussionLabel : UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight(rawValue: 25))
        return label
    }()
    
    lazy var discussionBackground : TopRectangleView = {
        let view = TopRectangleView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 4
        view.layer.masksToBounds = true
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleHomeTap))
        let longGesture = UILongPressGestureRecognizer(target: self, action: #selector(handleHomeHold))
        tapGesture.numberOfTapsRequired = 1
        view.addGestureRecognizer(tapGesture)
        view.addGestureRecognizer(longGesture)
        view.isUserInteractionEnabled = true
        return view
    }()
    
    let discussionLabel : UILabel = {
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
        return label
        
    }()
    
    let discussionSubLabel : UILabel = {
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
        return label
    }()
    
    let userCollectionView : UICollectionView = {
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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! HomeUserImage
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 40, height: 40)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(0, 4, 0, 0)
    }
    
    @objc func handleHomeTap(){
        delegate?.discussionTapped()
    }
    
    @objc func handleHomeHold(){
        delegate?.discussionHeld()
    }
    
    func setupView() {
        addSubview(discussionBackground)
        addSubview(discussionLabel)
        addSubview(discussionSubLabel)
        addSubview(userCollectionView)
        
        discussionBackground.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 8, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 315, height: 175)
        discussionLabel.anchor(top: discussionBackground.topAnchor, left: discussionBackground.leftAnchor, bottom: nil, right: discussionBackground.rightAnchor, paddingTop: 8, paddingLeft: 8, paddingBottom: 0, paddingRight: 8, width: 0, height: 55)
        discussionSubLabel.anchor(top: discussionLabel.bottomAnchor, left: discussionLabel.leftAnchor, bottom: nil, right: discussionBackground.rightAnchor, paddingTop: 4, paddingLeft: 0, paddingBottom: 0, paddingRight: 8, width: 0, height: 45)
        userCollectionView.anchor(top: discussionSubLabel.bottomAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 4, paddingLeft: 4, paddingBottom: 0, paddingRight: 0, width: 220, height: 60)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        userCollectionView.register(HomeUserImage.self, forCellWithReuseIdentifier: cellId)
        userCollectionView.delegate = self
        userCollectionView.dataSource = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
