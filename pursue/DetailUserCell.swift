//
//  DetailUserCell.swift
//  Inpursuit
//
//  Created by Jaylen Sanders on 5/5/19.
//  Copyright © 2019 Glory. All rights reserved.
//

import UIKit

class DetailUserCell : UICollectionViewCell {
    
    let profilePicture : UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "gian-cescon-637914-unsplash")?.withRenderingMode(.alwaysOriginal)
        iv.contentMode = .scaleAspectFill
        iv.layer.cornerRadius = 10
        iv.layer.masksToBounds = true
        return iv
    }()
    
    func setupView(){
        addSubview(profilePicture)
        
        profilePicture.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
