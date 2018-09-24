//
//  DetailChallengeCells.swift
//  pursue
//
//  Created by Jaylen Sanders on 6/25/18.
//  Copyright © 2018 Glory. All rights reserved.
//

import UIKit

class DetailChallengeCells : UICollectionViewCell  {
    
    let postDetail : UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.text = "Working on this."
        return label
    }()
    
    let timeLabel : UILabel = {
        let label = UILabel()
        label.text = "1h ago"
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()
    
    let rectangleBackground : HomeCellRectangleView = {
       let view = HomeCellRectangleView()
        view.backgroundColor = .white
        return view
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
    
    lazy var responsesButton : UIButton = {
       let button = UIButton()
        button.setTitle("6 Responses", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 12)
        return button
    }()
    
    lazy var addedButton : UIButton = {
        let button = UIButton()
        button.setTitle("3 Accepted", for: .normal)
        button.setTitleColor(UIColor.rgb(red: 65, green: 117, blue: 5), for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 12)
        return button
    }()
    
    lazy var downArrow : UIButton = {
       let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "expand_arrow1600").withRenderingMode(.alwaysOriginal), for: .normal)
        button.imageView?.contentMode = .scaleAspectFill
        return button
    }()
    
    func setupView(){
        addSubview(rectangleBackground)
        addSubview(imageView)
        addSubview(postDetail)
        addSubview(timeLabel)
        addSubview(responsesButton)
        addSubview(addedButton)
        addSubview(downArrow)
        
        rectangleBackground.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        imageView.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 8, paddingLeft: 8, paddingBottom: 0, paddingRight: 0, width: 82, height: 95)
        postDetail.anchor(top: imageView.topAnchor, left: imageView.rightAnchor, bottom: nil, right: rectangleBackground.rightAnchor, paddingTop: 0, paddingLeft: 12, paddingBottom: 0, paddingRight: 12, width: 0, height: 0)
        postDetail.heightAnchor.constraint(lessThanOrEqualToConstant: 40).isActive = true
        timeLabel.anchor(top: postDetail.bottomAnchor, left: postDetail.leftAnchor, bottom: nil, right: rectangleBackground.rightAnchor, paddingTop: 12, paddingLeft: 0, paddingBottom: 0, paddingRight: 12, width: 0, height: 14)
        responsesButton.anchor(top: nil, left: imageView.leftAnchor, bottom: rectangleBackground.bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 12, paddingRight: 48, width: responsesButton.intrinsicContentSize.width, height: 14)
        addedButton.anchor(top: responsesButton.topAnchor, left: responsesButton.rightAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 24, paddingBottom: 0, paddingRight: 0, width: addedButton.intrinsicContentSize.width, height: 14)
//        downArrow.anchor(top: nil, left: nil, bottom: rectangleBackground.bottomAnchor, right: rectangleBackground.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 12, paddingRight: 12, width: 19, height: 15)
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
