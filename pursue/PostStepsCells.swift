//
//  PostStepsCells.swift
//  pursue
//
//  Created by Jaylen Sanders on 10/20/17.
//  Copyright © 2017 Glory. All rights reserved.
//

import UIKit

class PostStepsCells : UICollectionViewCell {
    
    let skillLabel : UILabel = {
        let label = UILabel()
        label.text = "Work Hard Right Now"
        label.font = UIFont.systemFont(ofSize: 18, weight: UIFont.Weight(rawValue: 25))
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let selectSkill : UIButton = {
        let iv = UIButton()
        iv.layer.cornerRadius = 15
        iv.layer.borderWidth = 3
        iv.contentMode = .scaleAspectFill
        iv.layer.borderColor = UIColor.gray.cgColor
        iv.clipsToBounds = true
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
        
    }()
    
    func setupView(){
        addSubview(selectSkill)
        addSubview(skillLabel)
        
        selectSkill.anchor(top: nil, left: leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: 30, height: 30)
        selectSkill.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        skillLabel.anchor(top: nil, left: selectSkill.rightAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 12, paddingBottom: 0, paddingRight: 12, width: 0, height: 0)
        skillLabel.centerYAnchor.constraint(equalTo: selectSkill.centerYAnchor).isActive = true
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
