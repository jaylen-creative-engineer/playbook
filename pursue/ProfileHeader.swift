//
//  ProfileHeader.swift
//  pursue
//
//  Created by Jaylen Sanders on 9/12/17.
//  Copyright © 2017 Glory. All rights reserved.
//

import UIKit

protocol ProfileHeaderDelegate {
    func showNotifications()
    func handleSettings()
}

class ProfileHeader : UICollectionViewCell {
    
    var accessHomeController : HomeController?
    var delegate : ProfileHeaderDelegate?
    
    var user : User? {
        didSet {
            guard let imageUrl = user?.photoUrl else { return }
            photoImageView.loadImageUsingCacheWithUrlString(imageUrl)
            usernameLabel.text = user?.username
            fullnameLabel.text = user?.fullname
            userBio.text = user?.bio
        }
    }
    
    let cellId = "cellId"
    
    
    lazy var settingsButton : UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "gear").withRenderingMode(.alwaysOriginal), for: .normal)
        button.addTarget(self, action: #selector(handleSettings), for: .touchUpInside)
        button.backgroundColor = .white
        return button
    }()
    
    lazy var notificationsButton : UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "bell").withRenderingMode(.alwaysOriginal), for: .normal)
        button.addTarget(self, action: #selector(handleNotifications), for: .touchUpInside)
        button.backgroundColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var settingsBackground : UIButton = {
        let button = UIButton()
        button.backgroundColor = .white
        button.layer.cornerRadius = 20
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(handleSettings), for: .touchUpInside)
        return button
    }()
    
    let photoImageView : UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.layer.cornerRadius = 50
        iv.clipsToBounds = true
        return iv
    }()
    
    let usernameLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let fullnameLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.thin)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let userBio : UILabel = {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 5
        let label = UILabel()
        label.numberOfLines = 0
        
        let attrString = NSMutableAttributedString(string: "")
        attrString.addAttribute(NSAttributedStringKey.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, attrString.length))
        
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.attributedText = attrString
        label.backgroundColor = .clear
        label.translatesAutoresizingMaskIntoConstraints = false
        label.sizeToFit()
        return label
    }()
    
    var accessProfileController : ProfileController?
    
    @objc func handleSettings() {
        delegate?.handleSettings()
    }
    
    @objc func handleNotifications(){
        accessProfileController?.showNotifications()
    }
    
    
    func setupProfileOptions(){
        addSubview(settingsButton)
        addSubview(notificationsButton)
        
        settingsButton.anchor(top: topAnchor, left: nil, bottom: nil, right: rightAnchor, paddingTop: 64, paddingLeft: 0, paddingBottom: 0, paddingRight: 20, width: 26, height: 26)
        notificationsButton.anchor(top: settingsButton.topAnchor, left: nil, bottom: nil, right: settingsButton.leftAnchor, paddingTop: 2, paddingLeft: 0, paddingBottom: 0, paddingRight: 32, width: 22, height: 22)
    }
    
    func setupView(){
        let userInfoStack = UIStackView(arrangedSubviews: [usernameLabel, fullnameLabel])
        userInfoStack.axis = .vertical
        userInfoStack.spacing = 10
        userInfoStack.translatesAutoresizingMaskIntoConstraints = false
                
        addSubview(photoImageView)
        addSubview(userInfoStack)
        addSubview(userBio)
        photoImageView.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 64, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: 100, height: 100)
        userInfoStack.anchor(top: nil, left: photoImageView.rightAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 12, paddingBottom: 0, paddingRight: 12, width: 0, height: 0)
        userInfoStack.centerYAnchor.constraint(equalTo: photoImageView.centerYAnchor).isActive = true
        userBio.anchor(top: photoImageView.bottomAnchor, left: photoImageView.leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 24, paddingLeft: 0, paddingBottom: 0, paddingRight: 12, width: 0, height: userBio.intrinsicContentSize.height)
        setupProfileOptions()
    }
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
