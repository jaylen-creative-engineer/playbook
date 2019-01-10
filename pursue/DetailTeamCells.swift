//
//  DetailTeamCells.swift
//  Inpursuit
//
//  Created by Jaylen Sanders on 1/9/19.
//  Copyright © 2019 Glory. All rights reserved.
//

import UIKit

class DetailTeamCells : UICollectionViewCell {
    
    let userPhoto : UIImageView = {
       let iv = UIImageView()
        iv.layer.cornerRadius = 35
        iv.layer.masksToBounds = true
        iv.contentMode = .scaleAspectFill
        iv.image = UIImage(named: "gian-cescon-637914-unsplash")?.withRenderingMode(.alwaysOriginal)
        return iv
    }()
    
    let usernameLabel : UILabel = {
       let label = UILabel()
        label.text = "Test"
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    
    let fullnameLabel : UILabel = {
       let label = UILabel()
        label.text = "Test"
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    let nameStackView : UIStackView = {
       let sv = UIStackView()
        sv.axis = .vertical
        sv.distribution = .fillEqually
        return sv
    }()
    
    func setupView(){
        addSubview(userPhoto)
        addSubview(nameStackView)
        
        nameStackView.addArrangedSubview(usernameLabel)
        nameStackView.addArrangedSubview(fullnameLabel)
        
        userPhoto.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 4, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: 70, height: 70)
        nameStackView.anchor(top: userPhoto.topAnchor, left: userPhoto.rightAnchor, bottom: userPhoto.bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
