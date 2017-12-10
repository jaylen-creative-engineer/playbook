//
//  CameraController.swift
//  pursue
//
//  Created by Jaylen Sanders on 9/11/17.
//  Copyright © 2017 Glory. All rights reserved.
//

import UIKit
import AVFoundation

class CameraController: UICollectionViewCell, AVCapturePhotoCaptureDelegate {
    
    var cameraController : SelectCameraController?
    
    lazy var capturePhotoButton : UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "capture").withRenderingMode(.alwaysOriginal), for: .normal)
        button.addTarget(self, action: #selector(handleCapturePhoto), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupBottomOptions()
        backgroundColor = .clear
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func handleDismiss() {
        cameraController?.handleDismiss()
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
        addSubview(containerView)
        containerView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
    }
    
    lazy var menuBar: CameraBar = {
        let mb = CameraBar()
        mb.backgroundColor = .white
        return mb
    }()
    
    let bottomBackground : UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    lazy var cameraFlash : UIButton = {
       let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "flash-off").withRenderingMode(.alwaysOriginal), for: .normal)
        button.contentMode = .scaleAspectFill
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var flipCamera : UIButton = {
       let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "switch").withRenderingMode(.alwaysOriginal), for: .normal)
        button.contentMode = .scaleAspectFill
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    func setupBottomOptions (){
        addSubview(bottomBackground)
        bottomBackground.addSubview(capturePhotoButton)
        bottomBackground.addSubview(cameraFlash)
        bottomBackground.addSubview(flipCamera)
        
        bottomBackground.anchor(top: nil, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: (frame.height / 12.5) - 10, paddingRight: 0, width: 0, height: frame.height / 6.5)
        capturePhotoButton.anchor(top: bottomBackground.topAnchor, left: nil, bottom: nil, right: nil, paddingTop: 12, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 84, height: 80)
        capturePhotoButton.centerXAnchor.constraint(equalTo: bottomBackground.centerXAnchor).isActive = true
        cameraFlash.anchor(top: nil, left: bottomBackground.leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 48, paddingBottom: 0, paddingRight: 0, width: 30, height: 30)
        cameraFlash.centerYAnchor.constraint(equalTo: capturePhotoButton.centerYAnchor).isActive = true
        flipCamera.anchor(top: nil, left: nil, bottom: nil, right: bottomBackground.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 48, width: 42, height: 36)
        flipCamera.centerYAnchor.constraint(equalTo: capturePhotoButton.centerYAnchor).isActive = true
    }
    
    let output = AVCapturePhotoOutput()
    
    fileprivate func setupCaptureSession() {
        
        let captureSession = AVCaptureSession()
        
        guard let captureDevice = AVCaptureDevice.default(for: AVMediaType.video) else { return }
        // Setup Inputs
        
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
        previewLayer.frame = frame
        layer.addSublayer(previewLayer)
        captureSession.startRunning()
    }
}
