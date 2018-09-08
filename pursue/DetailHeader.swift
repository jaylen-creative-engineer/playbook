//
//  DetailHeader.swift
//  pursue
//
//  Created by Jaylen Sanders on 8/8/18.
//  Copyright © 2018 Glory. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit
import MediaPlayer

class DetailHeader : UICollectionViewCell {
    
    lazy var imageView : UIImageView = {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "ferrari").withRenderingMode(.alwaysOriginal)
        imageView.contentMode = .scaleAspectFill
        imageView.isUserInteractionEnabled = true
        
//        let pan = UIPanGestureRecognizer(target: self, action: #selector(handlePan))
//        imageView.addGestureRecognizer(pan)
        return imageView
    }()
    
    lazy var viewMoreButton : UIButton = {
        let button = UIButton()
        button.backgroundColor = .white
        button.layer.cornerRadius = 4
        button.layer.masksToBounds = true
//        button.addTarget(self, action: #selector(handleViewMore), for: .touchUpInside)
        return button
    }()
    
    
    func setupCollectionViewHeader(){
        let label = UILabel()
        label.text = "Travel On"
        label.numberOfLines = 2
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 24, weight: UIFont.Weight.init(25))
        label.textAlignment = .center
        
        let timeLabel = UILabel()
        timeLabel.text = "Day 3"
        timeLabel.font = UIFont.systemFont(ofSize: 14)
        timeLabel.textColor = .white
        
        let userPhoto = UIImageView()
        userPhoto.image = #imageLiteral(resourceName: "steph").withRenderingMode(.alwaysOriginal)
        userPhoto.contentMode = .scaleAspectFill
        userPhoto.layer.cornerRadius = 25
        userPhoto.layer.masksToBounds = true
        userPhoto.translatesAutoresizingMaskIntoConstraints = false
        
        let username = UILabel()
        username.text = "Test"
        username.font = UIFont.boldSystemFont(ofSize: 16)
        username.textColor = .white
        username.translatesAutoresizingMaskIntoConstraints = false
        
        let screenOverlay = UIView()
        screenOverlay.backgroundColor = UIColor.init(white: 0.8, alpha: 0.2)
        
        
        addSubview(imageView)
        imageView.addSubview(label)
        imageView.addSubview(timeLabel)
        imageView.addSubview(userPhoto)
        imageView.addSubview(username)
        imageView.addSubview(screenOverlay)
        imageView.addSubview(viewMoreButton)
        
        if UIDevice().userInterfaceIdiom == .phone {
            if UIScreen.main.nativeBounds.height >= 2436 {
                imageView.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: -47, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: frame.height + 5)
                userPhoto.anchor(top: imageView.safeAreaLayoutGuide.topAnchor, left: nil, bottom: nil, right: nil, paddingTop: 48, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 50, height: 50)
            } else {
                imageView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
                userPhoto.anchor(top: imageView.safeAreaLayoutGuide.topAnchor, left: nil, bottom: nil, right: nil, paddingTop: 12, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 50, height: 50)
            }
        }
        
        userPhoto.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        username.anchor(top: userPhoto.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 8, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 16)
        username.centerXAnchor.constraint(equalTo: userPhoto.centerXAnchor).isActive = true
        timeLabel.anchor(top: username.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 8, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 14)
        timeLabel.centerXAnchor.constraint(equalTo: username.centerXAnchor).isActive = true
        label.anchor(top: timeLabel.bottomAnchor, left: imageView.leftAnchor, bottom: nil, right: imageView.rightAnchor, paddingTop: 12, paddingLeft: 12, paddingBottom: 0, paddingRight: 12, width: 0, height: 28)
        screenOverlay.anchor(top: imageView.topAnchor, left: imageView.leftAnchor, bottom: imageView.bottomAnchor, right: imageView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        viewMoreButton.anchor(top: nil, left: nil, bottom: imageView.safeAreaLayoutGuide.bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 12, paddingRight: 0, width: 90, height: 10)
        viewMoreButton.centerXAnchor.constraint(equalTo: imageView.centerXAnchor).isActive = true
        
        //        imageView.transition(.translate(y: 0), .duration(1))
        
        //        collectionView?.hero.modifiers = [.scale(), .duration(1.5)]
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCollectionViewHeader()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
