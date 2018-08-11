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
    
    lazy var headerView : UIView = {
        let view  = UIView()
        return view
    }()
    
    lazy var imageView : UIImageView = {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "health").withRenderingMode(.alwaysOriginal)
        imageView.contentMode = .scaleAspectFill
        //        imageView.isUserInteractionEnabled = true
        //
        //        let pan = UIPanGestureRecognizer(target: self, action: #selector(handlePan))
        //        imageView.addGestureRecognizer(pan)
        return imageView
    }()
    
    @objc func playVideo(){
//        let videoURL = URL(string: "https://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4")
//        let player = AVPlayer(url: videoURL!)
//        let playerViewController = AVPlayerViewController()
//        playerViewController.player = player
//        self.present(playerViewController, animated: true) {
//            playerViewController.player!.play()
//        }
    }
    
    func setupCollectionViewHeader(){
        let label = UILabel()
        label.text = "Travel through amazing heights"
        label.numberOfLines = 2
        label.textColor = .white
        label.font = UIFont(name: "Lato-Bold", size: 18)
        
        let timeLabel = UILabel()
        timeLabel.text = "Day 3"
        timeLabel.font = UIFont.systemFont(ofSize: 14)
        timeLabel.textColor = .white
        
        let playBackground = LargePlayView()
        playBackground.translatesAutoresizingMaskIntoConstraints = false
        playBackground.backgroundColor = .white
        playBackground.layer.masksToBounds = true
        
        let playIcon = UIImageView()
        playIcon.image = #imageLiteral(resourceName: "view-more").withRenderingMode(.alwaysOriginal)
        playIcon.contentMode = .scaleAspectFill
        playIcon.translatesAutoresizingMaskIntoConstraints = false
        
        let userPhoto = UIImageView()
        userPhoto.image = #imageLiteral(resourceName: "steph").withRenderingMode(.alwaysOriginal)
        userPhoto.contentMode = .scaleAspectFill
        userPhoto.layer.cornerRadius = 20
        userPhoto.layer.masksToBounds = true
        userPhoto.translatesAutoresizingMaskIntoConstraints = false
        
        let username = UILabel()
        username.text = "Test"
        username.font = UIFont.systemFont(ofSize: 12)
        username.textColor = .white
        username.translatesAutoresizingMaskIntoConstraints = false
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(playVideo))
        tap.numberOfTapsRequired = 1
        playBackground.addGestureRecognizer(tap)
        
        addSubview(imageView)
        imageView.addSubview(label)
        imageView.addSubview(timeLabel)
        imageView.addSubview(playBackground)
        imageView.addSubview(playIcon)
        imageView.addSubview(userPhoto)
        imageView.addSubview(username)
        imageView.bringSubview(toFront: playIcon)
        
        imageView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        playBackground.anchor(top: nil, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 60, height: 60)
        playBackground.centerYAnchor.constraint(equalTo: imageView.centerYAnchor).isActive = true
        playBackground.centerXAnchor.constraint(equalTo: imageView.centerXAnchor).isActive = true
        playIcon.anchor(top: nil, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 24, height: 24)
        playIcon.centerXAnchor.constraint(equalTo: playBackground.centerXAnchor).isActive = true
        playIcon.centerYAnchor.constraint(equalTo: playBackground.centerYAnchor).isActive = true
        label.anchor(top: playBackground.bottomAnchor, left: imageView.leftAnchor, bottom: nil, right: imageView.rightAnchor, paddingTop: 18, paddingLeft: 12, paddingBottom: 0, paddingRight: 12, width: 0, height: 28)
        timeLabel.anchor(top: label.bottomAnchor, left: label.leftAnchor, bottom: nil, right: imageView.rightAnchor, paddingTop: 6, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: timeLabel.intrinsicContentSize.height)
        userPhoto.anchor(top: timeLabel.bottomAnchor, left: timeLabel.leftAnchor, bottom: nil, right: nil, paddingTop: 12, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 40, height: 40)
        username.anchor(top: nil, left: userPhoto.rightAnchor, bottom: nil, right: imageView.rightAnchor, paddingTop: 0, paddingLeft: 8, paddingBottom: 0, paddingRight: 0, width: 0, height: username.intrinsicContentSize.height)
        username.centerYAnchor.constraint(equalTo: userPhoto.centerYAnchor).isActive = true
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCollectionViewHeader()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
