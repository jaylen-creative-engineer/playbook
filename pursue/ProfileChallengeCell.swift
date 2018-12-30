//
//  ProfileChallengeCell.swift
//  Inpursuit
//
//  Created by Jaylen Sanders on 12/29/18.
//  Copyright © 2018 Glory. All rights reserved.
//

import UIKit

class ProfileChallengeCell : UICollectionViewCell {
    
    let photo : UIImageView = {
        let iv = UIImageView()
        iv.layer.cornerRadius = 4
        iv.layer.masksToBounds = true
        iv.contentMode = .scaleAspectFill
        return iv
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
        label.numberOfLines = 1
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 13)
        return label
    }()
    
    let timeLeftLabel : UILabel = {
        let label = UILabel()
        label.text = "3 Weeks Left"
        label.numberOfLines = 1
        label.font = UIFont.boldSystemFont(ofSize: 15)
        return label
    }()
    
    let textStackView : UIStackView = {
       let sv = UIStackView()
        sv.axis = .vertical
        sv.spacing = 10
        return sv
    }()
    
    let downArrow : UIButton = {
       let button = UIButton(type: .system)
        return button
    }()
    
    let downArrowImage : UIImageView = {
       let iv = UIImageView()
        iv.image = UIImage(named: "down_arrow")?.withRenderingMode(.alwaysOriginal)
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    func setupView(){
        addSubview(cellBottomBackground)
        addSubview(cellTopBackground)
        cellTopBackground.addSubview(photo)
        cellTopBackground.addSubview(textStackView)
        
        textStackView.addArrangedSubview(detailLabel)
        textStackView.addArrangedSubview(timeLeftLabel)
//        addSubview(downArrow)
//        addSubview(downArrowImage)
        
        cellBottomBackground.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 12, paddingBottom: 0, paddingRight: 12, width: 0, height: 0)
        cellTopBackground.anchor(top: cellBottomBackground.topAnchor, left: cellBottomBackground.leftAnchor, bottom: cellBottomBackground.bottomAnchor, right: cellBottomBackground.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        photo.anchor(top: nil, left: cellTopBackground.leftAnchor, bottom: nil, right: nil, paddingTop: 8, paddingLeft: 18, paddingBottom: 0, paddingRight: 0, width: 60, height: 60)
        photo.centerYAnchor.constraint(equalTo: cellTopBackground.centerYAnchor).isActive = true
        textStackView.anchor(top: nil, left: photo.rightAnchor, bottom: nil, right: cellTopBackground.rightAnchor, paddingTop: 0, paddingLeft: 18, paddingBottom: 0, paddingRight: 12, width: 0, height: 0)
        textStackView.centerYAnchor.constraint(equalTo: cellTopBackground.centerYAnchor).isActive = true
//        downArrow.anchor(top: nil, left: nil, bottom: nil, right: cellTopBackground.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 12, width: 30, height: 30)
//        downArrow.centerYAnchor.constraint(equalTo: textStackView.centerYAnchor).isActive = true
//        downArrowImage.anchor(top: nil, left: nil, bottom: nil, right: downArrow.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 8, width: 12, height: 10)
//        downArrowImage.centerYAnchor.constraint(equalTo: downArrow.centerYAnchor).isActive = true
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
