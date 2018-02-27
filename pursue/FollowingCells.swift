//
//  FollowingCells.swift
//  pursue
//
//  Created by Jaylen Sanders on 2/27/18.
//  Copyright © 2018 Glory. All rights reserved.
//

import UIKit

class FollowingCells : UICollectionViewCell {
    
    let imageView : UIImageView = {
       let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "samuel-l").withRenderingMode(.alwaysOriginal)
        iv.contentMode = .scaleAspectFill
        iv.layer.masksToBounds = true
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.layer.cornerRadius = 17.5
        return iv
    }()
 
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(imageView)
        imageView.anchor(top: nil, left: leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 8, paddingBottom: 0, paddingRight: 0, width: 35, height: 35)
        imageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

