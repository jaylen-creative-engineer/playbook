//
//  ProfileHeader.swift
//  pursue
//
//  Created by Jaylen Sanders on 6/22/18.
//  Copyright © 2018 Glory. All rights reserved.
//

import UIKit
import Mixpanel
import ParallaxHeader
import Firebase

protocol ProfileHeaderDelegate {
    func handleMessage(for cell : ProfileHeader)
}

class ProfileHeader : UICollectionViewCell {
    
//    var user : User! {
//        didSet {
//            guard let profilePicture = user?.photoUrl else { return }
//            imageView.loadImage(urlString: profilePicture)
//            usernameLabel.text = user?.username
//            fullnameLabel.text = user?.fullname
//            bioText.text = user?.bio
//            
//            if user?.bio == nil {
//                bioText.text = "Add Bio"
//                bioText.isUserInteractionEnabled = true
//                
//                let tap = UITapGestureRecognizer(target: self, action: #selector(handleEdit))
//                tap.numberOfTapsRequired = 1
//                bioText.addGestureRecognizer(tap)
//            }
//            
//            if user?.userId == Auth.auth().currentUser?.uid {
//                circleBackground.isHidden = true
//                addImageView.isHidden = true
//                backIcon.isHidden = true
//                backBackground.isHidden = true
//                
//                addSubview(usernameLabel)
//                addSubview(settingsButton)
//                
//                usernameLabel.anchor(top: safeAreaLayoutGuide.topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: 0, height: 18)
//                usernameLabel.widthAnchor.constraint(lessThanOrEqualToConstant: frame.width / 2)
//                settingsButton.anchor(top: nil, left: nil, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 12, width: 40, height: 40)
//                settingsButton.centerYAnchor.constraint(equalTo: usernameLabel.centerYAnchor).isActive = true
//                settingsButton.addTarget(self, action: #selector(handleSettings), for: .touchUpInside)
//            } else {
//                if user?.bio == nil {
//                    bioText.isHidden = true
//                }
//                
//                circleBackground.isHidden = false
//                addImageView.isHidden = false
//                backIcon.isHidden = false
//                backBackground.isHidden = false
//                
//                addSubview(usernameLabel)
//                addSubview(settingsButton)
//                
//                usernameLabel.anchor(top: safeAreaLayoutGuide.topAnchor, left: backIcon.rightAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 24, paddingBottom: 0, paddingRight: 0, width: 0, height: 18)
//                usernameLabel.widthAnchor.constraint(lessThanOrEqualToConstant: frame.width / 2)
//                settingsButton.anchor(top: nil, left: nil, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 12, width: 40, height: 40)
//                settingsButton.centerYAnchor.constraint(equalTo: usernameLabel.centerYAnchor).isActive = true
//                settingsButton.addTarget(self, action: #selector(handleFriendSettings), for: .touchUpInside)
//
//            }
//            
//            if user?.followers_count == 0 {
//                addedCountLabel.titleLabel?.text = String(0)
//            } else {
//                guard let followersCount = user?.followers_count else { return }
//                addedCountLabel.titleLabel?.text = String(followersCount)
//            }
//            
//            if user?.pursuits_count == 0 {
//                pursuitsCountLabel.text = String(0)
//            } else {
//                guard let pursuitsCount = user?.pursuits_count else { return }
//                pursuitsCountLabel.text = String(pursuitsCount)
//            }
//            
//            addImageView.setImage(user.is_following == 1 ? UIImage(named: "check")?.withRenderingMode(.alwaysOriginal) : UIImage(named: "add")?.withRenderingMode(.alwaysOriginal), for: .normal)
//            circleBackground.backgroundColor = user.is_following == 1 ? .black : .white
//        }
//    }
    
    let followId = "followId"
    var delegate : ProfileHeaderDelegate?
    var accessProfileController : ProfileController?
    
    let imageView : CustomImageView = {
        let iv = CustomImageView()
        iv.clipsToBounds = true
        iv.image = UIImage(named: "apartment-architecture-ceiling-259962")?.withRenderingMode(.alwaysOriginal)
        iv.contentMode = .scaleAspectFill
        iv.layer.cornerRadius = 30
        return iv
    }()
    
