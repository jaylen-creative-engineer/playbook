//
//  DetailChallengeRow.swift
//  pursue
//
//  Created by Jaylen Sanders on 6/25/18.
//  Copyright © 2018 Glory. All rights reserved.
//

import UIKit

class DetailChallenge : UICollectionViewCell {
    
    let cellId = "cellId"
    let headerId = "headerId"
    
    let imageName = [#imageLiteral(resourceName: "health")]
    
    lazy var collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    let challengesLabel : UILabel = {
       let label = UILabel()
        label.text = "Challenges"
        label.font = UIFont.boldSystemFont(ofSize: 14)
        return label
    }()
    
    var accessPostDetailController : PostDetailController?
    
    func setupView(){
        addSubview(challengesLabel)
        addSubview(collectionView)
        
        challengesLabel.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: challengesLabel.intrinsicContentSize.width, height: 18)
        collectionView.anchor(top: challengesLabel.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 12, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 150)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(DetailChallengeCells.self, forCellWithReuseIdentifier: cellId)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension DetailChallenge : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! DetailChallengeCells
        cell.imageView.image = #imageLiteral(resourceName: "health")
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        accessPostDetailController?.changeToChallenge()
//        accessHomeController?.handleChangeToDetail(viewType: "isChallengeDetail")
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 12)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width - 40, height: 145)
    }
}
