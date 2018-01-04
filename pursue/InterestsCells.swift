//
//  InterestsCells.swift
//  pursue
//
//  Created by Jaylen Sanders on 1/3/18.
//  Copyright © 2018 Glory. All rights reserved.
//

import UIKit


class InterestsCells : UICollectionViewCell {
    
    lazy var selectInterests : UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.layer.borderWidth = 1
        label.layer.borderColor = UIColor.black.cgColor
        label.layer.cornerRadius = 15
        label.backgroundColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isUserInteractionEnabled = true
        return label
    }()
    
    func setupView(){
        addSubview(selectInterests)
        selectInterests.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 2, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 110, height: 29)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
