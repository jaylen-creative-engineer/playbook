//
//  ProfileContainer.swift
//  Inpursuit
//
//  Created by Jaylen Sanders on 4/7/19.
//  Copyright © 2019 Glory. All rights reserved.
//

import UIKit

class ProfileContainer : UICollectionViewCell {
    
    let pursuitId = "pursuitId"
    
    lazy var actionBar : ProfileActionBar = {
        let bar = ProfileActionBar()
        bar.accessProfileContainer = self
        return bar
    }()
    
    let collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.showsHorizontalScrollIndicator = false
        cv.backgroundColor = .clear
        return cv
    }()
    
    let contentScrollView : UIScrollView = {
        let sv = UIScrollView()
        sv.showsHorizontalScrollIndicator = false
        sv.showsVerticalScrollIndicator = false
        sv.backgroundColor = .white
        sv.isPagingEnabled = true
        sv.isDirectionalLockEnabled = true
        return sv
    }()
    
    let pursuitCollectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.showsVerticalScrollIndicator = false
        cv.backgroundColor = .clear
        return cv
    }()
    
    let challengeCollectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.showsVerticalScrollIndicator = false
        cv.backgroundColor = .clear
        return cv
    }()
    
    var pages = [UICollectionView]()
    
    func setupMenuBar(){
        addSubview(actionBar)
        actionBar.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 12, width: 0, height: 60)
    }
    
    func scrolltoMenuIndex(menuIndex : Int){
        let indexPath = IndexPath(item: menuIndex, section: 0)
        contentScrollView.scrollRectToVisible(pages[indexPath.item].frame, animated: true)
    }
    
    func setupPursuitCollectionView(){
        pursuitCollectionView.register(ProfilePursuitCells.self, forCellWithReuseIdentifier: pursuitId)
        
    }
    
    func setupScrollView(){
        let page1 = pursuitCollectionView
        let page2 = challengeCollectionView
        
        pages = [page1, page2]
        
        contentScrollView.contentSize = CGSize(width: frame.width * CGFloat(pages.count), height: frame.height)
        contentScrollView.frame = CGRect(x: 0, y: 60, width: frame.width, height: frame.height)
        addSubview(contentScrollView)
        
        for i in 0 ..< pages.count{
            pages[i].frame = CGRect(x: frame.width * CGFloat(i), y: 0, width: frame.width, height: frame.height)
            contentScrollView.addSubview(pages[i])
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupMenuBar()
        setupScrollView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

