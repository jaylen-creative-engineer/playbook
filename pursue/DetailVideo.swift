//
//  DetailVideo.swift
//  Inpursuit
//
//  Created by Jaylen Sanders on 5/8/19.
//  Copyright © 2019 Glory. All rights reserved.
//

import UIKit

class DetailVideo : UICollectionViewCell {
    
    let randomView : UIView = {
        let view = UIView()
        view.backgroundColor = .red
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        insertSubview(randomView, belowSubview: self)
        randomView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
