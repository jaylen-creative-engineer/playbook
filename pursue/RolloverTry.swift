//
//  RolloverTry.swift
//  Inpursuit
//
//  Created by Jaylen Sanders on 1/12/19.
//  Copyright © 2019 Glory. All rights reserved.
//

import UIKit

class RolloverTry : UICollectionViewCell {
    
    let photo : UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named : "gian-cescon-637914-unsplash")?.withRenderingMode(.alwaysOriginal)
        iv.clipsToBounds = true
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    let halfBackgroundView : UIView = {
       let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    let photoBackground : HomeCellRectangleView = {
        let view = HomeCellRectangleView()
        view.backgroundColor = .white
        return view
    }()
    
    let detailLabel : UILabel = {
        let label = UILabel()
        label.text = "Have a vision to work towards"
        label.numberOfLines = 2
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.init(25))
        return label
    }()
    
    let userPhotoBackground : UserPhotoBackground = {
        let iv = UserPhotoBackground()
        iv.backgroundColor = .white
        return iv
    }()
    
    let userPhoto : UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "gian-cescon-637914-unsplash")?.withRenderingMode(.alwaysOriginal)
        iv.contentMode = .scaleAspectFill
        iv.layer.cornerRadius = 25
        iv.layer.masksToBounds = true
        return iv
    }()
    
    let usernameLabel : UILabel = {
       let label = UILabel()
        label.text = "Test"
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        photo.roundCorners(corners: [.topLeft, .topRight], radius: 8.0)
    }
    
    func setupView(){
       addSubview(photoBackground)
        addSubview(photo)
        addSubview(userPhotoBackground)
        addSubview(userPhoto)
        addSubview(detailLabel)
        addSubview(usernameLabel)
        
        photoBackground.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        photo.roundCorners(corners: [.topLeft, .topRight], radius: 8.0)
        photo.anchor(top: photoBackground.topAnchor, left: photoBackground.leftAnchor, bottom: nil, right: photoBackground.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 150)
        userPhotoBackground.centerXAnchor.constraint(equalTo: photo.centerXAnchor).isActive = true
        userPhotoBackground.centerYAnchor.constraint(equalTo: photo.bottomAnchor).isActive = true
        userPhotoBackground.anchor(top: nil, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 50, height: 50)
        userPhoto.anchor(top: userPhotoBackground.topAnchor, left: userPhotoBackground.leftAnchor, bottom: userPhotoBackground.bottomAnchor, right: userPhotoBackground.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        detailLabel.anchor(top: userPhoto.bottomAnchor, left: photoBackground.leftAnchor, bottom: nil, right: photoBackground.rightAnchor, paddingTop: 6, paddingLeft: 6, paddingBottom: 0, paddingRight: 6, width: 0, height: 0)
        detailLabel.heightAnchor.constraint(lessThanOrEqualToConstant: 40).isActive = true
        usernameLabel.anchor(top: detailLabel.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 4, paddingLeft: 12, paddingBottom: 0, paddingRight: 12, width: 0, height: 14)
        usernameLabel.centerXAnchor.constraint(equalTo: detailLabel.centerXAnchor).isActive = true
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
