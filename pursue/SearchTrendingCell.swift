//
//  SearchTrendingCell.swift
//  pursue
//
//  Created by Jaylen Sanders on 7/8/18.
//  Copyright © 2018 Glory. All rights reserved.
//

import UIKit


class SearchTrendingCell : UICollectionViewCell {
    
    let photo : UIImageView = {
        let iv = UIImageView()
        iv.layer.cornerRadius = 8
        iv.layer.masksToBounds = true
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    let detailLabel : UILabel = {
        let label = UILabel()
        label.text = "Have a vision to work towards"
        label.font = UIFont(name: "Lato-Semibold", size: 12)
        return label
    }()
    
    let usernameLabel : UILabel = {
        let label = UILabel()
        label.text = "Test"
        label.font = UIFont.systemFont(ofSize: 10)
        return label
    }()
    
    let daysLabel : UILabel = {
        let label = UILabel()
        label.text = "2 Days"
        label.font = UIFont.systemFont(ofSize: 10)
        return label
    }()
    
    let saveButtonBackground : GroupChatView = {
        let gcv = GroupChatView()
        gcv.translatesAutoresizingMaskIntoConstraints = false
        gcv.backgroundColor = .white
        return gcv
    }()
    
    let saveButton : UIButton = {
        let button = UIButton()
        button.setTitle("Save", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont(name: "Lato-Bold", size: 12)
        button.titleLabel?.textAlignment = .center
        return button
    }()
    
    let userPhoto : UIImageView = {
        let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "samuel-l").withRenderingMode(.alwaysOriginal)
        iv.contentMode = .scaleAspectFill
        iv.layer.cornerRadius = 20
        iv.layer.masksToBounds = true
        return iv
    }()
    
    let postTypeLabel : UILabel = {
        let label = UILabel()
        label.text = "Principle"
        label.font = UIFont(name: "Lato-Bold", size: 12)
        return label
    }()
    
    let playBackground : GroupChatView = {
        let view = GroupChatView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    
    let playIcon : UIImageView = {
        let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "view-more").withRenderingMode(.alwaysOriginal)
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    let circleView : UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.layer.cornerRadius = 2
        return view
    }()
    
    func setupView(){
        addSubview(photo)
        addSubview(detailLabel)
        addSubview(postTypeLabel)
        addSubview(usernameLabel)
        addSubview(circleView)
        addSubview(daysLabel)
        addSubview(userPhoto)
        addSubview(playBackground)
        addSubview(playIcon)
        addSubview(saveButtonBackground)
        addSubview(saveButton)
        
        photo.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 210, height: 230)
        userPhoto.anchor(top: photo.bottomAnchor, left: photo.leftAnchor, bottom: nil, right: nil, paddingTop: 12, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 40, height: 40)
        postTypeLabel.anchor(top: userPhoto.topAnchor, left: userPhoto.rightAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 8, paddingBottom: 0, paddingRight: 0, width: postTypeLabel.intrinsicContentSize.width, height: 14)
        detailLabel.anchor(top: postTypeLabel.bottomAnchor, left: postTypeLabel.leftAnchor, bottom: nil, right: photo.rightAnchor, paddingTop: 4, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 14)
        usernameLabel.anchor(top: detailLabel.bottomAnchor, left: detailLabel.leftAnchor, bottom: nil, right: nil, paddingTop: 6, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: usernameLabel.intrinsicContentSize.width, height: usernameLabel.intrinsicContentSize.height)
        circleView.anchor(top: nil, left: usernameLabel.rightAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 8, paddingBottom: 0, paddingRight: 0, width: 4, height: 4)
        circleView.centerYAnchor.constraint(equalTo: usernameLabel.centerYAnchor).isActive = true
        daysLabel.anchor(top: usernameLabel.topAnchor, left: circleView.rightAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 8, paddingBottom: 0, paddingRight: 0, width: daysLabel.intrinsicContentSize.width, height: daysLabel.intrinsicContentSize.height)
        playBackground.anchor(top: nil, left: nil, bottom: photo.bottomAnchor, right: photo.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 8, paddingRight: 8, width: 24, height: 24)
        playIcon.anchor(top: nil, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 10, height: 10)
        playIcon.centerXAnchor.constraint(equalTo: playBackground.centerXAnchor).isActive = true
        playIcon.centerYAnchor.constraint(equalTo: playBackground.centerYAnchor).isActive = true
        saveButtonBackground.anchor(top: photo.topAnchor, left: nil, bottom: nil, right: photo.rightAnchor, paddingTop: 8, paddingLeft: 0, paddingBottom: 0, paddingRight: 8, width: 70, height: 25)
        saveButton.anchor(top: saveButtonBackground.topAnchor, left: saveButtonBackground.leftAnchor, bottom: saveButtonBackground.bottomAnchor, right: saveButtonBackground.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
