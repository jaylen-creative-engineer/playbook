//
//  ActionMenuCells.swift
//  Inpursuit
//
//  Created by Jaylen Sanders on 12/28/18.
//  Copyright © 2018 Glory. All rights reserved.
//

import UIKit

class ActionMenuCells : UICollectionViewCell {
    
    let sectionLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.init(name: "Roboto-Black", size: 14)
        label.textColor = .gray
        return label
    }()
    
    override var isHighlighted: Bool {
        didSet {
            sectionLabel.textColor = isHighlighted ? .black : .gray
            sectionLabel.font = isHighlighted ? UIFont.init(name: "Roboto-Black", size: 14) : UIFont.init(name: "Roboto-Black", size: 14)
        }
    }
    
    override var isSelected: Bool {
        didSet {
            sectionLabel.textColor = isSelected ? .black : .gray
            sectionLabel.font = isSelected ? UIFont.init(name: "Roboto-Black", size: 14) : UIFont.init(name: "Roboto-Black", size: 14)
        }
    }
    
    func setupView(){
        addSubview(sectionLabel)
        
        sectionLabel.anchor(top: nil, left: leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: sectionLabel.intrinsicContentSize.width, height: sectionLabel.intrinsicContentSize.height)
        sectionLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
