//
//  DetailGoalCell.swift
//  Inpursuit
//
//  Created by Jaylen Sanders on 5/14/19.
//  Copyright © 2019 Glory. All rights reserved.
//

import UIKit

class DetailGoalCell : UICollectionViewCell {
    
    let goalImageView : UIImageView = {
        let iv = UIImageView()
        iv.layer.cornerRadius = 8
        iv.layer.masksToBounds = true
        iv.image = UIImage(named: "cafe-768771_1280")?.withRenderingMode(.alwaysOriginal)
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    let goalDescription : UILabel = {
        let label = UILabel()
        label.text = "Heavy exercises"
        label.numberOfLines = 2
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = .white
        return label
    }()
    
    func setupView(){
        addSubview(goalImageView)
        addSubview(goalDescription)
        
        goalImageView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        goalDescription.anchor(top: nil, left: goalImageView.leftAnchor, bottom: goalImageView.bottomAnchor, right: goalImageView.rightAnchor, paddingTop: 0, paddingLeft: 6, paddingBottom: 12, paddingRight: 8, width: 0, height: 0)
        goalDescription.heightAnchor.constraint(lessThanOrEqualToConstant: 38).isActive = true
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
