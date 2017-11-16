//
//  ProfilePursuitsCells.swift
//  pursue
//
//  Created by Jaylen Sanders on 10/26/17.
//  Copyright © 2017 Glory. All rights reserved.
//

import UIKit

class ProfilePursuitsCells : UICollectionViewCell {
    
    let pursuitButton : UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor.init(white: 0.4, alpha: 0.05)
        return button
    }()
    
    let pursuitLabel : UILabel = {
        let label = UILabel()
        label.text = "Battle"
        label.numberOfLines = 2
        label.font = UIFont.systemFont(ofSize: 20, weight: UIFont.Weight(rawValue: 25))
        return label
    }()
    
    let pursuitDetailLabel : UILabel = {
        let label = UILabel()
        label.text = "My effort is different from yours"
        label.numberOfLines = 2
        label.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.thin)
        return label
    }()
    
    let pursuitImage : UIImageView = {
        let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "backpack")
        iv.contentMode = .scaleAspectFill
        iv.layer.cornerRadius = 6
        iv.layer.masksToBounds = true
        return iv
    }()
    
    func setupCardDetails(){
        addSubview(pursuitLabel)
        addSubview(pursuitDetailLabel)
        pursuitLabel.anchor(top: pursuitImage.bottomAnchor, left: pursuitImage.leftAnchor, bottom: nil, right: pursuitImage.rightAnchor, paddingTop: 16, paddingLeft: 0, paddingBottom: 0, paddingRight: 8, width: 0, height: 14)
        pursuitDetailLabel.anchor(top: pursuitLabel.bottomAnchor, left: pursuitLabel.leftAnchor, bottom: nil, right: nil, paddingTop: 8, paddingLeft: 0, paddingBottom: 0, paddingRight: 12, width: pursuitDetailLabel.intrinsicContentSize.width, height: pursuitDetailLabel.intrinsicContentSize.height + 2)
    }
    
    func setupView(){
        addSubview(pursuitButton)
        pursuitButton.addSubview(pursuitImage)
        
        pursuitButton.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 185)
        pursuitImage.anchor(top: pursuitButton.topAnchor, left: pursuitButton.leftAnchor, bottom: pursuitButton.bottomAnchor, right: pursuitButton.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupCardDetails()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
