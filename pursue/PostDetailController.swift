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

class PostDetailController : UIViewController {

    let homeService = HomeServices()
    
    lazy var viewMoreButton : UIButton = {
       let button = UIButton()
        button.backgroundColor = .white
        button.layer.cornerRadius = 4
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(handleViewMore), for: .touchUpInside)
        return button
    }()
    
    lazy var imageView : UIImageView = {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "ferrari").withRenderingMode(.alwaysOriginal)
        imageView.contentMode = .scaleAspectFill
        imageView.isUserInteractionEnabled = true
        return imageView
    }()

    lazy var bottomView : UIView = {
       let view = UIView()
        view.backgroundColor = .red
        view.translatesAutoresizingMaskIntoConstraints = false
        
        let pan = UIPanGestureRecognizer(target: self, action: #selector(handlePan))
        view.addGestureRecognizer(pan)
        return view
    }()

    @objc func handleViewMore(){
        let engagementsView = PostEngagementsController(collectionViewLayout: UICollectionViewFlowLayout())
        engagementsView.motionTransitionType = .cover(direction: .up)
        present(engagementsView, animated: true, completion: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        tabBarController?.tabBar.isHidden = false
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
        
        imageView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: view.frame.height)
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
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hero.isEnabled = true
        isMotionEnabled = true
        setupCollectionViewHeader()
//        view.backgroundColor = .white
        view.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(handlePan)))
    }
    
    let engagementsView = PostEngagementsController()
    
    fileprivate func handlePanChanged(_ panGesture : UIPanGestureRecognizer) {
        let translation = panGesture.translation(in: self.view)
        self.view.transform = CGAffineTransform(translationX: 0, y: translation.y)
//        self.engagementsView.view.transform = CGAffineTransform(translationX: 0, y: -translation.y - 20)
    }
    
    fileprivate func handlePanEnded(_ panGesture : UIPanGestureRecognizer) {
        let translation = panGesture.translation(in: self.view)
        let velocity = panGesture.velocity(in: self.view)
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.view.transform = .identity
            
            if translation.y < 0 || velocity.y < -500 {
                self.handleViewMore()
                panGesture.isEnabled = false
            }

        })
    }
    
    @objc func handlePan(panGesture : UIPanGestureRecognizer){
        switch panGesture.state {
        case .changed:
            handlePanChanged(panGesture)
        default:
            handlePanEnded(panGesture)
        }
    }
    
    
    let headerView = DetailHeader()
}


