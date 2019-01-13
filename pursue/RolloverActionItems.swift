//
//  RolloverActionItems.swift
//  Inpursuit
//
//  Created by Jaylen Sanders on 1/12/19.
//  Copyright © 2019 Glory. All rights reserved.
//

import UIKit

class RolloverActionItems : UICollectionViewCell {
    
    lazy var checkBox : UIButton = {
       let button = UIButton(type: .system)
        button.tintColor = .black
        button.layer.cornerRadius = 12
        button.layer.masksToBounds = true
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.borderWidth = 1.75
        return button
    }()
    
    let numberLabel : UILabel = {
        let label = UILabel()
        label.text = "1"
        label.font = UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.init(25))
        return label
    }()
    
    let stepLabel : UILabel = {
       let label = UILabel()
        label.text = "This is filler text"
        label.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.init(25))
        return label
    }()
    
    let timeAgoLabel : UILabel = {
       let label = UILabel()
        label.text = "3 Days Ago"
        label.textColor = .gray
        label.font = UIFont.boldSystemFont(ofSize: 14)
        return label
    }()
    
    let isCompleteLabel : UILabel = {
       let label = UILabel()
        label.text = "Not Complete"
        label.textColor = UIColor.gray
        label.font = UIFont.boldSystemFont(ofSize: 14)
        return label
    }()
    
    let stepImage : UIImageView = {
       let iv = UIImageView()
        iv.image = UIImage(named : "max-andrey-716124-unsplash")?.withRenderingMode(.alwaysOriginal)
        iv.layer.cornerRadius = 8
        iv.layer.masksToBounds = true
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    let detailStackView : UIStackView = {
       let sv = UIStackView()
        sv.distribution = .fillProportionally
        sv.spacing = 4
        sv.axis = .vertical
        return sv
    }()
    
    func setupView(){
        addSubview(checkBox)
        addSubview(stepImage)
        addSubview(detailStackView)
        detailStackView.addArrangedSubview(stepLabel)
        detailStackView.addArrangedSubview(isCompleteLabel)
        detailStackView.addArrangedSubview(timeAgoLabel)
        
       checkBox.anchor(top: nil, left: leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 28, paddingBottom: 0, paddingRight: 0, width: 24, height: 24)
        checkBox.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        stepImage.anchor(top: topAnchor, left: nil, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 28, width: 70, height: 0)
        detailStackView.anchor(top: topAnchor, left: checkBox.rightAnchor, bottom: bottomAnchor, right: stepImage.leftAnchor, paddingTop: 0, paddingLeft: 24, paddingBottom: 0, paddingRight: 8, width: 0, height: 0)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
