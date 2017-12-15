//
//  UserCell.swift
//  pursue
//
//  Created by Jaylen Sanders on 9/17/17.
//  Copyright © 2017 Glory. All rights reserved.
//

import UIKit
import Firebase

class UserCell: UICollectionViewCell {
    
    var message: Message? {
        didSet {
            setupNameAndProfileImage()
            
            detailTextLabel.text = message?.text?.description
            
            if let seconds = message?.timestamp?.doubleValue {
                let timestampDate = Date(timeIntervalSince1970: seconds)
                
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "h:mm a"
                timeLabel.text = dateFormatter.string(from: timestampDate)
            }
            
            
        }
    }
    
    let detailTextLabel : UILabel = {
        let label = UILabel()
        return label
    }()
    
    let textLabel : UILabel = {
        let label = UILabel()
        return label
    }()
    
    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 30
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    let timeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor.darkGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    fileprivate func setupNameAndProfileImage() {
        
        if let id = message?.chatPartnerId() {
            let ref = Database.database().reference().child("users").child(id)
            ref.observeSingleEvent(of: .value, with: { (snapshot) in
                
                if let dictionary = snapshot.value as? [String: AnyObject] {
                    self.textLabel.text = dictionary["username"] as? String
                    
                    if let profileImageUrl = dictionary["profileImageURL"] as? String {
                        self.profileImageView.loadImageUsingCacheWithUrlString(profileImageUrl)
                    }
                }
                
            }, withCancel: nil)
        }
    }
    
    func setupMessageText(){
        addSubview(textLabel)
        addSubview(detailTextLabel)
        
        textLabel.font = UIFont.boldSystemFont(ofSize: 16)
        detailTextLabel.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.thin)
        
        textLabel.frame = CGRect(x: 84, y: textLabel.frame.origin.y - 2, width: textLabel.frame.width, height: textLabel.frame.height)
        detailTextLabel.frame = CGRect(x: 84, y: detailTextLabel.frame.origin.y + 2, width: detailTextLabel.frame.width, height: detailTextLabel.frame.height)
        
        textLabel.anchor(top: profileImageView.topAnchor, left: profileImageView.rightAnchor, bottom: nil, right: nil, paddingTop: 14, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: 120, height: textLabel.intrinsicContentSize.height)
        detailTextLabel.anchor(top: textLabel.bottomAnchor, left: textLabel.leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 10, paddingLeft: 0, paddingBottom: 0, paddingRight: 12, width: detailTextLabel.intrinsicContentSize.width, height: detailTextLabel.intrinsicContentSize.height)
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .black
        addSubview(profileImageView)
        addSubview(timeLabel)
        
        //ios 9 constraint anchors
        //need x,y,width,height anchors
        profileImageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true
        profileImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        profileImageView.widthAnchor.constraint(equalToConstant: 60).isActive = true
        profileImageView.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        //need x,y,width,height anchors
        timeLabel.font = UIFont.systemFont(ofSize: 14)
        timeLabel.anchor(top: profileImageView.topAnchor, left: nil, bottom: nil, right: self.rightAnchor, paddingTop: 14, paddingLeft: 0, paddingBottom: 0, paddingRight: 12, width: timeLabel.intrinsicContentSize.width, height: timeLabel.intrinsicContentSize.height)
        setupMessageText()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
