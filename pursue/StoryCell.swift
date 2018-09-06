//
//  StoryCell.swift
//  pursue
//
//  Created by Jaylen Sanders on 9/2/18.
//  Copyright © 2018 Glory. All rights reserved.
//

import UIKit
import Hero
import Motion

class StoryCell : UICollectionViewCell  {
    
    let backgroundShadow : StoryRectangleView = {
       let view = StoryRectangleView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    
    let topShadow : StoryTopRectangleView = {
       let view = StoryTopRectangleView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    
    let postRectangle : UIButton = {
       let button = UIButton()
        button.layer.cornerRadius = 8
        button.layer.masksToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .white
        return button
    }()
    
    let imageView : UIImageView = {
       let iv = UIImageView()
        iv.backgroundColor = .blue
        iv.layer.cornerRadius = 4
        iv.clipsToBounds = true
        iv.image = #imageLiteral(resourceName: "ferrari").withRenderingMode(.alwaysOriginal)
        iv.contentMode = .scaleAspectFill        
        return iv
    }()
    
    let postType : UILabel = {
       let label = UILabel()
        label.text = "Principle"
        label.font = UIFont(name: "Lato-Bold", size: 12)
        return label
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
    
    func setupView(){
        addSubview(imageView)
        addSubview(postType)
        addSubview(postDetail)
        addSubview(timeLabel)
        
        imageView.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 245)
        postType.anchor(top: imageView.bottomAnchor, left: imageView.leftAnchor, bottom: nil, right: imageView.rightAnchor, paddingTop: 12, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 14)
        postDetail.anchor(top: postType.bottomAnchor, left: postType.leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 8, paddingLeft: 0, paddingBottom: 0, paddingRight: 12, width: 0, height: 14)
        timeLabel.anchor(top: postDetail.bottomAnchor, left: postDetail.leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 8, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 14)
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
