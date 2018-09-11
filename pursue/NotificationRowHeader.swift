//
//  NotificationRowHeader.swift
//  pursue
//
//  Created by Jaylen Sanders on 8/22/18.
//  Copyright © 2018 Glory. All rights reserved.
//

import UIKit

class NotificationRowHeader : UICollectionViewCell {
    
    let rowLabel : UILabel = {
       let label = UILabel()
        label.text = "Today"
        label.textColor = .gray
        label.font = UIFont(name: "Lato-Bold", size: 14)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(rowLabel)
        rowLabel.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: rowLabel.intrinsicContentSize.width, height: 16)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
