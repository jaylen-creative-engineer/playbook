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
        iv.image = #imageLiteral(resourceName: "clean-8")
        iv.layer.cornerRadius = 40
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleProfileTap))
        tapGesture.numberOfTapsRequired = 1
        iv.addGestureRecognizer(tapGesture)
        iv.isUserInteractionEnabled = true
        return iv
    }()
    
    @objc override func handleProfileTap(){
        categoryPeopleDelegate?.profileTapped()
    }
    
    override func setupView() {
        super.setupView()
        addSubview(categoryUserPhoto)
        categoryUserPhoto.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 80, height: 80)
    }
}
