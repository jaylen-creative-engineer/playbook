//
//  StepNotification.swift
//  pursue
//
//  Created by Jaylen Sanders on 2/28/18.
//  Copyright © 2018 Glory. All rights reserved.
//

import UIKit

class StandardNotification : UICollectionViewCell {
    
    let imageView : UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = .blue
        iv.layer.cornerRadius = 4
        iv.clipsToBounds = true
        iv.image = #imageLiteral(resourceName: "ferrari").withRenderingMode(.alwaysOriginal)
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    let stepLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Lato-Semibold", size: 12)
        label.text = "Your step keep working was saved by test"
        label.numberOfLines = 2
        return label
    }()

    let timeLabel : UILabel = {
        let label = UILabel()
        label.text = "21 hours ago"
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()
    
    func setupView(){
        addSubview(imageView)
        addSubview(stepLabel)
        addSubview(timeLabel)
        
        imageView.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: 65, height: 80)
        stepLabel.anchor(top: imageView.centerYAnchor, left: imageView.rightAnchor, bottom: nil, right: rightAnchor, paddingTop: 4, paddingLeft: 12, paddingBottom: 0, paddingRight: 12, width: 0, height: 14)
        timeLabel.anchor(top: nil, left: imageView.rightAnchor, bottom: imageView.bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 12, paddingBottom: 0, paddingRight: 12, width: 0, height: 14)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
