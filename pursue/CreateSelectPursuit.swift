//
//  CreateSelectPursuit.swift
//  pursue
//
//  Created by Jaylen Sanders on 9/20/18.
//  Copyright © 2018 Glory. All rights reserved.
//

import UIKit

class CreateSelectPursuit : UICollectionViewCell {
    
    lazy var imageView : UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = .blue
        iv.layer.cornerRadius = 8
        iv.clipsToBounds = true
        iv.image = #imageLiteral(resourceName: "ferrari").withRenderingMode(.alwaysOriginal)
        iv.contentMode = .scaleAspectFill
        iv.isUserInteractionEnabled = true
        return iv
    }()
    
    let backgroundShadow : HomeCellRectangleView = {
        let view = HomeCellRectangleView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let postType : UILabel = {
        let label = UILabel()
        label.text = "Principle"
        label.font = UIFont(name: "Lato-Bold", size: 14)
        label.textColor = .white
        label.motionIdentifier = "postType"
        return label
    }()
    
    let userPhoto : UIImageView = {
        let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "samuel-l").withRenderingMode(.alwaysOriginal)
        iv.contentMode = .scaleAspectFill
        iv.layer.cornerRadius = 20
        iv.layer.masksToBounds = true
        iv.motionIdentifier = "userPhoto"
        return iv
    }()
    
    let postDetail : UILabel = {
        let label = UILabel()
        label.text = "Travel On"
        label.numberOfLines = 0
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 24, weight: UIFont.Weight.init(25))
        label.textAlignment = .center
        label.motionIdentifier = "postDetail"
        return label
    }()
    
    let daysLabel : UILabel = {
        let label = UILabel()
        label.text = "20 Days"
        label.font = UIFont(name: "Lato-Bold", size: 14)
        label.textColor = .white
        label.motionIdentifier = "daysLabel"
        return label
    }()
    
    let seperatorCircle : UIView = {
        let view = UIView()
        view.layer.cornerRadius = 3
        view.layer.masksToBounds = true
        view.backgroundColor = .white
        return view
    }()
    
    func setupView(){
        addSubview(backgroundShadow)
        addSubview(imageView)
        addSubview(postType)
        addSubview(postDetail)
        addSubview(seperatorCircle)
        addSubview(daysLabel)
        
        backgroundShadow.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        imageView.anchor(top: backgroundShadow.topAnchor, left: backgroundShadow.leftAnchor, bottom: backgroundShadow.bottomAnchor, right: backgroundShadow.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        postDetail.anchor(top: imageView.topAnchor, left: nil, bottom: nil, right: nil, paddingTop: 18, paddingLeft: 12, paddingBottom: 0, paddingRight: 12, width: 0, height: 0)
        postDetail.heightAnchor.constraint(lessThanOrEqualToConstant: 52).isActive = true
        postDetail.centerXAnchor.constraint(equalTo: imageView.centerXAnchor).isActive = true
        postType.anchor(top: postDetail.bottomAnchor, left: imageView.leftAnchor, bottom: nil, right: nil, paddingTop: 12, paddingLeft: (frame.width / 4) - 12, paddingBottom: 0, paddingRight: 0, width: postType.intrinsicContentSize.width, height: 16)
        seperatorCircle.anchor(top: nil, left: postType.rightAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: 6, height: 6)
        seperatorCircle.centerYAnchor.constraint(equalTo: postType.centerYAnchor).isActive = true
        daysLabel.anchor(top: postDetail.bottomAnchor, left: seperatorCircle.rightAnchor, bottom: nil, right: nil, paddingTop: 12, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: daysLabel.intrinsicContentSize.width, height: 16)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
