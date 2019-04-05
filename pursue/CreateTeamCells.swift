//
//  CreateTeamCells.swift
//  pursue
//
//  Created by Jaylen Sanders on 9/19/18.
//  Copyright © 2018 Glory. All rights reserved.
//

import UIKit

protocol CreateTeamCellsDelegate {
    func photoSelected(for cell : CreateTeamCells)
}

class CreateTeamCells : UICollectionViewCell {
    
    var delegate : CreateTeamCellsDelegate?
    
    lazy var userPhoto : UIImageView = {
       let iv = UIImageView()
        iv.layer.cornerRadius = 20
        iv.layer.masksToBounds = true
        iv.image = UIImage(named: "cafe-768771_1280")?.withRenderingMode(.alwaysOriginal)
        iv.contentMode = .scaleAspectFill
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleCellSelected))
        tap.numberOfTapsRequired = 1
        iv.addGestureRecognizer(tap)
        return iv
    }()
    
    lazy var searchFriendsButton : UIButton = {
       let button = UIButton()
        button.setTitle("INVITE TEAM", for: .normal)
        button.setTitleColor(.darkGray, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 12)
        button.titleLabel?.textAlignment = .left
        button.backgroundColor = .clear
        button.addTarget(self, action: #selector(handleInviteFriends), for: .touchUpInside)
        return button
    }()
    
    lazy var userPhotoOverlay : UIView = {
       let view = UIView()
        view.backgroundColor = UIColor.init(white: 1, alpha: 0.3)
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 20
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleCellSelected))
        tap.numberOfTapsRequired = 1
        view.addGestureRecognizer(tap)
        return view
    }()
    
    lazy var checkImageView : UIImageView = {
       let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "check").withRenderingMode(.alwaysOriginal)
        iv.contentMode = .scaleAspectFit
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleCellSelected))
        tap.numberOfTapsRequired = 1
        iv.addGestureRecognizer(tap)
        return iv
    }()
    
    let usernameLabel : UILabel = {
       let label = UILabel()
        label.text = "Test"
        label.font = UIFont.init(name: "Roboto-Medium", size: 16)
        return label
    }()
    
    var isClicked = false
    @objc func handleCellSelected(){
        delegate?.photoSelected(for: self)
        isClicked = !isClicked
        
        if isClicked == true {
            userPhotoOverlay.isHidden = false
            checkImageView.isHidden = false
        } else {
            userPhotoOverlay.isHidden = true
            checkImageView.isHidden = true
        }
    }
    
    @objc func handleInviteFriends(){
//        accessDetailController?.inviteContacts()
    }
    
    func setupFriendsSearch(){
        addSubview(searchFriendsButton)
        searchFriendsButton.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        searchFriendsButton.anchor(top: nil, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 14)
    }
    
    func setupView(){
        addSubview(userPhoto)
        addSubview(userPhotoOverlay)
        addSubview(checkImageView)
        addSubview(usernameLabel)
        
        userPhoto.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 18, paddingBottom: 0, paddingRight: 0, width: 40, height: 40)
        userPhotoOverlay.anchor(top: userPhoto.topAnchor, left: userPhoto.leftAnchor, bottom: userPhoto.bottomAnchor, right: userPhoto.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        checkImageView.anchor(top: nil, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 16, height: 16)
        checkImageView.centerYAnchor.constraint(equalTo: userPhotoOverlay.centerYAnchor).isActive = true
        checkImageView.centerXAnchor.constraint(equalTo: userPhotoOverlay.centerXAnchor).isActive = true
        usernameLabel.anchor(top: nil, left: userPhoto.rightAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 18, paddingBottom: 0, paddingRight: 12, width: 0, height: 18)
        usernameLabel.centerYAnchor.constraint(equalTo: userPhoto.centerYAnchor).isActive = true
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
