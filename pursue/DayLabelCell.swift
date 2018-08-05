//
//  DayCell.swift
//  pursue
//
//  Created by Jaylen Sanders on 7/2/18.
//  Copyright © 2018 Glory. All rights reserved.
//

import UIKit

class DayLabelCell : UICollectionViewCell {
    
    let dayLabel : UILabel = {
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
            dayLabel.textColor = isHighlighted ? .black : .gray
            labelUnderline.backgroundColor = isHighlighted ? .black : .clear
        }
    }
    
    override var isSelected: Bool {
        didSet {
            dayLabel.textColor = isSelected ? .black : .gray
            labelUnderline.backgroundColor = isSelected ? .black : .clear
        }
    }
    
    func setupView(){
        addSubview(dayLabel)
        addSubview(labelUnderline)
        
        dayLabel.anchor(top: nil, left: leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: dayLabel.intrinsicContentSize.width, height: dayLabel.intrinsicContentSize.height)
        dayLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        labelUnderline.anchor(top: dayLabel.bottomAnchor, left: dayLabel.leftAnchor, bottom: nil, right: dayLabel.rightAnchor, paddingTop: 2, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 2)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
