//
//  ChallengesRowCells.swift
//  pursue
//
//  Created by Jaylen Sanders on 10/23/17.
//  Copyright © 2017 Glory. All rights reserved.
//

import UIKit

protocol ExplorePrincipleCellsDelegate {
    func explorePrincipleTapped()
    func explorePrincipleHeld()
}

class ExplorePrincipleCells : UICollectionViewCell {
    
    var explorePrincipleDelegate : ExplorePrincipleCellsDelegate?
    
    let exploreButton : UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor.init(white: 0.4, alpha: 0.05)
        return button
    }()
    
    let exploreLabel : UILabel = {
        let label = UILabel()
        label.text = "Draw"
        label.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight(rawValue: 25))
        return label
    }()
    
    lazy var exploreImage : UIImageView = {
        let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "samuel-l")
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handlePrincipleTap))
        let longGesture = UILongPressGestureRecognizer(target: self, action: #selector(handlePrincipleHold))
        tapGesture.numberOfTapsRequired = 1
        iv.addGestureRecognizer(tapGesture)
        iv.addGestureRecognizer(longGesture)
        iv.isUserInteractionEnabled = true
        return iv
    }()
    
    @objc func handlePrincipleTap(){
        explorePrincipleDelegate?.explorePrincipleTapped()
    }
    
    @objc func handlePrincipleHold(){
        explorePrincipleDelegate?.explorePrincipleHeld()
    }
    
    func setupCardDetails(){
        
        addSubview(exploreImage)
        addSubview(exploreLabel)
        
        exploreImage.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 48, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 145)
        exploreLabel.anchor(top: exploreImage.bottomAnchor, left: exploreImage.leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 12, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: exploreLabel.intrinsicContentSize.height)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCardDetails()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
