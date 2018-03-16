//
//  SearchReturn.swift
//  pursue
//
//  Created by Jaylen Sanders on 2/15/18.
//  Copyright © 2018 Glory. All rights reserved.
//

import UIKit

class SearchReturn : UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .white
        cv.showsHorizontalScrollIndicator = false
        return cv
    }()
    
    let usersId = "usersId"
    let pursuitsId = "pursuitsId"
    let principlesId = "principlesId"
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
//        return CGSize(width: frame.width, height: 20)
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//        return UIEdgeInsetsMake(32, 0, 0, 0)
//    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch indexPath.item {
        case 0:
            return CGSize(width: frame.width, height: 230)
        case 1:
           return CGSize(width: frame.width, height: 430)
        case 2:
            return CGSize(width: frame.width, height: 430)
        default:
            assert(false, "This is not a valid cell")
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.item {
        case 0:
            let usersCell = collectionView.dequeueReusableCell(withReuseIdentifier: usersId, for: indexPath) as! SearchUsers
            return usersCell
        case 1:
            let pursuitsCell = collectionView.dequeueReusableCell(withReuseIdentifier: pursuitsId, for: indexPath) as! SearchSteps
            return pursuitsCell
        case 2:
            let principlesCell = collectionView.dequeueReusableCell(withReuseIdentifier: principlesId, for: indexPath) as! SearchPrinciples
            return principlesCell
        default:
            assert(false, "This is not a valid cell")
        }
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(SearchUsers.self, forCellWithReuseIdentifier: usersId)
        collectionView.register(SearchSteps.self, forCellWithReuseIdentifier: pursuitsId)
        collectionView.register(SearchPrinciples.self, forCellWithReuseIdentifier: principlesId)
        addSubview(collectionView)
        collectionView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
