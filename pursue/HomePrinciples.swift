//
//  HomePrinciples.swift
//  pursue
//
//  Created by Jaylen Sanders on 12/6/17.
//  Copyright © 2017 Glory. All rights reserved.
//

import UIKit

protocol HomePrinciplesDelegate {
    func showPrinciplesFeed()
    func principleTapped()
    func principleHeld()
}

class HomePrinciples : ProfilePrincipleRow, HomePrinciplesCellDelegate {
    
    let homePrincipleId = "homePrincipleId"
    var principlesDelegate : HomePrinciplesDelegate?
    let imageNames = ["mel-robbins", "reality", "census", "realist", "inheritance"]
    let homePrincipleLabel = ["5 Seconds", "Your reality is just a take on reality", "False Census Effect", "Naive Realism", "Treat others like they control your inheritance"]
    
    lazy var homeMoreButton : UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "right-arrow-1").withRenderingMode(.alwaysOriginal), for: .normal)
        button.addTarget(self, action: #selector(principlesFeed), for: .touchUpInside)
        return button
    }()
    
    @objc func principlesFeed() {
        principlesDelegate?.showPrinciplesFeed()
    }
    
    override func principleTapped(){
        principlesDelegate?.principleTapped()
    }
    
    override func principleHeld() {
        principlesDelegate?.principleHeld()
    }
    
    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: ((frame.width - 2) / 2) + 55, height: ((frame.width - 2) / 2) + 50)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: homePrincipleId, for: indexPath) as! HomePrinciplesCells
        cell.principleCellDelegate = self
        cell.profileLabel.text = homePrincipleLabel[indexPath.item]
        cell.homePrincipleImage.image = UIImage(named: imageNames[indexPath.item])?.withRenderingMode(.alwaysOriginal)
        rowLabel.text = "Mindful Principles"
        return cell
    }
    
    override func setupView() {
        super.setupView()
        addSubview(rowLabel)
        addSubview(postCollection)
        addSubview(homeMoreButton)
        
        rowLabel.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 12, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: rowLabel.intrinsicContentSize.width, height: rowLabel.intrinsicContentSize.height)
        postCollection.anchor(top: rowLabel.bottomAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        homeMoreButton.anchor(top: rowLabel.topAnchor, left: nil, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 20, width: 24, height: 12)
        postCollection.register(HomePrinciplesCells.self, forCellWithReuseIdentifier: homePrincipleId)
    }
    
}
