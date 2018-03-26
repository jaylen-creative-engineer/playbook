//
//  SearchUsers.swift
//  pursue
//
//  Created by Jaylen Sanders on 3/13/18.
//  Copyright © 2018 Glory. All rights reserved.
//

import UIKit

class SearchUsers : UICollectionViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    let exploreImageNames = ["profile-1", "profile-2", "profile-3", "profile-4", "profile-5"]
    let usernameText = ["Vice", "Jubilee", "boldceo", "Soulection", "GQ"]
    
    let rowLabel : UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.init(25))
        label.text = "People"
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
    
    var searchedUsers = [SearchedUsers]()
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if !searchedUsers.isEmpty {
            return 1
        } else {
            return 0
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: ((frame.width - 2) / 4) - 10, height: ((frame.width - 2) / 4))
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! PeopleRowCells
        if !searchedUsers.isEmpty {
            cell.user = searchedUsers[indexPath.item]
        }
        return cell
    }
    
    func profileTapped() {
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(0, 12, 0, 12)
    }
    
    func setupView(){
        addSubview(postCollection)
        addSubview(rowLabel)
        
        backgroundColor = .clear
        
        rowLabel.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: rowLabel.intrinsicContentSize.width, height: 20)
        postCollection.anchor(top: rowLabel.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 150)
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

