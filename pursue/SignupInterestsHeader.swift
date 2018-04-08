//
//  SignupInterestsHeader.swift
//  pursue
//
//  Created by Jaylen Sanders on 4/8/18.
//  Copyright © 2018 Glory. All rights reserved.
//

import UIKit

class SignupInterestsHeader : UICollectionViewCell {
    
    let selectInterestPrompt : UILabel = {
        let label = UILabel()
        label.text = "Please select 5 interests."
        label.font = UIFont.boldSystemFont(ofSize: 14)
        return label
    }()
    
    let interestBigLabel : UILabel = {
        let label = UILabel()
        label.text = "Select Interest."
        label.font = UIFont.systemFont(ofSize: 24, weight: UIFont.Weight.init(25))
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(interestBigLabel)
        addSubview(selectInterestPrompt)
        
        interestBigLabel.anchor(top: topAnchor, left: nil, bottom: nil, right: nil, paddingTop: 62, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: interestBigLabel.intrinsicContentSize.width, height: interestBigLabel.intrinsicContentSize.height)
        interestBigLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        selectInterestPrompt.anchor(top: interestBigLabel.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 12, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: selectInterestPrompt.intrinsicContentSize.width, height: selectInterestPrompt.intrinsicContentSize.height)
        selectInterestPrompt.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
