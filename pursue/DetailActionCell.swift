//
//  DetailActionCell.swift
//  Inpursuit
//
//  Created by Jaylen Sanders on 5/7/19.
//  Copyright © 2019 Glory. All rights reserved.
//

import UIKit

class DetailActionCell : UICollectionViewCell {
    
    let actionTextLabel : UILabel = {
        let label = UILabel()
        label.text = "Test"
        label.font = UIFont.boldSystemFont(ofSize: 12)
        return label
    }()
    
    let circleBackground : UIView = {
        let view = UIView()
        view.layer.cornerRadius = 7
        view.layer.masksToBounds = true
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.borderWidth = 1
        return view
    }()
    
    func setupView(){
        addSubview(circleBackground)
        addSubview(actionTextLabel)
        
        circleBackground.anchor(top: nil, left: leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: 14, height: 14)
        circleBackground.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        actionTextLabel.anchor(top: nil, left: circleBackground.rightAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 12, paddingBottom: 0, paddingRight: 12, width: 0, height: 14)
        actionTextLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
