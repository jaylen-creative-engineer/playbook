//
//  SignupInterestsHeader.swift
//  pursue
//
//  Created by Jaylen Sanders on 4/8/18.
//  Copyright © 2018 Glory. All rights reserved.
//

import UIKit

class SignupInterestsHeader : UICollectionViewCell {
    
    let interestBigLabel : UILabel = {
        let label = UILabel()
        label.text = "Select Interest."
        label.font = UIFont.systemFont(ofSize: 24, weight: UIFont.Weight.init(25))
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(interestBigLabel)
        
        interestBigLabel.anchor(top: topAnchor, left: nil, bottom: nil, right: nil, paddingTop: 62, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: interestBigLabel.intrinsicContentSize.width, height: interestBigLabel.intrinsicContentSize.height)
        interestBigLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
