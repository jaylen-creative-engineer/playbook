//
//  HomePicksRow.swift
//  pursue
//
//  Created by Jaylen Sanders on 6/21/18.
//  Copyright © 2018 Glory. All rights reserved.
//

import UIKit

class HomePicksRow : UICollectionViewCell {
    
    let rowLabel : UILabel = {
        let label = UILabel()
        label.text = "Top Picks."
        label.font = UIFont(name: "Lato-Bold", size: 14)
        return label
    }()

    let showMoreButton : UIButton = {
        let button = UIButton()
        button.setTitle("Show More", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.font = UIFont(name: "Lato-Bold", size: 12)
        return button
    }()

    let cellId = "cellId"

    var images = [#imageLiteral(resourceName: "clean-2"), #imageLiteral(resourceName: "clean-3"), #imageLiteral(resourceName: "samuel-l"), #imageLiteral(resourceName: "steph"), #imageLiteral(resourceName: "cars"), #imageLiteral(resourceName: "ghost"), #imageLiteral(resourceName: "mens-fashion")]
    let userPhotos = [#imageLiteral(resourceName: "clean-3"),#imageLiteral(resourceName: "clean-2"),#imageLiteral(resourceName: "comment-2"), #imageLiteral(resourceName: "comment-6"), #imageLiteral(resourceName: "comment-1"), #imageLiteral(resourceName: "mens-fashion")]

    let collectionView : UICollectionView = {
        let layout = PinterestLayout()
        layout.numberOfColumns = 2
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.showsVerticalScrollIndicator = false
        collectionView.isScrollEnabled = false
        return collectionView
    }()
    
    var accessHomeController : HomeController?
    
    @objc func goToFeed(){
        accessHomeController?.goToFeedView()
    }

    func setupView(){
        addSubview(rowLabel)
        addSubview(collectionView)
        addSubview(showMoreButton)
        
        rowLabel.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: rowLabel.intrinsicContentSize.width, height: rowLabel.intrinsicContentSize.height)
        collectionView.anchor(top: rowLabel.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 12, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 705)
        showMoreButton.anchor(top: collectionView.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 12, paddingBottom: 0, paddingRight: 12, width: 0, height: showMoreButton.intrinsicContentSize.height)
        
        collectionView.dataSource = self
        collectionView.contentInset = UIEdgeInsetsMake(10, 4, 10, 4)
        collectionView.register(HomePicksCell.self, forCellWithReuseIdentifier: cellId)
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

extension HomePicksRow : UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! HomePicksCell
        cell.userPhoto.image = userPhotos[indexPath.item]
        cell.photo.image = images[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        accessHomeController?.handleChangeToDetail(viewType: "isPrinciplesDetail")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
}

extension HomePicksRow : PinterestLayoutDelegate {
    func collectionView(_ collectionView: UICollectionView, heightForPhotoAtIndexPath indexPath: IndexPath, withWidth: CGFloat) -> CGFloat {
        if indexPath.item % 2 != 0 {
            return 105
        } else {
            return 100
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, heightForAnnotationAtIndexPath indexPath: IndexPath, withWidth width: CGFloat) -> CGFloat {
        if indexPath.item % 2 != 0 {
            return 105
        } else {
            return 100
        }
    }
    
    
}
