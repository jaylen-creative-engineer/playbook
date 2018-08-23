//
//  PursuitNotification.swift
//  pursue
//
//  Created by Jaylen Sanders on 2/28/18.
//  Copyright © 2018 Glory. All rights reserved.
//

import UIKit

class PostNotification : UICollectionViewCell {
    
    let dayLabel : UILabel = {
       let label = UILabel()
        label.text = "Today"
        label.font = UIFont(name: "Lato-Bold", size: 12)
        label.textAlignment = .left
        return label
    }()
    
    let usernameLabel : UILabel = {
        let label = UILabel()
        label.text = "TomDoe"
        label.textColor = .gray
        label.font = UIFont(name: "Lato-Semibold", size: 12)
        return label
    }()
    
    let photo : UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.layer.cornerRadius = 4
        iv.layer.masksToBounds = true
        iv.image = #imageLiteral(resourceName: "campus").withRenderingMode(.alwaysOriginal)
        return iv
    }()
    
    let descriptionLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Lato-Semibold", size: 12)
        label.text = "Hold your breath for four, release for four and breath in for four"
        label.numberOfLines = 2
        return label
    }()
    
    func setupView(){
        addSubview(dayLabel)
        addSubview(photo)
        addSubview(descriptionLabel)
        addSubview(usernameLabel)
                
        dayLabel.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 14)
        photo.anchor(top: dayLabel.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 12, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 150)
        descriptionLabel.anchor(top: photo.bottomAnchor, left: photo.leftAnchor, bottom: nil, right: photo.rightAnchor, paddingTop: 8, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 30)
        usernameLabel.anchor(top: descriptionLabel.bottomAnchor, left: descriptionLabel.leftAnchor, bottom: nil, right: photo.rightAnchor, paddingTop: 4, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: usernameLabel.intrinsicContentSize.height)
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
