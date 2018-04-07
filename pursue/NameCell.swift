//
//  NameCell.swift
//  pursue
//
//  Created by Jaylen Sanders on 4/5/18.
//  Copyright © 2018 Glory. All rights reserved.
//

import UIKit

class NameCell : UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .red
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
