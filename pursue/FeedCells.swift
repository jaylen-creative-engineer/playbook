//
//  FeedCells.swift
//  pursue
//
//  Created by Jaylen Sanders on 6/26/18.
//  Copyright © 2018 Glory. All rights reserved.
//

import UIKit

class FeedCells : UICollectionViewCell {
    
    let imageView : UIImageView = {
       let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "music").withRenderingMode(.alwaysOriginal)
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    let pursuitLabel : UILabel = {
       let label = UILabel()
        label.text = "Travel through amazing heights"
        label.numberOfLines = 2
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 18)
        return label
    }()
    
    let postLabel : UILabel = {
       let label = UILabel()
        label.text = "Building a tech company"
        label.font = UIFont.systemFont(ofSize: 12)
        label.numberOfLines = 2
        label.textColor = .white
        return label
    }()
    
    let timeLabel : UILabel = {
       let label = UILabel()
        label.text = "Day 3"
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .white
        return label
    }()
    
    let playBackground : PlayView = {
       let view = PlayView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.masksToBounds = true
        return view
    }()
    
    let playIcon : UIImageView = {
       let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "view-more").withRenderingMode(.alwaysOriginal)
        iv.contentMode = .scaleAspectFill
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    let likeButton : UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "thumbs-up").withRenderingMode(.alwaysTemplate), for: .normal)
        button.imageView?.contentMode = .scaleAspectFill
        button.tintColor = .white
        return button
    }()
    
    let likeLabel : UILabel = {
        let label = UILabel()
        label.text = "Like"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()
    
    let saveButton : UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "bookmark").withRenderingMode(.alwaysTemplate), for: .normal)
        button.imageView?.contentMode = .scaleAspectFill
        button.tintColor = .white
        return button
    }()
    
    let saveLabel : UILabel = {
        let label = UILabel()
        label.text = "Save"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()
    
    let addButton : UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "add").withRenderingMode(.alwaysTemplate), for: .normal)
        button.imageView?.contentMode = .scaleAspectFill
        button.tintColor = .white
        return button
    }()
    
    let contributeLabel : UILabel = {
        let label = UILabel()
        label.text = "Contribute"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()
    
    let commentButton : UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "highlight").withRenderingMode(.alwaysTemplate), for: .normal)
        button.imageView?.contentMode = .scaleAspectFill
        button.tintColor = .white
        return button
    }()
    
    let commentLabel : UILabel = {
        let label = UILabel()
        label.text = "Comment"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()
    
    let shareButton : UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "share").withRenderingMode(.alwaysTemplate), for: .normal)
        button.imageView?.contentMode = .scaleAspectFill
        button.tintColor = .white
        return button
    }()
    
    let shareLabel : UILabel = {
        let label = UILabel()
        label.text = "Share"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()
    
    func setupEngagements(){
        addSubview(likeButton)
        addSubview(likeLabel)
        addSubview(saveButton)
        addSubview(saveLabel)
        addSubview(addButton)
        addSubview(contributeLabel)
        addSubview(commentButton)
        addSubview(commentLabel)
        addSubview(shareButton)
        addSubview(shareLabel)
        
        likeButton.anchor(top: playIcon.bottomAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 54, paddingLeft: 28, paddingBottom: 0, paddingRight: 0, width: 24, height: 24)
        likeLabel.anchor(top: likeButton.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 8, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: likeLabel.intrinsicContentSize.width, height: likeLabel.intrinsicContentSize.height)
        likeLabel.centerXAnchor.constraint(equalTo: likeButton.centerXAnchor).isActive = true
        
        saveButton.anchor(top: playIcon.bottomAnchor, left: likeButton.rightAnchor, bottom: nil, right: nil, paddingTop: 54, paddingLeft: 48, paddingBottom: 0, paddingRight: 0, width: 16, height: 24)
        saveLabel.anchor(top: saveButton.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 8, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: saveLabel.intrinsicContentSize.width, height: saveLabel.intrinsicContentSize.height)
        saveLabel.centerXAnchor.constraint(equalTo: saveButton.centerXAnchor).isActive = true
        
        addButton.anchor(top: playIcon.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 54, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 24, height: 24)
        addButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        contributeLabel.anchor(top: saveLabel.topAnchor, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: contributeLabel.intrinsicContentSize.width, height: contributeLabel.intrinsicContentSize.height)
        contributeLabel.centerXAnchor.constraint(equalTo: addButton.centerXAnchor).isActive = true
        
        commentButton.anchor(top: playIcon.bottomAnchor, left: addButton.rightAnchor, bottom: nil, right: nil, paddingTop: 54, paddingLeft: 58, paddingBottom: 0, paddingRight: 0, width: 22, height: 24)
        commentLabel.anchor(top: saveLabel.topAnchor, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: commentLabel.intrinsicContentSize.width, height: commentLabel.intrinsicContentSize.height)
        commentLabel.centerXAnchor.constraint(equalTo: commentButton.centerXAnchor).isActive = true
        shareButton.anchor(top: playIcon.bottomAnchor, left: nil, bottom: nil, right: rightAnchor, paddingTop: 54, paddingLeft: 0, paddingBottom: 0, paddingRight: 18, width: 28, height: 24)
        shareLabel.anchor(top: saveLabel.topAnchor, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: shareLabel.intrinsicContentSize.width, height: shareLabel.intrinsicContentSize.height)
        shareLabel.centerXAnchor.constraint(equalTo: shareButton.centerXAnchor).isActive = true
    }
    
    func setupView(){
        addSubview(imageView)
        addSubview(pursuitLabel)
        addSubview(postLabel)
        addSubview(timeLabel)
        addSubview(playBackground)
        addSubview(playIcon)
  
        imageView.anchor(top: topAnchor, left: leftAnchor, bottom: safeAreaLayoutGuide.bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        pursuitLabel.anchor(top: imageView.centerYAnchor, left: imageView.leftAnchor, bottom: nil, right: imageView.centerXAnchor, paddingTop: 0, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: 0, height: 50)
        postLabel.anchor(top: pursuitLabel.bottomAnchor, left: pursuitLabel.leftAnchor, bottom: nil, right: imageView.rightAnchor, paddingTop: 6, paddingLeft: 0, paddingBottom: 0, paddingRight: 18, width: 0, height: postLabel.intrinsicContentSize.height)
        timeLabel.anchor(top: postLabel.bottomAnchor, left: postLabel.leftAnchor, bottom: nil, right: imageView.rightAnchor, paddingTop: 6, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: timeLabel.intrinsicContentSize.height)
        playBackground.anchor(top: timeLabel.bottomAnchor, left: timeLabel.leftAnchor, bottom: nil, right: nil, paddingTop: 32, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 30, height: 30)
        playIcon.anchor(top: nil, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 12, height: 12)
        playIcon.centerXAnchor.constraint(equalTo: playBackground.centerXAnchor).isActive = true
        playIcon.centerYAnchor.constraint(equalTo: playBackground.centerYAnchor).isActive = true
        setupEngagements()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        backgroundColor = .red
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
