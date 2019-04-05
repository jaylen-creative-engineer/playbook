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
    
    let userPhoto : CustomImageView = {
        let iv = CustomImageView()
        iv.clipsToBounds = true
        iv.image = UIImage(named: "apartment-architecture-ceiling-259962")?.withRenderingMode(.alwaysOriginal)
        iv.contentMode = .scaleAspectFill
        iv.layer.cornerRadius = 39
        return iv
    }()
    
    let bioText : UILabel = {
        let label = UILabel()
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 2
        paragraphStyle.paragraphSpacing = 5
        
        let attrString = NSMutableAttributedString(string: "Loreum Ipsum is simply dummy")
        attrString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, attrString.length))
        
        label.attributedText = attrString
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .darkGray
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()
    
    let addButton : ProfileAddViewShadow = {
        let button = ProfileAddViewShadow(type: .system)
        button.backgroundColor = .white
        button.layer.cornerRadius = 19
        button.layer.masksToBounds = true
        button.contentHorizontalAlignment = .center
        button.contentVerticalAlignment = .center
        return button
    }()
    
    let addLabel : UILabel = {
       let label = UILabel()
        label.text = "Add"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()

    lazy var settingsButton : UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("•••", for: .normal)
        button.backgroundColor = .white
        button.layer.cornerRadius = 19
        button.layer.masksToBounds = true
        button.tintColor = .darkGray
        button.titleLabel?.textColor = .darkGray
        button.contentHorizontalAlignment = .center
        button.contentVerticalAlignment = .center
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.init(25))
        return button
    }()
    
    let settingsLabel : UILabel = {
        let label = UILabel()
        label.text = "More"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()
    
    let usernameLabel : UILabel = {
        let label = UILabel()
        label.text = "Test"
        label.font = UIFont.systemFont(ofSize: 20, weight: UIFont.Weight.init(25))
        return label
    }()
    
    let fullnameLabel : UILabel = {
        let label = UILabel()
        label.text = "Test"
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    
    let userDetailsStackView : UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.spacing = 8
        return sv
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
    
    var isAdded = false
    let engagementService = EngagementServices()
    
    @objc func handleAdd(){
//        Mixpanel.mainInstance().track(event: "Post Save Clicked")
//        isAdded = !isAdded
//
//        if isAdded == false {
//            circleBackground.backgroundColor = .white
//            addImageView.setImage(UIImage(named: "add")?.withRenderingMode(.alwaysOriginal), for: .normal)
//            engagementService.toggleFollowUser(followeeId: 2, is_following: 0)
//        } else if isAdded == true {
//            circleBackground.backgroundColor = .black
//            addImageView.setImage(UIImage(named: "check")?.withRenderingMode(.alwaysOriginal), for: .normal)
//            engagementService.toggleFollowUser(followeeId: 2, is_following: 1)
//
//        }
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
    
    func setupStatsView(){
        
    }
    
    func setupEngagementsView(){
        addSubview(addButton)
        addSubview(addLabel)
        addSubview(settingsButton)
        addSubview(settingsLabel)
        
        addButton.anchor(top: userDetailsStackView.bottomAnchor, left: userDetailsStackView.leftAnchor, bottom: nil, right: nil, paddingTop: 12, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 38, height: 38)
        addLabel.anchor(top: addButton.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 4, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: addLabel.intrinsicContentSize.width, height: addLabel.intrinsicContentSize.height)
        addLabel.centerXAnchor.constraint(equalTo: addButton.centerXAnchor).isActive = true
        settingsButton.anchor(top: addButton.topAnchor, left: addButton.rightAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 28, paddingBottom: 0, paddingRight: 0, width: 38, height: 38)
        settingsLabel.anchor(top: settingsButton.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 4, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: settingsLabel.intrinsicContentSize.width, height: settingsLabel.intrinsicContentSize.height)
        settingsLabel.centerXAnchor.constraint(equalTo: settingsButton.centerXAnchor).isActive = true
    }
    
    func setupView(){
        addSubview(userPhoto)
        addSubview(userDetailsStackView)
        userDetailsStackView.addArrangedSubview(usernameLabel)
        userDetailsStackView.addArrangedSubview(fullnameLabel)
        
        userPhoto.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 24, paddingLeft: 18, paddingBottom: 0, paddingRight: 0, width: 78, height: 78)
        userDetailsStackView.anchor(top: nil, left: userPhoto.rightAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 12, paddingBottom: 0, paddingRight: 18, width: 0, height: 0)
        userDetailsStackView.heightAnchor.constraint(lessThanOrEqualToConstant: 78).isActive = true
        userDetailsStackView.centerYAnchor.constraint(equalTo: userPhoto.centerYAnchor).isActive = true
        setupEngagementsView()
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

