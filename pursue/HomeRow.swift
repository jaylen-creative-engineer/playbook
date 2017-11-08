//
//  HomeRow.swift
//  pursue
//
//  Created by Jaylen Sanders on 9/21/17.
//  Copyright © 2017 Glory. All rights reserved.
//

import UIKit

protocol ChangeToFeed {
    func handleChangeToFeed(for cell: HomeRow)
}

class HomeRow: UICollectionViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var accessHomeController : HomeController?
    var delegate : ChangeToFeed?
    
    let rowLabel : UILabel = {
        let label = UILabel()
        label.text = "TODAY'S PICKS"
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 12)
        let tap = UITapGestureRecognizer(target: self, action: #selector(feedChange))
        label.addGestureRecognizer(tap)
        label.isUserInteractionEnabled = true
        return label
    }()
    
    lazy var moreButton : UILabel = {
        let label = UILabel()
        label.text = "SEE MORE"
        label.textColor = .blue
        label.font = UIFont.boldSystemFont(ofSize: 12)
        let tap = UITapGestureRecognizer(target: self, action: #selector(feedChange))
        label.addGestureRecognizer(tap)
        label.isUserInteractionEnabled = true
        return label
    }()
    
    @objc func feedChange(){
        delegate?.handleChangeToFeed(for: self)
    }
    
    let cellId = "cellId"
    
    let postCollection : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }

    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (frame.width / 2) - 20, height: frame.height)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! HomeRowCells
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(0, 12, 0, 12)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        accessHomeController?.showPostDetailForPost()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(postCollection)
        addSubview(rowLabel)
        addSubview(moreButton)
        
        rowLabel.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 12, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: rowLabel.intrinsicContentSize.width, height: rowLabel.intrinsicContentSize.height)
        moreButton.anchor(top: rowLabel.topAnchor, left: nil, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 12, width: moreButton.intrinsicContentSize.width, height: moreButton.intrinsicContentSize.height)
        postCollection.anchor(top: rowLabel.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 12, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 330)
        postCollection.register(HomeRowCells.self, forCellWithReuseIdentifier: cellId)
        postCollection.dataSource = self
        postCollection.delegate = self
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}
