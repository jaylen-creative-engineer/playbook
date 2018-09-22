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

    let dayId = "dayId"
    let keyId = "keyId"
    let challengeId = "challengeId"
    let tryingId = "tryingId"
    let commentId = "commentId"
    
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
    
    let username : UILabel = {
        let label = UILabel()
        label.text = "Test"
        label.font = UIFont(name: "Lato-Bold", size: 14)
        label.textColor = .white
        label.motionIdentifier = "username"
        return label
    }()
    
    let timeLabel : UILabel = {
        let label = UILabel()
        label.text = "Today"
        label.font = UIFont(name: "Lato-Bold", size: 12)
        label.textColor = .white
        label.motionIdentifier = "timeLabel"
        return label
    }()
    
    let progressBar : UIProgressView = {
        let view = UIProgressView()
        view.progress = 100
        view.progressTintColor = .white
        view.layer.cornerRadius = 2
        view.layer.masksToBounds = true
        view.motionIdentifier = "progressBar"
        return view
    }()
    
    let saveBackground : UIButton = {
        let button = UIButton()
        button.backgroundColor = .white
        button.layer.cornerRadius = 17.5
        button.clipsToBounds = true
        button.motionIdentifier = "saveBackground"
        return button
    }()
    
    lazy var saveIcon : UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "bookmark").withRenderingMode(.alwaysOriginal), for: .normal)
        button.contentMode = .scaleAspectFill
        button.motionIdentifier = "saveIcon"
        return button
    }()
    
    let tryBackground : UIButton = {
        let button = UIButton()
        button.backgroundColor = .white
        button.layer.cornerRadius = 24
        button.clipsToBounds = true
        button.motionIdentifier = "tryBackground"
        return button
    }()
    
    lazy var tryIcon : UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "add").withRenderingMode(.alwaysOriginal), for: .normal)
        button.contentMode = .scaleAspectFill
        button.motionIdentifier = "tryIcon"
        return button
    }()

    
    let shareBackground : UIButton = {
        let button = UIButton()
        button.backgroundColor = .white
        button.layer.cornerRadius = 17.5
        button.clipsToBounds = true
        button.motionIdentifier = "shareBackground"
        return button
    }()
    
    lazy var shareIcon : UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "share").withRenderingMode(.alwaysOriginal), for: .normal)
        button.contentMode = .scaleAspectFill
        button.motionIdentifier = "shareIcon"
        return button
    }()
    
    let downBackground : UIButton = {
        let button = UIButton()
        button.backgroundColor = .black
        button.layer.cornerRadius = 17.5
        button.clipsToBounds = true
        return button
    }()
    
    lazy var downIcon : UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "down-arrow").withRenderingMode(.alwaysOriginal), for: .normal)
        button.contentMode = .scaleAspectFill
        button.addTarget(self, action: #selector(handleViewMore), for: .touchUpInside)
        return button
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
    
    func setupView(){
        view.addSubview(imageView)
        imageView.addSubview(progressBar)
        imageView.addSubview(userPhoto)
        imageView.addSubview(postType)
        imageView.addSubview(postDetail)
        imageView.addSubview(seperatorCircle)
        imageView.addSubview(daysLabel)
        imageView.addSubview(username)
        imageView.addSubview(timeLabel)
        imageView.addSubview(cancelButton)
        
//        imageView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: -5, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: view.frame.height / 1.3)
        progressBar.anchor(top: imageView.safeAreaLayoutGuide.topAnchor, left: imageView.leftAnchor, bottom: nil, right: imageView.rightAnchor, paddingTop: 48, paddingLeft: 8, paddingBottom: 0, paddingRight: 8, width: 0, height: 3)
        cancelButton.anchor(top: progressBar.bottomAnchor, left: nil, bottom: nil, right: imageView.rightAnchor, paddingTop: 18, paddingLeft: 0, paddingBottom: 0, paddingRight: 18, width: 16, height: 16)
        userPhoto.anchor(top: progressBar.bottomAnchor, left: imageView.leftAnchor, bottom: nil, right: nil, paddingTop: 18, paddingLeft: 8, paddingBottom: 0, paddingRight: 0, width: 40, height: 40)
        username.anchor(top: userPhoto.topAnchor, left: userPhoto.rightAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft: 12, paddingBottom: 0, paddingRight: 24, width: 0, height: 16)
        timeLabel.anchor(top: username.bottomAnchor, left: username.leftAnchor, bottom: nil, right: nil, paddingTop: 8, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 14)
        postDetail.anchor(top: timeLabel.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 24, paddingLeft: 12, paddingBottom: 0, paddingRight: 12, width: 0, height: 0)
        postDetail.heightAnchor.constraint(lessThanOrEqualToConstant: 52).isActive = true
        postDetail.centerXAnchor.constraint(equalTo: imageView.centerXAnchor).isActive = true
        postType.anchor(top: postDetail.bottomAnchor, left: imageView.leftAnchor, bottom: nil, right: nil, paddingTop: 12, paddingLeft: (view.frame.width / 3) - 12, paddingBottom: 0, paddingRight: 0, width: postType.intrinsicContentSize.width, height: 16)
        seperatorCircle.anchor(top: nil, left: postType.rightAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: 6, height: 6)
        seperatorCircle.centerYAnchor.constraint(equalTo: postType.centerYAnchor).isActive = true
        daysLabel.anchor(top: postDetail.bottomAnchor, left: seperatorCircle.rightAnchor, bottom: nil, right: nil, paddingTop: 12, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: daysLabel.intrinsicContentSize.width, height: 16)
        setupEngagements()
        
        collectionView?.parallaxHeader.view = imageView
        collectionView?.contentInset = UIEdgeInsets(top: -10, left: 0, bottom: 0, right: 0)
        collectionView?.parallaxHeader.height = view.frame.height / 1.2
        collectionView?.parallaxHeader.minimumHeight = 0
        collectionView?.parallaxHeader.mode = .topFill
        collectionView?.alwaysBounceVertical = false
        setupCollectionView()
    }
    
    func setupCollectionView(){
        collectionView?.register(PursuitDay.self, forCellWithReuseIdentifier: dayId)
        collectionView?.register(KeyPost.self, forCellWithReuseIdentifier: keyId)
        collectionView?.register(DetailChallenge.self, forCellWithReuseIdentifier: challengeId)
        collectionView?.register(DetailTrying.self, forCellWithReuseIdentifier: tryingId)
        collectionView?.register(PostComments.self, forCellWithReuseIdentifier: commentId)
    }
    
    func setupEngagements(){
        imageView.addSubview(saveBackground)
        imageView.addSubview(saveIcon)
        imageView.addSubview(tryBackground)
        imageView.addSubview(tryIcon)
        imageView.addSubview(shareBackground)
        imageView.addSubview(shareIcon)
        imageView.addSubview(downBackground)
        imageView.addSubview(downIcon)
        
        tryBackground.anchor(top: nil, left: nil, bottom: imageView.bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 32, paddingRight: 0, width: 48, height: 48)
        tryBackground.centerXAnchor.constraint(equalTo: imageView.centerXAnchor).isActive = true
        tryIcon.anchor(top: nil, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 24, height: 24)
        tryIcon.centerXAnchor.constraint(equalTo: tryBackground.centerXAnchor).isActive = true
        tryIcon.centerYAnchor.constraint(equalTo: tryBackground.centerYAnchor).isActive = true
        
        saveBackground.anchor(top: nil, left: nil, bottom: nil, right: tryBackground.leftAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 42, width: 35, height: 35)
        saveBackground.centerYAnchor.constraint(equalTo: tryBackground.centerYAnchor).isActive = true
        saveIcon.anchor(top: nil, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 14, height: 18)
        saveIcon.centerXAnchor.constraint(equalTo: saveBackground.centerXAnchor).isActive = true
        saveIcon.centerYAnchor.constraint(equalTo: saveBackground.centerYAnchor).isActive = true
        
        shareBackground.anchor(top: nil, left: tryBackground.rightAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 42, paddingBottom: 0, paddingRight: 0, width: 35, height: 35)
        shareBackground.centerYAnchor.constraint(equalTo: tryBackground.centerYAnchor).isActive = true
        shareIcon.anchor(top: nil, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 18, height: 16)
        shareIcon.centerXAnchor.constraint(equalTo: shareBackground.centerXAnchor).isActive = true
        shareIcon.centerYAnchor.constraint(equalTo: shareBackground.centerYAnchor).isActive = true
        
        downBackground.anchor(top: nil, left: shareBackground.rightAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 32, paddingBottom: 0, paddingRight: 0, width: 35, height: 35)
        downBackground.centerYAnchor.constraint(equalTo: tryBackground.centerYAnchor).isActive = true
        downIcon.anchor(top: nil, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 18, height: 18)
        downIcon.centerXAnchor.constraint(equalTo: downBackground.centerXAnchor).isActive = true
        downIcon.centerYAnchor.constraint(equalTo: downBackground.centerYAnchor).isActive = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.backgroundColor = .white
        hero.isEnabled = true
        isMotionEnabled = true
        setupView()
//        view.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(handlePan)))
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

extension PostDetailController : UICollectionViewDelegateFlowLayout {
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.item {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: dayId, for: indexPath) as! PursuitDay
            return cell
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: keyId, for: indexPath) as! KeyPost
            return cell
        case 2:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: challengeId, for: indexPath) as! DetailChallenge
            return cell
        case 3:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: tryingId, for: indexPath) as! DetailTrying
            return cell
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: commentId, for: indexPath) as! PostComments
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 200)
    }
}

