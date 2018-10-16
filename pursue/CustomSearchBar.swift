//
//  CustomSearchBar.swift
//  pursue
//
//  Created by Jaylen Sanders on 10/4/18.
//  Copyright © 2018 Glory. All rights reserved.
//

import UIKit

class CustomSearchBar : UIView {
    
    let backgroundView : SmallerCardView = {
       let view = SmallerCardView()
        view.backgroundColor = .white
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(backgroundView)
        backgroundView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 12, paddingBottom: 0, paddingRight: 12, width: 0, height: 0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
