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
import Mixpanel
import ParallaxHeader
import TRVSEventSource
import NVActivityIndicatorView

class PostDetailController : UICollectionViewController, PursuitDayDelegate, KeyPostDelegate, TeamListDelegate {

    let dayId = "dayId"
    let keyId = "keyId"
    let challengeId = "challengeId"
    let tryingId = "tryingId"
    let commentId = "commentId"
    let teamId = "teamId"
    let headerId = "headerId"
    var isProfile : Bool?
    
    let homeService = HomeServices()
    let profileService = ProfileServices()
    
    lazy var imageView : UIImageView = {
        let imageView = UIImageView()
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
    
    lazy var cancelBackground : UIButton = {
       let button = UIButton()
        button.backgroundColor = UIColor.init(white: 0.4, alpha: 0.5)
        button.layer.cornerRadius = 18
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(handleDismiss), for: .touchUpInside)
        return button
    }()
    
    let userPhoto : UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.layer.cornerRadius = 20
        iv.layer.masksToBounds = true
        return iv
    }()
    
    let postDetail : UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.init(25))
        label.textAlignment = .left
        return label
    }()
    
    let daysLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Lato-Bold", size: 14)
        label.textColor = .white
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
        label.font = UIFont(name: "Lato-Bold", size: 14)
        label.textColor = .white
        return label
    }()
    
    let timeLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Lato-Bold", size: 12)
        label.textColor = .white
        return label
    }()
    
    let progressBar : UIProgressView = {
        let view = UIProgressView()
        view.progress = 100
        view.progressTintColor = .white
        view.layer.cornerRadius = 2
        view.layer.masksToBounds = true
        return view
    }()
    
    let videoView = UIView()
    let containerView = UIView()
    
    lazy var forwardButton : UIButton = {
       let button = UIButton()
        button.backgroundColor = .clear
        button.addTarget(self, action: #selector(handleForward), for: .touchUpInside)
        return button
    }()
    
    lazy var backwardButton : UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        button.addTarget(self, action: #selector(handleBackward), for: .touchUpInside)
        return button
    }()
    
    lazy var savedButton : UIButton = {
       let button = UIButton()
        button.setTitle("Saved", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 12)
        button.contentHorizontalAlignment = .center
        button.contentVerticalAlignment = .center
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .black
        button.layer.cornerRadius = 4
        button.layer.masksToBounds = true
        return button
    }()
    
    let progressStackView : UIStackView = {
       let sv = UIStackView()
        sv.axis = .horizontal
        sv.distribution = .equalSpacing
        sv.alignment = .fill
        sv.spacing = 5
        return sv
    }()
    
    var postId : Int?
    
    var pursuitId : Int?
    
    var posts = [Post]()
    var pursuits = [Post]()
    
    var prevFrame = CGRect.zero
    var avPlayer : AVPlayer?
    var layer: AVPlayerLayer?
    var progressBarTimer: Timer?
    var progressTimerIsOn = false
    var progressTimeTotal = 0.0
    var progressTimeRemaining = 0.0
    var progressTimerUnit = 0.0
    var currentStory: Story?
    var stories = [Story]()
    var currentStoryIndex = 0
    
    @objc func handleDismiss(){
        dismiss(animated: true, completion: nil)
    }

    @objc func handleViewMore(){
//        let engagementsView = PostEngagementsController(collectionViewLayout: UICollectionViewFlowLayout())
//        engagementsView.motionTransitionType = .cover(direction: .up)
  
    }
    
    // MARK: - Click left/right
    
    @objc func handleForward(){
        if !stories.isEmpty {
            if(self.currentStory == stories.last) {
             
            } else {
                self.nextStory()
            }
        }
    }
    
    func nextStory(){
//        let previousProgressView = self.progressStackView.subviews[currentStoryIndex] as! UIProgressView
//        previousProgressView.setProgress(1.0, animated: false)
        self.currentStoryIndex += 1
        self.currentStory = stories[self.currentStoryIndex]
        
        self.avPlayer?.replaceCurrentItem(with: self.currentStory?.avPlayerItem)
        layer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
        layer?.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: videoView.frame.height)
        self.videoView.layer.insertSublayer(layer!, below: containerView.layer)
        self.startTimer()
        DispatchQueue.main.async(execute: {
            self.setStory()
        })
    }
    
    @objc func handleBackward(){
        if !stories.isEmpty {
            if(self.currentStory == stories.first) {
                if self.currentStory?.videoName != nil {
                    self.avPlayer!.currentItem!.seek(to: CMTime.zero, completionHandler: nil)
                    self.avPlayer?.play()
                    self.startTimer()
                }
                } else {
                    self.prevStory()
                }
            }
    }
    
    func prevStory(){
//        let previousProgressView = self.progressStackView.subviews[currentStoryIndex] as! UIProgressView
//        previousProgressView.setProgress(0.0, animated: false)
        self.currentStoryIndex -= 1
        self.currentStory = stories[self.currentStoryIndex]
        
        self.avPlayer?.replaceCurrentItem(with: self.currentStory?.avPlayerItem)
        layer?.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: videoView.frame.height)
        layer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
        self.videoView.layer.insertSublayer(layer!, below: containerView.layer)
        self.startTimer()
        DispatchQueue.main.async(execute: {
            self.setStory()
        })
    }
    
    // MARK: - Add Data
    
    fileprivate func addDataToStory() {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd HH:mm:ss.SSSSSS"
        
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "MMM dd,yyyy"
        
        self.posts.forEach({ (value) in
            if let date = dateFormatterGet.date(from: (value.created_at)!) {
                let timeAgoDisplay = date.timeAgoDisplay()
                self.stories.append(Story(caption: value.posts_description, profileName: value.username, userPhoto: value.userPhotourl, time: timeAgoDisplay, videoName: value.videoUrl, thumbnailUrl: value.thumbnailUrl))
            } else {
                print("There was an error decoding the string")
            }
        })
        self.currentStory = self.stories.first
        
//        if pursuitId != nil {
//            DispatchQueue.main.async {
//                self.posts.forEach({ (value) in
//                    if let date = dateFormatterGet.date(from: (value.created_at)!) {
//                        let timeAgoDisplay = date.timeAgoDisplay()
//                        self.stories.append(Story(caption: value.posts_description, profileName: value.username, userPhoto: value.userPhotourl, time: timeAgoDisplay, videoName: value.videoUrl, thumbnailUrl: value.thumbnailUrl))
//                    } else {
//                        print("There was an error decoding the string")
//                    }
//                })
//                self.currentStory = self.stories.first
//            }
//        } else if pursuitId == nil {
//            DispatchQueue.main.async {
//                self.posts.forEach({ (value) in
//                    if let date = dateFormatterGet.date(from: (value.created_at)!) {
//                        let timeAgoDisplay = date.timeAgoDisplay()
//                        self.stories.append(Story(caption: value.posts_description, profileName: value.username, userPhoto: value.userPhotourl, time: timeAgoDisplay, videoName: value.videoUrl, thumbnailUrl: value.thumbnailUrl))
//                    } else {
//                        print("There was an error decoding the string")
//                    }
//                })
//                self.currentStory = self.stories.first
//            }
//        }
    }
    
    func setStory(){
        if self.currentStory != nil {
            if self.currentStory?.videoName != nil {
                self.imageView.isHidden = true
            } else {
                self.imageView.isHidden = false
            }
            
            self.postDetail.text = self.currentStory?.caption
            self.username.text = self.currentStory?.profileName
            self.timeLabel.text = self.currentStory?.time
            self.userPhoto.loadImageUsingCacheWithUrlString((self.currentStory?.userPhoto)!)
        }
    }
    
    // MARK: - Setup Video
    
    func initializeVideoPlayerWithVideo() {

        DispatchQueue.main.async(execute: {
            self.setStory()
        })
        
        self.avPlayer = AVPlayer(playerItem: self.currentStory?.avPlayerItem)
        
        layer = AVPlayerLayer(player: avPlayer)
        layer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
        layer?.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: videoView.frame.height)
        
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handleSwipeFunction))
        self.videoView.isUserInteractionEnabled = true
        self.videoView.addGestureRecognizer(panGestureRecognizer)
        self.videoView.layer.insertSublayer(layer!, below: containerView.layer)
        avPlayer?.play()
        
        if !self.progressTimerIsOn {
            self.avPlayer?.currentItem?.seek(to: CMTime.zero, completionHandler: nil)
            self.avPlayer?.play()
            self.startTimer()
        }
    }
    
    // MARK: - Setup Progress Bar
    
    fileprivate func setupMultipleProgressBar() {
        containerView.addSubview(progressStackView)
        
        progressStackView.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: containerView.leftAnchor, bottom: nil, right: containerView.rightAnchor, paddingTop: 8, paddingLeft: 8, paddingBottom: 0, paddingRight: 8, width: 0, height: 2.5)

        let gaps = self.stories.count
        let viewWidth = self.progressStackView.frame.width - CGFloat(gaps)
        let viewUnit = Int(viewWidth) / (stories.count + 1)
        for _ in stories {
            let progressView = UIProgressView()
            progressView.progress = 0
            progressView.layer.cornerRadius = 2
            progressView.layer.masksToBounds = true
            progressView.trackTintColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.3)
            progressView.progressTintColor = UIColor.white
            progressView.widthAnchor.constraint(equalToConstant: CGFloat(viewUnit)).isActive = true
            self.progressStackView.addArrangedSubview(progressView)
        }
        
        self.currentStory = stories.first
    }
    
    // MARK: - Setup Timer
    
    func startTimer(){
        self.stopTimer()
        guard let duration = self.currentStory?.videoDuration else { return }
        self.progressTimeTotal = duration
        self.progressTimeRemaining = self.progressTimeTotal
        self.progressTimerUnit = self.progressTimeTotal / 100.0
        self.progressBarTimer = Timer.scheduledTimer(timeInterval: self.progressTimerUnit, target: self, selector: #selector(self.progressTimerRunning), userInfo: nil, repeats: true)
        self.progressTimerIsOn = true
        self.avPlayer?.play()
    }
    
    func stopTimer(){
        progressBarTimer?.invalidate()
        self.progressTimerIsOn = false
//        let progressView = self.progressStackView.subviews[currentStoryIndex] as! UIProgressView
//        progressView.setProgress(0, animated: false)
    }
    
    @objc func progressTimerRunning(sender: Timer){
        progressTimeRemaining -= self.progressTimerUnit
//        let progressView = self.progressStackView.subviews[currentStoryIndex] as! UIProgressView
//        progressView.setProgress(((Float(progressTimeTotal) - Float(progressTimeRemaining))/Float(progressTimeTotal)), animated: true)
        if(progressTimeRemaining <= 0){
            if(self.currentStory == stories.last){
            }
            else {
                self.nextStory()
            }
        }
    }
    
    func setupVideoView(){
        videoView.backgroundColor = .black
        imageView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: (view.frame.height / 1.2) + 65)
        containerView.insertSubview(imageView, belowSubview: containerView)
        
        containerView.addSubview(forwardButton)
        containerView.addSubview(backwardButton)
        containerView.addSubview(cancelButton)
        containerView.addSubview(userPhoto)
        containerView.addSubview(postDetail)
        containerView.addSubview(username)
        containerView.addSubview(timeLabel)
       
        
        forwardButton.anchor(top: containerView.topAnchor, left: containerView.centerXAnchor, bottom: containerView.bottomAnchor, right: videoView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        backwardButton.anchor(top: containerView.topAnchor, left: containerView.leftAnchor, bottom: containerView.bottomAnchor, right: videoView.centerXAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
    
        
        setupMultipleProgressBar()

        cancelButton.anchor(top: progressStackView.bottomAnchor, left: nil, bottom: nil, right: containerView.rightAnchor, paddingTop: 18, paddingLeft: 0, paddingBottom: 0, paddingRight: 18, width: 16, height: 16)
        
        containerView.insertSubview(cancelBackground, belowSubview: cancelButton)
        cancelBackground.centerXAnchor.constraint(equalTo: cancelButton.centerXAnchor).isActive = true
        cancelBackground.centerYAnchor.constraint(equalTo: cancelButton.centerYAnchor).isActive = true
        cancelBackground.anchor(top: nil, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 36, height: 36)
        
        userPhoto.anchor(top: progressStackView.bottomAnchor, left: containerView.leftAnchor, bottom: nil, right: nil, paddingTop: 18, paddingLeft: 8, paddingBottom: 0, paddingRight: 0, width: 40, height: 40)
        username.anchor(top: userPhoto.topAnchor, left: userPhoto.rightAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft: 12, paddingBottom: 0, paddingRight: 24, width: 0, height: 16)
        timeLabel.anchor(top: username.bottomAnchor, left: username.leftAnchor, bottom: nil, right: nil, paddingTop: 8, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 14)
        postDetail.anchor(top: nil, left: containerView.leftAnchor, bottom: containerView.safeAreaLayoutGuide.bottomAnchor, right: containerView.rightAnchor, paddingTop: 0, paddingLeft: 12, paddingBottom: 28, paddingRight: 12, width: 0, height: 0)
        postDetail.heightAnchor.constraint(lessThanOrEqualToConstant: 52).isActive = true
    }
    
    func setupCollectionView(){
        view.addSubview(videoView)
        videoView.addSubview(containerView)
        videoView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: (view.frame.height / 1.2) + 45)
        
        containerView.anchor(top: videoView.topAnchor, left: videoView.leftAnchor, bottom: nil, right: videoView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: videoView.frame.height)
        
        collectionView?.parallaxHeader.view = videoView
        collectionView?.parallaxHeader.height = videoView.frame.height - 35
        collectionView?.parallaxHeader.minimumHeight = 0
        collectionView?.parallaxHeader.mode = .topFill
        collectionView?.alwaysBounceVertical = false
        collectionView?.showsVerticalScrollIndicator = false
        collectionView?.backgroundColor = .white
        collectionView?.register(PursuitDay.self, forCellWithReuseIdentifier: dayId)
        collectionView?.register(KeyPost.self, forCellWithReuseIdentifier: keyId)
        collectionView?.register(DetailTrying.self, forCellWithReuseIdentifier: tryingId)
        collectionView?.register(PostResponses.self, forCellWithReuseIdentifier: commentId)
        collectionView?.register(TeamList.self, forCellWithReuseIdentifier: teamId)
    }
    
    func changeToDetail(sentPostId : Int){
        let detail = PostDetailController(collectionViewLayout: UICollectionViewFlowLayout())
        detail.isProfile = false
        detail.pursuitId = pursuitId
        detail.postId = sentPostId
        present(detail, animated: true, completion: nil)
    }
    
    func handleChangeToTryDetail(sentPursuitId : Int) {
        let detail = PostDetailController(collectionViewLayout: UICollectionViewFlowLayout())
        detail.pursuitId = sentPursuitId
        detail.isProfile = true
        present(detail, animated: true, completion: nil)
    }
    
    var myTimer: Timer?
    var seconds = 1
    
    deinit {
        myTimer?.invalidate()
    }
    
    func handleShare(for cell: PursuitDay) {
        if let name = NSURL(string: "https://itunes.apple.com/us/app/inpursuit-social/id1446350125?ls=1&mt=8") {
            let activityController = UIActivityViewController(activityItems: ["Add me on inpursuit ", name], applicationActivities: nil)
            Mixpanel.mainInstance().track(event: "Post Shared")
            present(activityController, animated: true, completion: nil)
        }
        else
        {
            let alert = UIAlertController(title: "Share", message: "Share is not available for this device. Consider updating to iOS 11.", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.cancel, handler: dismissAlertView))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func dismissAlertView(action : UIAlertAction) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func handleKeyPostSave(for cell: KeyPost) {
        let customAlert = CustomSavePopover()
        customAlert.providesPresentationContextTransitionStyle = true
        customAlert.definesPresentationContext = true
        customAlert.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        customAlert.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        self.showDetailViewController(customAlert, sender: self)
    }
    
    func handleChangeToProfile(userId : String) {
        let profileController = ProfileController(collectionViewLayout: UICollectionViewFlowLayout())
        profileController.isForeignAccount = true
        profileController.userId = userId
        profileController.isDetailView = true
        present(profileController, animated: true, completion: nil)
    }
    
    func handleSave(for cell: PursuitDay) {
        guard let indexPath = collectionView?.indexPath(for: cell) else { return }
        let post = self.detailPost?.days?[indexPath.item]
        
        let customAlert = CustomSavePopover()
        customAlert.post = post
        customAlert.accessDetailController = self
        customAlert.providesPresentationContextTransitionStyle = true
        customAlert.definesPresentationContext = true
        customAlert.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        customAlert.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        self.showDetailViewController(customAlert, sender: self)
    }
    
    func handleTry(for cell: PursuitDay) {
        guard let indexPath = collectionView?.indexPath(for: cell) else { return }
        let post = self.detailPost?.days?[indexPath.item]
        
        let customAlert = CustomTryPopover()
        customAlert.pursuitId = pursuitId
        customAlert.post = post
        customAlert.providesPresentationContextTransitionStyle = true
        customAlert.definesPresentationContext = true
        customAlert.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        customAlert.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        self.showDetailViewController(customAlert, sender: self)
    }
    
    func handleMore(for cell: PursuitDay) {
        let customAlert = CustomMorePopover()
        customAlert.providesPresentationContextTransitionStyle = true
        customAlert.definesPresentationContext = true
        customAlert.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        customAlert.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        self.showDetailViewController(customAlert, sender: self)
    }
    
    func handleAddFriends(for cell: TeamList) {
        let customAlert = CustomFriendPopover()
        customAlert.pursuitId = pursuitId
        customAlert.providesPresentationContextTransitionStyle = true
        customAlert.definesPresentationContext = true
        customAlert.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        customAlert.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        self.showDetailViewController(customAlert, sender: self)
    }
    
    func handleViewMoreResponses() {
        let view = ResponseController(collectionViewLayout: UICollectionViewFlowLayout())
        view.pursuitId = pursuitId
        present(view, animated: true, completion: nil)
    }
    
    func handleResponse(for cell: PursuitDay) {
        let photoSelectorController = SelectCameraController()
        photoSelectorController.isResponse = true
        photoSelectorController.pursuitId = pursuitId
        let navController = UINavigationController(rootViewController: photoSelectorController)
        present(navController, animated: true, completion: nil)
    }
    
    func viewMore(for cell: KeyPost) {
        let view = KeyPostController(collectionViewLayout: UICollectionViewFlowLayout())
        view.pursuitId = pursuitId
        present(view, animated: true, completion: nil)
    }

    func handleInviteContacts(){
        let inviteController = InviteController(collectionViewLayout: UICollectionViewFlowLayout())
        present(inviteController, animated: true, completion: nil)
    }
    
    var detailPost: HomeDetail?
    var engagements : Engagements?
    var days = [HomeDetail]()
    let engagementsService = EngagementServices()
    
    @objc func refreshEngagements() {
        if isProfile == false {
            self.engagementsService.getSaveStatus(postId: postId) { (engagement) in
                self.engagements?.tried = engagement.tried
                self.engagementsService.getTrystatus(pursuitId: self.pursuitId) { (engagement) in
                    self.engagements?.saved = engagement.saved
                }
                self.collectionView?.reloadData()
            }
        }
    }
    
    func getEngagements() {
        if isProfile == false {
            self.engagementsService.getSaveStatus(postId: postId) { (engagement) in
                self.engagements?.tried = engagement.tried
                self.engagementsService.getTrystatus(pursuitId: self.pursuitId) { (engagement) in
                    self.engagements?.saved = engagement.saved
                }
            }
        }
    }
    
    func getDetailContent(){
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd HH:mm:ss.SSSSSS"
        
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "MMM dd,yyyy"
        
        if isProfile == false {
            
            homeService.getArrayOfPost(postId: postId, pursuitId: pursuitId) { (homeDetail) in
                DispatchQueue.main.async {
                    homeDetail.posts?.forEach({ (value) in
                        if let date = dateFormatterGet.date(from: (value.created_at)!) {
                            let timeAgoDisplay = date.timeAgoDisplay()
                            self.stories.append(Story(caption: value.posts_description, profileName: value.username, userPhoto: value.userPhotourl, time: timeAgoDisplay, videoName: value.videoUrl, thumbnailUrl: value.thumbnailUrl))
                        } else {
                            print("There was an error decoding the string")
                        }
                    })
                    
                    self.currentStory = self.stories.first
                    self.postDetail.text = self.currentStory?.caption
                    self.username.text = self.currentStory?.profileName
                    self.timeLabel.text = self.currentStory?.time
                    self.imageView.loadImageUsingCacheWithUrlString((self.currentStory?.thumbnailUrl)!)
                    self.userPhoto.loadImageUsingCacheWithUrlString((self.currentStory?.userPhoto)!)
                    self.initializeVideoPlayerWithVideo()
                }
                
                self.setupVideoView()
            }
        } else {
            profileService.getArrayOfProfilePost(pursuitId: pursuitId) { (homeDetail) in
                DispatchQueue.main.async {
                    homeDetail.posts?.forEach({ (value) in
                        if let date = dateFormatterGet.date(from: (value.created_at)!) {
                            let timeAgoDisplay = date.timeAgoDisplay()
                            self.stories.append(Story(caption: value.posts_description, profileName: value.username, userPhoto: value.userPhotourl, time: timeAgoDisplay, videoName: value.videoUrl, thumbnailUrl: value.thumbnailUrl))
                        } else {
                            print("There was an error decoding the string")
                        }
                    })
                    
                    self.currentStory = self.stories.first
                    self.postDetail.text = self.currentStory?.caption
                    self.username.text = self.currentStory?.profileName
                    self.timeLabel.text = self.currentStory?.time
                    self.imageView.loadImageUsingCacheWithUrlString((self.currentStory?.thumbnailUrl)!)
                    self.userPhoto.loadImageUsingCacheWithUrlString((self.currentStory?.userPhoto)!)
                    self.initializeVideoPlayerWithVideo()
                }

                self.setupVideoView()
            }
        }
        
        homeService.getHomeDetail(pursuitId: pursuitId) { (detail) in
            DispatchQueue.main.async{
                self.detailPost = detail
                self.getEngagements()
                self.collectionView?.reloadData()
            }
            
        }
    }
    
    @objc func reloadTeam(){
        engagementsService.getTeam(pursuitId: pursuitId) { (team) in
            self.detailPost?.team = team.first?.team
            self.collectionView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        avPlayer?.automaticallyWaitsToMinimizeStalling = false
        getDetailContent()
        setupCollectionView()
        hero.isEnabled = true
        setupVideoView()
        
        NotificationCenter.default.addObserver(self, selector: #selector(refreshEngagements), name: CustomTryPopover.updateEngagementsNotificationName, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(refreshEngagements), name: CustomSavePopover.updateEngagementsNotificationName, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(reloadTeam), name: CustomFriendPopover.updateTeamNotificationName, object: nil)
    }
    
    func handleEngagementChanges(){
        let configs = URLSessionConfiguration.default
        configs.httpAdditionalHeaders = ["Accept" : "text/event-stream"]
        
        let eventsource = TRVSEventSource(url: NSURL(string: "http://localhost:8080/engagements/post-saved")! as URL, sessionConfiguration: configs)
        eventsource?.delegate = self
        eventsource?.open()
    }
    
    // MARK: - Handle view options
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self, name: Notification.Name.AVPlayerItemDidPlayToEndTime, object: nil)
        if avPlayer != nil{
            avPlayer?.replaceCurrentItem(with: nil)
            avPlayer = nil
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(playerItemDidReachEnd(notification:)), name: Notification.Name.AVPlayerItemDidPlayToEndTime, object: self.avPlayer?.currentItem)
    }
    
    @objc func playerItemDidReachEnd(notification: Notification) {
        if let playerItem: AVPlayerItem = notification.object as? AVPlayerItem {
            playerItem.seek(to: CMTime.zero, completionHandler: nil)
            self.avPlayer?.play()
        }
    }
    
    
    @objc func handleSwipeFunction(panGesture : UIPanGestureRecognizer){
        let translation = panGesture.translation(in: nil)
        let progress = translation.y / 2 / view.bounds.height
        
        switch panGesture.state {
        case .began:
            hero.dismissViewController()
        case .changed:
            Hero.shared.update(progress)
        default:
            if progress + panGesture.velocity(in: nil).y / view.bounds.height > 0.2 {
                Hero.shared.finish()
            } else {
                Hero.shared.cancel()
            }
        }
    }
    
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
        if detailPost?.key_posts?.first?.postId == nil {
            return 4
        } else {
            return 5
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if detailPost?.key_posts?.first?.postId == nil {
            switch indexPath.item {
            case 0:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: dayId, for: indexPath) as! PursuitDay
                cell.days = detailPost?.days
                cell.engagements = engagements
                cell.delegate = self
                cell.accessPostDetailController = self
                return cell
            case 1:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: teamId, for: indexPath) as! TeamList
                cell.team = detailPost?.team
                cell.delegate = self
                cell.accessDetailController = self
                return cell
            case 2:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: tryingId, for: indexPath) as! DetailTrying
                cell.trying = detailPost?.trying
                cell.accessPostDetailController = self
                return cell
            default:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: commentId, for: indexPath) as! PostResponses
                cell.responses = detailPost?.responses
                cell.accessDetailController = self
                return cell
            }
        } else  {
            switch indexPath.item {
            case 0:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: dayId, for: indexPath) as! PursuitDay
                cell.days = detailPost?.days
                cell.engagements = engagements
                cell.delegate = self
                cell.accessPostDetailController = self
                return cell
            case 1:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: keyId, for: indexPath) as! KeyPost
                cell.keyPost = detailPost?.key_posts
                cell.delegate = self
                return cell
            case 2:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: teamId, for: indexPath) as! TeamList
                cell.team = detailPost?.team
                cell.delegate = self
                cell.accessDetailController = self
                return cell
            case 3:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: tryingId, for: indexPath) as! DetailTrying
                cell.trying = detailPost?.trying
                cell.accessPostDetailController = self
                return cell
            default:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: commentId, for: indexPath) as! PostResponses
                cell.responses = detailPost?.responses
                cell.accessDetailController = self
                return cell
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 60.0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 60.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if detailPost?.key_posts?.first?.postId == nil {
            switch indexPath.item {
            case 0:
                return CGSize(width: view.frame.width, height: 400)
            case 1:
                return CGSize(width: view.frame.width, height: 120)
            case 2:
                return CGSize(width: view.frame.width, height: 320)
            case 3:
               return CGSize(width: view.frame.width, height: 450)
            default:
                return CGSize(width: view.frame.width, height: 220)
            }
        } else {
            switch indexPath.item {
            case 0:
                return CGSize(width: view.frame.width, height: 400)
            case 1:
                return CGSize(width: view.frame.width, height: 520)
            case 2:
                return CGSize(width: view.frame.width, height: 120)
            case 3:
                return CGSize(width: view.frame.width, height: 320)
            case 4:
                return CGSize(width: view.frame.width, height: 450)
            default:
                return CGSize(width: view.frame.width, height: 220)
            }
        }
    }
}

extension PostDetailController : TRVSEventSourceDelegate  {
    
    private func eventSource(eventSource: TRVSEventSource!, didReceiveEvent event: TRVSServerSentEvent!) {
        do {
            let enagementResponse = try JSONDecoder().decode(Engagements.self, from: event.data)
            self.engagements = enagementResponse
            self.collectionView?.reloadData()
        }
        catch let error {
            print(error)
        }
    }
}
