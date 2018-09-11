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
    
    let followId = "followId"
    var delegate : ProfileHeaderDelegate?
    var accessProfileController : ProfileController?
    
    let imageView : CustomImageView = {
        let iv = CustomImageView()
        iv.clipsToBounds = true
        iv.contentMode = .scaleAspectFill
        iv.image = #imageLiteral(resourceName: "comment-1").withRenderingMode(.alwaysOriginal)
        iv.layer.cornerRadius = 70
        return iv
    }()
    
    let usernameLabel : UILabel = {
       let label = UILabel()
        label.text = "jaylenhu27"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.init(25))
        return label
    }()
    
    let fullnameLabel : UILabel = {
       let label = UILabel()
        label.text = "Jaylen Sanders"
        label.textAlignment = .center
        label.font = UIFont(name: "Lato-Bold", size: 18)
        return label
    }()
    
    let bioText : UILabel = {
        let label = UILabel()
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 2
        paragraphStyle.paragraphSpacing = 5
        
        let attrString = NSMutableAttributedString(string: "Loreum Ipsum is simply dummy text of the printing and typesetting industry. Lorem ipsum has been the industry's.....")
        attrString.addAttribute(NSAttributedStringKey.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, attrString.length))
        
        label.attributedText = attrString
        label.font = UIFont.systemFont(ofSize: 12)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    lazy var notificationsButton : UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "notifications-bell-grey").withRenderingMode(.alwaysOriginal), for: .normal)
        button.imageView?.contentMode = .scaleAspectFill
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let messageBackground : MessageView = {
       let view = MessageView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var messageButton : UIButton = {
       let button = UIButton()
        button.backgroundColor = .black
        button.setTitle("Message", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont(name: "Lato-Bold", size: 14)
        button.layer.cornerRadius = 17
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(handleMessageTap), for: .touchUpInside)
        return button
    }()

    let addedCountLabel : UIButton = {
        let button = UIButton()
        button.setTitle("120", for: .normal)
        button.setTitleColor(.gray, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.init(25))
        return button
    }()
    
    let addedLabel : UIButton = {
        let button = UIButton()
        button.setTitle("ADDED", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont(name: "Lato-Bold", size: 10)
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
    
    let circleBackground : PlayView = {
       let view = PlayView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var chatImageView : UIImageView = {
       let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "chat").withRenderingMode(.alwaysOriginal)
        return iv
    }()
    
    lazy var addImageView : UIImageView = {
       let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "add").withRenderingMode(.alwaysOriginal)
        iv.contentMode = .scaleAspectFill
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    var fakeFollowerArray = [#imageLiteral(resourceName: "samuel-l"), #imageLiteral(resourceName: "comment-4"), #imageLiteral(resourceName: "comment-5"), #imageLiteral(resourceName: "comment-4"), #imageLiteral(resourceName: "comment-7")]
    
    @objc func handleMessageTap(){
        accessProfileController?.changeToInterests()
    }
    
    func setupEngagements(){
        addSubview(addedCountLabel)
        addSubview(addedLabel)
        addSubview(pursuitsCountLabel)
        addSubview(pursuitsLabel)
        addSubview(chatImageView)
        addSubview(messageBackground)
        addSubview(messageButton)
        
        addedCountLabel.anchor(top: bioText.bottomAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: frame.width / 5.5, paddingLeft: 16, paddingBottom: 0, paddingRight: 0, width: addedCountLabel.intrinsicContentSize.width, height: 18)
        addedLabel.anchor(top: addedCountLabel.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: addedLabel.intrinsicContentSize.height)
        addedLabel.centerXAnchor.constraint(equalTo: addedCountLabel.centerXAnchor).isActive = true
        pursuitsCountLabel.anchor(top: addedCountLabel.topAnchor, left: addedLabel.rightAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 48, paddingBottom: 0, paddingRight: 0, width: pursuitsCountLabel.intrinsicContentSize.width, height: 18)
        pursuitsLabel.anchor(top: pursuitsCountLabel.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: pursuitsLabel.intrinsicContentSize.height)
        pursuitsLabel.centerXAnchor.constraint(equalTo: pursuitsCountLabel.centerXAnchor).isActive = true
        messageBackground.anchor(top: addedCountLabel.topAnchor, left: nil, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 12, width: 120, height: 35)
        messageButton.anchor(top: messageBackground.topAnchor, left: messageBackground.leftAnchor, bottom: messageBackground.bottomAnchor, right: messageBackground.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
    }
    
    
    func setupNavBar(){
        addSubview(usernameLabel)
        addSubview(imageView)
        addSubview(circleBackground)
        circleBackground.addSubview(addImageView)
        addSubview(fullnameLabel)
        addSubview(bioText)
        
        usernameLabel.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: usernameLabel.intrinsicContentSize.width, height: usernameLabel.intrinsicContentSize.height)
        imageView.anchor(top: usernameLabel.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 42, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 140, height: 140)
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

