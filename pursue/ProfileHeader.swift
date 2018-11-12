//
//  ProfileHeader.swift
//  pursue
//
//  Created by Jaylen Sanders on 6/22/18.
//  Copyright © 2018 Glory. All rights reserved.
//

import UIKit

protocol ProfileHeaderDelegate {
    func handleMessage(for cell : ProfileHeader)
}

class ProfileHeader : UICollectionViewCell {
    
    var user : User! {
        didSet {
            guard let profilePicture = user?.photoUrl else { return }
            imageView.loadImage(urlString: profilePicture)
            usernameLabel.text = user?.username
            fullnameLabel.text = user?.fullname
            bioText.text = user?.bio
            
            if user?.bio == nil {
                bioText.text = "Add Bio"
                bioText.isUserInteractionEnabled = true
                
                let tap = UITapGestureRecognizer(target: self, action: #selector(handleEdit))
                tap.numberOfTapsRequired = 1
                bioText.addGestureRecognizer(tap)
            }
            
            let defaults = UserDefaults.standard
            if user?.userId == defaults.integer(forKey: "userId") {
                circleBackground.isHidden = true
                addImageView.isHidden = true
                backIcon.isHidden = true
                backBackground.isHidden = true
            } else {
                circleBackground.isHidden = false
                addImageView.isHidden = false
                backIcon.isHidden = false
                backBackground.isHidden = false
            }
            
            guard let followersCount = user?.followers_count else { return }
            addedCountLabel.titleLabel?.text = String(followersCount)
            guard let pursuitsCount = user?.pursuits_count else { return }
            pursuitsCountLabel.titleLabel?.text = String(pursuitsCount)
            
            addImageView.setImage(user.is_following == 1 ? UIImage(named: "check")?.withRenderingMode(.alwaysOriginal) : UIImage(named: "add")?.withRenderingMode(.alwaysOriginal), for: .normal)
            circleBackground.backgroundColor = user.is_following == 1 ? .black : .white
        }
    }
    
    let followId = "followId"
    var delegate : ProfileHeaderDelegate?
    var accessProfileController : ProfileController?
    
    let imageView : CustomImageView = {
        let iv = CustomImageView()
        iv.clipsToBounds = true
        iv.contentMode = .scaleAspectFill
        iv.layer.cornerRadius = 70
        return iv
    }()
    
    lazy var settingsButton : UIButton = {
       let button = UIButton()
        button.setTitle("•••", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.init(25))
        button.addTarget(self, action: #selector(handleSettings), for: .touchUpInside)
        button.contentHorizontalAlignment = .right
        button.contentVerticalAlignment = .top
        button.layer.cornerRadius = 17
        button.layer.masksToBounds = true
        return button
    }()
    
    let usernameLabel : UILabel = {
       let label = UILabel()
        label.textAlignment = .center
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
        
        let attrString = NSMutableAttributedString(string: "Loreum Ipsum is simply dummy text of the printing and typesetting industry. Lorem ipsum has been the industry's.....")
        attrString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, attrString.length))
        
        label.attributedText = attrString
        label.font = UIFont.systemFont(ofSize: 12)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    lazy var addedCountLabel : UIButton = {
        let button = UIButton()
        button.setTitle("120", for: .normal)
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
    
    let pursuitsCountLabel : UIButton = {
        let button = UIButton()
        button.setTitle("120", for: .normal)
        button.setTitleColor(.gray, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.init(25))
        return button
    }()
    
    let pursuitsLabel : UIButton = {
        let button = UIButton()
        button.setTitle("PURSUITS", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont(name: "Lato-Bold", size: 10)
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
    
    @objc func handleAdd(){
        
    }
    
    @objc func goBack(){
        accessProfileController?.goBack()
    }
    
    @objc func handleAdded(){
        accessProfileController?.showFriendsController()
    }
    
    @objc func handleSettings(){
        accessProfileController?.handleSettings()
    }
    
    @objc func handleEdit(){
        accessProfileController?.handleEditProfile()
    }
    
    func setupEngagements(){
        addSubview(addedCountLabel)
        addSubview(addedLabel)
        addSubview(pursuitsCountLabel)
        addSubview(pursuitsLabel)
        
        addedCountLabel.anchor(top: bioText.bottomAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: frame.width / 5.5, paddingLeft: 16, paddingBottom: 0, paddingRight: 0, width: addedCountLabel.intrinsicContentSize.width, height: 18)
        addedLabel.anchor(top: addedCountLabel.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: addedLabel.intrinsicContentSize.height)
        addedLabel.centerXAnchor.constraint(equalTo: addedCountLabel.centerXAnchor).isActive = true
        
        addSubview(addedBackground)
        addedBackground.anchor(top: addedCountLabel.topAnchor, left: addedLabel.leftAnchor, bottom: addedLabel.bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 90, height: 0)
        
        pursuitsCountLabel.anchor(top: addedCountLabel.topAnchor, left: addedLabel.rightAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 48, paddingBottom: 0, paddingRight: 0, width: pursuitsCountLabel.intrinsicContentSize.width, height: 18)
        pursuitsLabel.anchor(top: pursuitsCountLabel.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: pursuitsLabel.intrinsicContentSize.height)
        pursuitsLabel.centerXAnchor.constraint(equalTo: pursuitsCountLabel.centerXAnchor).isActive = true
        
    }
    
    func setupSettings(){
        setupBackButton()
        addSubview(usernameLabel)
        addSubview(settingsButton)
        
        if backIcon.isHidden {
            usernameLabel.anchor(top: safeAreaLayoutGuide.topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: 0, height: 18)
            usernameLabel.widthAnchor.constraint(lessThanOrEqualToConstant: frame.width / 2)
        } else {
            usernameLabel.anchor(top: safeAreaLayoutGuide.topAnchor, left: backIcon.rightAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 24, paddingBottom: 0, paddingRight: 0, width: 0, height: 18)
            usernameLabel.widthAnchor.constraint(lessThanOrEqualToConstant: frame.width / 2)
        }
       
        settingsButton.anchor(top: nil, left: nil, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 12, width: 40, height: 40)
        settingsButton.centerYAnchor.constraint(equalTo: usernameLabel.centerYAnchor).isActive = true
        
        
    }
    
    func setupBackButton(){
        addSubview(backIcon)
        addSubview(backBackground)
        
        backIcon.anchor(top: safeAreaLayoutGuide.topAnchor, left: safeAreaLayoutGuide.leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: 20, height: 20)
        backBackground.centerXAnchor.constraint(equalTo: backIcon.centerXAnchor).isActive = true
        backBackground.centerYAnchor.constraint(equalTo: backIcon.centerYAnchor).isActive = true
        backBackground.anchor(top: nil, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 38, height: 38)
    }
    
    func setupNavBar(){
        setupSettings()
        
        addSubview(imageView)
        addSubview(circleBackground)
        circleBackground.addSubview(addImageView)
        addSubview(fullnameLabel)
        addSubview(bioText)
        
        imageView.anchor(top: safeAreaLayoutGuide.topAnchor, left: nil, bottom: nil, right: nil, paddingTop: 54, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 140, height: 140)
        imageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        fullnameLabel.anchor(top: imageView.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 18, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: fullnameLabel.intrinsicContentSize.width, height: fullnameLabel.intrinsicContentSize.height)
        fullnameLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
         bioText.anchor(top: fullnameLabel.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 8, paddingLeft: 24, paddingBottom: 0, paddingRight: 24, width: 0, height: 70)
        circleBackground.anchor(top: nil, left: nil, bottom: imageView.bottomAnchor, right: imageView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 30, height: 30)
        addImageView.anchor(top: nil, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 16, height: 16)
        addImageView.centerYAnchor.constraint(equalTo: circleBackground.centerYAnchor).isActive = true
        addImageView.centerXAnchor.constraint(equalTo: circleBackground.centerXAnchor).isActive = true
        setupEngagements()
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupNavBar()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

