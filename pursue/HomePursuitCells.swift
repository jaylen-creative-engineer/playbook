//
//  HomePursuitCells.swift
//  Inpursuit
//
//  Created by Jaylen Sanders on 5/5/19.
//  Copyright © 2019 Glory. All rights reserved.
//

import UIKit

class HomePursuitCells : UICollectionViewCell {
    
    let pursuitImage : UIImageView = {
       let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.layer.cornerRadius = 15
        iv.layer.masksToBounds = true
        iv.image = UIImage(named: "cafe-768771_1280")?.withRenderingMode(.alwaysOriginal)
        return iv
    }()
    
    let textBackground : HomeCellConflictShadowView = {
       let view = HomeCellConflictShadowView()
        view.backgroundColor = .white
//        view.layer.masksToBounds = true
        return view
    }()
    
    let pursuitTitle : UILabel = {
        let label = UILabel()
        label.text = "Schedule your day"
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textAlignment = .left
        return label
    }()
    
    let pursuitSubTitle : UILabel = {
        let label = UILabel()
        label.text = "Set mini goals and milestones throughout the day"
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor.rgb(red: 139, green: 144, blue: 163)
        label.numberOfLines = 2
        label.textAlignment = .left
        return label
    }()
    
    let engagementCountLabel : UILabel = {
        let label = UILabel()
        label.text = "17k"
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = UIColor.rgb(red: 197, green: 199, blue: 209)
        label.textAlignment = .center
        return label
    }()
    
    let engagementLabel : UILabel = {
        let label = UILabel()
        label.text = "likes"
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor.rgb(red: 197, green: 199, blue: 209)
        label.textAlignment = .center
        return label
    }()
    
    let tryButton : UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .clear
        button.tintColor = .clear
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.borderWidth = 0.5
        button.layer.cornerRadius = 14
        button.layer.masksToBounds = true
        button.setTitle("TRY", for: .normal)
        button.setTitleColor(UIColor.rgb(red: 255, green: 255, blue: 255), for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 12)
        return button
    }()

    let forwardArrow : UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "forward-arrow")?.withRenderingMode(.alwaysOriginal), for: .normal)
        button.imageView?.contentMode = .scaleAspectFill
        button.tintColor = .white
        return button
    }()
    
    let saveButton : UIButton = {
       let button = UIButton(type: .system)
        button.tintColor = .white
        button.contentMode = .scaleAspectFill
        button.setImage(UIImage(named: "bookmark_outline")?.withRenderingMode(.alwaysTemplate), for: .normal)
        return button
    }()

    func setupEngagements(){
        addSubview(tryButton)
        addSubview(saveButton)
//        tryButton.addSubview(forwardArrow)
        
        tryButton.anchor(top: nil, left: nil, bottom: textBackground.topAnchor, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 18, paddingRight: 0, width: 75, height: 28)
        tryButton.centerXAnchor.constraint(equalTo: textBackground.centerXAnchor).isActive = true
        saveButton.anchor(top: pursuitImage.topAnchor, left: nil, bottom: nil, right: pursuitImage.rightAnchor, paddingTop: 12, paddingLeft: 0, paddingBottom: 0, paddingRight: 12, width: 17, height: 22)
//        forwardArrow.anchor(top: nil, left: tryButton.titleLabel?.rightAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 4, paddingBottom: 0, paddingRight: 6, width: 0, height: 14)
//        forwardArrow.centerYAnchor.constraint(equalTo: tryButton.centerYAnchor).isActive = true
    }
    
    func setupView(){
        addSubview(pursuitImage)
        addSubview(textBackground)
        textBackground.addSubview(pursuitTitle)
        textBackground.addSubview(engagementCountLabel)
        textBackground.addSubview(engagementLabel)
        textBackground.addSubview(pursuitSubTitle)
        
        pursuitImage.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 238)
        textBackground.anchor(top: nil, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 18, paddingBottom: 0, paddingRight: 18, width: 0, height: 107)
        textBackground.centerYAnchor.constraint(equalTo: pursuitImage.bottomAnchor).isActive = true
        pursuitTitle.anchor(top: textBackground.topAnchor, left: textBackground.leftAnchor, bottom: nil, right: textBackground.rightAnchor, paddingTop: 18, paddingLeft: 12, paddingBottom: 0, paddingRight: 12, width: 0, height: 22)
        engagementCountLabel.anchor(top: pursuitTitle.bottomAnchor, left: nil, bottom: nil, right: textBackground.rightAnchor, paddingTop: 12, paddingLeft: 0, paddingBottom: 0, paddingRight: 24, width: engagementCountLabel.intrinsicContentSize.width, height: 18)
        engagementLabel.anchor(top: engagementCountLabel.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 2, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: engagementLabel.intrinsicContentSize.width, height: 16)
        engagementLabel.centerXAnchor.constraint(equalTo: engagementCountLabel.centerXAnchor).isActive = true
        pursuitSubTitle.anchor(top: pursuitTitle.bottomAnchor, left: textBackground.leftAnchor, bottom: nil, right: engagementCountLabel.leftAnchor, paddingTop: 12, paddingLeft: 12, paddingBottom: 0, paddingRight: 18, width: 0, height: 0)
        pursuitSubTitle.heightAnchor.constraint(lessThanOrEqualToConstant: 50).isActive = true
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupEngagements()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
