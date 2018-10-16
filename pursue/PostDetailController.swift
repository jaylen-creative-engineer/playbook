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
import Mixpanel
import ParallaxHeader

class PostDetailController : UICollectionViewController, PursuitDayDelegate, KeyPostDelegate {

    let dayId = "dayId"
    let keyId = "keyId"
    let challengeId = "challengeId"
    let tryingId = "tryingId"
    let commentId = "commentId"
    let teamId = "teamId"
    
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
        return label
    }()
    
    let userPhoto : UIImageView = {
        let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "samuel-l").withRenderingMode(.alwaysOriginal)
        iv.contentMode = .scaleAspectFill
        iv.layer.cornerRadius = 20
        iv.layer.masksToBounds = true
        return iv
    }()
    
    let postDetail : UILabel = {
        let label = UILabel()
        label.text = "Travel On"
        label.numberOfLines = 0
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 24, weight: UIFont.Weight.init(25))
        label.textAlignment = .center
        return label
    }()
    
    let daysLabel : UILabel = {
        let label = UILabel()
        label.text = "20 Days"
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
        label.text = "Test"
        label.font = UIFont(name: "Lato-Bold", size: 14)
        label.textColor = .white
        return label
    }()
    
    let timeLabel : UILabel = {
        let label = UILabel()
        label.text = "Today"
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
    
    let progressStackView : UIStackView = {
       let sv = UIStackView()
        sv.axis = .horizontal
        sv.distribution = .equalSpacing
        sv.alignment = .fill
        sv.spacing = 5
        return sv
    }()
    
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
        present(PostEngagementsController(collectionViewLayout: UICollectionViewFlowLayout()), animated: true, completion: nil)
    }
    
    // MARK: - Click left/right
    
    @objc func handleForward(){
        if(self.currentStory == stories.last) {
            // Go to the end of video
            
        } else {
            self.nextStory()
        }
    }
    
    func nextStory(){
        let previousProgressView = self.progressStackView.subviews[currentStoryIndex] as! UIProgressView
        previousProgressView.setProgress(1.0, animated: false)
        self.currentStoryIndex += 1
        self.currentStory = stories[self.currentStoryIndex]
        self.avPlayer?.replaceCurrentItem(with: self.currentStory?.avPlayerItem)
//        layer?.frame = self.videoView.frame
//        self.videoView.layer.addSublayer(layer!)
        self.layer?.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: (view.frame.height / 1.2) + 20)
        layer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
        self.videoView.layer.addSublayer(layer!)
        self.startTimer()
        DispatchQueue.main.async(execute: {
        })
    }
    
    @objc func handleBackward(){
        if(self.currentStory == stories.first) {
            self.avPlayer!.currentItem!.seek(to: CMTime.zero, completionHandler: nil)
            self.avPlayer?.play()
            self.startTimer()
        } else {
            self.prevStory()
        }
    }
    
    func prevStory(){
        let previousProgressView = self.progressStackView.subviews[currentStoryIndex] as! UIProgressView
        previousProgressView.setProgress(0.0, animated: false)
        self.currentStoryIndex -= 1
        self.currentStory = stories[self.currentStoryIndex]
        self.avPlayer?.replaceCurrentItem(with: self.currentStory?.avPlayerItem)
//        layer?.frame = self.videoView.frame
        self.layer?.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: (view.frame.height / 1.2) + 20)
        layer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
        self.videoView.layer.addSublayer(layer!)
        self.startTimer()
        DispatchQueue.main.async(execute: {
            //Your main thread code goes in here
        })
    }
    
    // MARK: - Add Data
    
    fileprivate func addDataToStory() {
        self.stories.append(Story(caption: "Buck Bunny's Adventure 02", profileName: "Big Buck Bunny 02", description: "A small glimpse in a Big Buck Bunny's adventure", time: "2h ago", videoName: "video04"))
    }
    
    // MARK: - Setup Video
    
    func initializeVideoPlayerWithVideo() {

        DispatchQueue.main.async(execute: {
        })
    
        self.avPlayer = AVPlayer(playerItem: self.currentStory?.avPlayerItem)
        layer = AVPlayerLayer(player: avPlayer)
        self.layer?.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: (view.frame.height / 1.2) + 20)
        layer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
        
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handleSwipeFunction))
        
        self.videoView.isUserInteractionEnabled = true
        self.videoView.addGestureRecognizer(panGestureRecognizer)
        self.videoView.layer.addSublayer(layer!)
        avPlayer?.play()
        
        if !self.progressTimerIsOn {
            self.avPlayer?.currentItem?.seek(to: CMTime.zero, completionHandler: nil)
            self.avPlayer?.play()
            self.startTimer()
        }
    }
    
    // MARK: - Setup Progress Bar
    
    fileprivate func setupMultipleProgressBar() {
        addDataToStory()
        
        videoView.addSubview(progressStackView)
        
        progressStackView.anchor(top: containerView.safeAreaLayoutGuide.topAnchor, left: containerView.leftAnchor, bottom: nil, right: containerView.rightAnchor, paddingTop: view.frame.height / 4, paddingLeft: 8, paddingBottom: 0, paddingRight: 8, width: 0, height: 1.5)

        let gaps = self.stories.count
        let viewWidth = self.progressStackView.frame.width - CGFloat(gaps)
        let viewUnit = Int(viewWidth) / (stories.count + 1)
        for _ in stories {
            let progressView = UIProgressView()
            progressView.progress = 0
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
        let progressView = self.progressStackView.subviews[currentStoryIndex] as! UIProgressView
        progressView.setProgress(0, animated: false)
    }
    
    @objc func progressTimerRunning(sender: Timer){
        progressTimeRemaining -= self.progressTimerUnit
        let progressView = self.progressStackView.subviews[currentStoryIndex] as! UIProgressView
        progressView.setProgress(((Float(progressTimeTotal) - Float(progressTimeRemaining))/Float(progressTimeTotal)), animated: true)
        if(progressTimeRemaining <= 0){
            if(self.currentStory == stories.last){
                print("shrinked")
            }
            else {
                self.nextStory()
                print("next story")
            }
        }
    }
    
    func setupVideoView(){
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.backgroundColor = .white
        videoView.addSubview(containerView)
        
        containerView.addSubview(forwardButton)
        containerView.addSubview(backwardButton)
        containerView.addSubview(cancelButton)
        containerView.addSubview(userPhoto)
        containerView.addSubview(postType)
        containerView.addSubview(postDetail)
        containerView.addSubview(seperatorCircle)
        containerView.addSubview(daysLabel)
        containerView.addSubview(username)
        containerView.addSubview(timeLabel)
        
        containerView.anchor(top: videoView.topAnchor, left: videoView.leftAnchor, bottom: videoView.bottomAnchor, right: videoView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        forwardButton.anchor(top: containerView.topAnchor, left: containerView.centerXAnchor, bottom: containerView.bottomAnchor, right: containerView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        backwardButton.anchor(top: containerView.topAnchor, left: containerView.leftAnchor, bottom: containerView.bottomAnchor, right: containerView.centerXAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
    
        
        setupMultipleProgressBar()

        cancelButton.anchor(top: progressStackView.bottomAnchor, left: nil, bottom: nil, right: videoView.rightAnchor, paddingTop: 18, paddingLeft: 0, paddingBottom: 0, paddingRight: 18, width: 16, height: 16)
        userPhoto.anchor(top: progressStackView.bottomAnchor, left: videoView.leftAnchor, bottom: nil, right: nil, paddingTop: 18, paddingLeft: 8, paddingBottom: 0, paddingRight: 0, width: 40, height: 40)
        username.anchor(top: userPhoto.topAnchor, left: userPhoto.rightAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft: 12, paddingBottom: 0, paddingRight: 24, width: 0, height: 16)
        timeLabel.anchor(top: username.bottomAnchor, left: username.leftAnchor, bottom: nil, right: nil, paddingTop: 8, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 14)
        postDetail.anchor(top: timeLabel.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 24, paddingLeft: 12, paddingBottom: 0, paddingRight: 12, width: 0, height: 0)
        postDetail.heightAnchor.constraint(lessThanOrEqualToConstant: 52).isActive = true
        postDetail.centerXAnchor.constraint(equalTo: videoView.centerXAnchor).isActive = true
        postType.anchor(top: postDetail.bottomAnchor, left: videoView.leftAnchor, bottom: nil, right: nil, paddingTop: 12, paddingLeft: (view.frame.width / 3) - 12, paddingBottom: 0, paddingRight: 0, width: postType.intrinsicContentSize.width, height: 16)
        seperatorCircle.anchor(top: nil, left: postType.rightAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: 6, height: 6)
        seperatorCircle.centerYAnchor.constraint(equalTo: postType.centerYAnchor).isActive = true
        daysLabel.anchor(top: postDetail.bottomAnchor, left: seperatorCircle.rightAnchor, bottom: nil, right: nil, paddingTop: 12, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: daysLabel.intrinsicContentSize.width, height: 16)
        initializeVideoPlayerWithVideo()

    }
    
    func setupCollectionView(){
        videoView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height / 1.2)
        collectionView?.parallaxHeader.view = videoView
//        collectionView?.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        collectionView?.parallaxHeader.height = view.frame.height / 1.2
        collectionView?.parallaxHeader.minimumHeight = 0
        collectionView?.parallaxHeader.mode = .topFill
        collectionView?.alwaysBounceVertical = false
        collectionView?.showsVerticalScrollIndicator = false
        collectionView?.backgroundColor = .white
        collectionView?.register(PursuitDay.self, forCellWithReuseIdentifier: dayId)
        collectionView?.register(KeyPost.self, forCellWithReuseIdentifier: keyId)
        collectionView?.register(DetailChallenge.self, forCellWithReuseIdentifier: challengeId)
        collectionView?.register(DetailTrying.self, forCellWithReuseIdentifier: tryingId)
        collectionView?.register(PostComments.self, forCellWithReuseIdentifier: commentId)
        collectionView?.register(TeamList.self, forCellWithReuseIdentifier: teamId)
    }
    
    func handleShare(for cell: PursuitDay) {
        let activityController = UIActivityViewController(activityItems: [imageView.image ?? "", postDetail.text ?? "", daysLabel.text ?? ""], applicationActivities: nil)
        Mixpanel.mainInstance().track(event: "Post Shared")
        present(activityController, animated: true, completion: nil)
    }
    
    func handleSaveTap(){
        let customAlert = CustomPursuitPopover()
        customAlert.providesPresentationContextTransitionStyle = true
        customAlert.definesPresentationContext = true
        customAlert.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        customAlert.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        self.showDetailViewController(customAlert, sender: self)
    }
    
    func viewMore(for cell: KeyPost) {
        let view = KeyPostController(collectionViewLayout: UICollectionViewFlowLayout())
        present(view, animated: true, completion: nil)
    }
    
    func changeToChallenge(){
        let detail = ChallengeDetailController(collectionViewLayout: UICollectionViewFlowLayout())
        present(detail, animated: true, completion: nil)
    }
    
    func changeToComments(){
        let comments = CommentsController(collectionViewLayout: UICollectionViewFlowLayout())
        present(comments, animated: true, completion: nil)
    }
    
    func handleInviteContacts(){
        let inviteController = InviteController(collectionViewLayout: UICollectionViewFlowLayout())
        present(inviteController, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hero.isEnabled = true
        setupCollectionView()
        setupVideoView()
//        setupView()
//        addDataToStory()
//        progressBarStackViewSetup()
//        view.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(handlePan)))
    }
    
    // MARK: - Handle view options
    
    override func viewWillLayoutSubviews() {
        DispatchQueue.main.async(execute: {
            self.videoView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: (self.view.frame.height / 1.2))
        })
    }
//
    override func viewDidLayoutSubviews() {
        DispatchQueue.main.async(execute: {
            self.videoView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: (self.view.frame.height / 1.2))
        })
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self, name: Notification.Name.AVPlayerItemDidPlayToEndTime, object: nil)
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
    
    let engagementsView = PostEngagementsController()
    
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
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 10)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.item {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: dayId, for: indexPath) as! PursuitDay
            cell.delegate = self
            cell.accessPostDetailController = self
            return cell
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: keyId, for: indexPath) as! KeyPost
            cell.delegate = self
            return cell
        case 2:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: teamId, for: indexPath) as! TeamList
            cell.accessPostDetailController = self
            return cell
        case 3:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: tryingId, for: indexPath) as! DetailTrying
            return cell
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: commentId, for: indexPath) as! PostComments
            cell.accessPostDetailController = self
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 60.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 60.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch indexPath.item {
        case 0:
            return CGSize(width: view.frame.width, height: 380)
        case 1:
            return CGSize(width: view.frame.width, height: 520)
        case 2:
            return CGSize(width: view.frame.width, height: 160)
        case 3:
            return CGSize(width: view.frame.width, height: 300)
        default:
            return CGSize(width: view.frame.width, height: 220)
        }
    }
}

