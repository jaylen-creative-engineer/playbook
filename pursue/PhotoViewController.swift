//
//  PhotoViewController.swift
//  pursue
//
//  Created by Jaylen Sanders on 2/20/18.
//  Copyright © 2018 Glory. All rights reserved.
//

import UIKit
import Photos
import SnapSliderFilters
import Hero

class PhotoViewController: UIViewController, UIImagePickerControllerDelegate {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        view.layoutIfNeeded()
        updateStillImage()
    }
    
    private var backgroundImage: UIImage?
    var asset: PHAsset?
    var assetCollection: PHAssetCollection?
    
    var targetSize: CGSize {
        let scale = UIScreen.main.scale
        return CGSize(width: backgroundImageView.bounds.width * scale,
                      height: backgroundImageView.bounds.height * scale)
    }
    
    lazy var progressView : UIProgressView = {
        let pv = UIProgressView()
        return pv
    }()
    
    var is_principle = 0
    var is_step = 0
    
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
    
    lazy var backgroundWhiteFill : UIView = {
       let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 20
        view.layer.masksToBounds = true
        return view
    }()
    
    lazy var cancelFill : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.init(white: 0.3, alpha: 0.7)
        return view
    }()
    
    let createLabel : UILabel = {
       let label = UILabel()
        label.text = "Create"
        label.font = UIFont(name: "Lato-Bold", size: 18)
        return label
    }()
    
    lazy var backButton : UIButton = {
       let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "back-arrow").withRenderingMode(.alwaysOriginal), for: .normal)
        button.contentMode = .scaleAspectFill
        return button
    }()
    
    @objc func handlePursuit(){
//        if pursuitTitle.isHidden == false {
//            guard let image = backgroundImageView.image else { return }
////            let customAlert = CustomAlertView(capturedImage: image, contentUrl: nil, postDescription: pursuitTitle.text, is_principle: is_principle, is_step: is_step)
////            customAlert.providesPresentationContextTransitionStyle = true
////            customAlert.definesPresentationContext = true
////            customAlert.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
////            customAlert.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
////            self.present(customAlert, animated: true, completion: nil)
//        } else {
//            guard let image = backgroundImageView.image else { return }
////            let customAlert = CustomAlertView(capturedImage: image, contentUrl: nil, postDescription: "", is_principle: is_principle, is_step: is_step)
////            customAlert.providesPresentationContextTransitionStyle = true
////            customAlert.definesPresentationContext = true
////            customAlert.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
////            customAlert.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
////            self.present(customAlert, animated: true, completion: nil)
//        }
    }
    
    @objc func handleSave(){
        UIImageWriteToSavedPhotosAlbum(backgroundImage!, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
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
        let customAlert = CustomStepToggleView(is_step: is_step, is_principle: is_principle)
        customAlert.photoController = self
        customAlert.providesPresentationContextTransitionStyle = true
        customAlert.definesPresentationContext = true
        customAlert.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        customAlert.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        self.present(customAlert, animated: true, completion: nil)
    }
    
    func updateStillImage() {
        let options = PHImageRequestOptions()
        options.deliveryMode = .highQualityFormat
        options.isNetworkAccessAllowed = true
        
        if asset != nil {
            PHImageManager.default().requestImage(for: asset!, targetSize: targetSize,
                contentMode: .aspectFit, options: options, resultHandler: { image, _ in
                                                    
                    guard let convertedImage = image else { return }
                    self.backgroundImageView.isHidden = false
                    self.backgroundImageView.image = convertedImage
            })
        }
    }
    
    lazy var nextButton : UIButton = {
       let button = UIButton()
        button.backgroundColor = .blue
        button.layer.cornerRadius = 20
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(handleNext), for: .touchUpInside)
        return button
    }()
    
    lazy var nextArrow : UIImageView = {
       let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "forward-arrow").withRenderingMode(.alwaysTemplate)
        iv.contentMode = .scaleAspectFill
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleNext))
        tap.numberOfTapsRequired = 1
        iv.addGestureRecognizer(tap)
        return iv
    }()
    
    lazy var createCollectionViews: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .white
        cv.dataSource = self
        cv.delegate = self
        cv.showsHorizontalScrollIndicator = false
        cv.isPagingEnabled = true
        cv.isScrollEnabled = false
        return cv
    }()
    
    let detailId = "detailId"
    let pursuitId = "pursuitId"
    
    @objc func handleNext(){
        let indexPath = IndexPath(item: 1, section: 0)
        createCollectionViews.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    
    func setupCreateCollectionView(){
        createCollectionViews.delegate = self
        createCollectionViews.dataSource = self
        createCollectionViews.register(CreateDetailsCell.self, forCellWithReuseIdentifier: detailId)
        createCollectionViews.register(CreatePursuitsCells.self, forCellWithReuseIdentifier: pursuitId)
        
        view.addSubview(createCollectionViews)
        view.addSubview(nextButton)
        view.addSubview(nextArrow)
        
        createCollectionViews.anchor(top: createLabel.bottomAnchor, left: view.leftAnchor, bottom: backgroundWhiteFill.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
       
        nextButton.anchor(top: nil, left: nil, bottom: createCollectionViews.safeAreaLayoutGuide.bottomAnchor, right: view.safeAreaLayoutGuide.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 12, paddingRight: 12, width: 40, height: 40)
        nextArrow.anchor(top: nil, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 18, height: 18)
        nextArrow.centerXAnchor.constraint(equalTo: nextButton.centerXAnchor).isActive = true
        nextArrow.centerYAnchor.constraint(equalTo: nextButton.centerYAnchor).isActive = true
    }
    
    func setupView(){
        view.addSubview(backgroundImageView)
        view.addSubview(cancelFill)
        view.addSubview(backgroundWhiteFill)
        view.addSubview(createLabel)
        view.addSubview(backButton)
        
        backgroundImageView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        cancelFill.anchor(top: backgroundImageView.topAnchor, left: backgroundImageView.leftAnchor, bottom: backgroundImageView.bottomAnchor, right: backgroundImageView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        backgroundWhiteFill.anchor(top: nil, left: cancelFill.leftAnchor, bottom: view.bottomAnchor, right: cancelFill.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: view.frame.height / 1.6)
        createLabel.anchor(top: backgroundWhiteFill.topAnchor, left: nil, bottom: nil, right: nil, paddingTop: 18, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: createLabel.intrinsicContentSize.width, height: createLabel.intrinsicContentSize.height)
        createLabel.centerXAnchor.constraint(equalTo: backgroundWhiteFill.centerXAnchor).isActive = true
        backButton.anchor(top: nil, left: backgroundWhiteFill.leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: 18, height: 18)
        backButton.centerYAnchor.constraint(equalTo: createLabel.centerYAnchor).isActive = true
        setupCreateCollectionView()
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        hero.isEnabled = true
        setupView()
    }
    
    @objc func cancel() {
        dismiss(animated: true, completion: nil)
    }
}

extension PhotoViewController : UITextViewDelegate {
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let currentText:String = textView.text
        let updatedText = (currentText as NSString).replacingCharacters(in: range, with: text)
        
        if updatedText.isEmpty {
            
            textView.text = "Add Caption"
            textView.textColor = .gray
            textView.font = UIFont.boldSystemFont(ofSize: 14)
            
            textView.selectedTextRange = textView.textRange(from: textView.beginningOfDocument, to: textView.beginningOfDocument)
            
            return false
        }
            
        else if textView.textColor == UIColor.lightGray && !text.isEmpty {
            textView.text = nil
            textView.textColor = UIColor.black
        }
        
        return true
    }
    
    func textViewDidChangeSelection(_ textView: UITextView) {
        if self.view.window != nil {
            if textView.textColor == UIColor.lightGray {
                textView.selectedTextRange = textView.textRange(from: textView.beginningOfDocument, to: textView.beginningOfDocument)
            }
        }
    }
    
}

extension PhotoViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.item {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: detailId, for: indexPath) as! CreateDetailsCell
            return cell
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: pursuitId, for: indexPath) as! CreatePursuitsCells
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height / 1.6)
    }
}
