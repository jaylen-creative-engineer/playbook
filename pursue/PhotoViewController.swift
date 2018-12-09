//
//  PhotoViewController.swift
//  pursue
//
//  Created by Jaylen Sanders on 2/20/18.
//  Copyright © 2018 Glory. All rights reserved.
//

import UIKit
import Photos
import Mixpanel
import AVFoundation
import AVKit

class PhotoViewController: UIViewController, UIImagePickerControllerDelegate {
    
    private var backgroundImage: UIImage?
    var asset: PHAsset?
    var assetCollection: PHAssetCollection?
    var isResponse : Bool?
    var pursuitId : Int?
    
    var videoURL: URL?
    var player: AVPlayer?
    var videoLayer: AVPlayerLayer?
    var playerController : AVPlayerViewController?
    let videoView = UIView()
    let containerView = UIView()
    
    var targetSize: CGSize {
        let scale = UIScreen.main.scale
        return CGSize(width: backgroundImageView.bounds.width * scale,
                      height: backgroundImageView.bounds.height * scale)
    }
    
    lazy var backgroundImageView : UIImageView = {
        let iv = UIImageView()
        iv.image = backgroundImage
        iv.contentMode = .scaleAspectFill
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.layer.cornerRadius = 4
        iv.layer.masksToBounds = true
        return iv
    }()
    
