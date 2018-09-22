//
//  HomePostCells.swift
//  pursue
//
//  Created by Jaylen Sanders on 8/28/18.
//  Copyright © 2018 Glory. All rights reserved.
//

import UIKit
import Hero

class HomePostCells : UICollectionViewCell  {
    
    lazy var imageView : UIImageView = {
        let iv = UIImageView()
        iv.layer.cornerRadius = 12
        iv.clipsToBounds = true
        iv.image = #imageLiteral(resourceName: "ferrari").withRenderingMode(.alwaysOriginal)
        iv.contentMode = .scaleAspectFill
        iv.isUserInteractionEnabled = true
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleChangeDetail))
        tap.numberOfTapsRequired = 1
        iv.addGestureRecognizer(tap)
        return iv
    }()
    
    let backgroundShadow : GroupChatView = {
       let view = GroupChatView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let postType : UILabel = {
        let label = UILabel()
        label.text = "Principle"
        label.font = UIFont(name: "Lato-Bold", size: 14)
        label.textColor = .white
        label.motionIdentifier = "postType"
        return label
    }()
    
    let userPhoto : UIImageView = {
       let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "samuel-l").withRenderingMode(.alwaysOriginal)
        iv.contentMode = .scaleAspectFill
        iv.layer.cornerRadius = 20
        iv.layer.masksToBounds = true
        iv.motionIdentifier = "userPhoto"
        return iv
    }()
    
    let postDetail : UILabel = {
        let label = UILabel()
        label.text = "Travel On"
        label.numberOfLines = 0
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 24, weight: UIFont.Weight.init(25))
        label.textAlignment = .center
        label.motionIdentifier = "postDetail"
        return label
    }()
    
    let daysLabel : UILabel = {
        let label = UILabel()
        label.text = "20 Days"
        label.font = UIFont(name: "Lato-Bold", size: 14)
        label.textColor = .white
        label.motionIdentifier = "daysLabel"
        return label
    }()
    
    let seperatorCircle : UIView = {
       let view = UIView()
        view.layer.cornerRadius = 3
        view.layer.masksToBounds = true
        view.backgroundColor = .white
        return view
    }()
    
    let username : UILabel = {
        let label = UILabel()
        label.text = "Test"
        label.font = UIFont(name: "Lato-Bold", size: 14)
        label.textColor = .white
        label.motionIdentifier = "username"
        return label
    }()
    
    let timeLabel : UILabel = {
        let label = UILabel()
        label.text = "Today"
        label.font = UIFont(name: "Lato-Bold", size: 12)
        label.textColor = .white
        label.motionIdentifier = "timeLabel"
        return label
    }()
    
    let saveBackground : UIButton = {
       let button = UIButton()
        button.backgroundColor = .white
        button.layer.cornerRadius = 15
        button.clipsToBounds = true
        button.motionIdentifier = "saveBackground"
        return button
    }()
    
    let saveLabel : UILabel = {
       let label = UILabel()
        label.text = "Save"
        label.font = UIFont(name: "Lato-Bold", size: 12)
        label.textColor = .white
        label.motionIdentifier = "saveLabel"
        return label
    }()
    
    lazy var saveIcon : UIButton = {
       let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "bookmark").withRenderingMode(.alwaysOriginal), for: .normal)
        button.contentMode = .scaleAspectFill
        button.motionIdentifier = "saveIcon"
        return button
    }()
    
    let tryBackground : UIButton = {
        let button = UIButton()
        button.backgroundColor = .white
        button.layer.cornerRadius = 21
        button.clipsToBounds = true
        button.motionIdentifier = "tryBackground"
        return button
    }()
    
    lazy var tryIcon : UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "add").withRenderingMode(.alwaysOriginal), for: .normal)
        button.contentMode = .scaleAspectFill
        button.motionIdentifier = "tryIcon"
        return button
    }()
    
    let tryLabel : UILabel = {
        let label = UILabel()
        label.text = "Try"
        label.font = UIFont(name: "Lato-Bold", size: 12)
        label.textColor = .white
        label.motionIdentifier = "tryLabel"
        return label
    }()
    
    let shareBackground : UIButton = {
        let button = UIButton()
        button.backgroundColor = .white
        button.layer.cornerRadius = 15
        button.clipsToBounds = true
        button.motionIdentifier = "shareBackground"
        return button
    }()
    
    lazy var shareIcon : UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "share").withRenderingMode(.alwaysOriginal), for: .normal)
        button.contentMode = .scaleAspectFill
        button.motionIdentifier = "shareIcon"
        return button
    }()
    
    let shareLabel : UILabel = {
        let label = UILabel()
        label.text = "Share"
        label.font = UIFont(name: "Lato-Bold", size: 12)
        label.textColor = .white
        label.motionIdentifier = "shareLabel"
        return label
    }()
    
    let progressBar : UIProgressView = {
       let view = UIProgressView()
        view.progress = 100
        view.progressTintColor = .white
        view.layer.cornerRadius = 2
        view.layer.masksToBounds = true
        view.motionIdentifier = "progressBar"
        return view
    }()
    
    var accessFeedController : FeedCell?
    
    @objc func handleChangeDetail(){
        accessFeedController?.handleChangeToDetail(transitionId: "0")
    }
    
    func setupEngagements(){
        addSubview(saveBackground)
        addSubview(saveIcon)
        addSubview(tryBackground)
        addSubview(tryIcon)
        addSubview(saveLabel)
        addSubview(tryLabel)
        addSubview(shareBackground)
        addSubview(shareIcon)
        addSubview(shareLabel)

        tryBackground.anchor(top: nil, left: nil, bottom: imageView.bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 32, paddingRight: 0, width: 42, height: 42)
        tryBackground.centerXAnchor.constraint(equalTo: imageView.centerXAnchor).isActive = true
        tryIcon.anchor(top: nil, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 18, height: 18)
        tryIcon.centerXAnchor.constraint(equalTo: tryBackground.centerXAnchor).isActive = true
        tryIcon.centerYAnchor.constraint(equalTo: tryBackground.centerYAnchor).isActive = true
        
        saveBackground.anchor(top: nil, left: nil, bottom: nil, right: tryBackground.leftAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 34, width: 30, height: 30)
        saveBackground.centerYAnchor.constraint(equalTo: tryBackground.centerYAnchor).isActive = true
        saveIcon.anchor(top: nil, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 12, height: 16)
        saveIcon.centerXAnchor.constraint(equalTo: saveBackground.centerXAnchor).isActive = true
        saveIcon.centerYAnchor.constraint(equalTo: saveBackground.centerYAnchor).isActive = true

        shareBackground.anchor(top: nil, left: tryBackground.rightAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 34, paddingBottom: 0, paddingRight: 0, width: 30, height: 30)
        shareBackground.centerYAnchor.constraint(equalTo: tryBackground.centerYAnchor).isActive = true
        shareIcon.anchor(top: nil, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 16, height: 14)
        shareIcon.centerXAnchor.constraint(equalTo: shareBackground.centerXAnchor).isActive = true
        shareIcon.centerYAnchor.constraint(equalTo: shareBackground.centerYAnchor).isActive = true
    }
    
    func setupView(){
        addSubview(backgroundShadow)
        addSubview(imageView)
        addSubview(progressBar)
        addSubview(userPhoto)
        addSubview(postType)
        addSubview(postDetail)
        addSubview(seperatorCircle)
        addSubview(daysLabel)
        addSubview(username)
        addSubview(timeLabel)
        
        backgroundShadow.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 8, paddingBottom: 0, paddingRight: 8, width: 0, height: frame.height)
        imageView.anchor(top: backgroundShadow.topAnchor, left: backgroundShadow.leftAnchor, bottom: backgroundShadow.bottomAnchor, right: backgroundShadow.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        progressBar.anchor(top: imageView.topAnchor, left: imageView.leftAnchor, bottom: nil, right: imageView.rightAnchor, paddingTop: 8, paddingLeft: 8, paddingBottom: 0, paddingRight: 8, width: 0, height: 3)
        userPhoto.anchor(top: progressBar.bottomAnchor, left: imageView.leftAnchor, bottom: nil, right: nil, paddingTop: 18, paddingLeft: 8, paddingBottom: 0, paddingRight: 0, width: 40, height: 40)
        username.anchor(top: userPhoto.topAnchor, left: userPhoto.rightAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 12, paddingBottom: 0, paddingRight: 24, width: 0, height: 16)
        timeLabel.anchor(top: username.bottomAnchor, left: username.leftAnchor, bottom: nil, right: nil, paddingTop: 8, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 14)
        postDetail.anchor(top: imageView.topAnchor, left: nil, bottom: nil, right: nil, paddingTop: frame.height / 6, paddingLeft: 12, paddingBottom: 0, paddingRight: 12, width: 0, height: 0)
        postDetail.heightAnchor.constraint(lessThanOrEqualToConstant: 52).isActive = true
        postDetail.centerXAnchor.constraint(equalTo: imageView.centerXAnchor).isActive = true
        postType.anchor(top: postDetail.bottomAnchor, left: imageView.leftAnchor, bottom: nil, right: nil, paddingTop: 12, paddingLeft: (frame.width / 3) - 12, paddingBottom: 0, paddingRight: 0, width: postType.intrinsicContentSize.width, height: 16)
        seperatorCircle.anchor(top: nil, left: postType.rightAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: 6, height: 6)
        seperatorCircle.centerYAnchor.constraint(equalTo: postType.centerYAnchor).isActive = true
        daysLabel.anchor(top: postDetail.bottomAnchor, left: seperatorCircle.rightAnchor, bottom: nil, right: nil, paddingTop: 12, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: daysLabel.intrinsicContentSize.width, height: 16)
        setupEngagements()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        hero.isEnabled = true
        isMotionEnabled = true
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
