//
//  MyPursuitStoryCell.swift
//  pursue
//
//  Created by Jaylen Sanders on 9/6/18.
//  Copyright © 2018 Glory. All rights reserved.
//

import UIKit

class RecommenedPursuitCell : UICollectionViewCell {
    
    let photo : UIImageView = {
        let iv = UIImageView()
        iv.layer.cornerRadius = 12
        iv.layer.masksToBounds = true
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    let photoBackground : HomeCellRectangleView = {
        let view = HomeCellRectangleView()
        view.backgroundColor = .white
        return view
    }()
    
    let detailLabel : UILabel = {
        let label = UILabel()
        label.text = "Have a vision to work towards"
        label.textColor = .white
        label.numberOfLines = 1
        label.font = UIFont.boldSystemFont(ofSize: 12)
        return label
    }()
    
    let userPhoto : UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "gian-cescon-637914-unsplash")?.withRenderingMode(.alwaysOriginal)
        iv.contentMode = .scaleAspectFill
        iv.layer.cornerRadius = 15
        iv.layer.masksToBounds = true
        return iv
    }()
    
    func setupView(){
        addSubview(photoBackground)
        addSubview(photo)
        addSubview(userPhoto)
        addSubview(detailLabel)
        
        photoBackground.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        photo.anchor(top: photoBackground.topAnchor, left: photoBackground.leftAnchor, bottom: photoBackground.bottomAnchor, right: photoBackground.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        userPhoto.anchor(top: photo.topAnchor, left: photo.leftAnchor, bottom: nil, right: nil, paddingTop: 6, paddingLeft: 6, paddingBottom: 0, paddingRight: 0, width: 30, height: 30)
        detailLabel.anchor(top: nil, left: photo.leftAnchor, bottom: photo.bottomAnchor, right: photo.rightAnchor, paddingTop: 0, paddingLeft: 8, paddingBottom: 12, paddingRight: 8, width: 0, height: 14)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
