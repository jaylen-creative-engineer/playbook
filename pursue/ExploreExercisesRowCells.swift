//
//  ExploreChallengeRowCells.swift
//  pursue
//
//  Created by Jaylen Sanders on 10/24/17.
//  Copyright © 2017 Glory. All rights reserved.
//

import UIKit

protocol ExploreExerciseCellsDelegate {
    func pursuitTapped()
    func pursuitHeld()
}
class ExploreExercisesRowCells  : UICollectionViewCell {
    
    var exploreExereciseDelegate : ExploreExerciseCellsDelegate?
    
    let exploreLabel : UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 14)
        label.textAlignment = .justified
        return label
    }()
    
    lazy var exploreImage : UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.layer.masksToBounds = true
        iv.translatesAutoresizingMaskIntoConstraints = false
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handlePursuitTap))
        let longGesture = UILongPressGestureRecognizer(target: self, action: #selector(handlePursuitHold))
        tapGesture.numberOfTapsRequired = 1
        iv.addGestureRecognizer(tapGesture)
        iv.addGestureRecognizer(longGesture)
        iv.isUserInteractionEnabled = true
        iv.layer.cornerRadius = 4
        return iv
    }()
    
    @objc func handlePursuitTap(){
        exploreExereciseDelegate?.pursuitTapped()
    }
    
    @objc func handlePursuitHold(){
        exploreExereciseDelegate?.pursuitHeld()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        exploreLabel.sizeToFit()
    }
    
    func setupView(){
        addSubview(exploreImage)
        addSubview(exploreLabel)

        exploreImage.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 6, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 250, height: 155)
        exploreLabel.anchor(top: exploreImage.bottomAnchor, left: exploreImage.leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 12, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 45)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

