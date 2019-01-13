//
//  RolloverAnswerCell.swift
//  Inpursuit
//
//  Created by Jaylen Sanders on 1/12/19.
//  Copyright © 2019 Glory. All rights reserved.
//

import UIKit

class RolloverAnswerCell : UICollectionViewCell {
    
    let answerLabel : UILabel = {
       let label = UILabel()
        label.text = "This is filler text"
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textAlignment = .justified
        label.textColor = .white
        return label
    }()
    
    let upVotesLabel : UILabel = {
       let label = UILabel()
        label.text = "3 Upvotes"
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 14)
        return label
    }()
    
    let usernameLabel : UILabel = {
       let label = UILabel()
        label.text = "Test"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    let acceptButton : UIButton = {
       let button = UIButton(type: .system)
        button.layer.cornerRadius = 4
        button.layer.masksToBounds = true
        button.backgroundColor = .white
        button.setTitle("Accept", for: .normal)
        button.contentHorizontalAlignment = .center
        button.contentVerticalAlignment = .center
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12, weight: UIFont.Weight.init(25))
        return button
    }()
    
    let answerImageView : UIImageView = {
       let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.layer.cornerRadius = 8
        iv.layer.masksToBounds = true
        iv.image = UIImage(named : "apartment-architecture-ceiling-259962")?.withRenderingMode(.alwaysOriginal)
        return iv
    }()
    
    let cellBackgroundView : StoryBottomRectangleView = {
       let view = StoryBottomRectangleView()
        view.backgroundColor = .white
        return view
    }()
    
    let detailsStackView : UIStackView = {
       let sv = UIStackView()
        sv.axis = .horizontal
        sv.distribution = .fillEqually
        sv.spacing = 5
        return sv
    }()
    
    let overlayView : UIView = {
       let view = UIView()
        view.layer.cornerRadius = 8
        view.layer.masksToBounds = true
        view.backgroundColor = UIColor.init(white: 0.4, alpha: 0.4)
        return view
    }()
    
    func setupView(){
        addSubview(cellBackgroundView)
        addSubview(answerImageView)
        addSubview(overlayView)
        addSubview(acceptButton)
        addSubview(upVotesLabel)
        addSubview(answerLabel)
        
        
        cellBackgroundView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        answerImageView.anchor(top: cellBackgroundView.topAnchor, left: cellBackgroundView.leftAnchor, bottom: cellBackgroundView.bottomAnchor, right: cellBackgroundView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        overlayView.anchor(top: answerImageView.topAnchor, left: answerImageView.leftAnchor, bottom: answerImageView.bottomAnchor, right: answerImageView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        acceptButton.anchor(top: overlayView.topAnchor, left: overlayView.leftAnchor, bottom: nil, right: nil, paddingTop: 12, paddingLeft: 18, paddingBottom: 0, paddingRight: 0, width: acceptButton.intrinsicContentSize.width + 15, height: 24)
        upVotesLabel.anchor(top: nil, left: overlayView.leftAnchor, bottom: overlayView.bottomAnchor, right: overlayView.rightAnchor, paddingTop: 0, paddingLeft: 18, paddingBottom: 18, paddingRight: 8, width: upVotesLabel.intrinsicContentSize.width, height: 16)
        answerLabel.anchor(top: nil, left: overlayView.leftAnchor, bottom: upVotesLabel.topAnchor, right: overlayView.rightAnchor, paddingTop: 0, paddingLeft: 18, paddingBottom: 8, paddingRight: 12, width: 0, height: 0)
        answerLabel.heightAnchor.constraint(lessThanOrEqualToConstant: 44).isActive = true
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
