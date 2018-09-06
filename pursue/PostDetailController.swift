//
//  PursuitsDetailController.swift
//  pursue
//
//  Created by Jaylen Sanders on 10/17/17.
//  Copyright © 2017 Glory. All rights reserved.
//

import UIKit
import Hero
import Firebase
import AVFoundation
import AVKit
import MediaPlayer
import Motion

class PostDetailController : UICollectionViewController {
    
    let headerId = "headerId"
    let commentId = "commentId"
    let videoId = "videoId"
    let postId = "postId"
    let teamId = "teamId"
    let dayId = "dayId"
    let pursuitId = "discussionPursuitId"
    let solutionId = "solutionId"
    let cellId = "cellId"
    let challengeId = "challengeId"
    
    var isStandardView = false
    var isChallengeView = false
    
    let homeService = HomeServices()
    
    lazy var scrollView : UIScrollView = {
       let view = UIScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentSize.height = 2000
        view.backgroundColor = .brown
        return view
    }()

    lazy var imageView : UIImageView = {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "ferrari").withRenderingMode(.alwaysOriginal)
        imageView.contentMode = .scaleAspectFill
        imageView.isUserInteractionEnabled = true
        
        let pan = UIPanGestureRecognizer(target: self, action: #selector(handlePan))
        imageView.addGestureRecognizer(pan)
        return imageView
    }()
    
    lazy var viewMoreButton : UIButton = {
       let button = UIButton()
        button.backgroundColor = .white
        button.layer.cornerRadius = 4
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(handleViewMore), for: .touchUpInside)
        return button
    }()
    
    @objc func handleViewMore(){
        let engagementsView = PostEngagementsController(collectionViewLayout: UICollectionViewFlowLayout())
        engagementsView.motionTransitionType = .cover(direction: .up)
        present(engagementsView, animated: true, completion: nil)
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
        
        
        view.addSubview(imageView)
        imageView.addSubview(label)
        imageView.addSubview(timeLabel)
        imageView.addSubview(userPhoto)
        imageView.addSubview(username)
        imageView.addSubview(screenOverlay)
        imageView.addSubview(viewMoreButton)
        
        imageView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        userPhoto.anchor(top: imageView.safeAreaLayoutGuide.topAnchor, left: nil, bottom: nil, right: nil, paddingTop: 12, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 50, height: 50)
        userPhoto.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        tabBarController?.tabBar.isHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.contentInset = UIEdgeInsetsMake(0, 0, 0, 0)
        collectionView?.backgroundColor = .white
        collectionView?.showsVerticalScrollIndicator = false
        collectionView?.isScrollEnabled = false
        hero.isEnabled = true
        
        isMotionEnabled = true
        setupCollectionViewHeader()
    }
    
    @objc func handlePan(panGesture : UIPanGestureRecognizer){
//        let progress = scrollView.contentOffset.y / (scrollView.contentSize.height - scrollView.bounds.size.height)
        let translation = panGesture.translation(in: nil)
        let progress = translation.y / 2 / view.bounds.height
        print(progress)
//
//
//        switch panGesture.state {
//        case .began:
//            hero.dismissViewController()
//        case .changed:
//            Hero.shared.update(progress)
//        let currentPos = CGPoint(x: translation.x + imageView.center.x, y: translation.y + imageView.center.y)
//
//        Hero.shared.apply(modifiers: [.position(currentPos)], to: imageView)
//        default:
//            if progress + panGesture.velocity(in: nil).y / view.bounds.height > 0.2 {
//                Hero.shared.finish()
//            } else {
//                Hero.shared.cancel()
//            }
//        }
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
    }
}

