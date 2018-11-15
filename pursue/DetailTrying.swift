//
//  DetailRelated.swift
//  pursue
//
//  Created by Jaylen Sanders on 9/7/18.
//  Copyright © 2018 Glory. All rights reserved.
//

import UIKit

class DetailTrying : UICollectionViewCell {
    
    var trying : [Post]? {
        didSet {
            for value in trying ?? [] {
                print(value)
                if value.pursuitId == nil {
                    addSubview(noTries)
                    noTries.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
                    noTries.anchor(top: tryingLabel.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 32, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: noTries.intrinsicContentSize.width, height: 18)
                }
            }
            
            collectionView.reloadData()
            
        }
    }
    
    let cellId = "cellId"
        
    let tryingLabel : UILabel = {
        let label = UILabel()
        label.text = "People Trying This Pursuit"
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
    
    let noTries : UILabel = {
        let label = UILabel()
        label.text = "No One Has Tried This Pursuit Yet"
        label.textColor = .gray
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    
    var accessPostDetailController : PostDetailController?
    
    func setupView(){
        addSubview(tryingLabel)
        addSubview(collectionView)
        
        tryingLabel.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: tryingLabel.intrinsicContentSize.width, height: 18)
        collectionView.anchor(top: tryingLabel.bottomAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 12, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(DetailSavedCells.self, forCellWithReuseIdentifier: cellId)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension DetailTrying : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! DetailSavedCells
        cell.post = trying?[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        for value in trying ?? [] {
            if value.pursuitId == nil {
               return 0
            }
        }
        
        return trying?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.init(top: 0, left: 12, bottom: 0, right: 12)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width / 2.25, height: frame.height - 72)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        accessPostDetailController?.changeToDetail()
    }
}
