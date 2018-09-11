//
//  NotificationHeaderCells.swift
//  pursue
//
//  Created by Jaylen Sanders on 9/10/18.
//  Copyright © 2018 Glory. All rights reserved.
//

import UIKit

class NotificationHeaderCells : UICollectionViewCell {
    
    let sectionLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.init(25))
        label.textColor = .gray
        return label
    }()
    

    override var isHighlighted: Bool {
        didSet {
            sectionLabel.textColor = isHighlighted ? .black : .gray
        }
    }
    
    override var isSelected: Bool {
        didSet {
            sectionLabel.textColor = isSelected ? .black : .gray
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

