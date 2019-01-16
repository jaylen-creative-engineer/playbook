//
//  CreateChallengeCell.swift
//  Inpursuit
//
//  Created by Jaylen Sanders on 1/15/19.
//  Copyright © 2019 Glory. All rights reserved.
//

import UIKit

class CreateChallengeCell : UICollectionViewCell {
    
    let photo : UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "cafe-768771_1280")?.withRenderingMode(.alwaysOriginal)
        iv.layer.masksToBounds = true
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    let userPhoto : UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "cafe-768771_1280")?.withRenderingMode(.alwaysOriginal)
        iv.contentMode = .scaleAspectFill
        iv.layer.cornerRadius = 15
        iv.layer.masksToBounds = true
        return iv
    }()
    
    let usernameLabel : UILabel = {
        let label = UILabel()
        label.text = "Test"
        label.font = UIFont.systemFont(ofSize: 13)
        return label
    }()
    
    let nameTimeStackView : UIStackView = {
        let sv = UIStackView()
        sv.axis = .horizontal
        sv.spacing = 8
        return sv
    }()
    
    let cellBottomBackground : StoryBottomRectangleView = {
        let view = StoryBottomRectangleView()
        view.backgroundColor = .white
        return view
    }()
    
    let cellTopBackground : StoryTopRectangleView = {
        let view = StoryTopRectangleView()
        view.backgroundColor = .white
        return view
    }()
    
    let detailLabel : UILabel = {
        let label = UILabel()
        label.text = "Have a vision to work towards"
        label.numberOfLines = 2
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    
    let timeLeftLabel : UILabel = {
        let label = UILabel()
        label.text = "3 Weeks Left"
        label.numberOfLines = 1
        label.font = UIFont.systemFont(ofSize: 13)
        return label
    }()
    
    let textStackView : UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.spacing = 10
        return sv
    }()
    
    let seperatorView : UIView = {
        let view = UIView()
        view.backgroundColor = .darkGray
        view.layer.cornerRadius = 2
        view.layer.masksToBounds = true
        return view
    }()
    
    let addButton : UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .black
        button.setImage(UIImage(named: "add"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFill
        return button
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        photo.roundCorners(corners: [.topLeft, .topRight], radius: 8.0)
    }
    
    func setupView(){
        addSubview(cellBottomBackground)
        addSubview(cellTopBackground)
        addSubview(photo)
        addSubview(userPhoto)
        addSubview(usernameLabel)
        addSubview(seperatorView)
        addSubview(timeLeftLabel)
        addSubview(detailLabel)
        addSubview(addButton)
        
        cellBottomBackground.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        cellTopBackground.anchor(top: cellBottomBackground.topAnchor, left: cellBottomBackground.leftAnchor, bottom: cellBottomBackground.bottomAnchor, right: cellBottomBackground.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        photo.roundCorners(corners: [.topLeft, .topRight], radius: 8.0)
        photo.anchor(top: cellTopBackground.topAnchor, left: cellTopBackground.leftAnchor, bottom: nil, right: cellTopBackground.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: (frame.height / 2) + 30)
        userPhoto.anchor(top: nil, left: cellTopBackground.leftAnchor, bottom: cellTopBackground.bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 18, paddingBottom: 18, paddingRight: 0, width: 30, height: 30)
        usernameLabel.anchor(top: nil, left: userPhoto.rightAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 10, paddingBottom: 0, paddingRight: 0, width: usernameLabel.intrinsicContentSize.width, height: 16)
        usernameLabel.centerYAnchor.constraint(equalTo: userPhoto.centerYAnchor).isActive = true
        seperatorView.centerYAnchor.constraint(equalTo: usernameLabel.centerYAnchor).isActive = true
        seperatorView.anchor(top: nil, left: usernameLabel.rightAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 4, paddingBottom: 0, paddingRight: 0, width: 4, height: 4)
        timeLeftLabel.anchor(top: nil, left: seperatorView.rightAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 4, paddingBottom: 0, paddingRight: 0, width: timeLeftLabel.intrinsicContentSize.width, height: 16)
        timeLeftLabel.centerYAnchor.constraint(equalTo: userPhoto.centerYAnchor).isActive = true
        detailLabel.anchor(top: photo.bottomAnchor, left: cellTopBackground.leftAnchor, bottom: userPhoto.topAnchor, right: cellTopBackground.rightAnchor, paddingTop: 8, paddingLeft: 18, paddingBottom: 18, paddingRight: 12, width: 0, height: 0)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
