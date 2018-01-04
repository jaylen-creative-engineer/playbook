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
    
    let categoryMainDescription : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight(rawValue: 25))
        label.numberOfLines = 2
        label.textColor = .black
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleHomeTap))
        tapGesture.numberOfTapsRequired = 1
        label.addGestureRecognizer(tapGesture)
        
        let longGesture = UILongPressGestureRecognizer(target: self, action: #selector(handleHomeHold))
        label.addGestureRecognizer(longGesture)
        label.text = "Gone on a trip"
        return label
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
        addSubview(categoryMainDescription)
        
         categoryPostImage.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 16, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 300)
        categoryMainDescription.anchor(top: categoryPostImage.bottomAnchor, left: categoryPostImage.leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 12, paddingLeft: 0, paddingBottom: 0, paddingRight: 8, width: 0, height: categoryMainDescription.intrinsicContentSize.height)
    }
}
