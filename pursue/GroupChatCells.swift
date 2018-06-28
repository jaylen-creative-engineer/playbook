//
//  GroupChatCells.swift
//  pursue
//
//  Created by Jaylen Sanders on 6/28/18.
//  Copyright © 2018 Glory. All rights reserved.
//

import UIKit

class GroupChatCells : UICollectionViewCell {
    
    let unreadBubble : UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.layer.cornerRadius = 4
        view.layer.masksToBounds = true
        return view
    }()
    
    let peopleBackground : GroupChatView = {
        let view = GroupChatView()
        return view
    }()
    
    let secondBackground : GroupChatView = {
        let view = GroupChatView()
        return view
    }()
    
    let thirdBackground : GroupChatView = {
        let view = GroupChatView()
        return view
    }()
    
    let userPhoto : UIImageView = {
        let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "samuel-l").withRenderingMode(.alwaysOriginal)
        iv.contentMode = .scaleAspectFill
        iv.layer.masksToBounds = true
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.layer.cornerRadius = 12
        return iv
    }()
    
    let secondUserPhoto : UIImageView = {
        let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "samuel-l").withRenderingMode(.alwaysOriginal)
        iv.contentMode = .scaleAspectFill
        iv.layer.masksToBounds = true
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.layer.cornerRadius = 12
        return iv
    }()
    
    let thirdUserPhoto : UIImageView = {
        let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "samuel-l").withRenderingMode(.alwaysOriginal)
        iv.contentMode = .scaleAspectFill
        iv.layer.masksToBounds = true
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.layer.cornerRadius = 12
        return iv
    }()
    
    let commentLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.text = "Commented on your pursuit: I worked on this also. Good luck and keep working"
        label.numberOfLines = 2
        return label
    }()
    
    let usernameLabel : UILabel = {
        let label = UILabel()
        label.text = "TomDoe"
        label.font = UIFont.boldSystemFont(ofSize: 14)
        return label
    }()
    
    let timeLabel : UILabel = {
        let label = UILabel()
        label.text = "21 hours ago"
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()
    
    func setupView(){
        addSubview(unreadBubble)
        addSubview(userPhoto)
        addSubview(secondUserPhoto)
        addSubview(thirdUserPhoto)
        addSubview(usernameLabel)
        addSubview(commentLabel)
        addSubview(timeLabel)
        
        unreadBubble.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 29, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: 8, height: 8)
        userPhoto.anchor(top: topAnchor, left: unreadBubble.rightAnchor, bottom: nil, right: nil, paddingTop: 16, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: 24, height: 24)
        secondUserPhoto.anchor(top: topAnchor, left: userPhoto.rightAnchor, bottom: nil, right: nil, paddingTop: 4, paddingLeft: 4, paddingBottom: 0, paddingRight: 0, width: 24, height: 24)
        thirdUserPhoto.anchor(top: secondUserPhoto.bottomAnchor, left: secondUserPhoto.leftAnchor, bottom: nil, right: nil, paddingTop: 4, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 24, height: 24)
        usernameLabel.anchor(top: secondUserPhoto.topAnchor, left: secondUserPhoto.rightAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: usernameLabel.intrinsicContentSize.width, height: usernameLabel.intrinsicContentSize.height)
        commentLabel.anchor(top: usernameLabel.bottomAnchor, left: usernameLabel.leftAnchor, bottom: nil, right: safeAreaLayoutGuide.rightAnchor, paddingTop: 8, paddingLeft: 0, paddingBottom: 0, paddingRight: 10, width: commentLabel.intrinsicContentSize.width, height: (commentLabel.intrinsicContentSize.height * 2) + 5)
        timeLabel.anchor(top: commentLabel.bottomAnchor, left: commentLabel.leftAnchor, bottom: nil, right: nil, paddingTop: 8, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: timeLabel.intrinsicContentSize.width, height: timeLabel.intrinsicContentSize.height)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
