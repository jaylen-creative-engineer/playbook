//
//  MyPursuitStoryCell.swift
//  pursue
//
//  Created by Jaylen Sanders on 9/6/18.
//  Copyright © 2018 Glory. All rights reserved.
//

import UIKit

class RecommenedPursuitCell : UICollectionViewCell {
    
    let imageView : UIImageView = {
       let iv = UIImageView()
        iv.image = UIImage(named: "4a6ed813870319.5627984277e3f")
        iv.contentMode = .scaleAspectFill
        iv.layer.cornerRadius = 4
        iv.layer.masksToBounds = true
        return iv
    }()
    
    let usernameLabel : UILabel = {
       let label = UILabel()
        label.text = "Test"
        label.font = UIFont(name: "Lato-Bold", size: 12)
        return label
    }()
    
    let postDescription : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.text = "Working on this."
        label.numberOfLines = 0
        return label
    }()
    
    let timeLabel : UILabel = {
       let label = UILabel()
        label.text = "1h ago"
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .gray
        return label
    }()
    
    func setupView(){
        addSubview(imageView)
        addSubview(usernameLabel)
        addSubview(postDescription)
        addSubview(timeLabel)
        
        imageView.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 400)
        usernameLabel.anchor(top: imageView.bottomAnchor, left: imageView.leftAnchor, bottom: nil, right: imageView.rightAnchor, paddingTop: 12, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 14)
        postDescription.anchor(top: usernameLabel.bottomAnchor, left: usernameLabel.leftAnchor, bottom: nil, right: usernameLabel.rightAnchor, paddingTop: 8, paddingLeft: 0, paddingBottom: 0, paddingRight: 8, width: 0, height: 0)
        postDescription.heightAnchor.constraint(lessThanOrEqualToConstant: 32).isActive = true
        timeLabel.anchor(top: postDescription.bottomAnchor, left: imageView.leftAnchor, bottom: nil, right: imageView.rightAnchor, paddingTop: 8, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 14)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
