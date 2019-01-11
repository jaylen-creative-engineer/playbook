//
//  ProfileAddedCells.swift
//  Inpursuit
//
//  Created by Jaylen Sanders on 1/10/19.
//  Copyright © 2019 Glory. All rights reserved.
//

import UIKit

class ProfileAddedCells : UICollectionViewCell {
    
    let cellBackgroundView : HomeCellRectangleView = {
       let view = HomeCellRectangleView()
        view.backgroundColor = .white
        return view
    }()
    
    let userPhoto : UIImageView = {
       let iv = UIImageView()
        iv.layer.cornerRadius = 27.5
        iv.layer.masksToBounds = true
        iv.image = UIImage(named: "gian-cescon-637914-unsplash")?.withRenderingMode(.alwaysOriginal)
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    let usernameLabel : UILabel = {
       let label = UILabel()
        label.text = "Test"
        label.font = UIFont.boldSystemFont(ofSize: 14)
        return label
    }()
    
    let detailStackView : UIStackView = {
       let sv = UIStackView()
        sv.axis = .vertical
        sv.distribution = .fill
        sv.spacing = 10
        return sv
    }()
    
    func setupView(){
        addSubview(cellBackgroundView)
        addSubview(userPhoto)
        addSubview(usernameLabel)
        
        cellBackgroundView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        userPhoto.anchor(top: cellBackgroundView.topAnchor, left: nil, bottom: nil, right: nil, paddingTop: 24, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 55, height: 55)
        userPhoto.centerXAnchor.constraint(equalTo: cellBackgroundView.centerXAnchor).isActive = true
        usernameLabel.centerXAnchor.constraint(equalTo: userPhoto.centerXAnchor).isActive = true
        usernameLabel.anchor(top: userPhoto.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 18, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: usernameLabel.intrinsicContentSize.width, height: 16)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
