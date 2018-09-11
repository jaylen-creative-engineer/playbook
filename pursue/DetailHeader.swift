//
//  DetailHeader.swift
//  pursue
//
//  Created by Jaylen Sanders on 8/8/18.
//  Copyright © 2018 Glory. All rights reserved.
//

import UIKit

class DetailHeader : UICollectionViewCell {
    
    let headerLabel : UILabel = {
       let label = UILabel()
        label.text = "Day 1"
        label.font = UIFont(name: "Lato-Bold", size: 12)
        return label
    }()
    
    func setupView(){
        addSubview(headerLabel)
        headerLabel.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: 0, height: headerLabel.intrinsicContentSize.height)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
