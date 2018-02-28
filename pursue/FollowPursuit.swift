//
//  FollowPursuit.swift
//  pursue
//
//  Created by Jaylen Sanders on 2/27/18.
//  Copyright © 2018 Glory. All rights reserved.
//

import UIKit

class FollowPursuit : UICollectionViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, PeopleRowCellDelegate {
    
    let exploreImageNames = ["profile-1", "profile-2", "profile-3", "profile-4", "profile-5"]
    let usernameText = ["Vice", "Jubilee", "boldceo", "Soulection", "GQ"]
    
    let rowLabel : UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight(rawValue: 25))
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var followBackground : CardView = {
        let button = CardView()
        button.backgroundColor = .white
        button.layer.cornerRadius = 20
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isUserInteractionEnabled = true

        let tap = UITapGestureRecognizer(target: self, action: #selector(toggleFollow))
        tap.numberOfTapsRequired = 1
        button.addGestureRecognizer(tap)
        return button
    }()
    
    lazy var addIcon : UIImageView = {
        let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "add-profile").withRenderingMode(.alwaysTemplate)
        iv.tintColor = .black
        iv.contentMode = .scaleAspectFill
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.isUserInteractionEnabled = true
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(toggleFollow))
        tap.numberOfTapsRequired = 1
        iv.addGestureRecognizer(tap)
        return iv
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
    
    var isFollow = false
    @objc func toggleFollow(){
        isFollow = !isFollow
        if isFollow == true {
            followBackground.backgroundColor = .black
            addIcon.tintColor = .white
        } else {
            followBackground.backgroundColor = .white
            addIcon.tintColor = .black
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: ((frame.width - 2) / 4) - 10, height: ((frame.width - 2) / 4))
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! FollowPursuitCells
        cell.userPhoto.image = UIImage(named: exploreImageNames[indexPath.item])?.withRenderingMode(.alwaysOriginal)
        cell.usernameLabel.text = usernameText[indexPath.item]
        rowLabel.text = "Following"
        return cell
    }
    
    func profileTapped() {
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(0, 12, 0, 12)
    }
    
    func setupView(){
        addSubview(postCollection)
        addSubview(followBackground)
        addSubview(addIcon)
        addSubview(rowLabel)
        
        followBackground.anchor(top: topAnchor, left: nil, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 12, width: 40, height: 40)
        addIcon.anchor(top: nil, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 15, height: 15)
        addIcon.centerYAnchor.constraint(equalTo: followBackground.centerYAnchor).isActive = true
        addIcon.centerXAnchor.constraint(equalTo: followBackground.centerXAnchor).isActive = true
        rowLabel.anchor(top: nil, left: leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: rowLabel.intrinsicContentSize.width, height: rowLabel.intrinsicContentSize.height)
        rowLabel.centerYAnchor.constraint(equalTo: followBackground.centerYAnchor).isActive = true
        postCollection.anchor(top: rowLabel.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 12, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 150)
        postCollection.showsHorizontalScrollIndicator = false
        postCollection.register(FollowPursuitCells.self, forCellWithReuseIdentifier: cellId)
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
