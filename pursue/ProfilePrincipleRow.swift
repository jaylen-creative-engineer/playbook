//
//  ProfilePrincipleRow.swift
//  pursue
//
//  Created by Jaylen Sanders on 11/27/17.
//  Copyright © 2017 Glory. All rights reserved.
//

import UIKit

protocol ProfilePrincipleDelegate {
    func profilePrincipleTapped()
    func profilePrincipleHeld()
}

class ProfilePrincipleRow : UICollectionViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, ProfilePrincipleCellsDelegate {
    
    var delegate : ProfilePrincipleDelegate?
    
    let rowLabel : UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 12)
        return label
    }()
    
    let profileImageNames = ["realist", "inheritance", "value-first", "menu-numbers"]
    let profileLabelText = ["Naive Realism", "Treat others like they control your inheritance","Show value upfront", "Organize and label menu categories"]
    
    let cellId = "cellId"
    let peopleId = "peopleId"
    
    let postCollection : UICollectionView = {
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
        return 4
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: ((frame.width - 2) / 2) + 55, height: ((frame.width - 2) / 2) + 68)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ProfilePrincipleCells
        rowLabel.text = "PRINCIPLES"
        cell.delegate = self
        cell.profileLabel.text = profileLabelText[indexPath.item]
        cell.profileImage.image = UIImage(named: profileImageNames[indexPath.item])?.withRenderingMode(.alwaysOriginal)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(0, 12, 0, 12)
    }
    
    func principleTapped() {
        delegate?.profilePrincipleTapped()
    }
    
    func principleHeld() {
        delegate?.profilePrincipleHeld()
    }
    
    func setupView(){
        addSubview(rowLabel)
        addSubview(postCollection)
        addSubview(moreButton)
        rowLabel.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 12, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: rowLabel.intrinsicContentSize.width, height: rowLabel.intrinsicContentSize.height)
        moreButton.anchor(top: rowLabel.topAnchor, left: nil, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 20, width: 24, height: 12)
        postCollection.anchor(top: rowLabel.bottomAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 16, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        postCollection.showsHorizontalScrollIndicator = false
        postCollection.register(ProfilePrincipleCells.self, forCellWithReuseIdentifier: cellId)
        postCollection.dataSource = self
        postCollection.delegate = self
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
       setupView()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

