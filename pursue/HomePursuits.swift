//
//  HomePursuits.swift
//  pursue
//
//  Created by Jaylen Sanders on 12/6/17.
//  Copyright © 2017 Glory. All rights reserved.
//

import UIKit

protocol HomePursuitsRowDelegate {
    func showPursuitsFeed()
    func pursuitClicked()
    func pursuitHeld()
}

class HomePursuits : ProfilePursuitsRow, PursuitSelected {
    
    var pursuitsDelegate : HomePursuitsRowDelegate?
    let homeCellId = "homeCellId"
    
    lazy var homeMoreButton : UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "right-arrow-1").withRenderingMode(.alwaysOriginal), for: .normal)
        button.addTarget(self, action: #selector(handlePursuitsChange), for: .touchUpInside)
        return button
    }()
    
    @objc func handlePursuitsChange(){
        pursuitsDelegate?.showPursuitsFeed()
    }
    
    override func pursuitTapped() {
        pursuitsDelegate?.pursuitClicked()
    }
    
    override func pursuitHeld() {
        pursuitsDelegate?.pursuitHeld()
    }
    
    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: ((frame.width - 2) / 2) + 125, height: 300)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: homeCellId, for: indexPath) as! HomePursuitsCells
        cell.homePursuitDelegate = self
        rowLabel.text = "YOUR PURSUITS"
        return cell
    }
    
    override func setupView() {
        super.setupView()
        postCollection.register(HomePursuitsCells.self, forCellWithReuseIdentifier: homeCellId)
        addSubview(homeMoreButton)
        homeMoreButton.anchor(top: rowLabel.topAnchor, left: nil, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 20, width: 24, height: 12)
    }
}
