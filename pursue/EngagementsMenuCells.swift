//
//  EngagementsMenuCells.swift
//  Inpursuit
//
//  Created by Jaylen Sanders on 1/2/19.
//  Copyright © 2019 Glory. All rights reserved.
//

import UIKit

class EngagementsMenuCells : UICollectionViewCell {
    
    let sectionLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = .gray
        return label
    }()
    
    override var isHighlighted: Bool {
        didSet {
            sectionLabel.textColor = isHighlighted ? .black : .gray
            sectionLabel.font = isHighlighted ? UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.init(25)) : UIFont.boldSystemFont(ofSize: 16)
        }
    }
    
    override var isSelected: Bool {
        didSet {
            sectionLabel.textColor = isSelected ? .black : .gray
            sectionLabel.font = isSelected ? UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.init(25)) : UIFont.boldSystemFont(ofSize: 16)
        }
    }
    
    func setupView(){
        addSubview(sectionLabel)
        
        sectionLabel.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: sectionLabel.intrinsicContentSize.width, height: sectionLabel.intrinsicContentSize.height)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
