//
//  CategoryExerciseCells.swift
//  pursue
//
//  Created by Jaylen Sanders on 10/26/17.
//  Copyright © 2017 Glory. All rights reserved.
//

import UIKit

protocol CategoryExerciseDelegate {
    func categoryTapped()
    func categoryHeld()
}

class CategoryExerciseCells  : HomePursuitsCells {
    
    var categoryDelegate : CategoryExerciseDelegate?
    
    lazy var categoryPursuitImage : UIImageView = {
        let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "ferrari")
        iv.contentMode = .scaleAspectFill
        iv.layer.masksToBounds = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handlePursuitTap))
        let longGesture = UILongPressGestureRecognizer(target: self, action: #selector(handlePursuitHold))
        tapGesture.numberOfTapsRequired = 1
        iv.addGestureRecognizer(tapGesture)
        iv.addGestureRecognizer(longGesture)
        iv.isUserInteractionEnabled = true
        return iv
    }()
    
    let categoryProgressBar : UIProgressView = {
        let pv = UIProgressView()
        pv.trackTintColor = UIColor.rgb(red: 211, green: 211, blue: 211)
        pv.progress = 0.3
        pv.progressTintColor = UIColor.rgb(red: 0, green: 128, blue: 0)
        pv.translatesAutoresizingMaskIntoConstraints = false
        return pv
    }()
    
    lazy var categoryPursuitLabel : UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight(rawValue: 25))
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleHomeTap))
        let longGesture = UILongPressGestureRecognizer(target: self, action: #selector(handleHomeHold))
        tapGesture.numberOfTapsRequired = 1
        label.addGestureRecognizer(tapGesture)
        label.addGestureRecognizer(longGesture)
        label.text = "Almost Done"
        return label
    }()
    
    let categoryProgressLabel : UILabel = {
        let label = UILabel()
        label.text = "30%"
        label.textColor = UIColor.rgb(red: 0, green: 128, blue: 0)
        label.font = UIFont.boldSystemFont(ofSize: 12)
        return label
    }()
    
    override func setupView() {
        addSubview(categoryPursuitImage)
        addSubview(categoryPursuitLabel)
        addSubview(categoryProgressBar)
        addSubview(categoryProgressLabel)
        
        categoryPursuitImage.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 24, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 190)
        categoryProgressLabel.anchor(top: categoryPursuitImage.bottomAnchor, left: nil, bottom: nil, right: categoryPursuitImage.rightAnchor, paddingTop: 4, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: categoryProgressLabel.intrinsicContentSize.width, height: categoryProgressLabel.intrinsicContentSize.height)
        categoryProgressBar.anchor(top: nil, left: categoryPursuitImage.leftAnchor, bottom: nil, right: categoryProgressLabel.leftAnchor, paddingTop: 4, paddingLeft: 0, paddingBottom: 0, paddingRight: 8, width: 0, height: 3)
        categoryProgressBar.centerYAnchor.constraint(equalTo: categoryProgressLabel.centerYAnchor).isActive = true
        categoryPursuitLabel.anchor(top: categoryProgressBar.bottomAnchor, left: categoryProgressBar.leftAnchor, bottom: nil, right: categoryPursuitImage.rightAnchor, paddingTop: 8, paddingLeft: 0, paddingBottom: 0, paddingRight: 8, width: 0, height: categoryPursuitLabel.intrinsicContentSize.height)
    }
    
    @objc override func handlePursuitTap(){
        categoryDelegate?.categoryTapped()
    }
    
    @objc override func handlePursuitHold(){
        categoryDelegate?.categoryHeld()
    }
}
