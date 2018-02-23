//
//  SelectCameraController.swift
//  pursue
//
//  Created by Jaylen Sanders on 12/1/17.
//  Copyright © 2017 Glory. All rights reserved.
//

import UIKit
import SwiftyCam
import Photos
import Hero

class SelectCameraController : SwiftyCamViewController, SwiftyCamViewControllerDelegate{
   
    let libraryId = "libraryId"
    let cameraId = "cameraId"
    var allPhotos : PHFetchResult<PHAsset>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cameraDelegate = self
        maximumVideoDuration = 10.0
        shouldUseDeviceOrientation = true
        allowAutoRotate = true
        audioEnabled = true
        setupView()
        toggleFlash()
        
        let allPhotosOptions = PHFetchOptions()
        allPhotosOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: true)]
        allPhotos = PHAsset.fetchAssets(with: allPhotosOptions)
        getAssetFromPhoto()
    }
    
    lazy var captureButton : SwiftyRecordButton = {
       let button = SwiftyRecordButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor.init(white: 0.7, alpha: 0.5)
        button.layer.borderWidth = 4
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.cornerRadius = 25
        button.layer.masksToBounds = true
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
    
    @objc func handleLibrary(){
        let libraryController = PhotoLibrary()
        libraryController.fetchResult = allPhotos
        navigationController?.isHeroEnabled = true
        navigationController?.heroNavigationAnimationType = .fade
        navigationController?.pushViewController(libraryController, animated: true)
    }

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
        navigationController?.isHeroEnabled = true
        navigationController?.heroNavigationAnimationType = .fade
        dismiss(animated: true, completion: nil)
    }
    
    @objc func toggleFlash(){
        flashEnabled = !flashEnabled
        if flashEnabled == true {
            cancelFlashLine.isHidden = true
        } else {
            cancelFlashLine.isHidden = false
        }
    }
    
    func setupView(){
        view.addSubview(captureButton)
        view.addSubview(flipCameraButton)
        view.addSubview(photoLibraryButton)
        
        captureButton.anchor(top: nil, left: nil, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 12, paddingRight: 0, width: 50, height: 50)
        captureButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        flipCameraButton.anchor(top: nil, left: nil, bottom: nil, right: view.safeAreaLayoutGuide.rightAnchor, paddingTop: 12, paddingLeft: 0, paddingBottom: 0, paddingRight: 24, width: 28, height: 20)
        flipCameraButton.centerYAnchor.constraint(equalTo: captureButton.centerYAnchor).isActive = true
        photoLibraryButton.anchor(top: nil, left: view.safeAreaLayoutGuide.leftAnchor, bottom: nil, right: nil, paddingTop: 12, paddingLeft: 24, paddingBottom: 0, paddingRight: 0, width: 28, height: 28)
        photoLibraryButton.centerYAnchor.constraint(equalTo: captureButton.centerYAnchor).isActive = true
        setupTopOptions()
        
    }
    
    func setupTopOptions(){
        view.addSubview(flashButton)
        view.addSubview(cancelFlashLine)
        view.addSubview(cancelButton)
        flashButton.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: nil, bottom: nil, right: view.safeAreaLayoutGuide.rightAnchor, paddingTop: 12, paddingLeft: 0, paddingBottom: 0, paddingRight: 18, width: 15, height: 20)
        cancelFlashLine.anchor(top: flashButton.topAnchor, left: flashButton.leftAnchor, bottom: flashButton.bottomAnchor, right: flashButton.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        cancelButton.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.safeAreaLayoutGuide.leftAnchor, bottom: nil, right: nil, paddingTop: 12, paddingLeft: 18, paddingBottom: 0, paddingRight: 0, width: 15, height: 15)
    }
    
    @objc func cameraSwitchTapped(){
        switchCamera()
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        captureButton.delegate = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
    func swiftyCam(_ swiftyCam: SwiftyCamViewController, didTake photo: UIImage) {
        let newVC = PhotoViewController(image: photo)
        self.present(newVC, animated: true, completion: nil)
    }

    func swiftyCam(_ swiftyCam: SwiftyCamViewController, didBeginRecordingVideo camera: SwiftyCamViewController.CameraSelection) {
        captureButton.growButton()
        UIView.animate(withDuration: 0.25, animations: {
            self.flashButton.alpha = 0.0
            self.flipCameraButton.alpha = 0.0
        })
    }

    func swiftyCam(_ swiftyCam: SwiftyCamViewController, didFinishRecordingVideo camera: SwiftyCamViewController.CameraSelection) {
        captureButton.shrinkButton()
        UIView.animate(withDuration: 0.25, animations: {
            self.flashButton.alpha = 1.0
            self.flipCameraButton.alpha = 1.0
        })
    }

    func swiftyCam(_ swiftyCam: SwiftyCamViewController, didFinishProcessVideoAt url: URL) {
        let newVC = VideoViewController(videoURL: url)
        self.present(newVC, animated: true, completion: nil)
    }

    func swiftyCam(_ swiftyCam: SwiftyCamViewController, didFocusAtPoint point: CGPoint) {
        let focusView = UIImageView(image: #imageLiteral(resourceName: "focus"))
        focusView.center = point
        focusView.alpha = 0.0
        view.addSubview(focusView)

        UIView.animate(withDuration: 0.25, delay: 0.0, options: .curveEaseInOut, animations: {
            focusView.alpha = 1.0
            focusView.transform = CGAffineTransform(scaleX: 1.25, y: 1.25)
        }, completion: { (success) in
            UIView.animate(withDuration: 0.15, delay: 0.5, options: .curveEaseInOut, animations: {
                focusView.alpha = 0.0
                focusView.transform = CGAffineTransform(translationX: 0.6, y: 0.6)
            }, completion: { (success) in
                focusView.removeFromSuperview()
            })
        })
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
