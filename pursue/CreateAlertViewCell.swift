//
//  CreateAlertViewCell.swift
//  pursue
//
//  Created by Jaylen Sanders on 3/20/18.
//  Copyright © 2018 Glory. All rights reserved.
//

import UIKit

class CreateAlertViewCell : UICollectionViewCell {
    
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
        iv.layer.masksToBounds = true
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    func setupView(){
        addSubview(backgroundContainer)
        backgroundContainer.addSubview(pursuitImageView)
        
        backgroundContainer.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 330, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 175)
        pursuitImageView.anchor(top: backgroundContainer.topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 8, paddingRight: 0, width: 0, height: 150)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
