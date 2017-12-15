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
        return iv
    }()
    
    @objc override func handlePrincipleTap() {
        categoryDelegate?.principleTapped()
    }
    
    @objc override func handlePrincipleHold(){
        categoryDelegate?.principleHeld()
    }
    
    override func setupCardDetails() {
        super.setupCardDetails()
        addSubview(categoryPrincipleImage)
        categoryPrincipleImage.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 8, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 190)
    }
}
