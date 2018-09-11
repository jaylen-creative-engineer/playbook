//
//  DetailChallengeHeader.swift
//  pursue
//
//  Created by Jaylen Sanders on 9/9/18.
//  Copyright © 2018 Glory. All rights reserved.
//

import UIKit

class DetailChallengeHeader : UICollectionViewCell  {
    
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
    
    let answersLabel : UILabel = {
       let label = UILabel()
        label.text = "Answers"
        label.font = UIFont(name: "Lato-Bold", size: 14)
        return label
    }()
    
    func setupView(){
        addSubview(imageView)
        addSubview(postDetail)
        addSubview(timeLabel)
        addSubview(answersLabel)
        
        imageView.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: 130, height: 145)
        timeLabel.anchor(top: nil, left: imageView.rightAnchor, bottom: imageView.bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 8, paddingBottom: 0, paddingRight: 12, width: 0, height: 14)
        postDetail.anchor(top: nil, left: imageView.rightAnchor, bottom: timeLabel.topAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 8, paddingBottom: 8, paddingRight: 12, width: 0, height: 14)
        answersLabel.anchor(top: nil, left: leftAnchor, bottom: bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: answersLabel.intrinsicContentSize.width, height: 16)
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

