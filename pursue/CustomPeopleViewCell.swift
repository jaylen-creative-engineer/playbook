//
//  CustomPeopleViewCell.swift
//  pursue
//
//  Created by Jaylen Sanders on 3/12/18.
//  Copyright © 2018 Glory. All rights reserved.
//

import UIKit

class CustomPeopleViewCell : UICollectionViewCell {
        
    lazy var pursuitLabel : UILabel = {
        let label = UILabel()
        label.text = "Pursuit Label"
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var profileImageView : UIImageView = {
        let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "samuel-l").withRenderingMode(.alwaysOriginal)
        iv.contentMode = .scaleAspectFill
        iv.layer.cornerRadius = 30
        iv.layer.masksToBounds = true
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    func setupView(){
        addSubview(profileImageView)
        addSubview(pursuitLabel)
        profileImageView.anchor(top: topAnchor, left: nil, bottom: nil, right: nil, paddingTop: 4, paddingLeft: 0, paddingBottom: 18, paddingRight: 0, width: 60, height: 60)
        profileImageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        pursuitLabel.anchor(top: profileImageView.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 8, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: pursuitLabel.intrinsicContentSize.width, height: pursuitLabel.intrinsicContentSize.height)
        pursuitLabel.centerXAnchor.constraint(equalTo: profileImageView.centerXAnchor).isActive = true
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
