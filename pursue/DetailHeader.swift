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
    
    let playBackground : LargePlayView = {
       let pv = LargePlayView()
        pv.translatesAutoresizingMaskIntoConstraints = false
        pv.backgroundColor = .white
        pv.layer.masksToBounds = true
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(playVideo))
        tap.numberOfTapsRequired = 1
        pv.addGestureRecognizer(tap)
        return pv
    }()
    
    let playIcon : UIImageView = {
       let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "view-more").withRenderingMode(.alwaysOriginal)
        iv.contentMode = .scaleAspectFill
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    lazy var commentBackground : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.init(white: 1, alpha: 0.4)
        view.layer.cornerRadius = 20
        view.layer.masksToBounds = true
        return view
    }()
    
    lazy var commentButton : UIButton = {
       let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "comment").withRenderingMode(.alwaysOriginal), for: .normal)
        button.imageView?.contentMode = .scaleAspectFill
        return button
    }()
    
    lazy var saveBackground : UIView = {
       let view = UIView()
        view.backgroundColor = UIColor.init(white: 1, alpha: 0.4)
        view.layer.cornerRadius = 20
        view.layer.masksToBounds = true
        return view
    }()
    
    lazy var saveButton : UIButton = {
       let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "bookmark").withRenderingMode(.alwaysTemplate), for: .normal)
        button.imageView?.contentMode = .scaleAspectFill
        button.tintColor = .black
        return button
    }()
    
    lazy var shareBackground : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.init(white: 1, alpha: 0.4)
        view.layer.cornerRadius = 20
        view.layer.masksToBounds = true
        return view
    }()
    
    lazy var shareButton : UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "share").withRenderingMode(.alwaysOriginal), for: .normal)
        button.imageView?.contentMode = .scaleAspectFill
        return button
    }()
    
    lazy var contributeBackground : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.init(white: 1, alpha: 0.4)
        view.layer.cornerRadius = 20
        view.layer.masksToBounds = true
        return view
    }()
    
    lazy var contributeButton : UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "add").withRenderingMode(.alwaysOriginal), for: .normal)
        button.imageView?.contentMode = .scaleAspectFill
        return button
    }()
    
    let followBackground : FollowRectangleView = {
        let view = FollowRectangleView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    
    let collaborateBackground : FollowRectangleView = {
        let view = FollowRectangleView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .black
        return view
    }()
    
    lazy var collaborateButton : UIButton = {
        let button = UIButton()
        button.backgroundColor = .black
        button.setTitle("Collaborate", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont(name: "Lato-Bold", size: 12)
        button.layer.cornerRadius = 16
        button.layer.masksToBounds = true
        return button
    }()
    
    lazy var followButton : UIButton = {
        let button = UIButton()
        button.backgroundColor = .white
        button.setTitle("Follow", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont(name: "Lato-Bold", size: 12)
        button.layer.cornerRadius = 16
        button.layer.masksToBounds = true
        return button
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
//        imageView.addSubview(followBackground)
        imageView.addSubview(followButton)
//        imageView.addSubview(collaborateBackground)
        imageView.addSubview(collaborateButton)
        
        imageView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        userPhoto.anchor(top: imageView.safeAreaLayoutGuide.topAnchor, left: nil, bottom: nil, right: nil, paddingTop: 12, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 50, height: 50)
        userPhoto.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        username.anchor(top: userPhoto.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 8, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 16)
        username.centerXAnchor.constraint(equalTo: userPhoto.centerXAnchor).isActive = true
        timeLabel.anchor(top: username.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 8, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 14)
        timeLabel.centerXAnchor.constraint(equalTo: username.centerXAnchor).isActive = true
        label.anchor(top: timeLabel.bottomAnchor, left: imageView.leftAnchor, bottom: nil, right: imageView.rightAnchor, paddingTop: 12, paddingLeft: 12, paddingBottom: 0, paddingRight: 12, width: 0, height: 28)
        screenOverlay.anchor(top: imageView.topAnchor, left: imageView.leftAnchor, bottom: imageView.bottomAnchor, right: imageView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        followButton.anchor(top: label.bottomAnchor, left: imageView.leftAnchor, bottom: nil, right: nil, paddingTop: 24, paddingLeft: (frame.width / 5) - 10, paddingBottom: 0, paddingRight: 0, width: 110, height: 32)
        collaborateButton.anchor(top: followButton.topAnchor, left: followButton.rightAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 24, paddingBottom: 0, paddingRight: 0, width: 110, height: 32)
        
        setupEngagments()
        
    }
    
    func setupEngagments(){
        imageView.addSubview(playBackground)
        imageView.addSubview(playIcon)
        imageView.bringSubview(toFront: playIcon)
        imageView.addSubview(saveBackground)
        imageView.addSubview(saveButton)
        imageView.addSubview(contributeBackground)
        imageView.addSubview(contributeButton)
        imageView.addSubview(commentBackground)
        imageView.addSubview(commentButton)
        imageView.addSubview(shareBackground)
        imageView.addSubview(shareButton)
        
        playBackground.anchor(top: nil, left: nil, bottom: imageView.safeAreaLayoutGuide.bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 24, paddingRight: 0, width: 50, height: 50)
        playBackground.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        playIcon.anchor(top: nil, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 20, height: 20)
        playIcon.centerXAnchor.constraint(equalTo: playBackground.centerXAnchor).isActive = true
        playIcon.centerYAnchor.constraint(equalTo: playBackground.centerYAnchor).isActive = true
        saveBackground.anchor(top: nil, left: playBackground.rightAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 32, paddingBottom: 0, paddingRight: 0, width: 40, height: 40)
        saveBackground.centerYAnchor.constraint(equalTo: playBackground.centerYAnchor).isActive = true
        saveButton.anchor(top: nil, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 12, height: 16)
        saveButton.centerXAnchor.constraint(equalTo: saveBackground.centerXAnchor).isActive = true
        saveButton.centerYAnchor.constraint(equalTo: saveBackground.centerYAnchor).isActive = true
        contributeBackground.anchor(top: saveBackground.topAnchor, left: nil, bottom: nil, right: playBackground.leftAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 32, width: 40, height: 40)
        contributeButton.anchor(top: nil, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 16, height: 16)
        contributeButton.centerXAnchor.constraint(equalTo: contributeBackground.centerXAnchor).isActive = true
        contributeButton.centerYAnchor.constraint(equalTo: contributeBackground.centerYAnchor).isActive = true
        commentBackground.anchor(top: contributeBackground.topAnchor, left: nil, bottom: nil, right: contributeBackground.leftAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 32, width: 40, height: 40)
        commentButton.anchor(top: nil, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 16, height: 16)
        commentButton.centerYAnchor.constraint(equalTo: commentBackground.centerYAnchor).isActive = true
        commentButton.centerXAnchor.constraint(equalTo: commentBackground.centerXAnchor).isActive = true
        shareBackground.anchor(top: saveBackground.topAnchor, left: saveBackground.rightAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 32, paddingBottom: 0, paddingRight: 0, width: 40, height: 40)
        shareButton.anchor(top: nil, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 17, height: 16)
        shareButton.centerXAnchor.constraint(equalTo: shareBackground.centerXAnchor).isActive = true
        shareButton.centerYAnchor.constraint(equalTo: shareBackground.centerYAnchor).isActive = true
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCollectionViewHeader()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
