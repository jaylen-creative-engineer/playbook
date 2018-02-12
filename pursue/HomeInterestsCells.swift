//
//  HomeInterestsCells.swift
//  pursue
//
//  Created by Jaylen Sanders on 1/18/18.
//  Copyright © 2018 Glory. All rights reserved.
//

import UIKit

class HomeInterestsCells : UICollectionViewCell {
    
    lazy var interestsLabel : UILabel = {
       let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override var isHighlighted: Bool {
        didSet {
            interestsLabel.font = isHighlighted ?  UIFont.systemFont(ofSize: 24, weight: UIFont.Weight(rawValue: 25)) : UIFont.systemFont(ofSize: 18)
        }
    }
    
    override var isSelected: Bool {
        didSet {
            interestsLabel.font = isSelected ? UIFont.systemFont(ofSize: 24, weight: UIFont.Weight(rawValue: 25)) : UIFont.systemFont(ofSize: 18)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(interestsLabel)
        interestsLabel.anchor(top: nil, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: interestsLabel.intrinsicContentSize.height)
        interestsLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        interestsLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
