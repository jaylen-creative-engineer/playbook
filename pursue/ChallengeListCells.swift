//
//  ChallengeListCells.swift
//  pursue
//
//  Created by Jaylen Sanders on 9/23/18.
//  Copyright © 2018 Glory. All rights reserved.
//

import UIKit

class ChallengeListCells : UICollectionViewCell {
    
    let postImage : UIImageView = {
        let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "ferrari-f70").withRenderingMode(.alwaysOriginal)
        iv.layer.cornerRadius = 8
        iv.layer.masksToBounds = true
        return iv
    }()
    
    let postDetail : UILabel = {
        let label = UILabel()
        label.text = "Some words to explain this post."
        label.font = UIFont.boldSystemFont(ofSize: 12)
        return label
    }()
    
    let dateLabel : UILabel = {
        let label = UILabel()
        label.text = "2 Days Ago"
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()
    
    let acceptLabel : UIButton = {
       let button = UIButton()
        button.setTitle("Accept", for: .normal)
        button.setTitleColor(.green, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 12)
        return button
    }()
    
    let declineLabel : UIButton = {
        let button = UIButton()
        button.setTitle("Decline", for: .normal)
        button.setTitleColor(.red, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 12)
        return button
    }()
    
    func setupView(){
        addSubview(postImage)
        addSubview(postDetail)
        addSubview(dateLabel)
        addSubview(acceptLabel)
        addSubview(declineLabel)
        
        postImage.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: 100, height: 120)
        postDetail.anchor(top: postImage.topAnchor, left: postImage.rightAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 8, paddingBottom: 0, paddingRight: 12, width: 0, height: 0)
        postDetail.heightAnchor.constraint(lessThanOrEqualToConstant: 60).isActive = true
        dateLabel.anchor(top: postDetail.bottomAnchor, left: postDetail.leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 8, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 16)
        
        acceptLabel.anchor(top: nil, left: dateLabel.leftAnchor, bottom: postImage.bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: acceptLabel.intrinsicContentSize.width, height: 14)
        declineLabel.anchor(top: acceptLabel.topAnchor, left: acceptLabel.rightAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 16, paddingBottom: 0, paddingRight: 0, width: declineLabel.intrinsicContentSize.width, height: 14)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
