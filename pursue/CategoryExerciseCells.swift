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
        iv.image = #imageLiteral(resourceName: "backpack")
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
    
    
    @objc override func handlePursuitTap(){
        categoryDelegate?.categoryTapped()
    }
    
    @objc override func handlePursuitHold(){
        categoryDelegate?.categoryHeld()
    }
}
