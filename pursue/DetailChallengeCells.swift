//
//  DetailChallengeCells.swift
//  pursue
//
//  Created by Jaylen Sanders on 6/25/18.
//  Copyright © 2018 Glory. All rights reserved.
//

import UIKit

class DetailChallengeCells : UICollectionViewCell  {
    
    let imageView : UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = .blue
        iv.layer.cornerRadius = 4
        iv.clipsToBounds = true
        iv.image = #imageLiteral(resourceName: "ferrari").withRenderingMode(.alwaysOriginal)
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    let postDetail : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.text = "Working on this."
        return label
    }()
    
    let timeLabel : UILabel = {
        let label = UILabel()
        label.text = "1h ago"
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .gray
        return label
    }()
    
    let acceptButton : UIButton = {
       let button = UIButton()
        button.setTitle("Accept", for: .normal)
        button.setTitleColor(.green, for: .normal)
        button.titleLabel?.font = UIFont(name: "Lato-Bold", size: 12)
        return button
    }()
    
    let declineButton : UIButton = {
        let button = UIButton()
        button.setTitle("Decline", for: .normal)
        button.setTitleColor(.red, for: .normal)
        button.titleLabel?.font = UIFont(name: "Lato-Bold", size: 12)
        return button
    }()
    
    let upVotesCount : UILabel = {
       let label = UILabel()
        label.text = "30 Upvotes"
        label.font = UIFont.boldSystemFont(ofSize: 12)
        return label
    }()
    
//    lazy var upVote
    
    func setupView(){
        addSubview(imageView)
        addSubview(acceptButton)
        addSubview(declineButton)
        addSubview(upVotesCount)
        addSubview(postDetail)

        imageView.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: 130, height: 145)
        postDetail.anchor(top: nil, left: imageView.rightAnchor, bottom: upVotesCount.topAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 8, paddingBottom: 8, paddingRight: 12, width: 0, height: 14)
        acceptButton.anchor(top: nil, left: imageView.rightAnchor, bottom: imageView.bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 8, paddingBottom: 0, paddingRight: 0, width: acceptButton.intrinsicContentSize.width, height: 14)
        declineButton.anchor(top: acceptButton.topAnchor, left: acceptButton.rightAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 8, paddingBottom: 0, paddingRight: 0, width: declineButton.intrinsicContentSize.width, height: 14)
        upVotesCount.anchor(top: nil, left: imageView.rightAnchor, bottom: acceptButton.topAnchor, right: nil, paddingTop: 0, paddingLeft: 8, paddingBottom: 8, paddingRight: 0, width: upVotesCount.intrinsicContentSize.width, height: 14)
       
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
