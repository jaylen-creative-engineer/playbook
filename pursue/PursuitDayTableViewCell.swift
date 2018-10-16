//
//  PursuitDayTableViewCell.swift
//  pursue
//
//  Created by Jayesh on 06/08/18.
//  Copyright © 2018 Glory. All rights reserved.
//

import UIKit

class PursuitDayTableViewCell: UICollectionViewCell {
    
    let photo : UIImageView = {
        let iv = UIImageView()
        iv.layer.cornerRadius = 4
        iv.layer.masksToBounds = true
        iv.clipsToBounds = true
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    let dayLabel : UILabel = {
       let label = UILabel()
        label.text = "Days"
        label.font = UIFont.boldSystemFont(ofSize: 14)
        return label
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
    
//    let images = ["788572ee949285fae33dca5d846a4664", "clean-2", "academics", "fashion-design", "690dae66bfe860df34fc7a756b53c15d", "690dae66bfe860df34fc7a756b53c15d", "690dae66bfe860df34fc7a756b53c15d", "690dae66bfe860df34fc7a756b53c15d", "690dae66bfe860df34fc7a756b53c15d", "690dae66bfe860df34fc7a756b53c15d", "690dae66bfe860df34fc7a756b53c15d", "690dae66bfe860df34fc7a756b53c15d"]
    
    var images = [#imageLiteral(resourceName: "app-screenshot-1"), #imageLiteral(resourceName: "app-screenshot-2"), #imageLiteral(resourceName: "contacts"), #imageLiteral(resourceName: "3d-touch"), #imageLiteral(resourceName: "stock-exchange")]

    
    func setupView(index : Int){
//        self.selectionStyle = .none
        addSubview(dayLabel)
        addSubview(photo)
        addSubview(postLabel)
        photo.image = images[index]
        
        dayLabel.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 18)
        photo.anchor(top: dayLabel.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 18, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 190)
        postLabel.anchor(top: photo.bottomAnchor, left: photo.leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 8, paddingLeft: 0, paddingBottom: 0, paddingRight: 6, width: 0, height: 0)
        postLabel.heightAnchor.constraint(lessThanOrEqualToConstant: 30).isActive = true
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
//    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
//        super.init(style: style, reuseIdentifier: reuseIdentifier)
////        setupView()
//    }
//
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
