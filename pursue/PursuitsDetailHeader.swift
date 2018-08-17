//
//  PursuitsDetailHeader.swift
//  pursue
//
//  Created by Jaylen Sanders on 10/17/17.
//  Copyright © 2017 Glory. All rights reserved.
//

import UIKit
import Firebase

protocol DetailDelegate {
    func handleShare(for cell : PursuitsDetailHeader)
    func handleSave(for cell : PursuitsDetailHeader)
    func handleLike(for cell : PursuitsDetailHeader)
}

class PursuitsDetailHeader : UICollectionViewCell {
    
    var delegate : DetailDelegate?
    
    let usernameLabel : UILabel = {
        let label = UILabel()
        label.text = "Versace"
        label.font = UIFont(name: "Lato-Bold", size: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var userPhoto : UIImageView = {
        let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "samuel-l")
        iv.layer.cornerRadius = 20
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
    }()
    
    let fullnameLabel : UILabel = {
       let label = UILabel()
        label.text = "Versace"
        label.font = UIFont.systemFont(ofSize: 10)
        return label
    }()
    
    let likeButton : UIButton = {
       let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "thumbs-up").withRenderingMode(.alwaysTemplate), for: .normal)
        button.imageView?.contentMode = .scaleAspectFill
        button.tintColor = .gray
        button.addTarget(self, action: #selector(handleLike), for: .touchUpInside)
        return button
    }()
    
    let likeLabel : UILabel = {
        let label = UILabel()
        label.text = "Like"
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()
    
    lazy var saveButton : UIButton = {
       let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "bookmark").withRenderingMode(.alwaysTemplate), for: .normal)
        button.imageView?.contentMode = .scaleAspectFill
        button.tintColor = .gray
        button.addTarget(self, action: #selector(handleSave), for: .touchUpInside)
        return button
    }()
    
    let saveLabel : UILabel = {
       let label = UILabel()
        label.text = "Save"
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()
    
    lazy var addButton : UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "add").withRenderingMode(.alwaysTemplate), for: .normal)
        button.imageView?.contentMode = .scaleAspectFill
        button.tintColor = .gray
        button.addTarget(self, action: #selector(handleContribute), for: .touchUpInside)
        return button
    }()
    
    let contributeLabel : UILabel = {
        let label = UILabel()
        label.text = "Contribute"
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()
    
    lazy var commentButton : UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "highlight").withRenderingMode(.alwaysTemplate), for: .normal)
        button.imageView?.contentMode = .scaleAspectFill
        button.tintColor = .gray
        button.addTarget(self, action: #selector(handleComment), for: .touchUpInside)
        return button
    }()
    
    let commentLabel : UILabel = {
        let label = UILabel()
        label.text = "Comment"
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()
    
    lazy var shareButton : UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "share").withRenderingMode(.alwaysTemplate), for: .normal)
        button.imageView?.contentMode = .scaleAspectFill
        button.tintColor = .gray
        button.addTarget(self, action: #selector(shareSelected), for: .touchUpInside)
        return button
    }()
    
    lazy var shareLabel : UILabel = {
        let label = UILabel()
        label.text = "Share"
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 12)
        label.isUserInteractionEnabled = true
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(shareSelected))
        tap.numberOfTapsRequired = 1
        label.addGestureRecognizer(tap)
        return label
    }()
    
    @objc func handleLike(){
        Analytics.logEvent("Like pressed", parameters: nil)
        delegate?.handleLike(for: self)
    }
    
    @objc func shareSelected(){
        Analytics.logEvent("App has been shared", parameters: nil)
        delegate?.handleShare(for: self)
    }
    
    @objc func handleComment(){
        Analytics.logEvent("Post has been commented on", parameters: nil)
    }
    
    @objc func handleSave(){
        Analytics.logEvent("Post has been saved", parameters: nil)
        delegate?.handleSave(for: self)
    }
    
    @objc func handleContribute(){
        Analytics.logEvent("Post has been contributed to", parameters: nil)
    }
    
    func setupEngagements(){
        addSubview(saveButton)
        addSubview(saveLabel)
        addSubview(addButton)
        addSubview(contributeLabel)
        addSubview(commentButton)
        addSubview(commentLabel)
        addSubview(shareButton)
        addSubview(shareLabel)
        
        saveButton.anchor(top: userPhoto.bottomAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 18, paddingLeft: 28, paddingBottom: 0, paddingRight: 0, width: 16, height: 24)
        saveLabel.anchor(top: saveButton.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 8, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: saveLabel.intrinsicContentSize.width, height: saveLabel.intrinsicContentSize.height)
        saveLabel.centerXAnchor.constraint(equalTo: saveButton.centerXAnchor).isActive = true
        
        addButton.anchor(top: userPhoto.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 18, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 24, height: 24)
        addButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        contributeLabel.anchor(top: saveLabel.topAnchor, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: contributeLabel.intrinsicContentSize.width, height: contributeLabel.intrinsicContentSize.height)
        contributeLabel.centerXAnchor.constraint(equalTo: addButton.centerXAnchor).isActive = true
        
        commentButton.anchor(top: userPhoto.bottomAnchor, left: addButton.rightAnchor, bottom: nil, right: nil, paddingTop: 18, paddingLeft: 58, paddingBottom: 0, paddingRight: 0, width: 22, height: 24)
        commentLabel.anchor(top: saveLabel.topAnchor, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: commentLabel.intrinsicContentSize.width, height: commentLabel.intrinsicContentSize.height)
        commentLabel.centerXAnchor.constraint(equalTo: commentButton.centerXAnchor).isActive = true
        shareButton.anchor(top: userPhoto.bottomAnchor, left: nil, bottom: nil, right: rightAnchor, paddingTop: 18, paddingLeft: 0, paddingBottom: 0, paddingRight: 18, width: 28, height: 24)
        shareLabel.anchor(top: saveLabel.topAnchor, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: shareLabel.intrinsicContentSize.width, height: shareLabel.intrinsicContentSize.height)
        shareLabel.centerXAnchor.constraint(equalTo: shareButton.centerXAnchor).isActive = true
    }
    
    func setupView(){
        addSubview(userPhoto)
        addSubview(usernameLabel)
        addSubview(fullnameLabel)
        
        userPhoto.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 12, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: 40, height: 40)
        usernameLabel.anchor(top: userPhoto.topAnchor, left: userPhoto.rightAnchor, bottom: nil, right: nil, paddingTop: 4, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: usernameLabel.intrinsicContentSize.width, height: usernameLabel.intrinsicContentSize.height)
        fullnameLabel.anchor(top: usernameLabel.bottomAnchor, left: usernameLabel.leftAnchor, bottom: nil, right: nil, paddingTop: 6, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: fullnameLabel.intrinsicContentSize.width, height: fullnameLabel.intrinsicContentSize.height)
        setupEngagements()
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

