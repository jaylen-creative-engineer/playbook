//
//  HomeTeam.swift
//  Inpursuit
//
//  Created by Jaylen Sanders on 1/14/19.
//  Copyright © 2019 Glory. All rights reserved.
//

import UIKit

class HomeTeam : UICollectionViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    let cellBackgroundView : SmallerCardView = {
        let view = SmallerCardView()
        view.backgroundColor = .white
        return view
    }()
    
    let teamLabel : UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = .gray
        label.font = UIFont.init(name: "Roboto-Black", size: 14)
        label.text = "TEAM"
        return label
    }()
    
    let collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
       let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.showsHorizontalScrollIndicator = false
        cv.isScrollEnabled = false
        cv.backgroundColor = .clear
        return cv
    }()
    
    let cellId = "cellId"
    
    func setupCollectionView(){
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(HomeTeamCells.self, forCellWithReuseIdentifier: cellId)
        addSubview(collectionView)
        collectionView.anchor(top: teamLabel.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 18, paddingBottom: 18, paddingRight: 18, width: 0, height: 85)
    }
    
    func setupView(){
        addSubview(cellBackgroundView)
        addSubview(teamLabel)
        
        cellBackgroundView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        teamLabel.anchor(top: cellBackgroundView.topAnchor, left: cellBackgroundView.leftAnchor, bottom: nil, right: nil, paddingTop: 12, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: teamLabel.intrinsicContentSize.width, height: 16)
        setupCollectionView()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 50, height: 60)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 20.0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! HomeTeamCells
        return cell
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class HomeTeamCells : UICollectionViewCell {
    
    let userPhoto : UIImageView = {
       let iv = UIImageView()
        iv.layer.cornerRadius = 20
        iv.layer.masksToBounds = true
        iv.contentMode = .scaleAspectFill
        iv.image = UIImage(named: "IMG_0807")?.withRenderingMode(.alwaysOriginal)
        return iv
    }()
    
    let usernameLabel : UILabel = {
       let label = UILabel()
        label.text = "Test"
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()
    
    func setupView(){
        addSubview(userPhoto)
        addSubview(usernameLabel)
        
        userPhoto.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 40, height: 40)
        usernameLabel.centerXAnchor.constraint(equalTo: userPhoto.centerXAnchor).isActive = true
        usernameLabel.anchor(top: userPhoto.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 6, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 15)
        usernameLabel.widthAnchor.constraint(lessThanOrEqualToConstant: 50).isActive = true
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
