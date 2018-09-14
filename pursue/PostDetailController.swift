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
    
    lazy var imageView : UIImageView = {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "ferrari").withRenderingMode(.alwaysOriginal)
        imageView.contentMode = .scaleAspectFill
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    lazy var downArrow : UIButton = {
       let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "down-arrow").withRenderingMode(.alwaysOriginal), for: .normal)
        button.contentMode = .scaleAspectFill
        button.addTarget(self, action: #selector(handleViewMore), for: .touchUpInside)
        return button
    }()
    
    lazy var cancelButton : UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "cancel").withRenderingMode(.alwaysTemplate), for: .normal)
        button.tintColor = .white
        button.contentMode = .scaleAspectFill
        button.addTarget(self, action: #selector(handleDismiss), for: .touchUpInside)
        return button
    }()
    
    let timeLabel : UILabel = {
       let label = UILabel()
        label.text = "Today"
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .white
        return label
    }()
    
    let postLabel : UILabel = {
       let label = UILabel()
        label.text = "Travel On"
        label.numberOfLines = 0
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 24, weight: UIFont.Weight.init(25))
        label.textAlignment = .left
        return label
    }()
    
    let userPhoto : UIImageView = {
       let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "steph").withRenderingMode(.alwaysOriginal)
        iv.contentMode = .scaleAspectFill
        iv.layer.cornerRadius = 20
        iv.layer.masksToBounds = true
        return iv
    }()
    
    let username : UILabel = {
       let label = UILabel()
        label.text = "Test"
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = .white
        return label
    }()
    
    let numberOfDaysLabel : UILabel = {
       let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.text = "12 Days On This Pursuit"
        label.textColor = .white
        return label
    }()
    
    @objc func handleDismiss(){
        dismiss(animated: true, completion: nil)
    }

    @objc func handleViewMore(){
//        let engagementsView = PostEngagementsController(collectionViewLayout: UICollectionViewFlowLayout())
//        engagementsView.motionTransitionType = .cover(direction: .up)
        present(PostEngagementsController(collectionViewLayout: UICollectionViewFlowLayout()), animated: true, completion: nil)
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
        let screenOverlay = UIView()
        screenOverlay.backgroundColor = UIColor.init(white: 0.8, alpha: 0.2)
        
        view.addSubview(imageView)
        imageView.addSubview(numberOfDaysLabel)
        imageView.addSubview(postLabel)
        imageView.addSubview(timeLabel)
        imageView.addSubview(userPhoto)
        imageView.addSubview(username)
        imageView.addSubview(screenOverlay)
        imageView.addSubview(downArrow)
        imageView.addSubview(cancelButton)
        
        imageView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: -5, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: view.frame.height + 5)
        numberOfDaysLabel.anchor(top: cancelButton.bottomAnchor, left: imageView.safeAreaLayoutGuide.leftAnchor, bottom: nil, right: imageView.rightAnchor, paddingTop: 24, paddingLeft: 12, paddingBottom: 0, paddingRight: 12, width: numberOfDaysLabel.intrinsicContentSize.width, height: 16)
        postLabel.anchor(top: numberOfDaysLabel.bottomAnchor, left: imageView.safeAreaLayoutGuide.leftAnchor, bottom: nil, right: imageView.rightAnchor, paddingTop: 18, paddingLeft: 12, paddingBottom: 0, paddingRight: 12, width: 0, height: 0)
        postLabel.heightAnchor.constraint(lessThanOrEqualToConstant: view.frame.height / 3).isActive = true
        userPhoto.anchor(top: nil, left: imageView.safeAreaLayoutGuide.leftAnchor, bottom: imageView.safeAreaLayoutGuide.bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 12, paddingBottom: 18, paddingRight: 0, width: 40, height: 40)
        username.anchor(top: userPhoto.topAnchor, left: userPhoto.rightAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft: 12, paddingBottom: 0, paddingRight: 24, width: 0, height: 16)
        timeLabel.anchor(top: username.bottomAnchor, left: username.leftAnchor, bottom: nil, right: nil, paddingTop: 8, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 14)
        screenOverlay.anchor(top: imageView.topAnchor, left: imageView.leftAnchor, bottom: imageView.bottomAnchor, right: imageView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        downArrow.anchor(top: userPhoto.topAnchor, left: nil, bottom: nil, right: imageView.rightAnchor, paddingTop: 10, paddingLeft: 0, paddingBottom: 0, paddingRight: 12, width: 22, height: 22)
        cancelButton.anchor(top: imageView.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: nil, right: nil, paddingTop: 12, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: 16, height: 16)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hero.isEnabled = true
        isMotionEnabled = true
        setupCollectionViewHeader()
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
}

