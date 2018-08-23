//
//  NotificationRowHeader.swift
//  pursue
//
//  Created by Jaylen Sanders on 8/22/18.
//  Copyright © 2018 Glory. All rights reserved.
//

import UIKit

class NotificationRowHeader : UICollectionViewCell {
    
    let label : UILabel = {
       let label = UILabel()
        label.text = "Today"
        label.textColor = .gray
        label.font = UIFont(name: "Lato-Semibold", size: 12)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(label)
        label.anchor(top: topAnchor, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: label.intrinsicContentSize.width, height: 14)
        label.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
