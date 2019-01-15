//
//  NewHomeCells.swift
//  Inpursuit
//
//  Created by Jaylen Sanders on 1/5/19.
//  Copyright © 2019 Glory. All rights reserved.
//

import UIKit
import iCarousel
import CHIPageControl
import ABSteppedProgressBar

class NewHomeCells : UICollectionViewCell {
    
    let collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    let usernameLabel : UILabel = {
        let label = UILabel()
        label.text = "Test"
        label.font = UIFont.init(name: "Roboto-Black", size: 14)
        return label
    }()
    
    let userPhoto : UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.layer.cornerRadius = 15
        iv.layer.masksToBounds = true
        iv.image = UIImage(named: "cafe-768771_1280")?.withRenderingMode(.alwaysOriginal)
        return iv
    }()
    
    let cellBackgroundView : HomeCellConflictShadowView = {
        let view = HomeCellConflictShadowView()
        view.backgroundColor = .white
        return view
    }()
    
    let pursuitImageView : UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "cafe-768771_1280")?.withRenderingMode(.alwaysOriginal)
        iv.contentMode = .scaleAspectFill
        iv.layer.masksToBounds = true
        iv.layer.cornerRadius = 6
        return iv
    }()
    
    let cellId = "cellId"
    
    func setupCollectionView(){
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(NewHomeDetail.self, forCellWithReuseIdentifier: cellId)
        
        addSubview(cellBackgroundView)
        addSubview(userPhoto)
        addSubview(usernameLabel)
        addSubview(pursuitImageView)
        addSubview(collectionView)
        
        cellBackgroundView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 8, paddingBottom: 0, paddingRight: 8, width: 0, height: 0)
        
        userPhoto.anchor(top: cellBackgroundView.topAnchor, left: cellBackgroundView.leftAnchor, bottom: nil, right: nil, paddingTop: 18, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: 30, height: 30)
        usernameLabel.centerYAnchor.constraint(equalTo: userPhoto.centerYAnchor).isActive = true
        usernameLabel.anchor(top: nil, left: userPhoto.rightAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 8, paddingBottom: 0, paddingRight: 0, width: 0, height: 16)
        pursuitImageView.anchor(top: userPhoto.bottomAnchor, left: cellBackgroundView.leftAnchor, bottom: nil, right: cellBackgroundView.rightAnchor, paddingTop: 18, paddingLeft: 12, paddingBottom: 0, paddingRight: 12, width: 0, height: 475)
        collectionView.anchor(top: pursuitImageView.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 12, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 170)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCollectionView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension NewHomeCells : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 25.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 25.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 24)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 300, height: 120)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! NewHomeDetail
        return cell
    }
}
