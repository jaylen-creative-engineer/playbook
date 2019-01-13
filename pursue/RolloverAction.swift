//
//  RolloverDay.swift
//  Inpursuit
//
//  Created by Jaylen Sanders on 1/11/19.
//  Copyright © 2019 Glory. All rights reserved.
//

import UIKit

class RolloverDay : UICollectionViewCell {
    
    let pursuitImageView : UIImageView = {
       let iv = UIImageView()
        iv.layer.cornerRadius = 8
        iv.layer.masksToBounds = true
        iv.contentMode = .scaleAspectFill
        iv.image = UIImage(named : "max-andrey-716124-unsplash")?.withRenderingMode(.alwaysOriginal)
        return iv
    }()
    
    let pursuitDescription : UILabel = {
       let label = UILabel()
        label.text = "This is filler text"
        label.textColor = .white
        label.numberOfLines = 1
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    
    let dayLabel : UILabel = {
       let label = UILabel()
        label.text = "S1 : Day 3"
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 1
        label.textColor = .white
        return label
    }()
    
    func setupView(){
        addSubview(pursuitImageView)
        addSubview(dayLabel)
        addSubview(pursuitDescription)
        
        pursuitImageView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        dayLabel.anchor(top: nil, left: pursuitImageView.leftAnchor, bottom: pursuitImageView.bottomAnchor, right: pursuitImageView.rightAnchor, paddingTop: 0, paddingLeft: 12, paddingBottom: 12, paddingRight: 12, width: 0, height: 15)
        pursuitDescription.anchor(top: nil, left: pursuitImageView.leftAnchor, bottom: dayLabel.topAnchor, right: pursuitImageView.rightAnchor, paddingTop: 0, paddingLeft: 12, paddingBottom: 8, paddingRight: 12, width: 0, height: 18)
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
