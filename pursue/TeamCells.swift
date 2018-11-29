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
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(addToTeam))
        tapGesture.numberOfTapsRequired = 1
        iv.addGestureRecognizer(tapGesture)
        iv.isUserInteractionEnabled = true
        iv.layer.cornerRadius = 25
        return iv
    }()
    
    lazy var selectedFill : UIView = {
       let view = UIView()
        view.backgroundColor = UIColor.init(white: 0.4, alpha: 0.8)
        view.layer.cornerRadius = 25
        view.layer.masksToBounds = true
        view.isHidden = true
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(addToTeam))
        tap.numberOfTapsRequired = 1
        view.addGestureRecognizer(tap)
        return view
    }()
    
    lazy var checkMark : UIImageView = {
       let iv = UIImageView()
        iv.image = UIImage(named: "check")?.withRenderingMode(.alwaysOriginal)
        iv.contentMode = .scaleAspectFill
        iv.isHidden = true
        return iv
    }()
    
    var accessDetailView : CaptureDetailView?
    var accessFriendPopover : CustomFriendPopover?
    var accessTeamView : TeamList?
    
    var isClicked = false
    var isDetailView : Bool?
    
    @objc func addToTeam(){
        if isDetailView == nil {
            isClicked = !isClicked
            
            if isClicked == true {
                accessDetailView?.team.append(team!)
                accessFriendPopover?.users.append(team!)
                checkMark.isHidden = false
                selectedFill.isHidden = false
            } else {
                checkMark.isHidden = true
                selectedFill.isHidden = true
            }
        } else if isDetailView == true {
            changeToProfile()
        }
    }
    
    @objc func changeToProfile(){
        accessTeamView?.changeToProfile(userId: (team?.userId)!)
    }
    
    func setupView(){
        addSubview(profileImage)
        addSubview(usernameLabel)
        addSubview(selectedFill)
        addSubview(checkMark)
        
        profileImage.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: 50, height: 50)
        usernameLabel.anchor(top: profileImage.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 8, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 14)
        usernameLabel.centerXAnchor.constraint(equalTo: profileImage.centerXAnchor).isActive = true
        selectedFill.anchor(top: profileImage.topAnchor, left: profileImage.leftAnchor, bottom: profileImage.bottomAnchor, right: profileImage.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        checkMark.centerYAnchor.constraint(equalTo: selectedFill.centerYAnchor).isActive = true
        checkMark.centerXAnchor.constraint(equalTo: selectedFill.centerXAnchor).isActive = true
        checkMark.anchor(top: nil, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 14, height: 14)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

