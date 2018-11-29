//
//  SelectCameraController.swift
//  pursue
//
//  Created by Jaylen Sanders on 12/1/17.
//  Copyright © 2017 Glory. All rights reserved.
//

import UIKit
import Photos


class SelectCameraController : SwiftyCamViewController, SwiftyCamViewControllerDelegate, UIViewControllerTransitioningDelegate {
    
    let libraryId = "libraryId"
    let cameraId = "cameraId"
    var allPhotos : PHFetchResult<PHAsset>!
    var arrPost : [Post] = []
    
    var seconds = 2
    var timer = Timer()
    var isTimerRunning = false
    var progressBarTimer: Timer?
    var progressTimerIsOn = false
    var progressTimeTotal = 0.0
    var progressTimeRemaining = 0.0
    var progressTimerUnit = 0.0
    
    var isResponse : Bool?
    var pursuitId : Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cameraDelegate = self
        maximumVideoDuration = 20.0
        shouldUseDeviceOrientation = true
        allowAutoRotate = true
        audioEnabled = true
        allowBackgroundAudio = true
        defaultCamera = .front
        flashMode = .auto
        setupView()
        getAssetFromPhoto()
    }
    
    lazy var captureButton : SwiftyRecordButton = {
        let button = SwiftyRecordButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor.init(white: 0.7, alpha: 0.5)
        button.layer.borderWidth = 4
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.cornerRadius = 35
        button.layer.masksToBounds = true
        button.delegate = self
        return button
    }()
    
    lazy var flipCameraButton : UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "swap_arrows").withRenderingMode(.alwaysTemplate), for: .normal)
        button.contentMode = .scaleAspectFill
        button.tintColor = .white
        button.addTarget(self, action: #selector(cameraSwitchTapped), for: .touchUpInside)
        return button
    }()
    
    lazy var flipBackground : UIButton = {
       let button = UIButton()
        button.layer.cornerRadius = 19
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(cameraSwitchTapped), for: .touchUpInside)
        return button
    }()
    
    lazy var flashButton : UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "flash").withRenderingMode(.alwaysTemplate), for: .normal)
        button.contentMode = .scaleAspectFill
        button.tintColor = .white
        button.addTarget(self, action: #selector(toggleFlash), for: .touchUpInside)
        return button
    }()
    
    lazy var flashBackground : UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 19
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(toggleFlash), for: .touchUpInside)
        return button
    }()
    
    lazy var cancelFlashLine : ViewWithDiagonalLine = {
        let v = ViewWithDiagonalLine()
        let tap = UITapGestureRecognizer(target: self, action: #selector(toggleFlash))
        tap.numberOfTapsRequired = 1
        v.addGestureRecognizer(tap)
        return v
    }()
    
    let captureProgressTrack : UIProgressView = {
        let view = UIProgressView()
        view.trackTintColor = .black
        view.progressTintColor = .white
        view.layer.cornerRadius = 2
        view.layer.masksToBounds = true
        return view
    }()
    
    lazy var cancelButton : UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "cancel").withRenderingMode(.alwaysTemplate), for: .normal)
        button.contentMode = .scaleAspectFill
        button.tintColor = .white
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
    
    lazy var photoLibraryButton : UIButton = {
        let button = UIButton()
        button.contentMode = .scaleAspectFill
        button.layer.cornerRadius = 4
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(handleLibrary), for: .touchUpInside)
        return button
    }()
    
    @objc func handleLibrary(){
        let libraryController = PhotoLibrary()
        libraryController.pursuitId = pursuitId
        libraryController.isResponse = isResponse
        libraryController.fetchResult = allPhotos
        libraryController.photoLibraryButton.setImage(photoLibraryButton.imageView?.image, for: .normal)
        present(libraryController, animated: true, completion: nil)
    }
    
    var photos : PHFetchResult<PHAsset>!
    fileprivate let imageManager = PHCachingImageManager()
    
    func getAssetFromPhoto(){
        let allPhotosOptions = PHFetchOptions()
        allPhotosOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: true)]
        allPhotos = PHAsset.fetchAssets(with: allPhotosOptions)
        
        DispatchQueue.main.async {
            self.allPhotos.enumerateObjects({ (asset, count, stop) in
                let targetSize = CGSize(width: 200, height: 200)
                self.imageManager.requestImage(for: asset, targetSize: targetSize, contentMode: .aspectFit, options: nil) { (image, _) in
                    self.photoLibraryButton.setImage(image, for: .normal)
                }
            })
        }
    }
    
    @objc func handleDismiss(){
        dismiss(animated: true, completion: nil)
    }
    
    
    @objc func toggleFlash(){
        if flashMode == .auto{
            flashMode = .on
             cancelFlashLine.isHidden = true
        }else if flashMode == .on{
            flashMode = .off
            cancelFlashLine.isHidden = false
        }else if flashMode == .off{
            flashMode = .auto
            cancelFlashLine.isHidden = false
        }
    }
    
    func setupView(){
        view.addSubview(captureButton)
        view.addSubview(flipCameraButton)
        view.addSubview(photoLibraryButton)
        view.addSubview(flashButton)
        view.addSubview(cancelFlashLine)
        
        captureButton.anchor(top: nil, left: nil, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 12, paddingRight: 0, width: 70, height: 70)
        captureButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        flipCameraButton.anchor(top: nil, left: nil, bottom: captureButton.topAnchor, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 32, paddingRight: 24, width: 28, height: 20)
        flipCameraButton.centerXAnchor.constraint(equalTo: captureButton.centerXAnchor).isActive = true
        
        view.addSubview(flipBackground)
        flipBackground.centerXAnchor.constraint(equalTo: flipCameraButton.centerXAnchor).isActive = true
        flipBackground.centerYAnchor.constraint(equalTo: flipCameraButton.centerYAnchor).isActive = true
        flipBackground.anchor(top: nil, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 38, height: 38)
        
        flashButton.anchor(top: nil, left: nil, bottom: nil, right: view.safeAreaLayoutGuide.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 48, width: 20, height: 25)
        flashButton.centerYAnchor.constraint(equalTo: captureButton.centerYAnchor).isActive = true
        
        view.addSubview(flashBackground)
        flashBackground.centerXAnchor.constraint(equalTo: flashButton.centerXAnchor).isActive = true
        flashBackground.centerYAnchor.constraint(equalTo: flashButton.centerYAnchor).isActive = true
        flashBackground.anchor(top: nil, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 38, height: 38)
        
        cancelFlashLine.anchor(top: flashButton.topAnchor, left: flashButton.leftAnchor, bottom: flashButton.bottomAnchor, right: flashButton.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        photoLibraryButton.anchor(top: nil, left: view.safeAreaLayoutGuide.leftAnchor, bottom: nil, right: nil, paddingTop: 12, paddingLeft: 48, paddingBottom: 0, paddingRight: 0, width: 28, height: 28)
        photoLibraryButton.centerYAnchor.constraint(equalTo: captureButton.centerYAnchor).isActive = true
        setupTopOptions()
    }
    
    func setupTopOptions(){
        view.addSubview(cancelButton)
        cancelButton.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.safeAreaLayoutGuide.leftAnchor, bottom: nil, right: nil, paddingTop: 12, paddingLeft: 18, paddingBottom: 0, paddingRight: 0, width: 15, height: 15)
        
        view.addSubview(cancelBackground)
        cancelBackground.centerXAnchor.constraint(equalTo: cancelButton.centerXAnchor).isActive = true
        cancelBackground.centerYAnchor.constraint(equalTo: cancelButton.centerYAnchor).isActive = true
        cancelBackground.anchor(top: nil, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 38, height: 38)
    }
    
    @objc func cameraSwitchTapped(){
        switchCamera()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        captureButton.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.navigationBar.isHidden = true
        tabBarController?.tabBar.isHidden = true
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    func swiftyCam(_ swiftyCam: SwiftyCamViewController, didTake photo: UIImage) {
        let newVC = PhotoViewController()
        newVC.pursuitId = pursuitId
        newVC.isResponse = isResponse
        newVC.backgroundImageView.image = photo
        self.present(newVC, animated: true, completion: nil)
    }
    
     func swiftyCamDidFailToConfigure(_ swiftyCam: SwiftyCamViewController) {
        let message = NSLocalizedString("Unable to capture media", comment: "Alert message when something goes wrong during capture session configuration")
        let alertController = UIAlertController(title: "AVCam", message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Alert OK button"), style: .cancel, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
    
    func swiftyCam(_ swiftyCam: SwiftyCamViewController, didBeginRecordingVideo camera: SwiftyCamViewController.CameraSelection) {
        captureButton.growButton()
        UIView.animate(withDuration: 0.25, animations: {
            self.flashButton.alpha = 0.0
            self.photoLibraryButton.alpha = 0.0
            self.cancelFlashLine.alpha = 0.0
            self.flipCameraButton.alpha = 0.0
            self.cancelButton.alpha = 0.0
        })
    }
    
    func swiftyCam(_ swiftyCam: SwiftyCamViewController, didFinishRecordingVideo camera: SwiftyCamViewController.CameraSelection) {
        captureButton.shrinkButton()
        UIView.animate(withDuration: 0.25, animations: {
            self.flashButton.alpha = 1.0
            self.photoLibraryButton.alpha = 1.0
            self.cancelFlashLine.alpha = 1.0
            self.flipCameraButton.alpha = 1.0
            self.cancelButton.alpha = 1.0
        })
    }
    
    func swiftyCam(_ swiftyCam: SwiftyCamViewController, didFinishProcessVideoAt url: URL) {
        let newVC = VideoViewController()
        newVC.pursuitId = pursuitId
        newVC.isResponse = isResponse
        newVC.videoURL = url
        self.present(newVC, animated: true, completion: nil)
    }
    
    func swiftyCamSessionDidStartRunning(_ swiftyCam: SwiftyCamViewController) {
        captureButton.isEnabled = true
    }
    
    func swiftyCamSessionDidStopRunning(_ swiftyCam: SwiftyCamViewController) {
        captureButton.isEnabled = false
    }
    
    func swiftyCam(_ swiftyCam: SwiftyCamViewController, didChangeZoomLevel zoom: CGFloat) {
        print(zoom)
    }
    
    func swiftyCam(_ swiftyCam: SwiftyCamViewController, didSwitchCameras camera: SwiftyCamViewController.CameraSelection) {
        print(camera)
    }
    
    func swiftyCam(_ swiftyCam: SwiftyCamViewController, didFailToRecordVideo error: Error) {
        print(error)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
    
}

// MARK: PHPhotoLibraryChangeObserver
extension SelectCameraController : PHPhotoLibraryChangeObserver {
    
    func photoLibraryDidChange(_ changeInstance: PHChange) {
        DispatchQueue.main.async {
            if let changeDetails = changeInstance.changeDetails(for: self.allPhotos) {
                self.allPhotos = changeDetails.fetchResultAfterChanges
                // (The table row for this one doesn't need updating, it always says "All Photos".)
            }
        }
    }
}