    lazy var settingsButton : UIButton = {
       let button = UIButton()
        button.setTitle("•••", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.init(25))
//        button.addTarget(self, action: #selector(handleSettings), for: .touchUpInside)
        button.contentHorizontalAlignment = .right
        button.contentVerticalAlignment = .top
        button.layer.cornerRadius = 17
        button.layer.masksToBounds = true
        return button
    }()
    
    let usernameLabel : UILabel = {
       let label = UILabel()
        label.text = "Test"
        label.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.init(25))
        return label
    }()
    
    let fullnameLabel : UILabel = {
       let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont(name: "Lato-Bold", size: 18)
        return label
    }()
    
    lazy var bioText : UILabel = {
        let label = UILabel()
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 2
        paragraphStyle.paragraphSpacing = 5
        
        let attrString = NSMutableAttributedString(string: "Loreum Ipsum is simply dummy")
        attrString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, attrString.length))
        
        label.attributedText = attrString
        label.font = UIFont.systemFont(ofSize: 12)
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()
    
    lazy var addedCountLabel : UIButton = {
        let button = UIButton()
        button.setTitle("0", for: .normal)
        button.setTitleColor(.gray, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.init(25))
        button.addTarget(self, action: #selector(handleAdded), for: .touchUpInside)
        return button
    }()
    
    lazy var addedLabel : UIButton = {
        let button = UIButton()
        button.setTitle("ADDED", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont(name: "Lato-Bold", size: 10)
        button.addTarget(self, action: #selector(handleAdded), for: .touchUpInside)
        return button
    }()
    
    lazy var addedBackground : UIButton = {
       let button = UIButton()
        button.addTarget(self, action: #selector(handleAdded), for: .touchUpInside)
        return button
    }()
    
    let pursuitsCountLabel : UILabel = {
        let button = UILabel()
        button.text = "0"
        button.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.init(25))
        button.textColor = .gray
        return button
    }()
    
    let addButton : UIButton = {
       let button = UIButton()
        return button
    }()
    
    let pursuitsLabel : UILabel = {
        let button = UILabel()
        button.text = "PURSUITS"
        button.font = UIFont(name: "Lato-Bold", size: 10)
        button.textColor = .black
        return button
    }()
    
    lazy var circleBackground : AddFriendView = {
       let view = AddFriendView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleAdd))
        tap.numberOfTapsRequired = 1
        view.addGestureRecognizer(tap)
        return view
    }()
    
    lazy var addImageView : UIButton = {
       let button = UIButton()
        button.contentMode = .scaleAspectFill
        button.addTarget(self, action: #selector(handleAdd), for: .touchUpInside)
//        button.contentMode = .scaleAspectFill
        
//        iv.image = #imageLiteral(resourceName: "add").withRenderingMode(.alwaysOriginal)
//        iv.contentMode = .scaleAspectFill
//        iv.translatesAutoresizingMaskIntoConstraints = false
//        iv.isUserInteractionEnabled = true
//
//        let tap = UITapGestureRecognizer(target: self, action: #selector(handleAdd))
//        tap.numberOfTapsRequired = 1
//        iv.addGestureRecognizer(tap)
        return button
    }()
    
    lazy var backIcon : UIButton = {
        let button = UIButton()
        button.setBackgroundImage(#imageLiteral(resourceName: "back-arrow").withRenderingMode(.alwaysOriginal), for: .normal)
        button.addTarget(self, action: #selector(goBack), for: .touchUpInside)
        return button
    }()
    
    lazy var backBackground : UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 19
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(goBack), for: .touchUpInside)
        return button
    }()
    
    var isAdded = false
    let engagementService = EngagementServices()
    
    @objc func handleAdd(){
        Mixpanel.mainInstance().track(event: "Post Save Clicked")
        isAdded = !isAdded
        
        if isAdded == false {
            circleBackground.backgroundColor = .white
            addImageView.setImage(UIImage(named: "add")?.withRenderingMode(.alwaysOriginal), for: .normal)
            engagementService.toggleFollowUser(followeeId: 2, is_following: 0)
        } else if isAdded == true {
            circleBackground.backgroundColor = .black
            addImageView.setImage(UIImage(named: "check")?.withRenderingMode(.alwaysOriginal), for: .normal)
            engagementService.toggleFollowUser(followeeId: 2, is_following: 1)
            
        }
    }
    
    @objc func goBack(){
        accessProfileController?.handleDismiss()
    }
    
    @objc func handleAdded(){
        accessProfileController?.showFriendsController()
    }
    
    @objc func handleSettings(){
        accessProfileController?.handleSettings()
    }
    
    @objc func handleFriendSettings(){
//        guard let userId = user.userId else { return }
//        accessProfileController?.handleFriendsSettings(friendId: userId)
    }
    
    @objc func handleEdit(){
        accessProfileController?.handleEditProfile()
    }
    
    func setupEngagements(){
        addSubview(addedCountLabel)
        addSubview(addedLabel)
        addSubview(pursuitsCountLabel)
        addSubview(pursuitsLabel)
        
        addedCountLabel.anchor(top: bioText.bottomAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: frame.width / 5.5, paddingLeft: 16, paddingBottom: 0, paddingRight: 0, width: 0, height: 18)
        addedCountLabel.widthAnchor.constraint(lessThanOrEqualToConstant: 120).isActive = true
        addedLabel.anchor(top: addedCountLabel.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: addedLabel.intrinsicContentSize.height)
        addedLabel.centerXAnchor.constraint(equalTo: addedCountLabel.centerXAnchor).isActive = true
        
        addSubview(addedBackground)
        addedBackground.anchor(top: addedCountLabel.topAnchor, left: addedLabel.leftAnchor, bottom: addedLabel.bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 90, height: 0)
        
        pursuitsCountLabel.anchor(top: bioText.bottomAnchor, left: addedLabel.rightAnchor, bottom: nil, right: nil, paddingTop: frame.width / 5.5, paddingLeft: 48, paddingBottom: 0, paddingRight: 0, width: 0, height: 18)
        pursuitsCountLabel.widthAnchor.constraint(lessThanOrEqualToConstant: 60).isActive = true
        pursuitsLabel.anchor(top: pursuitsCountLabel.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 8, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: pursuitsLabel.intrinsicContentSize.height)
        pursuitsLabel.centerXAnchor.constraint(equalTo: pursuitsCountLabel.centerXAnchor).isActive = true
        
    }

    func setupBackButton(){
//        addSubview(settingsButton)
//        
//        settingsButton.anchor(top: safeAreaLayoutGuide.topAnchor, left: nil, bottom: nil, right: rightAnchor, paddingTop: 12, paddingLeft: 0, paddingBottom: 0, paddingRight: 12, width: 40, height: 40)
        
        addSubview(backIcon)
        addSubview(backBackground)
        
        backIcon.anchor(top: safeAreaLayoutGuide.topAnchor, left: safeAreaLayoutGuide.leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: 20, height: 20)
        backBackground.centerXAnchor.constraint(equalTo: backIcon.centerXAnchor).isActive = true
        backBackground.centerYAnchor.constraint(equalTo: backIcon.centerYAnchor).isActive = true
        backBackground.anchor(top: nil, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 38, height: 38)
    }
    
    func setupNavBar(){
        
        addSubview(imageView)
        addSubview(usernameLabel)
        addSubview(bioText)
        
        imageView.anchor(top: safeAreaLayoutGuide.topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 32, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: 60, height: 60)
        usernameLabel.anchor(top: imageView.topAnchor, left: imageView.rightAnchor, bottom: nil, right: nil, paddingTop: 6, paddingLeft: 18, paddingBottom: 0, paddingRight: 12, width: usernameLabel.intrinsicContentSize.width, height: 18)
        bioText.anchor(top: usernameLabel.bottomAnchor, left: usernameLabel.leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 8, paddingLeft: 0, paddingBottom: 0, paddingRight: 12, width: 0, height: 0)
        bioText.heightAnchor.constraint(lessThanOrEqualToConstant: 50).isActive = true
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupNavBar()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

