//
//  ChatPeopleCells.swift
//  pursue
//
//  Created by Jaylen Sanders on 6/28/18.
//  Copyright © 2018 Glory. All rights reserved.
//

import UIKit

class ChatPeopleCells : UICollectionViewCell {

    let peopleBackground : CardView = {
        let view = CardView()
        view.layer.cornerRadius = 25
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let usernameLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 12)
        return label
    }()
    
    let fullnameLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 10)
        return label
    }()
    
    lazy var profileImage : UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.layer.cornerRadius = 25
        return iv
    }()
    
    
    func setupView(){
        addSubview(peopleBackground)
        addSubview(profileImage)
        addSubview(fullnameLabel)
        addSubview(usernameLabel)
        
        peopleBackground.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 50, height: 50)
        profileImage.anchor(top: peopleBackground.topAnchor, left: peopleBackground.leftAnchor, bottom: peopleBackground.bottomAnchor, right: peopleBackground.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        usernameLabel.anchor(top: profileImage.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 10, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: usernameLabel.intrinsicContentSize.width, height: usernameLabel.intrinsicContentSize.height)
        usernameLabel.centerXAnchor.constraint(equalTo: profileImage.centerXAnchor).isActive = true
        fullnameLabel.anchor(top: usernameLabel.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 6, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: fullnameLabel.intrinsicContentSize.width, height: fullnameLabel.intrinsicContentSize.height)
        fullnameLabel.centerXAnchor.constraint(equalTo: usernameLabel.centerXAnchor).isActive = true
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
