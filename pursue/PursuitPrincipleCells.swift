//
//  PursuitPrincipleCells.swift
//  pursue
//
//  Created by Jaylen Sanders on 12/12/17.
//  Copyright © 2017 Glory. All rights reserved.
//

import UIKit

class PursuitPrincipleCells : UICollectionViewCell {
    
    let principleLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight(rawValue: 25))
        label.text = "Drive Fast"
        return label
    }()
    
    lazy var principleImage : UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.isUserInteractionEnabled = true
        iv.layer.cornerRadius = 4
        iv.image = #imageLiteral(resourceName: "mel-robbins")
        return iv
    }()
    
    func setupCardDetails(){
        addSubview(principleImage)
        addSubview(principleLabel)
        
        principleImage.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 145)
        principleLabel.anchor(top: principleImage.bottomAnchor, left: principleImage.leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 12, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: principleLabel.intrinsicContentSize.height)
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCardDetails()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
