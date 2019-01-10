//
//  DetailTryingCell.swift
//  Inpursuit
//
//  Created by Jaylen Sanders on 1/9/19.
//  Copyright © 2019 Glory. All rights reserved.
//

import UIKit
import PinterestLayout

class DetailTryingCell : UICollectionViewCell {
    
    let collectionView : UICollectionView = {
        let layout = PinterestLayout()
        layout.numberOfColumns = 2
        layout.cellPadding = 10
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.showsVerticalScrollIndicator = false
        collectionView.isScrollEnabled = true
        return collectionView
    }()
    
     let imageNames = [UIImage(named : "cafe-768771_1280"), UIImage(named : "gian-cescon-637914-unsplash"), UIImage(named : "IMG_0807"), UIImage(named : "IMG_3935")]
    
    let cellId = "cellId"
    
    func setupCollectionView(){
        collectionView.register(DetailTryingPhotoCells.self, forCellWithReuseIdentifier: cellId)
        collectionView.delegate = self
        collectionView.dataSource = self
        
        if let layout = collectionView.collectionViewLayout as? PinterestLayout {
            layout.delegate = self
        }
        
        addSubview(collectionView)
        collectionView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCollectionView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension DetailTryingCell : PinterestLayoutDelegate, UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! DetailTryingPhotoCells
        cell.photo.image = imageNames[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageNames.count
    }
    
    func collectionView(collectionView: UICollectionView, heightForImageAtIndexPath indexPath: IndexPath, withWidth: CGFloat) -> CGFloat {
        if indexPath.item % 2 != 0 {
            return 120
        } else {
            return 115
        }
    }
    
    func collectionView(collectionView: UICollectionView, heightForAnnotationAtIndexPath indexPath: IndexPath, withWidth: CGFloat) -> CGFloat {
        if indexPath.item % 2 != 0 {
            return 120
        } else {
            return 115
        }
    }
}

class DetailTryingPhotoCells : UICollectionViewCell {
    
    let photo : UIImageView = {
        let iv = UIImageView()
        iv.layer.cornerRadius = 12
        iv.layer.masksToBounds = true
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    let photoBackground : HomeCellRectangleView = {
        let view = HomeCellRectangleView()
        view.backgroundColor = .white
        return view
    }()
    
    let detailLabel : UILabel = {
        let label = UILabel()
        label.text = "Have a vision to work towards"
        label.textColor = .white
        label.numberOfLines = 1
        label.font = UIFont.boldSystemFont(ofSize: 12)
        return label
    }()
    
    let userPhoto : UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "gian-cescon-637914-unsplash")?.withRenderingMode(.alwaysOriginal)
        iv.contentMode = .scaleAspectFill
        iv.layer.cornerRadius = 15
        iv.layer.masksToBounds = true
        return iv
    }()
    
    func setupView(){
        addSubview(photoBackground)
        addSubview(photo)
        addSubview(userPhoto)
        addSubview(detailLabel)
        
        photoBackground.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        photo.anchor(top: photoBackground.topAnchor, left: photoBackground.leftAnchor, bottom: photoBackground.bottomAnchor, right: photoBackground.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        userPhoto.anchor(top: photo.topAnchor, left: photo.leftAnchor, bottom: nil, right: nil, paddingTop: 6, paddingLeft: 6, paddingBottom: 0, paddingRight: 0, width: 30, height: 30)
        detailLabel.anchor(top: nil, left: photo.leftAnchor, bottom: photo.bottomAnchor, right: photo.rightAnchor, paddingTop: 0, paddingLeft: 8, paddingBottom: 12, paddingRight: 8, width: 0, height: 14)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
