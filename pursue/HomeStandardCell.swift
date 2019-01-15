//
//  HomeStandardCell.swift
//  Inpursuit
//
//  Created by Jaylen Sanders on 12/21/18.
//  Copyright © 2018 Glory. All rights reserved.
//

import UIKit
import iCarousel

class HomeStandardCell : UICollectionViewCell {
 
    let usernameLabel : UILabel = {
        let label = UILabel()
        label.text = "Test"
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()
    
    let userPhoto : UIImageView = {
       let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.layer.cornerRadius = 15
        iv.layer.masksToBounds = true
        iv.image = UIImage(named: "cafe-768771_1280")?.withRenderingMode(.alwaysOriginal)
        return iv
    }()
    
    let cellBackgroundView : HomeCellConflictShadowView = {
        let view = HomeCellConflictShadowView()
        view.backgroundColor = .white
        return view
    }()
    
    let detailLabel : UILabel = {
       let label = UILabel()
        label.text = "This is filler text"
        label.textColor = .white
        label.numberOfLines = 2
        label.font = UIFont.boldSystemFont(ofSize: 22)
        return label
    }()
    
    let pursuitImageView : UIImageView = {
       let iv = UIImageView()
        iv.image = UIImage(named: "cafe-768771_1280")?.withRenderingMode(.alwaysOriginal)
        iv.contentMode = .scaleAspectFill
        iv.layer.masksToBounds = true
        return iv
    }()
    
    let seperatorView : UIView = {
        let view = UIView()
        view.backgroundColor = .darkGray
        view.layer.cornerRadius = 2
        view.layer.masksToBounds = true
        return view
    }()
    
    let timeLeftLabel : UILabel = {
        let label = UILabel()
        label.text = "3 Weeks Left"
        label.numberOfLines = 1
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()
    
    let overlayView : UIView = {
       let view = UIView()
        return view
    }()
    
    func setupView(){
        addSubview(cellBackgroundView)
        addSubview(pursuitImageView)
        addSubview(userPhoto)
        addSubview(usernameLabel)
        addSubview(seperatorView)
        addSubview(timeLeftLabel)
        addSubview(overlayView)
        insertSubview(detailLabel, aboveSubview: overlayView)
        
        cellBackgroundView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 12, paddingBottom: 0, paddingRight: 12, width: 0, height: 0)
        pursuitImageView.anchor(top: cellBackgroundView.topAnchor, left: cellBackgroundView.leftAnchor, bottom: nil, right: cellBackgroundView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 580)
        userPhoto.anchor(top: nil, left: cellBackgroundView.leftAnchor, bottom: cellBackgroundView.bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 18, paddingBottom: 18, paddingRight: 0, width: 30, height: 30)
        usernameLabel.anchor(top: nil, left: userPhoto.rightAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 10, paddingBottom: 0, paddingRight: 0, width: usernameLabel.intrinsicContentSize.width, height: 16)
        usernameLabel.centerYAnchor.constraint(equalTo: userPhoto.centerYAnchor).isActive = true
        seperatorView.centerYAnchor.constraint(equalTo: usernameLabel.centerYAnchor).isActive = true
        seperatorView.anchor(top: nil, left: usernameLabel.rightAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 4, paddingBottom: 0, paddingRight: 0, width: 4, height: 4)
        timeLeftLabel.anchor(top: nil, left: seperatorView.rightAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 4, paddingBottom: 0, paddingRight: 0, width: timeLeftLabel.intrinsicContentSize.width, height: 16)
        timeLeftLabel.centerYAnchor.constraint(equalTo: userPhoto.centerYAnchor).isActive = true
        overlayView.anchor(top: nil, left: pursuitImageView.leftAnchor, bottom: pursuitImageView.bottomAnchor, right: pursuitImageView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 150)
        detailLabel.anchor(top: nil, left: overlayView.leftAnchor, bottom: overlayView.bottomAnchor, right: overlayView.rightAnchor, paddingTop: 0, paddingLeft: 18, paddingBottom: 28, paddingRight: 12, width: 0, height: 0)
        detailLabel.heightAnchor.constraint(lessThanOrEqualToConstant: 44).isActive = true
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        pursuitImageView.roundCorners(corners: [.topLeft, .topRight], radius: 10)
        overlayView.applyGradient(colours: [.clear, UIColor.init(white: 0.16, alpha: 0.92)], locations: [0.1, 0.8])
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
