//
//  LoadMoreIndicator.swift
//  pursue
//
//  Created by Jaylen Sanders on 11/16/18.
//  Copyright © 2018 Glory. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class HomeLoadMoreIndicator : UICollectionViewCell {
    
    let indicator : UIActivityIndicatorView = {
       let view = UIActivityIndicatorView()
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(indicator)
        indicator.anchor(top: nil, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 30, height: 30)
        indicator.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        indicator.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
