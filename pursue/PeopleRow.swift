//
//  PeopleRow.swift
//  pursue
//
//  Created by Jaylen Sanders on 10/23/17.
//  Copyright © 2017 Glory. All rights reserved.
//

import UIKit

protocol PeopleRowDelegate {
    func profileTapped()
}

class PeopleRow : UICollectionViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, PeopleRowCellDelegate {
    
    var peopleDelegate : PeopleRowDelegate?
    let exploreImageNames = ["profile-1", "profile-2", "profile-3", "profile-4", "profile-5"]
    let usernameText = ["Vice", "Jubilee", "boldceo", "Soulection", "GQ"]
    
    let rowLabel : UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 12)
        return label
    }()
    
    let cellId = "cellId"
    let peopleId = "peopleId"
    
    let postCollection : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: ((frame.width - 2) / 4) - 10, height: ((frame.width - 2) / 4))
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! PeopleRowCells
        cell.peopleDelegate = self
        cell.userPhoto.image = UIImage(named: exploreImageNames[indexPath.item])?.withRenderingMode(.alwaysOriginal)
        cell.usernameLabel.text = usernameText[indexPath.item]
        rowLabel.text = "PEOPLE"
        return cell
    }
    
    func profileTapped() {
        peopleDelegate?.profileTapped()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(0, 12, 0, 12)
    }
    
    func setupView(){
        addSubview(postCollection)
        addSubview(rowLabel)
        rowLabel.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 40, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: rowLabel.intrinsicContentSize.width, height: rowLabel.intrinsicContentSize.height)
        postCollection.anchor(top: rowLabel.bottomAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        postCollection.showsHorizontalScrollIndicator = false
        postCollection.register(PeopleRowCells.self, forCellWithReuseIdentifier: cellId)
        postCollection.delegate = self
        postCollection.dataSource = self
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
