//
//  VideoViewController.swift
//  pursue
//
//  Created by Jaylen Sanders on 2/20/18.
//  Copyright © 2018 Glory. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit
import Photos
import PryntTrimmerView

class VideoViewController: AssetSelectionViewController {
    
    var isResponse : Bool?
    var pursuitId : Int?
    
    lazy var cancelButton : UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "cancel").withRenderingMode(.alwaysTemplate), for: .normal)
        button.tintColor = .white
        button.contentMode = .scaleAspectFill
        button.addTarget(self, action: #selector(cancel), for: .touchUpInside)
        return button
    }()
    
    lazy var continueButton : UIButton = {
        let cv = UIButton()
        cv.backgroundColor = .white
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.layer.cornerRadius = 20
        cv.layer.masksToBounds = true
        cv.addTarget(self, action: #selector(handlePursuit), for: .touchUpInside)
        return cv
    }()
    
    lazy var forwardArrow : UIImageView = {
        let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "forward-arrow").withRenderingMode(.alwaysOriginal)
        iv.contentMode = .scaleAspectFill
        iv.translatesAutoresizingMaskIntoConstraints = false
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handlePursuit))
        tap.numberOfTapsRequired = 1
        iv.addGestureRecognizer(tap)
        return iv
    }()
    
    lazy var saveIcon : UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "save").withRenderingMode(.alwaysTemplate), for: .normal)
        button.tintColor = .white
        button.contentMode = .scaleAspectFill
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleSave), for: .touchUpInside)
        return button
    }()
    
    lazy var saveLabel  : UILabel = {
        let label = UILabel()
        label.text = "Save"
        label.font = .systemFont(ofSize: 12)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleSave))
        tap.numberOfTapsRequired = 1
        label.addGestureRecognizer(tap)
        return label
    }()
    
    lazy var saveBackground : UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleSave), for: .touchUpInside)
        return button
    }()
    
    lazy var cancelBackground : UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 19
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(handleDismiss), for: .touchUpInside)
        return button
    }()
    
    var playbackTimeCheckerTimer: Timer?
    var trimmerPositionChangedTimer: Timer?
    var is_principle = 0
    var is_step = 0
    
    func generateThumnail(url : URL, fromTime:Float64) -> UIImage {
        let asset = AVAsset(url: url)
        let assetImgGenerate = AVAssetImageGenerator(asset: asset)
        assetImgGenerate.appliesPreferredTrackTransform = true
        assetImgGenerate.requestedTimeToleranceAfter = CMTime.zero;
        assetImgGenerate.requestedTimeToleranceBefore = CMTime.zero;
        let time = CMTimeMakeWithSeconds(fromTime, preferredTimescale: 600)
        
        do {
            
            let img = try assetImgGenerate.copyCGImage(at: time, actualTime: nil)
            let image : UIImage = UIImage.init(cgImage: img)
            return image
            
         } catch let error as NSError {
            
            print("Image generation failed with error \(error)")
            return UIImage(color: .clear)!
        }
    }
    
    @objc func handleDismiss(){
        dismiss(animated: true, completion: nil)
    }
    
    @objc func handlePursuit(){
        if isResponse == true {
            guard let url = videoURL else { return }
            let image = generateThumnail(url: url, fromTime: Float64(0.10))
            let customAlert = CaptureResponseView()
            customAlert.respondImageView.image = image
            customAlert.pursuitId = pursuitId
            customAlert.thumbnailImage = image
            customAlert.videoURL = url
            customAlert.providesPresentationContextTransitionStyle = true
            customAlert.definesPresentationContext = true
            customAlert.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
            customAlert.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
            self.showDetailViewController(customAlert, sender: self)
        } else {
            guard let url = videoURL else { return }
            let image = generateThumnail(url: url, fromTime: Float64(0.10))
            let customAlert = CaptureDetailView()
            customAlert.thumbnailImage = image
            customAlert.videoURL = url
            customAlert.providesPresentationContextTransitionStyle = true
            customAlert.definesPresentationContext = true
            customAlert.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
            customAlert.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
            self.showDetailViewController(customAlert, sender: self)
        }
    }
    
    
    @objc func handleSave(){
        PHPhotoLibrary.shared().performChanges({
            PHAssetChangeRequest.creationRequestForAssetFromVideo(atFileURL: self.videoURL!)
        }) { saved, error in
            if saved {
                let alertController = UIAlertController(title: "Your video was successfully saved", message: nil, preferredStyle: .alert)
                let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                alertController.addAction(defaultAction)
                self.present(alertController, animated: true, completion: nil)
            }
        }
    }
    
    @objc func handleHighlight () {
    }
    
    var videoURL: URL?
    var player: AVPlayer?
    var playerController : AVPlayerViewController?
    
    func setupView(){
        view.addSubview(playerController!.view)
        view.addSubview(saveLabel)
        view.addSubview(saveIcon)
        view.addSubview(saveBackground)
        view.addSubview(cancelButton)
        view.addSubview(cancelBackground)
        view.addSubview(continueButton)
        view.addSubview(forwardArrow)
        
        playerController!.view.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        saveLabel.anchor(top: nil, left: playerController?.view.safeAreaLayoutGuide.leftAnchor, bottom: continueButton.bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 18, paddingBottom: 0, paddingRight: 0, width: saveLabel.intrinsicContentSize.width, height: saveLabel.intrinsicContentSize.height)
        saveIcon.anchor(top: nil, left: nil, bottom: saveLabel.topAnchor, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 12, paddingRight: 0, width: 20, height: 20)
        saveIcon.centerXAnchor.constraint(equalTo: saveLabel.centerXAnchor).isActive = true
        saveBackground.anchor(top: saveIcon.topAnchor, left: saveLabel.leftAnchor, bottom: saveLabel.bottomAnchor, right: saveLabel.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        cancelButton.anchor(top: playerController?.view.safeAreaLayoutGuide.topAnchor, left: playerController?.view.safeAreaLayoutGuide.leftAnchor, bottom: nil, right: nil, paddingTop: 12, paddingLeft: 18, paddingBottom: 0, paddingRight: 0, width: 15, height: 15)
        
        cancelBackground.centerXAnchor.constraint(equalTo: cancelButton.centerXAnchor).isActive = true
        cancelBackground.centerYAnchor.constraint(equalTo: cancelButton.centerYAnchor).isActive = true
        cancelBackground.anchor(top: nil, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 38, height: 38)
        
        continueButton.anchor(top: nil, left: nil, bottom: playerController?.view.safeAreaLayoutGuide.bottomAnchor, right: playerController?.view.safeAreaLayoutGuide.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 12, paddingRight: 24, width: 40, height: 40)
        forwardArrow.anchor(top: nil, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 15, height: 10)
        forwardArrow.centerXAnchor.constraint(equalTo: continueButton.centerXAnchor).isActive = true
        forwardArrow.centerYAnchor.constraint(equalTo: continueButton.centerYAnchor).isActive = true
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        
        player = AVPlayer(url: videoURL!)
        playerController = AVPlayerViewController()
        playerController?.videoGravity = convertToAVLayerVideoGravity(AVLayerVideoGravity.resizeAspectFill.rawValue)
        player?.play()
        
        guard player != nil && playerController != nil else { return }
        playerController!.showsPlaybackControls = false
        playerController!.player = player!
        self.addChild(playerController!)
        setupView()
        NotificationCenter.default.addObserver(self, selector: #selector(playerItemDidReachEnd), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: self.player!.currentItem)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        player?.play()
        startPlaybackTimeChecker()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        player?.pause()
        stopPlaybackTimeChecker()
        
        NotificationCenter.default.removeObserver(self, name: Notification.Name.AVPlayerItemDidPlayToEndTime, object: nil)
        if player != nil{
            player?.replaceCurrentItem(with: nil)
            player = nil
        }
    }
    
    @objc func cancel() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc fileprivate func playerItemDidReachEnd(_ notification: Notification) {
        if self.player != nil {
            self.player!.play()
        }
    }
    
    // MARK: - Trim Video
    var isCrop = false
    
    @objc func loadVideo() {
        // override in subclass
//        isCrop = !isCrop
//        if isCrop == true {
//            let asset = AVAsset(url: videoURL!)
//            trimmerView.asset = asset
//            trimmerView.isHidden = false
//        } else {
//            trimmerView.isHidden = true
//        }
    }

    func startPlaybackTimeChecker() {
        stopPlaybackTimeChecker()
        playbackTimeCheckerTimer = Timer.scheduledTimer(timeInterval: 0.1, target: self,
                                                        selector:
            #selector(onPlaybackTimeChecker), userInfo: nil, repeats: true)
    }
    
    func stopPlaybackTimeChecker() {
        playbackTimeCheckerTimer?.invalidate()
        playbackTimeCheckerTimer = nil
    }
    
    @objc func onPlaybackTimeChecker() {
        
//        guard let startTime = trimmerView.startTime, let endTime = trimmerView.endTime, let player = player else { return }
//
//        let playBackTime = player.currentTime()
//        trimmerView.seek(to: playBackTime)
//
//        if playBackTime >= endTime {
//            player.seek(to: startTime, toleranceBefore: CMTime.zero, toleranceAfter: CMTime.zero)
//            trimmerView.seek(to: startTime)
//        }
    }

}

extension VideoViewController: TrimmerViewDelegate {
    
    func positionBarStoppedMoving(_ playerTime: CMTime) {
        player?.seek(to: playerTime, toleranceBefore: CMTime.zero, toleranceAfter: CMTime.zero)
        player?.play()
        startPlaybackTimeChecker()
    }
    
    func didChangePositionBar(_ playerTime: CMTime) {
        stopPlaybackTimeChecker()
        player?.pause()
        player?.seek(to: playerTime, toleranceBefore: CMTime.zero, toleranceAfter: CMTime.zero)
//        let _ = (trimmerView.endTime! - trimmerView.startTime!).seconds
    }
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertToAVLayerVideoGravity(_ input: String) -> AVLayerVideoGravity {
	return AVLayerVideoGravity(rawValue: input)
}