    lazy var backgroundWhiteFill : UIView = {
       let view = UIView()
        view.backgroundColor = UIColor.init(white: 0.7, alpha: 0.7)
        view.layer.cornerRadius = 20
        view.layer.masksToBounds = true
        return view
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
        label.font = .systemFont(ofSize: 14)
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
        button.layer.cornerRadius = 19
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(handleDismiss), for: .touchUpInside)
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
//        iv.tintColor = .white
        iv.contentMode = .scaleAspectFill
        iv.translatesAutoresizingMaskIntoConstraints = false
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handlePursuit))
        tap.numberOfTapsRequired = 1
        iv.addGestureRecognizer(tap)
        return iv
    }()
    
    @objc func handlePursuit(){
        if isResponse == true {
            let customAlert = CaptureResponseView()
            customAlert.respondImageView.image = backgroundImageView.image!
            customAlert.pursuitId = pursuitId
            customAlert.providesPresentationContextTransitionStyle = true
            customAlert.definesPresentationContext = true
            customAlert.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
            customAlert.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
            self.showDetailViewController(customAlert, sender: self)
        } else {
            let customAlert = CaptureDetailView()
            customAlert.thumbnailImage = backgroundImageView.image!
            customAlert.providesPresentationContextTransitionStyle = true
            customAlert.definesPresentationContext = true
            customAlert.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
            customAlert.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
            self.showDetailViewController(customAlert, sender: self)
        }
    }
    
    @objc func handleSave(){
        if backgroundImage != nil {
            UIImageWriteToSavedPhotosAlbum(backgroundImage!, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
        } else {
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
    }
    
    @objc func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            let ac = UIAlertController(title: "Save error", message: error.localizedDescription, preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            present(ac, animated: true)
        } else {
            let ac = UIAlertController(title: "Saved!", message: "Your altered image has been saved to your photos.", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            present(ac, animated: true)
        }
    }
    
    func generateThumnail(url : URL, fromTime:Float64) -> UIImage {
        let asset = AVAsset(url: url)
        let assetImgGenerate = AVAssetImageGenerator(asset: asset)
        assetImgGenerate.appliesPreferredTrackTransform = true
        assetImgGenerate.requestedTimeToleranceAfter = CMTime.zero;
        assetImgGenerate.requestedTimeToleranceBefore = CMTime.zero;
        let time = CMTimeMakeWithSeconds(fromTime, preferredTimescale: 600)
        
        do {
            let img = try assetImgGenerate.copyCGImage(at: time, actualTime: nil)
            let image = UIImage.init(cgImage: img)
            return image
        } catch let error as NSError {
            
            print("Image generation failed with error \(error)")
            return UIImage(color: .clear)!
        }
    }
    
    @objc func handleHighlight () {
    }
    
    func updateStillImage() {
        let options = PHImageRequestOptions()
        options.deliveryMode = .highQualityFormat
        options.isNetworkAccessAllowed = true
        
        if asset != nil {
            PHImageManager.default().requestImage(for: asset!, targetSize: targetSize,
                contentMode: .aspectFill, options: options, resultHandler: { image, _ in
                                                    
                    guard let convertedImage = image else { return }
                    self.backgroundImageView.isHidden = false
                    self.backgroundImageView.image = convertedImage
            })
        }
    }
    
    @objc func handleDismiss(){
        self.dismiss(animated: true, completion: nil)
    }
    
    func submitPursuit(){
        Mixpanel.initialize(token: "Pursuit created")
    }
    
    fileprivate func convertToAVLayerVideoGravity(_ input: String) -> AVLayerVideoGravity {
        return AVLayerVideoGravity(rawValue: input)
    }
    
    @objc fileprivate func playerItemDidReachEnd(_ notification: Notification) {
        if self.player != nil {
            self.player!.pause()
        }
    }
    
    func setupVideo(){
        if videoURL != nil {
            player = AVPlayer(url: videoURL!)
            playerController = AVPlayerViewController()
            playerController?.videoGravity = convertToAVLayerVideoGravity(AVLayerVideoGravity.resizeAspectFill.rawValue)
            
            guard player != nil && playerController != nil else { return }
            playerController!.showsPlaybackControls = false
            playerController!.player = player!
            self.addChild(playerController!)
            view.addSubview(playerController!.view)
            
            playerController!.view.anchor(top: cancelButton.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 32, paddingLeft: 42, paddingBottom: 0, paddingRight: 42, width: 0, height: view.frame.height / 2)
            
            view.addSubview(saveLabel)
            view.addSubview(saveIcon)
            view.addSubview(saveBackground)
            
            saveLabel.anchor(top: nil, left: playerController?.view.safeAreaLayoutGuide.leftAnchor, bottom: continueButton.bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 18, paddingBottom: 0, paddingRight: 0, width: saveLabel.intrinsicContentSize.width, height: saveLabel.intrinsicContentSize.height)
            saveIcon.anchor(top: nil, left: nil, bottom: saveLabel.topAnchor, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 12, paddingRight: 0, width: 20, height: 20)
            saveIcon.centerXAnchor.constraint(equalTo: saveLabel.centerXAnchor).isActive = true
            saveBackground.anchor(top: saveIcon.topAnchor, left: saveLabel.leftAnchor, bottom: saveLabel.bottomAnchor, right: saveLabel.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
            
            view.addSubview(cancelButton)
            view.addSubview(continueButton)
            view.addSubview(forwardArrow)
            
            cancelButton.anchor(top: playerController?.view.safeAreaLayoutGuide.topAnchor, left: playerController?.view.safeAreaLayoutGuide.leftAnchor, bottom: nil, right: nil, paddingTop: 12, paddingLeft: 18, paddingBottom: 0, paddingRight: 0, width: 15, height: 15)
            
            view.addSubview(cancelBackground)
            cancelBackground.centerXAnchor.constraint(equalTo: cancelButton.centerXAnchor).isActive = true
            cancelBackground.centerYAnchor.constraint(equalTo: cancelButton.centerYAnchor).isActive = true
            cancelBackground.anchor(top: nil, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 38, height: 38)
            
            continueButton.anchor(top: nil, left: nil, bottom: playerController?.view.safeAreaLayoutGuide.bottomAnchor, right: playerController?.view.safeAreaLayoutGuide.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 12, paddingRight: 24, width: 40, height: 40)
            forwardArrow.anchor(top: nil, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 15, height: 10)
            forwardArrow.centerXAnchor.constraint(equalTo: continueButton.centerXAnchor).isActive = true
            forwardArrow.centerYAnchor.constraint(equalTo: continueButton.centerYAnchor).isActive = true
            
            NotificationCenter.default.addObserver(self, selector: #selector(playerItemDidReachEnd), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: self.player!.currentItem)
        }
    }

    func setupPage(){
        view.addSubview(backgroundImageView)
        view.addSubview(cancelButton)
        view.addSubview(continueButton)
        view.addSubview(forwardArrow)
        
         backgroundImageView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        cancelButton.anchor(top: backgroundImageView.safeAreaLayoutGuide.topAnchor, left: backgroundImageView.safeAreaLayoutGuide.leftAnchor, bottom: nil, right: nil, paddingTop: 12, paddingLeft: 18, paddingBottom: 0, paddingRight: 0, width: 15, height: 15)
        
        view.addSubview(cancelBackground)
        cancelBackground.centerXAnchor.constraint(equalTo: cancelButton.centerXAnchor).isActive = true
        cancelBackground.centerYAnchor.constraint(equalTo: cancelButton.centerYAnchor).isActive = true
        cancelBackground.anchor(top: nil, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 38, height: 38)
        
        continueButton.anchor(top: nil, left: nil, bottom: backgroundImageView.safeAreaLayoutGuide.bottomAnchor, right: backgroundImageView.safeAreaLayoutGuide.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 12, paddingRight: 24, width: 40, height: 40)
        forwardArrow.anchor(top: nil, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 15, height: 10)
        forwardArrow.centerXAnchor.constraint(equalTo: continueButton.centerXAnchor).isActive = true
        forwardArrow.centerYAnchor.constraint(equalTo: continueButton.centerYAnchor).isActive = true
        
        view.addSubview(saveLabel)
        view.addSubview(saveIcon)
        view.addSubview(saveBackground)
        
        saveLabel.anchor(top: nil, left: backgroundImageView.safeAreaLayoutGuide.leftAnchor, bottom: continueButton.bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 18, paddingBottom: 0, paddingRight: 0, width: saveLabel.intrinsicContentSize.width, height: saveLabel.intrinsicContentSize.height)
        saveIcon.anchor(top: nil, left: nil, bottom: saveLabel.topAnchor, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 12, paddingRight: 0, width: 20, height: 20)
        saveIcon.centerXAnchor.constraint(equalTo: saveLabel.centerXAnchor).isActive = true
        saveBackground.anchor(top: saveIcon.topAnchor, left: saveLabel.leftAnchor, bottom: saveLabel.bottomAnchor, right: saveLabel.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
    }
    
    func setupView(){
        
        if videoURL != nil {
            setupVideo()
        } else {
            setupPage()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        setupView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if videoURL != nil {
             player?.play()
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        if videoURL != nil {
            player?.pause()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        view.layoutIfNeeded()
        updateStillImage()
    }
}
