//
//  ChatDetailCell.swift
//  pursue
//
//  Created by Jaylen Sanders on 9/5/18.
//  Copyright © 2018 Glory. All rights reserved.
//

import UIKit

class ChatDetailCell : UITableViewCell {
    
    let messageLabel = UILabel()
    let bubbleBackgroundView = UIView()
    
    let messageBackgroundView : ChatMessageView = {
        let view = ChatMessageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    
    let messageImageView : UIImageView = {
       let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "samuel-l").withRenderingMode(.alwaysOriginal)
        iv.contentMode = .scaleAspectFill
        iv.layer.cornerRadius = 15
        iv.layer.masksToBounds = true
        return iv
    }()
    
    var leadingConstraint: NSLayoutConstraint!
    var trailingConstraint: NSLayoutConstraint!
    
    var imageLeadingConstraint : NSLayoutConstraint!
    var imageTrailingConstraint : NSLayoutConstraint!
    
    var chatMessage: ChatMessage! {
        didSet {
            messageLabel.text = chatMessage.text
            
            if chatMessage.isIncoming {
                leadingConstraint.isActive = true
                trailingConstraint.isActive = false
                
                messageImageView.anchor(top: bubbleBackgroundView.bottomAnchor, left: bubbleBackgroundView.leftAnchor, bottom: nil, right: nil, paddingTop: -8, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 30, height: 30)
            } else {
                leadingConstraint.isActive = false
                trailingConstraint.isActive = true

                messageImageView.anchor(top: bubbleBackgroundView.bottomAnchor, left: nil, bottom: nil, right: bubbleBackgroundView.rightAnchor, paddingTop: -8, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 30, height: 30)
            }
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .clear
        bubbleBackgroundView.backgroundColor = .white
        bubbleBackgroundView.layer.cornerRadius = 12
        bubbleBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.numberOfLines = 0
        messageLabel.textColor = .black
        messageLabel.font = UIFont.systemFont(ofSize: 14)
        
        addSubview(messageBackgroundView)
        addSubview(bubbleBackgroundView)
        addSubview(messageLabel)
        addSubview(messageImageView)
        
    
        let constraints = [
            messageLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            messageLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -32),
            messageLabel.widthAnchor.constraint(lessThanOrEqualToConstant: 200),
            
            
            messageBackgroundView.topAnchor.constraint(equalTo: messageLabel.topAnchor, constant: -16),
            messageBackgroundView.leadingAnchor.constraint(equalTo: messageLabel.leadingAnchor, constant: -16),
            messageBackgroundView.bottomAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: 16),
            messageBackgroundView.trailingAnchor.constraint(equalTo: messageLabel.trailingAnchor, constant: 16),
            
//            messageImageView.heightAnchor.constraint(equalToConstant: 40),
//            messageImageView.widthAnchor.constraint(equalToConstant: 40),
//            messageImageView.bottomAnchor.constraint(equalTo: topAnchor, constant: -16),
            
            bubbleBackgroundView.topAnchor.constraint(equalTo: messageBackgroundView.topAnchor),
            bubbleBackgroundView.leadingAnchor.constraint(equalTo: messageBackgroundView.leadingAnchor),
            bubbleBackgroundView.bottomAnchor.constraint(equalTo: messageBackgroundView.bottomAnchor),
            bubbleBackgroundView.trailingAnchor.constraint(equalTo: messageBackgroundView.trailingAnchor)
            ]
        
        NSLayoutConstraint.activate(constraints)
        
        leadingConstraint = messageLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32)
        leadingConstraint.isActive = false
        
        trailingConstraint = messageLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -32)
        trailingConstraint.isActive = true
        
//        imageLeadingConstraint = messageImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32)
//        imageLeadingConstraint.isActive = false
//
//        imageTrailingConstraint = messageImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -32)
//        imageTrailingConstraint.isActive = true
        
//        if !leadingConstraint.isActive {
//             messageImageView.anchor(top: bubbleBackgroundView.bottomAnchor, left: bubbleBackgroundView.leftAnchor, bottom: nil, right: nil, paddingTop: -8, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 30, height: 30)
//        } else if trailingConstraint.isActive == true {
//            messageImageView.anchor(top: bubbleBackgroundView.bottomAnchor, left: nil, bottom: nil, right: bubbleBackgroundView.rightAnchor, paddingTop: -8, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 30, height: 30)
//        }
        
        
//        imageLeadingConstraint = messageImageView.leadingAnchor.constraint(equalTo: messageLabel.leadingAnchor, constant: 32)
//        imageLeadingConstraint.isActive = false
//
//        imageTrailingConstraint = messageImageView.trailingAnchor.constraint(equalTo: messageLabel.trailingAnchor, constant: 32)
//        imageTrailingConstraint.isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
