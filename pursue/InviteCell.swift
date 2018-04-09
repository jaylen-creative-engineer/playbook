//
//  InviteCell.swift
//  pursue
//
//  Created by Jaylen Sanders on 3/2/18.
//  Copyright © 2018 Glory. All rights reserved.
//

import UIKit

protocol SendInviteDelegate {
    func sendInviteText(for cell : InviteCell)
}

class InviteCell : UICollectionViewCell {
    
    var contact : Contacts? {
        didSet {
            firstnameLabel.text = contact?.firstname
            lastnameLabel.text = contact?.lastname
            phoneNumber.text = contact?.phoneNumber
        }
    }
    
    let firstnameLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.init(25))
        return label
    }()
    
    let lastnameLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.init(25))
        return label
    }()
    
    let phoneNumber : UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 12)
        return label
    }()
    
    let userPhoto : UIImageView = {
       let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.image = #imageLiteral(resourceName: "contact-display").withRenderingMode(.alwaysOriginal)
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.layer.cornerRadius = 15
        iv.layer.masksToBounds = true
        return iv
    }()
    
    lazy var inviteButton : UIButton = {
       let button = UIButton()
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 12)
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.masksToBounds = true
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 12.5
        button.addTarget(self, action: #selector(handleInvite), for: .touchUpInside)
        return button
    }()
    
    var delegate : SendInviteDelegate?
    var isInvited = true
    
    @objc func handleInvite(){
        delegate?.sendInviteText(for: self)
        isInvited = !isInvited
        
        if isInvited == true {
            inviteButton.setTitleColor(.white, for: .normal)
            inviteButton.setTitle("Invited", for: .normal)
            inviteButton.backgroundColor = .black
        } else {
            inviteButton.setTitle("Invite", for: .normal)
            inviteButton.setTitleColor(.black, for: .normal)
            inviteButton.backgroundColor = .white
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(userPhoto)
        addSubview(firstnameLabel)
        addSubview(lastnameLabel)
        addSubview(phoneNumber)
        addSubview(inviteButton)
        
        userPhoto.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 8, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: 30, height: 30)
        inviteButton.anchor(top: topAnchor, left: nil, bottom: nil, right: rightAnchor, paddingTop: 8, paddingLeft: 0, paddingBottom: 0, paddingRight: 12, width: 80, height: 25)
        firstnameLabel.anchor(top: userPhoto.topAnchor, left: userPhoto.rightAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: firstnameLabel.intrinsicContentSize.width, height: firstnameLabel.intrinsicContentSize.height)
        lastnameLabel.anchor(top: firstnameLabel.topAnchor, left: firstnameLabel.rightAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 4, paddingBottom: 0, paddingRight: 0, width: lastnameLabel.intrinsicContentSize.width, height: lastnameLabel.intrinsicContentSize.height)
        phoneNumber.anchor(top: firstnameLabel.bottomAnchor, left: firstnameLabel.leftAnchor, bottom: nil, right: nil, paddingTop: 8, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: phoneNumber.intrinsicContentSize.width, height: phoneNumber.intrinsicContentSize.height)
        handleInvite()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
