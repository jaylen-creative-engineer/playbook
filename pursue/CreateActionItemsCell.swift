//
//  CreateActionItemsCell.swift
//  Inpursuit
//
//  Created by Jaylen Sanders on 1/15/19.
//  Copyright © 2019 Glory. All rights reserved.
//

import UIKit

class CreateActionItemsCell : UICollectionViewCell {
    
    lazy var checkBox : UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .black
        button.layer.cornerRadius = 10
        button.layer.masksToBounds = true
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.borderWidth = 1
        return button
    }()
    
    let stepLabel : UILabel = {
        let label = UILabel()
        label.text = "This is filler text"
        label.font = UIFont.init(name: "Roboto-Medium", size: 16)
        return label
    }()

    func setupView(){
        addSubview(checkBox)
        addSubview(stepLabel)
      
        checkBox.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 24, paddingBottom: 0, paddingRight: 0, width: 20, height: 20)
        stepLabel.anchor(top: topAnchor, left: checkBox.rightAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 18, paddingBottom: 0, paddingRight: 12, width: 0, height: stepLabel.intrinsicContentSize.height)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
