//
//  TeamRowCells.swift
//  pursue
//
//  Created by Jaylen Sanders on 6/25/18.
//  Copyright © 2018 Glory. All rights reserved.
//

import UIKit

class TeamCells : UICollectionViewCell {
    
    var team : User? {
        didSet {
            guard let image = team?.photoUrl else { return }
            profileImage.loadImageUsingCacheWithUrlString(image)
            usernameLabel.text = team?.username
        }
    }
    
    let usernameLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()
    
    lazy var profileImage : UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleHomeTap))
        let longGesture = UILongPressGestureRecognizer(target: self, action: #selector(handleHomeHold))
        tapGesture.numberOfTapsRequired = 1
        iv.addGestureRecognizer(tapGesture)
        iv.addGestureRecognizer(longGesture)
        iv.isUserInteractionEnabled = true
        iv.layer.cornerRadius = 25
        return iv
    }()
    
    @objc func handleHomeTap(){
    }
    
    @objc func handleHomeHold(){
    }
    
    func setupView(){
        addSubview(profileImage)
        addSubview(usernameLabel)
        
        profileImage.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: 50, height: 50)
        usernameLabel.anchor(top: profileImage.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 8, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 14)
        usernameLabel.centerXAnchor.constraint(equalTo: profileImage.centerXAnchor).isActive = true
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

