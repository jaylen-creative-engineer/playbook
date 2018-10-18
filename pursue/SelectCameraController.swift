//
//  SelectCameraController.swift
//  pursue
//
//  Created by Jaylen Sanders on 12/1/17.
//  Copyright © 2017 Glory. All rights reserved.
//

import UIKit
import Photos
import AVFoundation

class SelectCameraController : UIViewController, AVCapturePhotoCaptureDelegate {
   
    let libraryId = "libraryId"
    let cameraId = "cameraId"
    var allPhotos : PHFetchResult<PHAsset>!
    
    var flashMode = AVCaptureDevice.FlashMode.off
    var cameraCheck = CameraType.Back
    
    var frontCamera: AVCaptureDevice?
    var frontCameraInput: AVCaptureDeviceInput?
    
    var rearCamera: AVCaptureDevice?
    var rearCameraInput: AVCaptureDeviceInput?
    
    let cameraController = CameraController()
    var arrPost : [Post] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        maximumVideoDuration = 10.0
//        shouldUseDeviceOrientation = true
//        allowAutoRotate = true
//        audioEnabled = true
        setupCaptureSession()
        setupView()
        toggleFlash()
        
        let allPhotosOptions = PHFetchOptions()
        allPhotosOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: true)]
        allPhotos = PHAsset.fetchAssets(with: allPhotosOptions)
        getAssetFromPhoto()
    }
    
    lazy var captureButton : UIButton = {
       let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.borderWidth = 4
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.cornerRadius = 30
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(handleCapturePhoto), for: .touchUpInside)
        
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(handleRecordVideo))
        button.addGestureRecognizer(longPress)
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
    
    lazy var flashButton : UIButton = {
       let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "flash").withRenderingMode(.alwaysTemplate), for: .normal)
        button.contentMode = .scaleAspectFill
        button.tintColor = .white
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
    
    lazy var cancelButton : UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "cancel").withRenderingMode(.alwaysTemplate), for: .normal)
        button.contentMode = .scaleAspectFill
        button.tintColor = .white
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
    
    let capturePreview : UIView = {
       let view = UIView()
        return view
    }()
    
    @objc func handleLibrary(){
        let libraryController = PhotoLibrary()
        libraryController.fetchResult = allPhotos
        libraryController.photoLibraryButton.setImage(photoLibraryButton.imageView?.image, for: .normal)
        present(libraryController, animated: true, completion: nil)
    }

    override var prefersStatusBarHidden: Bool { return true }
    var photos : PHFetchResult<PHAsset>!
    fileprivate let imageManager = PHCachingImageManager()
    
    func getAssetFromPhoto(){
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
        self.navigationController?.dismiss(animated: true, completion: nil)
    }
    
    @objc func toggleFlash(){
        
        if flashMode == .on {
            flashMode = .off
            cancelFlashLine.isHidden = true
        } else {
            flashMode = .on
            cancelFlashLine.isHidden = false
        }
    }
    
    @objc func handleRecordVideo(){
        
    }
    func setupView(){
        view.addSubview(captureButton)
        view.addSubview(flipCameraButton)
        view.addSubview(photoLibraryButton)
        view.addSubview(flashButton)
        view.addSubview(cancelFlashLine)
        
        captureButton.anchor(top: nil, left: nil, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 12, paddingRight: 0, width: 60, height: 60)
        captureButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        flipCameraButton.anchor(top: nil, left: nil, bottom: captureButton.topAnchor, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 24, paddingRight: 24, width: 28, height: 20)
        flipCameraButton.centerXAnchor.constraint(equalTo: captureButton.centerXAnchor).isActive = true
        flashButton.anchor(top: nil, left: nil, bottom: nil, right: view.safeAreaLayoutGuide.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 48, width: 20, height: 25)
        flashButton.centerYAnchor.constraint(equalTo: captureButton.centerYAnchor).isActive = true

        cancelFlashLine.anchor(top: flashButton.topAnchor, left: flashButton.leftAnchor, bottom: flashButton.bottomAnchor, right: flashButton.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        photoLibraryButton.anchor(top: nil, left: view.safeAreaLayoutGuide.leftAnchor, bottom: nil, right: nil, paddingTop: 12, paddingLeft: 48, paddingBottom: 0, paddingRight: 0, width: 28, height: 28)
        photoLibraryButton.centerYAnchor.constraint(equalTo: captureButton.centerYAnchor).isActive = true
        setupTopOptions()
        
        if UserDefaults.standard.value(forKey: "cameraIntroPopover") == nil {
            setupIntroView()
        } else {
            dismissHomePopover()
        }
    }
    
    func setupTopOptions(){
        view.addSubview(cancelButton)
        cancelButton.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.safeAreaLayoutGuide.leftAnchor, bottom: nil, right: nil, paddingTop: 12, paddingLeft: 18, paddingBottom: 0, paddingRight: 0, width: 15, height: 15)
    }
 
    @objc func cameraSwitchTapped(){
        do {
            try cameraController.switchCameras()
        } catch {
            print(error)
        }
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
//        captureButton.delegate = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
    @objc func handleCapturePhoto() {
        
        let settings = AVCapturePhotoSettings()
        
        guard let previewFormatType = settings.availablePreviewPhotoPixelFormatTypes.first else { return }
        
        settings.previewPhotoFormat = [kCVPixelBufferPixelFormatTypeKey as String: previewFormatType]
        
        output.capturePhoto(with: settings, delegate: self)
    }
    
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        guard let imageData = photo.fileDataRepresentation() else { return }
        let previewImage = UIImage(data: imageData)
        
        let containerView = PreviewPhotoContainerView()
        containerView.accessSelectController = self
        containerView.previewImageView.image = previewImage
        view.addSubview(containerView)
        containerView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
    }
    
    let output = AVCapturePhotoOutput()
    let captureSession = AVCaptureSession()
    
    fileprivate func setupCaptureSession() {
        if cameraCheck == CameraType.Front {
            cameraCheck = CameraType.Back
            
            guard let captureDevice = AVCaptureDevice.default(for: AVMediaType.video) else { return }
            do {
                let input = try AVCaptureDeviceInput(device: captureDevice)
                if captureSession.canAddInput(input) {
                    captureSession.addInput(input)
                }
            } catch let err {
                print("Could not setup camera input:", err)
            }
            
            if captureSession.canAddOutput(output) {
                captureSession.addOutput(output)
            }
            
            let previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
            previewLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
            previewLayer.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
            view.layer.addSublayer(previewLayer)
            
            captureSession.startRunning()
            
        } else {
            cameraCheck = .Front
            
            guard let captureDevice = AVCaptureDevice.default(for: AVMediaType.video) else { return }
            
            do {
                let input = try AVCaptureDeviceInput(device: captureDevice)
                if captureSession.canAddInput(input) {
                    captureSession.addInput(input)
                }
            } catch let err {
                print("Could not setup camera input:", err)
            }
            
            if captureSession.canAddOutput(output) {
                captureSession.addOutput(output)
            }
            
            let previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
            previewLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
            previewLayer.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
            view.layer.addSublayer(previewLayer)
            
            captureSession.startRunning()
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
//        setupCaptureSession()
//        setupView()
    }
    
    // MARK: - Show first load popover
    
    lazy var alertView : UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.isUserInteractionEnabled = true
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissHomePopover))
        tap.numberOfTapsRequired = 1
        view.addGestureRecognizer(tap)
        return view
    }()
    
    lazy var backgroundView : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissHomePopover))
        tap.numberOfTapsRequired = 1
        view.addGestureRecognizer(tap)
        return view
    }()
    
    lazy var homeIntroLabel : UILabel = {
        let label = UILabel()
        label.text = "Record Pursuits"
        label.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.init(25))
        return label
    }()
    
    lazy var pursuitsDescription : UILabel = {
        let label = UILabel()
        let attributedString = NSMutableAttributedString(string: "Stay inspired and learn steps and principles that can help you on your journey.")
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 5
        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, attributedString.length))
        label.attributedText = attributedString
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.numberOfLines = 2
        return label
    }()
    
    lazy var gotItButton : UIButton = {
        let button = UIButton()
        button.setTitle("Got It", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.titleLabel?.textAlignment = .justified
        button.isUserInteractionEnabled = true
        button.addTarget(self, action: #selector(dismissHomePopover), for: .touchUpInside)
        return button
    }()
    
    let underlineView = UIView()
    
    @objc func dismissHomePopover(){
        UserDefaults.standard.set("true", forKey: "cameraIntroPopover")

        backgroundView.isHidden = true
        alertView.isHidden = true
        homeIntroLabel.isHidden = true
        pursuitsDescription.isHidden = true
        underlineView.isHidden = true
        gotItButton.isHidden = true
        
        self.tabBarController?.tabBar.layer.zPosition = 0
        self.tabBarController?.tabBar.isHidden = false
    }
    
    func setupIntroView() {
        self.tabBarController?.tabBar.layer.zPosition = -1
        self.tabBarController?.tabBar.isHidden = true
        alertView.layer.cornerRadius = 15
        setupIntroConstraints()
        animateView()
    }
    
    func setupIntroConstraints(){
        underlineView.backgroundColor = .lightGray
        
        view.addSubview(backgroundView)
        view.addSubview(alertView)
        view.addSubview(homeIntroLabel)
        view.addSubview(pursuitsDescription)
        view.addSubview(underlineView)
        alertView.addSubview(gotItButton)
        
        backgroundView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        backgroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 50).isActive = true
        alertView.anchor(top: nil, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 250)
        alertView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 50).isActive = true
        homeIntroLabel.anchor(top: alertView.topAnchor, left: alertView.leftAnchor, bottom: nil, right: nil, paddingTop: 12, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: homeIntroLabel.intrinsicContentSize.width, height: homeIntroLabel.intrinsicContentSize.height)
        pursuitsDescription.anchor(top: homeIntroLabel.bottomAnchor, left: homeIntroLabel.leftAnchor, bottom: nil, right: alertView.rightAnchor, paddingTop: 8, paddingLeft: 0, paddingBottom: 0, paddingRight: 12, width: 0, height: 80)
        underlineView.anchor(top: pursuitsDescription.bottomAnchor, left: alertView.leftAnchor, bottom: nil, right: alertView.rightAnchor, paddingTop: 12, paddingLeft: 12, paddingBottom: 0, paddingRight: 12, width: 0, height: 0.5)
        gotItButton.anchor(top: underlineView.bottomAnchor, left: underlineView.leftAnchor, bottom: nil, right: nil, paddingTop: 12, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: gotItButton.intrinsicContentSize.width, height: gotItButton.intrinsicContentSize.height)
    }
    
    func animateView() {
        alertView.alpha = 0;
        self.alertView.frame.origin.y = self.alertView.frame.origin.y + 50
        UIView.animate(withDuration: 0.4, animations: { () -> Void in
            self.alertView.alpha = 1.0;
            self.alertView.frame.origin.y = self.alertView.frame.origin.y - 50
        })
    }
}

// MARK: PHPhotoLibraryChangeObserver
extension SelectCameraController : PHPhotoLibraryChangeObserver {
    
    func photoLibraryDidChange(_ changeInstance: PHChange) {
        DispatchQueue.main.sync {
            // Check each of the three top-level fetches for changes.
            if let changeDetails = changeInstance.changeDetails(for: allPhotos) {
                allPhotos = changeDetails.fetchResultAfterChanges
                // (The table row for this one doesn't need updating, it always says "All Photos".)
            }
            
        }
    }
}

enum CameraType {
    case Front
    case Back
}
