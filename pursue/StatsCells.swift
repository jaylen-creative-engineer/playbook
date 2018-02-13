//
//  StatsCells.swift
//  pursue
//
//  Created by Jaylen Sanders on 2/12/18.
//  Copyright © 2018 Glory. All rights reserved.
//

import UIKit

class StatsCells : UICollectionViewCell {
    
    let countLabel : UILabel = {
       let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let contentTypeLabel : UILabel = {
       let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(countLabel)
        addSubview(contentTypeLabel)
        countLabel.anchor(top: nil, left: leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: countLabel.intrinsicContentSize.width, height: countLabel.intrinsicContentSize.height)
        countLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        contentTypeLabel.anchor(top: countLabel.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 8, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: contentTypeLabel.intrinsicContentSize.width, height: contentTypeLabel.intrinsicContentSize.height)
        contentTypeLabel.centerXAnchor.constraint(equalTo: countLabel.centerXAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
