//
//  PursuitDayTableViewCell.swift
//  pursue
//
//  Created by Jayesh on 06/08/18.
//  Copyright © 2018 Glory. All rights reserved.
//

import UIKit

class PursuitDayTableViewCell: UICollectionViewCell {
    
    var post : Post? {
        didSet {
            guard let image = post?.thumbnailUrl else { return }
            photo.loadImageUsingCacheWithUrlString(image)
            postLabel.text = post?.posts_description
        }
    }
    
    let photo : UIImageView = {
        let iv = UIImageView()
        iv.layer.cornerRadius = 4
        iv.layer.masksToBounds = true
        iv.clipsToBounds = true
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    let postLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Lato-Semibold", size: 12)
        return label
    }()
    
    func setupView(){
        addSubview(photo)
        addSubview(postLabel)
        
        photo.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 18, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 190)
        postLabel.anchor(top: photo.bottomAnchor, left: photo.leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 8, paddingLeft: 0, paddingBottom: 0, paddingRight: 6, width: 0, height: 0)
        postLabel.heightAnchor.constraint(lessThanOrEqualToConstant: 30).isActive = true
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
