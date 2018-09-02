//
//  StoryCell.swift
//  pursue
//
//  Created by Jaylen Sanders on 9/2/18.
//  Copyright © 2018 Glory. All rights reserved.
//

import UIKit

class StoryCell : UICollectionViewCell {
    
    let backgroundShadow : StoryRectangleView = {
       let view = StoryRectangleView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let topShadow : StoryTopRectangleView = {
       let view = StoryTopRectangleView()
        view.translatesAutoresizingMaskIntoConstraints = false
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
        addSubview(backgroundShadow)
        addSubview(topShadow)
        addSubview(postRectangle)
        postRectangle.addSubview(imageView)
        postRectangle.addSubview(postType)
        postRectangle.addSubview(postDetail)
        postRectangle.addSubview(timeLabel)
        
        backgroundShadow.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        topShadow.anchor(top: backgroundShadow.topAnchor, left: backgroundShadow.leftAnchor, bottom: backgroundShadow.bottomAnchor, right: backgroundShadow.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        postRectangle.anchor(top: topShadow.topAnchor, left: topShadow.leftAnchor, bottom: topShadow.bottomAnchor, right: topShadow.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        imageView.anchor(top: postRectangle.topAnchor, left: postRectangle.leftAnchor, bottom: postRectangle.bottomAnchor, right: nil, paddingTop: 8, paddingLeft: 8, paddingBottom: 8, paddingRight: 0, width: 130, height: 0)
        postType.anchor(top: imageView.centerYAnchor, left: imageView.rightAnchor, bottom: nil, right: rightAnchor, paddingTop: 24, paddingLeft: 12, paddingBottom: 0, paddingRight: 12, width: 0, height: 14)
        postDetail.anchor(top: postType.bottomAnchor, left: postType.leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 8, paddingLeft: 0, paddingBottom: 0, paddingRight: 12, width: 0, height: 14)
        timeLabel.anchor(top: nil, left: postDetail.leftAnchor, bottom: imageView.bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 12, width: 0, height: 14)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
