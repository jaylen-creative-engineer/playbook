//
//  ExploreChallengeRowCells.swift
//  pursue
//
//  Created by Jaylen Sanders on 10/24/17.
//  Copyright © 2017 Glory. All rights reserved.
//

import UIKit

class ExploreExercisesRowCells  : UICollectionViewCell {
    
    let exploreLabel : UILabel = {
        let label = UILabel()
        label.text = "Battle"
        label.numberOfLines = 2
        label.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight(rawValue: 25))
        return label
    }()
    
    let exploreImage : UIImageView = {
        let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "backpack")
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
    }()
    
    func setupView(){
        addSubview(exploreImage)
        addSubview(exploreLabel)

        exploreImage.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 200, height: 125)
        exploreLabel.anchor(top: exploreImage.bottomAnchor, left: exploreImage.leftAnchor, bottom: nil, right: exploreImage.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 8, width: 0, height: 42)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

