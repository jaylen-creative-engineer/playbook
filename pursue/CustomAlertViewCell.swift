//
//  CustomAlertViewCell.swift
//  pursue
//
//  Created by Jaylen Sanders on 2/23/18.
//  Copyright © 2018 Glory. All rights reserved.
//

import UIKit

class CustomAlertViewCell : UICollectionViewCell {
    
    var pursuit : Pursuit? {
        didSet {
            pursuitLabel.text = pursuit?.pursuitDescription
            guard let photoUrl = pursuit?.thumbnailUrl else { return }
            pursuitImageView.loadImage(urlString: photoUrl)
        }
    }
    
    lazy var pursuitLabel : UILabel = {
       let label = UILabel()
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var backgroundContainer : UIView = {
       let view = UIView()
        view.layer.cornerRadius = 4
        view.layer.masksToBounds = true
        return view
    }()
    
    lazy var pursuitImageView : CustomImageView = {
       let iv = CustomImageView()
        iv.contentMode = .scaleAspectFill
        iv.layer.cornerRadius = 4
        iv.backgroundColor = .lightGray
        iv.layer.masksToBounds = true
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    func setupView(){
        addSubview(backgroundContainer)
        backgroundContainer.addSubview(pursuitLabel)
        backgroundContainer.addSubview(pursuitImageView)

        backgroundContainer.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 320, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 175)
        pursuitImageView.anchor(top: backgroundContainer.topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 8, paddingRight: 0, width: 135, height: 150)
        pursuitLabel.anchor(top: pursuitImageView.bottomAnchor, left: backgroundContainer.leftAnchor, bottom: nil, right: backgroundContainer.rightAnchor, paddingTop: 8, paddingLeft: 0, paddingBottom: 0, paddingRight: 4, width: 0, height: pursuitLabel.intrinsicContentSize.height)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
