//
//  DetailChallengeCells.swift
//  pursue
//
//  Created by Jaylen Sanders on 6/25/18.
//  Copyright © 2018 Glory. All rights reserved.
//

import UIKit

class DetailChallengeCells : UICollectionViewCell {
    
    let photoBackground : HomeCellRectangleView = {
        let iv = HomeCellRectangleView()
        iv.layer.cornerRadius = 8
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    let photo : UIImageView = {
        let iv = UIImageView()
        iv.layer.cornerRadius = 8
        iv.layer.masksToBounds = true
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    let resolvedLabel : UILabel = {
       let label = UILabel()
        label.text = "Resolved"
        label.textColor = .green
        label.font = UIFont.systemFont(ofSize: 10)
        return label
    }()
    
    let detailLabel : UILabel = {
        let label = UILabel()
        label.text = "Have a vision to work towards"
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()
    
    let daysLabel : UILabel = {
        let label = UILabel()
        label.text = "2 Days"
        label.font = UIFont.systemFont(ofSize: 10)
        label.textColor = .gray
        return label
    }()
    
    let circleView : UIView = {
       let view = UIView()
        view.layer.cornerRadius = 2
        view.layer.masksToBounds = true
        view.backgroundColor = .lightGray
        return view
    }()
    
    let seperatorLine : UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    func setupView(){
        addSubview(photoBackground)
        addSubview(photo)
        addSubview(detailLabel)
        addSubview(daysLabel)
        addSubview(circleView)
        addSubview(resolvedLabel)
        addSubview(seperatorLine)
        
        photoBackground.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 210, height: 130)
        photo.anchor(top: photoBackground.topAnchor, left: photoBackground.leftAnchor, bottom: photoBackground.bottomAnchor, right: photoBackground.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        detailLabel.anchor(top: photo.bottomAnchor, left: photo.leftAnchor, bottom: nil, right: nil, paddingTop: 18, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: detailLabel.intrinsicContentSize.width, height: detailLabel.intrinsicContentSize.height)
        daysLabel.anchor(top: detailLabel.bottomAnchor, left: photo.leftAnchor, bottom: nil, right: nil, paddingTop: 10, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: daysLabel.intrinsicContentSize.width, height: daysLabel.intrinsicContentSize.height)
        circleView.anchor(top: daysLabel.topAnchor, left: daysLabel.rightAnchor, bottom: nil, right: nil, paddingTop: 4, paddingLeft: 6, paddingBottom: 0, paddingRight: 0, width: 4, height: 4)
        resolvedLabel.anchor(top: daysLabel.topAnchor, left: circleView.rightAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 6, paddingBottom: 0, paddingRight: 0, width: resolvedLabel.intrinsicContentSize.width, height: resolvedLabel.intrinsicContentSize.height)
        seperatorLine.anchor(top: photo.topAnchor, left: nil, bottom: photo.bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 2.5, height: 0)
        seperatorLine.centerXAnchor.constraint(equalTo: photo.centerXAnchor).isActive = true
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
