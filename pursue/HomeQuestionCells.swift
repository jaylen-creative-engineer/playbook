//
//  HomeQuestionCells.swift
//  Inpursuit
//
//  Created by Jaylen Sanders on 5/5/19.
//  Copyright © 2019 Glory. All rights reserved.
//

import UIKit

class HomeQuestionCells : UICollectionViewCell {
    
    let questionImageView : UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "cafe-768771_1280")?.withRenderingMode(.alwaysOriginal)
        iv.contentMode = .scaleAspectFill
        iv.layer.cornerRadius = 10
        iv.layer.masksToBounds = true
        return iv
    }()
    
    let questionLabel : UILabel = {
        let label = UILabel()
        label.text = "As a startup CEO, what is your favorite productivity hack?"
        label.font = UIFont.systemFont(ofSize: 15)
        label.textAlignment = .left
        label.numberOfLines = 2
        return label
    }()
    
    let forwardButton : UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "forward")?.withRenderingMode(.alwaysTemplate), for: .normal)
        button.imageView?.contentMode = .scaleAspectFill
        button.tintColor = UIColor.darkGray
        return button
    }()
    
    func setupView(){
        addSubview(questionImageView)
        addSubview(questionLabel)
        addSubview(forwardButton)
        
        questionImageView.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: 58, height: 58)
        questionLabel.anchor(top: nil, left: questionImageView.rightAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 12, paddingBottom: 0, paddingRight: 24, width: 0, height: 0)
        questionLabel.heightAnchor.constraint(lessThanOrEqualToConstant: 40).isActive = true
        questionLabel.centerYAnchor.constraint(equalTo: questionImageView.centerYAnchor).isActive = true
        forwardButton.anchor(top: nil, left: nil, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 18, width: 9, height: 14)
        forwardButton.centerYAnchor.constraint(equalTo: questionLabel.centerYAnchor).isActive = true
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
