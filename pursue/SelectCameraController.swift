//
//  SelectCameraController.swift
//  pursue
//
//  Created by Jaylen Sanders on 12/1/17.
//  Copyright © 2017 Glory. All rights reserved.
//

import UIKit
import AVFoundation

class SelectCameraController : UICollectionViewController, UICollectionViewDelegateFlowLayout, AVCapturePhotoCaptureDelegate {
    
    let cellId = "cellId"
    let selectId = "selectId"
    
    lazy var capturePhotoButton : UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "capture").withRenderingMode(.alwaysOriginal), for: .normal)
        button.addTarget(self, action: #selector(handleCapturePhoto), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let flowLayout = collectionView?.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.scrollDirection = .horizontal
            flowLayout.minimumLineSpacing = 0
        }
        
        collectionView?.isPagingEnabled = true
        navigationController?.navigationBar.isHidden = true
        collectionView?.register(CameraController.self, forCellWithReuseIdentifier: cellId)
        collectionView?.register(PhotoSelectorController.self, forCellWithReuseIdentifier: selectId)
        collectionView?.contentInset = UIEdgeInsetsMake(55, 0, 75, 0)
        setupCaptureSession()
        setupMenuBar()
        scrollToMenuIndex(menuIndex: 1)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.item {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: selectId, for: indexPath) as! PhotoSelectorController
            cell.cameraController = self
            return cell
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! CameraController
            return cell
        default:
            assert(false)
        }
    }
    
    @objc func handleNext(image : UIImage){
        let sharePhotoController = SharePhotoController()
        sharePhotoController.selectedImage = image
        present(sharePhotoController, animated: true, completion: nil)
    }
    
    let select : UILabel = {
       let label = UILabel()
        label.text = "SELECT PHOTO"
        return label
    }()
    
    let captureLabel : UILabel = {
       let label = UILabel()
        label.text = "CAPTURE"
        return label
    }()
    
    let titles = ["LIBRARY", "CAPTURE"]
    
    func scrollToMenuIndex(menuIndex: Int) {
        let indexPath = IndexPath(item: menuIndex, section: 0)
        cameraTitle.text = "\(titles[menuIndex])"
        collectionView?.scrollToItem(at: indexPath, at: [], animated: true)
    }
    
    @objc func handleDismiss() {
        dismiss(animated: true, completion: nil)
    }
    
    
    @objc func handleCapturePhoto(){
        let settings = AVCapturePhotoSettings()
        guard let previewFormatType = settings.availablePreviewPhotoPixelFormatTypes.first else { return }
        settings.previewPhotoFormat = [kCVPixelBufferPixelFormatTypeKey as String : previewFormatType]
        output.capturePhoto(with: settings, delegate: self)
    }
    
    func photoOutput(_ captureOutput: AVCapturePhotoOutput, didFinishProcessingPhoto photoSampleBuffer: CMSampleBuffer?, previewPhoto previewPhotoSampleBuffer: CMSampleBuffer?, resolvedSettings: AVCaptureResolvedPhotoSettings, bracketSettings: AVCaptureBracketedStillImageSettings?, error: Error?) {
        let imageData = AVCapturePhotoOutput.jpegPhotoDataRepresentation(forJPEGSampleBuffer: photoSampleBuffer!, previewPhotoSampleBuffer: previewPhotoSampleBuffer)
        let previewImage = UIImage(data: imageData!)
        
        let containerView = PreviewPhotoContainerView()
        containerView.previewImageView.image = previewImage
        view.addSubview(containerView)
        containerView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
    }
    
    lazy var menuBar: CameraBar = {
        let mb = CameraBar()
        mb.backgroundColor = .white
        mb.cameraController = self
        return mb
    }()
    
    let cameraTitle : UILabel = {
        let label = UILabel()
        label.text = "PHOTO"
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let backgroundFill : UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    lazy var cancelButton : UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "cancel_shadow").withRenderingMode(.alwaysTemplate), for: .normal)
        button.tintColor = .black
        button.contentMode = .scaleAspectFill
        button.addTarget(self, action: #selector(handleDismiss), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let index = targetContentOffset.pointee.x / view.frame.width
        let indexPath = IndexPath(item: Int(index), section: 0)
        menuBar.collectionView.selectItem(at: indexPath, animated: true, scrollPosition: [])
        scrollToMenuIndex(menuIndex: Int(index))
    }
    
    private func setupTopBar(){
        let guide = view.safeAreaLayoutGuide
        view.addSubview(backgroundFill)
        view.addSubview(cancelButton)
        view.addSubview(cameraTitle)
        
        backgroundFill.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: (view.frame.height / 8.5) - 10)
        cancelButton.anchor(top: nil, left: backgroundFill.leftAnchor, bottom: backgroundFill.bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 12, paddingBottom: 16, paddingRight: 0, width: 18, height: 18)
        cameraTitle.anchor(top: nil, left: nil, bottom: backgroundFill.bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 16, paddingRight: 0, width: cameraTitle.intrinsicContentSize.width + 30, height: cameraTitle.intrinsicContentSize.height)
        cameraTitle.centerXAnchor.constraint(equalTo: backgroundFill.centerXAnchor).isActive = true
    }
    
    private func setupMenuBar() {
        let guide = view.safeAreaLayoutGuide
        view.addSubview(menuBar)
        menuBar.anchor(top: nil, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: view.frame.height / 12)
        setupTopBar()
    }
    
    let output = AVCapturePhotoOutput()
    
    fileprivate func setupCaptureSession() {
        let captureSession = AVCaptureSession()
        guard let captureDevice = AVCaptureDevice.default(for: AVMediaType.video) else { return }
        
        do {
            let input = try AVCaptureDeviceInput(device: captureDevice)
            if captureSession.canAddInput(input){
                captureSession.addInput(input)
            }
        } catch let err{
            print("Could not setup camera input ", err)
        }
        
        if captureSession.canAddOutput(output){
            captureSession.addOutput(output)
        }
        
        let previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer.frame = view.frame
        view.layer.addSublayer(previewLayer)
        captureSession.startRunning()
    }
}
