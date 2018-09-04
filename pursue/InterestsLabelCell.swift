//
//  InterestsLabelCell.swift
//  pursue
//
//  Created by Jaylen Sanders on 8/19/18.
//  Copyright © 2018 Glory. All rights reserved.
//

import UIKit

class InterestsLabelCell : UICollectionViewCell {
    
    let interestsLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Lato-Bold", size: 12)
        label.textColor = .gray
        return label
    }()
    
    let labelUnderline : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override var isHighlighted: Bool {
        didSet {
            interestsLabel.textColor = isHighlighted ? .black : .gray
//            labelUnderline.backgroundColor = isHighlighted ? .black : .clear
        }
    }
    
    override var isSelected: Bool {
        didSet {
            interestsLabel.textColor = isSelected ? .black : .gray
            labelUnderline.backgroundColor = isSelected ? .black : .clear
        }
    }
    
    func setupView(){
        addSubview(interestsLabel)
        addSubview(labelUnderline)
        
        interestsLabel.anchor(top: nil, left: leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: interestsLabel.intrinsicContentSize.width, height: interestsLabel.intrinsicContentSize.height)
        interestsLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        labelUnderline.anchor(top: interestsLabel.bottomAnchor, left: interestsLabel.leftAnchor, bottom: nil, right: interestsLabel.rightAnchor, paddingTop: 2, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 1.5)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

