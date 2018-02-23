//
//  PhotoViewController.swift
//  pursue
//
//  Created by Jaylen Sanders on 2/20/18.
//  Copyright © 2018 Glory. All rights reserved.
//

import UIKit
import Photos
import XLActionController

class PhotoViewController: UIViewController, UIImagePickerControllerDelegate {
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        view.layoutIfNeeded()
        updateStillImage()
    }
    
    private var backgroundImage: UIImage
    var asset: PHAsset!
    
    var targetSize: CGSize {
        let scale = UIScreen.main.scale
        return CGSize(width: backgroundImageView.bounds.width * scale,
                      height: backgroundImageView.bounds.height * scale)
    }
    
    lazy var progressView : UIProgressView = {
        let pv = UIProgressView()
        return pv
    }()
    
    init(image: UIImage) {
        self.backgroundImage = image
        super.init(nibName: nil, bundle: nil)
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
    
    lazy var cancelButton : UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "cancel").withRenderingMode(.alwaysOriginal), for: .normal)
        button.contentMode = .scaleAspectFill
        button.addTarget(self, action: #selector(cancel), for: .touchUpInside)
        return button
    }()
    
    lazy var continueButton : UIButton = {
       let cv = UIButton()
        cv.backgroundColor = .black
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.layer.cornerRadius = 20
        cv.layer.masksToBounds = true
        cv.addTarget(self, action: #selector(handlePursuit), for: .touchUpInside)
        return cv
    }()
    
    lazy var forwardArrow : UIImageView = {
       let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "forward-arrow").withRenderingMode(.alwaysTemplate)
        iv.tintColor = .white
        iv.contentMode = .scaleAspectFill
        iv.translatesAutoresizingMaskIntoConstraints = false
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handlePursuit))
        tap.numberOfTapsRequired = 1
        iv.addGestureRecognizer(tap)
        return iv
    }()
    
    lazy var highlightIcon : UIButton = {
       let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "mark").withRenderingMode(.alwaysOriginal), for: .normal)
        button.contentMode = .scaleAspectFill
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleHighlight), for: .touchUpInside)
        return button
    }()
    
    lazy var highlightLabel : UILabel = {
        let label = UILabel()
        label.text = "Mark"
        label.font = .systemFont(ofSize: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleHighlight))
        tap.numberOfTapsRequired = 1
        label.addGestureRecognizer(tap)
        return label
    }()
    
    lazy var saveIcon : UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "save").withRenderingMode(.alwaysOriginal), for: .normal)
        button.contentMode = .scaleAspectFill
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleSave), for: .touchUpInside)
        return button
    }()
    
    lazy var saveLabel  : UILabel = {
        let label = UILabel()
        label.text = "Save"
        label.font = .systemFont(ofSize: 12)
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
    
    lazy var highlightBackground : UIButton = {
       let button = UIButton()
        button.backgroundColor = .clear
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleHighlight), for: .touchUpInside)
        return button
    }()
    
    @objc func handlePursuit(){
        let actionController = SkypeActionController()
        
        actionController.addAction(Action("Mark as principle", style: .default, handler: { action in
            // do something useful
        }))
        
        actionController.addAction(Action("Cancel", style: .default, handler: {action in
            
        }))
        present(actionController, animated: true, completion: nil)
    }
    
    @objc func handleSave(){
        UIImageWriteToSavedPhotosAlbum(backgroundImage, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
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
    
    @objc func handleHighlight () {
        let actionController = SkypeActionController()
  
        actionController.addAction(Action("Mark as principle", style: .default, handler: { action in
            // do something useful
        }))
        actionController.addAction(Action("Mark as step", style: .default, handler: { action in
            // do something useful
        }))
        
        actionController.addAction(Action("Cancel", style: .default, handler: {action in
            
        }))
        present(actionController, animated: true, completion: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateStillImage() {
        // Prepare the options to pass when fetching the (photo, or video preview) image.
        let options = PHImageRequestOptions()
        options.deliveryMode = .highQualityFormat
        options.isNetworkAccessAllowed = true

        PHImageManager.default().requestImage(for: asset,
                                              targetSize: targetSize,
                                              contentMode: .aspectFit,
                                              options: options,
                                              resultHandler: { image, _ in

            guard let image = image else { return }
            
            self.backgroundImageView.isHidden = false
            self.backgroundImageView.image = image
        })
    }
    
    func setupBottomLeftOptions(){
        view.addSubview(highlightLabel)
        view.addSubview(highlightIcon)
        view.addSubview(saveLabel)
        view.addSubview(saveIcon)
        view.addSubview(highlightBackground)
        view.addSubview(saveBackground)
        
        highlightLabel.anchor(top: nil, left: view.safeAreaLayoutGuide.leftAnchor, bottom: continueButton.bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 18, paddingBottom: 0, paddingRight: 0, width: highlightLabel.intrinsicContentSize.width, height: highlightLabel.intrinsicContentSize.height)
        highlightIcon.anchor(top: nil, left: nil, bottom: highlightLabel.topAnchor, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 12, paddingRight: 0, width: 22, height: 20)
        highlightIcon.centerXAnchor.constraint(equalTo: highlightLabel.centerXAnchor).isActive = true
        highlightBackground.anchor(top: highlightIcon.topAnchor, left: highlightLabel.leftAnchor, bottom: highlightLabel.bottomAnchor, right: highlightLabel.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        saveLabel.anchor(top: highlightLabel.topAnchor, left: highlightLabel.rightAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 28, paddingBottom: 0, paddingRight: 0, width: saveLabel.intrinsicContentSize.width, height: saveLabel.intrinsicContentSize.height)
        saveIcon.anchor(top: nil, left: nil, bottom: saveLabel.topAnchor, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 12, paddingRight: 0, width: 20, height: 20)
        saveIcon.centerXAnchor.constraint(equalTo: saveLabel.centerXAnchor).isActive = true
        saveBackground.anchor(top: saveIcon.topAnchor, left: saveLabel.leftAnchor, bottom: saveLabel.bottomAnchor, right: saveLabel.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
    }
    
    func setupView(){
        view.addSubview(cancelButton)
        view.addSubview(backgroundImageView)
        view.addSubview(continueButton)
        view.addSubview(forwardArrow)
        

        cancelButton.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.safeAreaLayoutGuide.leftAnchor, bottom: nil, right: nil, paddingTop: 12, paddingLeft: 18, paddingBottom: 0, paddingRight: 0, width: 15, height: 15)
        backgroundImageView.anchor(top: cancelButton.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 32, paddingLeft: 42, paddingBottom: 0, paddingRight: 42, width: 0, height: view.frame.height / 2)
        continueButton.anchor(top: nil, left: nil, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.safeAreaLayoutGuide.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 12, paddingRight: 24, width: 40, height: 40)
        forwardArrow.anchor(top: nil, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 15, height: 10)
        forwardArrow.centerXAnchor.constraint(equalTo: continueButton.centerXAnchor).isActive = true
        forwardArrow.centerYAnchor.constraint(equalTo: continueButton.centerYAnchor).isActive = true
        
        setupBottomLeftOptions()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        setupView()
    }
    
    @objc func cancel() {
        dismiss(animated: true, completion: nil)
    }
}
