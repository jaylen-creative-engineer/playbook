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
        iv.layer.cornerRadius = 60
        return iv
    }()
    
//    lazy var settingsButton : UIButton = {
//       let button = UIButton()
//        button.setTitle("•••", for: .normal)
//        button.setTitleColor(.black, for: .normal)
//        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.init(25))
////        button.addTarget(self, action: #selector(handleSettings), for: .touchUpInside)
//        button.contentHorizontalAlignment = .right
//        button.contentVerticalAlignment = .top
//        button.layer.cornerRadius = 17
//        button.layer.masksToBounds = true
//        return button
//    }()
    
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
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    lazy var notificationsButton : UIButton = {
       let button = UIButton(type: .system)
        button.tintColor = .darkGray
        button.setImage(UIImage(named: "notifications-bell")?.withRenderingMode(.alwaysTemplate), for: .normal)
        button.imageView?.contentMode = .scaleAspectFill
        return button
    }()
    
    lazy var settingsButton : UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("•••", for: .normal)
        button.tintColor = .darkGray
        button.titleLabel?.textColor = .darkGray
        button.contentHorizontalAlignment = .center
        button.contentVerticalAlignment = .center
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.init(25))
        return button
    }()
    
    lazy var followersCountLabel : UIButton = {
        let button = UIButton()
        button.setTitle("0", for: .normal)
        button.setTitleColor(.gray, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.init(25))
        button.addTarget(self, action: #selector(handleAdded), for: .touchUpInside)
        return button
    }()
    
    lazy var followersLabel : UIButton = {
        let button = UIButton()
        button.setTitle("Followers", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 12)
        button.addTarget(self, action: #selector(handleAdded), for: .touchUpInside)
        return button
    }()
    
    lazy var addedBackground : UIButton = {
       let button = UIButton()
        button.addTarget(self, action: #selector(handleAdded), for: .touchUpInside)
        return button
    }()
    
    let followingCountLabel : UILabel = {
        let button = UILabel()
        button.text = "0"
        button.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.init(25))
        button.textColor = .gray
        return button
    }()

    let followingLabel : UILabel = {
        let button = UILabel()
        button.text = "Following"
        button.font = UIFont.boldSystemFont(ofSize: 12)
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
    
    lazy var addButton : UIButton = {
       let button = UIButton(type: .system)
        button.setTitle("Add", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 16
        button.layer.masksToBounds = true
        button.backgroundColor = .white
        return button
    }()
    
    let settingsBackgroundView : HomeView = {
        let view = HomeView()
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
        
        addSubview(settingsButton)
        addSubview(notificationsButton)
        addSubview(imageView)
        addSubview(usernameLabel)
        addSubview(bioText)
//        addSubview(followersLabel)
//        addSubview(followersCountLabel)
//        addSubview(followingLabel)
//        addSubview(followingCountLabel)
//        addSubview(settingsBackgroundView)
//        addSubview(settingsButton)
        
        settingsButton.anchor(top: safeAreaLayoutGuide.topAnchor, left: nil, bottom: nil, right: rightAnchor, paddingTop: 12, paddingLeft: 0, paddingBottom: 0, paddingRight: 18, width: 30, height: 24)
        notificationsButton.anchor(top: safeAreaLayoutGuide.topAnchor, left: nil, bottom: nil, right: settingsButton.leftAnchor, paddingTop: 12, paddingLeft: 0, paddingBottom: 0, paddingRight: 18, width: 24, height: 28)
        imageView.anchor(top: notificationsButton.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 24, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: 120, height: 120)
        imageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        usernameLabel.centerXAnchor.constraint(equalTo: imageView.centerXAnchor).isActive = true
        usernameLabel.anchor(top: imageView.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 12, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: usernameLabel.intrinsicContentSize.width, height: 18)
        bioText.anchor(top: usernameLabel.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 18, paddingLeft: 0, paddingBottom: 0, paddingRight: 12, width: 0, height: 0)
        bioText.centerXAnchor.constraint(equalTo: imageView.centerXAnchor).isActive = true
        bioText.heightAnchor.constraint(lessThanOrEqualToConstant: 50).isActive = true
//        followersLabel.anchor(top: nil, left: leftAnchor, bottom: bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 12, paddingBottom: 12, paddingRight: 0, width: followersLabel.intrinsicContentSize.width, height: 14)
//        followersCountLabel.centerXAnchor.constraint(equalTo: followersLabel.centerXAnchor).isActive = true
//        followersCountLabel.anchor(top: nil, left: nil, bottom: followersLabel.topAnchor, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 8, paddingRight: 0, width: followingCountLabel.intrinsicContentSize.width, height: 14)
//        followingLabel.anchor(top: followersLabel.topAnchor, left: followersLabel.rightAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 32, paddingBottom: 0, paddingRight: 0, width: followingLabel.intrinsicContentSize.width, height: 14)
//        followingCountLabel.centerXAnchor.constraint(equalTo: followingLabel.centerXAnchor).isActive = true
//        followingCountLabel.anchor(top: followersCountLabel.topAnchor, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: followingCountLabel.intrinsicContentSize.width, height: 14)
//        settingsBackgroundView.anchor(top: nil, left: nil, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 16, paddingRight: 12, width: 120, height: 34)
//        settingsButton.anchor(top: settingsBackgroundView.topAnchor, left: settingsBackgroundView.leftAnchor, bottom: settingsBackgroundView.bottomAnchor, right: settingsBackgroundView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupNavBar()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

