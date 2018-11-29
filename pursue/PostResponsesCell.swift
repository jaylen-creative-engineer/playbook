//
//  PostCommentsCell.swift
//  pursue
//
//  Created by Jaylen Sanders on 10/16/17.
//  Copyright © 2017 Glory. All rights reserved.
//

import UIKit

class PostResponsesCell : UICollectionViewCell {
    
    var post : Post? {
        didSet {
            guard let image = post?.thumbnailUrl else { return }
            photo.loadImageUsingCacheWithUrlString(image)
            solutionLabel.text = post?.posts_description
            usernameLabel.text = post?.username
        }
    }
    
    let photo : UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.layer.cornerRadius = 4
        iv.layer.masksToBounds = true
        return iv
    }()
    
    let solutionLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.numberOfLines = 0
        return label
    }()
    
    let usernameLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()
    
    func setupView(){
        addSubview(photo)
        
        photo.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 8, paddingBottom: 8, paddingRight: 0, width: 110, height: 120)
        if solutionLabel.text == "" {
            addSubview(usernameLabel)
            usernameLabel.anchor(top: photo.topAnchor, left: photo.rightAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 12, paddingBottom: 0, paddingRight: 12, width: 0, height: 0)
            usernameLabel.heightAnchor.constraint(lessThanOrEqualToConstant: 30).isActive = true
        } else {
            addSubview(solutionLabel)
            addSubview(usernameLabel)
            solutionLabel.anchor(top: photo.topAnchor, left: photo.rightAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 12, paddingBottom: 0, paddingRight: 12, width: 0, height: 0)
            solutionLabel.heightAnchor.constraint(lessThanOrEqualToConstant: 30).isActive = true
            usernameLabel.anchor(top: solutionLabel.bottomAnchor, left: photo.rightAnchor, bottom: nil, right: rightAnchor, paddingTop: 8, paddingLeft: 12, paddingBottom: 0, paddingRight: 12, width: 0, height: 0)
            usernameLabel.heightAnchor.constraint(lessThanOrEqualToConstant: 30).isActive = true
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
