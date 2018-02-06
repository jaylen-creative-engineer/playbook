//
//  ProfileDiscussion.swift
//  pursue
//
//  Created by Jaylen Sanders on 12/9/17.
//  Copyright © 2017 Glory. All rights reserved.
//

import UIKit

protocol ProfileDiscussionDelegate {
    func profileDiscussionTapped()
    func profileDiscussionHeld()
}

class ProfileDiscussion : UICollectionViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, ProfileDiscussionCellsDelegate {
    
    let profileDiscussionId = "profileDiscussionId"
    
    let discussionCollection : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    let rowLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.init(25))
        return label
    }()
    
    lazy var moreButton : UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "right-arrow-1").withRenderingMode(.alwaysOriginal), for: .normal)
        button.addTarget(self, action: #selector(handleProfileDiscussionFeed), for: .touchUpInside)
        return button
    }()
    
    var profileDelegate : ProfileDiscussionDelegate?
    var accessProfileController : ProfileController?
    
    let profileImageNames = ["social-marketing", "google-adds", "content-marketing", "seo"]
    let profileLabelText = ["Instagram Marketing", "Using Google Ads", "Content Marketing", "SEO Little Known Tricks"]
    
    @objc func handleProfileDiscussionFeed(){
        accessProfileController?.handleChangeToFeed(viewType: "isDiscussionFeed")
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: profileDiscussionId, for: indexPath) as! ProfileDiscussionCells
        cell.delegate = self
        cell.profileDiscussionLabel.text = profileLabelText[indexPath.item]
        cell.profileDiscussionImage.image = UIImage(named: profileImageNames[indexPath.item])?.withRenderingMode(.alwaysOriginal)
        rowLabel.text = "Discussions"
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 315, height: ((frame.width - 2) / 2) + 5)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(0, 12, 0, 12)
    }
    
    func discussionTapped() {
        accessProfileController?.handleChangeToDetail(viewType: "isDiscussionDetail")
    }
    
    func discussionHeld() {
        profileDelegate?.profileDiscussionHeld()
    }
    
    func setupView() {
        addSubview(rowLabel)
        addSubview(discussionCollection)
        addSubview(moreButton)
        rowLabel.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 24, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: rowLabel.intrinsicContentSize.width, height: rowLabel.intrinsicContentSize.height)
        discussionCollection.anchor(top: rowLabel.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 12, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 265)
        moreButton.anchor(top: rowLabel.topAnchor, left: nil, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 20, width: 24, height: 12)
        discussionCollection.register(ProfileDiscussionCells.self, forCellWithReuseIdentifier: profileDiscussionId)
        discussionCollection.delegate = self
        discussionCollection.dataSource = self
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
