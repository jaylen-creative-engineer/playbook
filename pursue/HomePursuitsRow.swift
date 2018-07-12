//
//  HomePursuitsRow.swift
//  pursue
//
//  Created by Jaylen Sanders on 6/19/18.
//  Copyright © 2018 Glory. All rights reserved.
//

import UIKit

class HomePursuitsRow : UICollectionViewCell {
    
    let rowLabel : UILabel = {
       let label = UILabel()
        label.text = "My Pursuits."
        label.font = UIFont(name: "Lato-Bold", size: 14)
        return label
    }()
    
    lazy var showAllButton : UIButton = {
       let button = UIButton()
        button.setTitle("Show All", for: .normal)
        button.addTarget(self, action: #selector(goToFeed), for: .touchUpInside)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont(name: "Lato-Bold", size: 12)
        return button
    }()
    
    var accessHomeController : HomeController?
    
    let cellId = "cellId"
    
    let imageName = [#imageLiteral(resourceName: "health")]
    
    let collectionView : UICollectionView = {
        let layout = PinterestLayout()
        layout.numberOfColumns = 2
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.showsVerticalScrollIndicator = false
        return collectionView
    }()
    
    @objc func goToFeed(){
        accessHomeController?.goToFeedView()
    }
    
    func setupView(){
        let underlineView = UIView()
        underlineView.backgroundColor = .black

        addSubview(rowLabel)
        addSubview(underlineView)
        addSubview(showAllButton)
        addSubview(collectionView)
        
        rowLabel.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: rowLabel.intrinsicContentSize.width, height: rowLabel.intrinsicContentSize.height)
        underlineView.anchor(top: nil, left: nil, bottom: rowLabel.bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 12, width: 48, height: 2)
        showAllButton.anchor(top: nil, left: underlineView.leftAnchor, bottom: underlineView.topAnchor, right: underlineView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 16)
        collectionView.anchor(top: rowLabel.bottomAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 12, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        collectionView.dataSource = self
        collectionView.contentInset = UIEdgeInsetsMake(10, 0, 10, 0)
        collectionView.register(HomePursuitsCells.self, forCellWithReuseIdentifier: cellId)
        if let layout = collectionView.collectionViewLayout as? PinterestLayout {
            layout.delegate = self
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension HomePursuitsRow : UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! HomePursuitsCells
        cell.photo.image = #imageLiteral(resourceName: "health")
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        accessHomeController?.handleChangeToDetail(viewType: "isPursuitDetail")
    }

    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let numberOfColumns : CGFloat = 2
//        let width = collectionView.frame.size.width
//        let xInsets : CGFloat = 10
//        let cellSpacing : CGFloat = 12
//
//        return CGSize(width: (width / numberOfColumns) - (xInsets + cellSpacing), height: (width / numberOfColumns) - (xInsets + cellSpacing))
//    }
}

extension HomePursuitsRow : PinterestLayoutDelegate {
    func collectionView(_ collectionView: UICollectionView, heightForPhotoAtIndexPath indexPath: IndexPath, withWidth: CGFloat) -> CGFloat {
        if indexPath.item % 2 != 0 {
            return 110
        } else {
            return 100
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, heightForAnnotationAtIndexPath indexPath: IndexPath, withWidth width: CGFloat) -> CGFloat {
        if indexPath.item % 2 != 0 {
            return 110
        } else {
            return 100
        }
    }
    
    
}
