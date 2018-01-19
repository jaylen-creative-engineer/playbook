//
//  CategoryChallengeCells.swift
//  pursue
//
//  Created by Jaylen Sanders on 10/26/17.
//  Copyright © 2017 Glory. All rights reserved.
//

import UIKit

protocol CategoryPrincipleDelegate {
    func principleTapped()
    func principleHeld()
}
class CategoryPrincipleCells : HomePrinciplesCells {
    
    var categoryDelegate : CategoryPrincipleDelegate?
    
    lazy var categoryPrincipleImage : UIImageView = {
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
        iv.layer.cornerRadius = 4
        return iv
    }()
    
    let categoryLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight(rawValue: 25))
        label.text = "Follow these"
        return label
    }()
    
    @objc func handlePrincipleTap() {
        categoryDelegate?.principleTapped()
    }
    
    @objc func handlePrincipleHold(){
        categoryDelegate?.principleHeld()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        categoryLabel.sizeToFit()
    }
    
    override func setupCardDetails() {
        super.setupCardDetails()
        addSubview(categoryPrincipleImage)
        addSubview(categoryLabel)
        categoryPrincipleImage.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 8, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 190)
        categoryLabel.anchor(top: categoryPrincipleImage.bottomAnchor, left: categoryPrincipleImage.leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 12, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 50)
    }
}
