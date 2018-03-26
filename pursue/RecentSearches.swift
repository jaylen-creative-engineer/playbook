//
//  RecentSearches.swift
//  pursue
//
//  Created by Jaylen Sanders on 3/13/18.
//  Copyright © 2018 Glory. All rights reserved.
//

import UIKit

class RecentSearches : UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .clear
        cv.showsVerticalScrollIndicator = false
        cv.delegate = self
        cv.dataSource = self
        return cv
    }()
    
    let cellId = "cellId"
    let stepId = "stepId"
    let profileId = "profileId"
    let principlesId = "principlesId"
    var isStepView = false
    var isPrincipleView = false
    var isProfileView = false
    
    func stepViewCheck(){
        isStepView = true
        isPrincipleView = false
        isProfileView = false
        collectionView.reloadData()
    }
    
    func principleViewCheck(){
        isStepView = false
        isPrincipleView = true
        isProfileView = false
        collectionView.reloadData()
    }
    
    func profileViewCheck(){
        isStepView = false
        isPrincipleView = false
        isProfileView = true
        collectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 8
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width, height: 120)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch true {
        case isStepView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: stepId, for: indexPath) as! RecentSearchPursuits
            return cell
        case isProfileView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: profileId, for: indexPath) as! RecentSearchUsers
            return cell
        case isPrincipleView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: principlesId, for: indexPath) as! RecentSearchPrinciples
            return cell
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: stepId, for: indexPath) as! RecentSearchPursuits
            cell.cancelButton.isHidden = true
            cell.pursuitImage.isHidden = true
            cell.pursuitLabel.isHidden = true
            return cell
        }
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        collectionView.register(RecentSearchUsers.self, forCellWithReuseIdentifier: profileId)
        collectionView.register(RecentSearchPursuits.self, forCellWithReuseIdentifier: stepId)
        collectionView.register(RecentSearchPrinciples.self, forCellWithReuseIdentifier: principlesId)
        addSubview(collectionView)
        collectionView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
