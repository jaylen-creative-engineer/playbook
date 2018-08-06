//
//  PursuitDayTableViewCell.swift
//  pursue
//
//  Created by Jayesh on 06/08/18.
//  Copyright © 2018 Glory. All rights reserved.
//

import UIKit

class PursuitDayTableViewCell: UITableViewCell {

    
    
    let incompleteCircle : UIView = {
        let view = UIView()
        view.backgroundColor = .blue
        view.layer.cornerRadius = 3
        view.layer.masksToBounds = true
        return view
    }()
    
    let photo : UIImageView = {
        let iv = UIImageView()
        iv.layer.cornerRadius = 8
        iv.layer.masksToBounds = true
        iv.clipsToBounds = true
//        iv.image =
        iv.contentMode = .scaleToFill
        return iv
    }()
    
    let postLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Lato-Semibold", size: 12)
        label.text = "Working at this thing here."
        return label
    }()
    
    let postTypeLabel : UILabel = {
        let label = UILabel()
        label.text = "Principle"
        label.textColor = .gray
        label.font = UIFont(name: "Lato-Bold", size: 12)
        return label
    }()
    
    let images = ["788572ee949285fae33dca5d846a4664", "clean-2", "academics", "fashion-design", "690dae66bfe860df34fc7a756b53c15d"]
    
    func setupView(index : Int){
        self.selectionStyle = .none
        contentView.addSubview(incompleteCircle)
        contentView.addSubview(photo)
        contentView.addSubview(postLabel)
        contentView.addSubview(postTypeLabel)
        photo.image = UIImage(named: images[index])
        incompleteCircle.anchor(top: nil, left: leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 12, paddingBottom: 10, paddingRight: 0, width: 6, height: 6)
        incompleteCircle.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        photo.anchor(top: topAnchor, left: incompleteCircle.rightAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: 90, height: 100)
        postLabel.anchor(top: photo.topAnchor, left: photo.rightAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 8, paddingBottom: 0, paddingRight: 0, width: 0, height: 14)
        postTypeLabel.anchor(top: postLabel.bottomAnchor, left: postLabel.leftAnchor, bottom: nil, right: nil, paddingTop: 8, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: postTypeLabel.intrinsicContentSize.width, height: 14)
        
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
//        setupView()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
