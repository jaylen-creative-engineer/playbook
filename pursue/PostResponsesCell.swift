//
//  PostCommentsCell.swift
//  pursue
//
//  Created by Jaylen Sanders on 10/16/17.
//  Copyright © 2017 Glory. All rights reserved.
//

import UIKit

protocol PostResponseDelegate {
    func handleAccept(for cell : PostResponsesCell)
}

class PostResponsesCell : UICollectionViewCell {

    var delegate : PostResponseDelegate?
    
    let photo : UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.layer.cornerRadius = 4
        iv.layer.masksToBounds = true
        return iv
    }()
    
    let solutionLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.text = "Hold your breath for four, release for four and breath in for four"
        label.numberOfLines = 2
        return label
    }()
    
    let usernameLabel : UILabel = {
        let label = UILabel()
        label.text = "Test"
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()
    
    lazy var acceptLabel : UIButton = {
        let button = UIButton()
        button.setTitle("Add To Pursuit", for: .normal)
        button.setTitleColor(.green, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 12)
        button.addTarget(self, action: #selector(handleAccept), for: .touchUpInside)
        return button
    }()
    
    @objc func handleAccept(){
        delegate?.handleAccept(for: self)
    }
    
    func setupView(){
        addSubview(photo)
        addSubview(solutionLabel)
        addSubview(usernameLabel)
        addSubview(acceptLabel)
        
        photo.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 8, paddingBottom: 8, paddingRight: 0, width: 110, height: 120)
        solutionLabel.anchor(top: photo.topAnchor, left: photo.rightAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 12, paddingBottom: 0, paddingRight: 12, width: 0, height: (solutionLabel.intrinsicContentSize.height * 2) + 5)
        usernameLabel.anchor(top: solutionLabel.bottomAnchor, left: solutionLabel.leftAnchor, bottom: nil, right: nil, paddingTop: 8, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: usernameLabel.intrinsicContentSize.width, height: usernameLabel.intrinsicContentSize.height)
        acceptLabel.anchor(top: nil, left: usernameLabel.leftAnchor, bottom: photo.bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: acceptLabel.intrinsicContentSize.width, height: acceptLabel.intrinsicContentSize.height)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
