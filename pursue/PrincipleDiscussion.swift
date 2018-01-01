//
//  PrincipleDiscussion.swift
//  pursue
//
//  Created by Jaylen Sanders on 12/11/17.
//  Copyright © 2017 Glory. All rights reserved.
//

import UIKit

class PrincipleDiscussion :  UICollectionViewCell, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource {
    
    let cellId = "cellId"
    
    var accessPursuitDetailController : PursuitsDetailController?
    
    let pursuitDiscussion : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    func setupView(){
        addSubview(pursuitDiscussion)
        
        pursuitDiscussion.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! PrincipleDiscussionCells
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(12, 0, 0, 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width, height: 140)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        accessPursuitDetailController?.showChallengesDetail()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        
        pursuitDiscussion.dataSource = self
        pursuitDiscussion.delegate = self
        pursuitDiscussion.register(PrincipleDiscussionCells.self, forCellWithReuseIdentifier: cellId)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
