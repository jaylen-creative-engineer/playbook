//
//  ProfilePrincipleCells.swift
//  pursue
//
//  Created by Jaylen Sanders on 11/27/17.
//  Copyright © 2017 Glory. All rights reserved.
//

import UIKit

class ProfilePrincipleCells : UICollectionViewCell {
    
    let profileLabel : UILabel = {
        let label = UILabel()
        label.text = "DRAW"
        label.font = UIFont.systemFont(ofSize: 12, weight: UIFont.Weight(rawValue: 25))
        return label
    }()
    
    let profileDetailLabel : UILabel = {
        let label = UILabel()
        label.text = "Put In More Effort"
        label.font = UIFont.systemFont(ofSize: 18, weight: UIFont.Weight(rawValue: 25))
        return label
    }()
    
    let profileImage : UIImageView = {
        let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "samuel-l")
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.layer.cornerRadius = 4
        return iv
    }()
    
    func setupCardDetails(){
        
        addSubview(profileImage)
        addSubview(profileLabel)
        addSubview(profileDetailLabel)
        
        profileImage.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 62, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 190)
        profileLabel.anchor(top: profileImage.bottomAnchor, left: profileImage.leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 12, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: profileLabel.intrinsicContentSize.height)
        profileDetailLabel.anchor(top: profileLabel.bottomAnchor, left: profileLabel.leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 4, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: profileDetailLabel.intrinsicContentSize.height)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCardDetails()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
