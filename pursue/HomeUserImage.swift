//
//  HomeUserImage.swift
//  pursue
//
//  Created by Jaylen Sanders on 12/28/17.
//  Copyright © 2017 Glory. All rights reserved.
//

import UIKit

class HomeUserImage : UICollectionViewCell {
    
    let profileImage : UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.layer.masksToBounds = true
        iv.image = #imageLiteral(resourceName: "samuel-l").withRenderingMode(.alwaysOriginal)
        iv.layer.cornerRadius = 17.5
        return iv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(profileImage)
        profileImage.anchor(top: nil, left: leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 35, height: 35)
        profileImage.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
