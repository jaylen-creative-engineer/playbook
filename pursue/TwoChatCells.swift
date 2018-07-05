//
//  TwoChatCells.swift
//  pursue
//
//  Created by Jaylen Sanders on 6/28/18.
//  Copyright © 2018 Glory. All rights reserved.
//

import UIKit

class TwoChatCells : UICollectionViewCell {
    
    let unreadBubble : UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.layer.cornerRadius = 4
        view.layer.masksToBounds = true
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
    
    let secondPhoto : UIImageView = {
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
        label.font = UIFont(name: "Lato-Semibold", size: 12)
        label.text = "Commented on your pursuit: I worked on this also. Good luck and keep working"
        label.numberOfLines = 2
        return label
    }()
    
    let usernameLabel : UILabel = {
        let label = UILabel()
        label.text = "TomDoe"
        label.font = UIFont(name: "Lato-Bold", size: 14)
        return label
    }()
    
    let timeLabel : UILabel = {
        let label = UILabel()
        label.text = "21 hours ago"
        label.font = UIFont.systemFont(ofSize: 10)
        return label
    }()
    
    func setupView(){
        addSubview(unreadBubble)
        addSubview(userPhoto)
        addSubview(secondPhoto)
        addSubview(usernameLabel)
        addSubview(commentLabel)
        addSubview(timeLabel)
        
        unreadBubble.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 29, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: 8, height: 8)
        userPhoto.anchor(top: topAnchor, left: unreadBubble.rightAnchor, bottom: nil, right: nil, paddingTop: 8, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: 24, height: 24)
        secondPhoto.anchor(top: userPhoto.bottomAnchor, left: userPhoto.rightAnchor, bottom: nil, right: nil, paddingTop: 2, paddingLeft: 2, paddingBottom: 0, paddingRight: 0, width: 24, height: 24)
        usernameLabel.anchor(top: userPhoto.topAnchor, left: secondPhoto.rightAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: usernameLabel.intrinsicContentSize.width, height: usernameLabel.intrinsicContentSize.height)
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
