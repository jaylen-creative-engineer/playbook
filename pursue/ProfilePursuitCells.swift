//
//  ProfilePursuitCells.swift
//  pursue
//
//  Created by Jaylen Sanders on 3/13/18.
//  Copyright © 2018 Glory. All rights reserved.
//

import UIKit

class ProfilePursuitCells : UICollectionViewCell {
    
    let photo : UIImageView = {
        let iv = UIImageView()
        iv.layer.cornerRadius = 8
        iv.layer.masksToBounds = true
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    let detailLabel : UILabel = {
        let label = UILabel()
        label.text = "Have a vision to work towards"
        label.font = UIFont(name: "Lato-Semibold", size: 12)
        return label
    }()
    
    let saveButtonBackground : GroupChatView = {
        let gcv = GroupChatView()
        gcv.translatesAutoresizingMaskIntoConstraints = false
        gcv.backgroundColor = .white
        return gcv
    }()
    
    let saveButton : UIButton = {
        let button = UIButton()
        button.setTitle("Save", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont(name: "Lato-Bold", size: 12)
        button.titleLabel?.textAlignment = .center
        return button
    }()
    
    let playBackground : GroupChatView = {
        let view = GroupChatView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    
    let playIcon : UIImageView = {
        let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "view-more").withRenderingMode(.alwaysOriginal)
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    func setupView(){
        addSubview(photo)
        addSubview(detailLabel)
        addSubview(playBackground)
        addSubview(playIcon)
        addSubview(saveButtonBackground)
        addSubview(saveButton)
        
        photo.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 210, height: 230)
        detailLabel.anchor(top: photo.bottomAnchor, left: photo.leftAnchor, bottom: nil, right: photo.rightAnchor, paddingTop: 12, paddingLeft: 8, paddingBottom: 0, paddingRight: 0, width: 0, height: 14)
        playBackground.anchor(top: nil, left: nil, bottom: photo.bottomAnchor, right: photo.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 8, paddingRight: 8, width: 24, height: 24)
        playIcon.anchor(top: nil, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 10, height: 10)
        playIcon.centerXAnchor.constraint(equalTo: playBackground.centerXAnchor).isActive = true
        playIcon.centerYAnchor.constraint(equalTo: playBackground.centerYAnchor).isActive = true
        saveButtonBackground.anchor(top: photo.topAnchor, left: nil, bottom: nil, right: photo.rightAnchor, paddingTop: 8, paddingLeft: 0, paddingBottom: 0, paddingRight: 8, width: 70, height: 25)
        saveButton.anchor(top: saveButtonBackground.topAnchor, left: saveButtonBackground.leftAnchor, bottom: saveButtonBackground.bottomAnchor, right: saveButtonBackground.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
