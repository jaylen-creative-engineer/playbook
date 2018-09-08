//
//  EngagementsHeaderCell.swift
//  pursue
//
//  Created by Jaylen Sanders on 9/7/18.
//  Copyright © 2018 Glory. All rights reserved.
//

import UIKit

class EngagementsHeaderCell : UICollectionViewCell {
    
    let sectionLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Lato-Bold", size: 12)
        label.textColor = .gray
        return label
    }()
    
    override var isHighlighted: Bool {
        didSet {
            sectionLabel.textColor = isHighlighted ? .black : .gray
            //            labelUnderline.backgroundColor = isHighlighted ? .black : .clear
        }
    }
    
    override var isSelected: Bool {
        didSet {
            sectionLabel.textColor = isSelected ? .black : .gray
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
