//
//  CategoryPeopleCells.swift
//  pursue
//
//  Created by Jaylen Sanders on 10/26/17.
//  Copyright © 2017 Glory. All rights reserved.
//

import UIKit

protocol CategoryPeopleDelegate {
    func profileTapped()
}

class CategoryPeopleCells : PeopleRowCells {
    
    var categoryPeopleDelegate : CategoryPeopleDelegate?
    
    lazy var categoryUserPhoto : UIImageView = {
        let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "samuel-l")
        iv.layer.cornerRadius = 40
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleProfileTap))
        tapGesture.numberOfTapsRequired = 1
        iv.addGestureRecognizer(tapGesture)
        iv.isUserInteractionEnabled = true
        return iv
    }()
    
    let categoryUsernameLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.text = "MyName"
        return label
    }()
    
    @objc override func handleProfileTap(){
        categoryPeopleDelegate?.profileTapped()
    }
    
    override func setupView() {
        super.setupView()
        addSubview(categoryUserPhoto)
        addSubview(categoryUsernameLabel)
        
        categoryUserPhoto.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 80, height: 80)
        categoryUsernameLabel.anchor(top: categoryUserPhoto.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 16, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: categoryUsernameLabel.intrinsicContentSize.width, height: categoryUsernameLabel.intrinsicContentSize.height)
        categoryUsernameLabel.centerXAnchor.constraint(equalTo: categoryUserPhoto.centerXAnchor).isActive = true
    }
}
