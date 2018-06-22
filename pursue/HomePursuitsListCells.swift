//
//  HomePursuitsListCells.swift
//  pursue
//
//  Created by Jaylen Sanders on 6/21/18.
//  Copyright © 2018 Glory. All rights reserved.
//

import UIKit

class HomePursuitsListCells : UICollectionViewCell {
    
    let photoBackground : HomeCellRectangleView = {
        let iv = HomeCellRectangleView()
        iv.layer.cornerRadius = 8
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    let photo : UIImageView = {
        let iv = UIImageView()
        iv.layer.cornerRadius = 8
        iv.layer.masksToBounds = true
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    let detailLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.numberOfLines = 2
        return label
    }()
    
    let usernameLabel : UILabel = {
        let label = UILabel()
        label.text = "Test"
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()
    
    let circleView : UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        view.layer.cornerRadius = 2
        return view
    }()
    
    let daysLabel : UILabel = {
        let label = UILabel()
        label.text = "24 Days"
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()
    
    let costLabel : UILabel = {
       let label = UILabel()
        label.text = "$50.00"
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .blue
        return label
    }()
    
    let optionButton : UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "options").withRenderingMode(.alwaysTemplate), for: .normal)
        button.imageView?.contentMode = .scaleAspectFill
        button.tintColor = .gray
        return button
    }()
    
    func setupView(){
        addSubview(photoBackground)
        addSubview(photo)
        addSubview(detailLabel)
        addSubview(usernameLabel)
        addSubview(circleView)
        addSubview(daysLabel)
        addSubview(costLabel)
        addSubview(optionButton)
        
        photoBackground.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: 210, height: 130)
        photo.anchor(top: photoBackground.topAnchor, left: photoBackground.leftAnchor, bottom: photoBackground.bottomAnchor, right: photoBackground.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        detailLabel.anchor(top: photo.topAnchor, left: photo.rightAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: 90, height: 50)
        usernameLabel.anchor(top: detailLabel.bottomAnchor, left: detailLabel.leftAnchor, bottom: nil, right: nil, paddingTop: 6, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: usernameLabel.intrinsicContentSize.width, height: usernameLabel.intrinsicContentSize.height)
        circleView.anchor(top: nil, left: usernameLabel.rightAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 8, paddingBottom: 0, paddingRight: 0, width: 4, height: 4)
        circleView.centerYAnchor.constraint(equalTo: usernameLabel.centerYAnchor).isActive = true
        daysLabel.anchor(top: usernameLabel.topAnchor, left: circleView.rightAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 8, paddingBottom: 0, paddingRight: 0, width: daysLabel.intrinsicContentSize.width, height: daysLabel.intrinsicContentSize.height)
        costLabel.anchor(top: usernameLabel.bottomAnchor, left: usernameLabel.leftAnchor, bottom: nil, right: nil, paddingTop: 10, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: costLabel.intrinsicContentSize.width, height: costLabel.intrinsicContentSize.height)
         optionButton.anchor(top: photo.topAnchor, left: nil, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 12, width: 8, height: 16)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
