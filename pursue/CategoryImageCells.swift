//
//  CategoryImageCells.swift
//  pursue
//
//  Created by Jaylen Sanders on 10/26/17.
//  Copyright © 2017 Glory. All rights reserved.
//

import UIKit

protocol CategoryImageDelegate {
    func homeImageTapped()
    func homeImageHeld()
}

class CategoryImageCells : HomeRowCells {
    
    var categoryImageDelegate : CategoryImageDelegate?
    
    lazy var categoryPostImage : UIImageView = {
        let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "tumblr_nbje6dualg1r46py4o1_1280")
        iv.contentMode = .scaleAspectFill
        iv.layer.masksToBounds = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleHomeTap))
        let longGesture = UILongPressGestureRecognizer(target: self, action: #selector(handleHomeHold))
        tapGesture.numberOfTapsRequired = 1
        iv.addGestureRecognizer(tapGesture)
        iv.addGestureRecognizer(longGesture)
        iv.isUserInteractionEnabled = true
        return iv
    }()
    
    @objc override func handleHomeTap(){
        categoryImageDelegate?.homeImageTapped()
    }
    
    @objc override func handleHomeHold(){
        categoryImageDelegate?.homeImageHeld()
    }
    
    override func setupView() {
        super.setupView()
        
        addSubview(categoryPostImage)
         categoryPostImage.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 16, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 300)
    }
}
