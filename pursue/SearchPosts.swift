//
//  SearchPrinciples.swift
//  pursue
//
//  Created by Jaylen Sanders on 2/15/18.
//  Copyright © 2018 Glory. All rights reserved.
//

import UIKit

class SearchPosts : UICollectionViewCell {
    
    var posts : [Post]? {
        didSet {
            collectionView.reloadData()
        }
    }
    
    let cellId = "cellId"
    var accessHomeController : HomeController?
    
    let postsLabel : UILabel = {
        let label = UILabel()
        label.text = "Posts"
        label.font = UIFont.boldSystemFont(ofSize: 14)
        return label
    }()
    
    let collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    func setupView(){
        addSubview(postsLabel)
        addSubview(collectionView)

        postsLabel.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: postsLabel.intrinsicContentSize.width, height: 16)
        collectionView.anchor(top: postsLabel.bottomAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 24, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(SearchPostCells.self, forCellWithReuseIdentifier: cellId)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension SearchPosts : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! SearchPostCells
        cell.post = posts?[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return posts?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        accessHomeController?.changeToSearchPostDetail(searchPostId: (posts?[indexPath.item].postId)!, searchPursuitId: (posts?[indexPath.item].pursuitId)!)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.init(top: 0, left: 12, bottom: 0, right: 12)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (frame.width / 2) + 20, height: (frame.height / 1.2) - 20)
    }
}

