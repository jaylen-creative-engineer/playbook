//
//  CustomOptionView.swift
//  pursue
//
//  Created by Jaylen Sanders on 3/12/18.
//  Copyright © 2018 Glory. All rights reserved.
//

import UIKit

class CustomOptionView : UIViewController {
    
    let alertViewGrayColor = UIColor(red: 224.0/255.0, green: 224.0/255.0, blue: 224.0/255.0, alpha: 1)
    let cellId = "cellId"
    
    lazy var alertView : UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    lazy var linkLabel : UILabel = {
        let label = UILabel()
        label.text = "Post Options"
        label.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.init(25))
        label.textAlignment = .left
        return label
    }()
    
    lazy var searchButton : UIButton = {
        let button = UIButton()
        button.setTitle("Search", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.init(25))
        button.titleLabel?.textAlignment = .center
        button.backgroundColor = .black
        button.layer.cornerRadius = 2
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var cancelBackground : UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleCancel))
        tap.numberOfTapsRequired = 1
        view.addGestureRecognizer(tap)
        return view
    }()
    
    
    lazy var cancelLabel : UILabel = {
        let label = UILabel()
        label.text = "Cancel"
        label.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.init(25))
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleCancel))
        tap.numberOfTapsRequired = 1
        label.addGestureRecognizer(tap)
        label.textAlignment = .center
        label.isUserInteractionEnabled = true
        return label
    }()
    
    lazy var likeTitle : UIButton = {
        let button = UIButton()
        button.setTitle("Like", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.contentHorizontalAlignment = .left
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(toggleLike), for: .touchUpInside)
        return button
    }()
    
    lazy var saveTitle : UIButton = {
        let button = UIButton()
        button.setTitle("Save Current Post", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.contentHorizontalAlignment = .left
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(toggleSavePost), for: .touchUpInside)
        return button
    }()
    
    
    lazy var saveStepTitle : UIButton = {
        let button = UIButton()
        button.setTitle("Save Current Post as a Step", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.contentHorizontalAlignment = .left
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(toggleStepSave), for: .touchUpInside)
        return button
    }()
    
    lazy var savePrincipleTitle : UIButton = {
        let button = UIButton()
        button.setTitle("Save Current Post as a Principle", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.contentHorizontalAlignment = .left
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(togglePrincipleSave), for: .touchUpInside)
        return button
    }()
    
    lazy var shareTitle : UIButton = {
        let button = UIButton()
        button.setTitle("Share", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var dismissBackground : UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        button.isUserInteractionEnabled = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleCancel), for: .touchUpInside)
        return button
    }()
    
    var isLiked = false
    var isSavedImage = false
    var isStepSaved = false
    var isPrincipleSaved = false
    
    @objc func toggleLike(){
        isLiked = !isLiked
        
        if isLiked == true {
            likeTitle.setTitle("Unliked", for: .normal)
        } else {
            likeTitle.setTitle("Like", for: .normal)
        }
    }
    
    @objc func toggleSavePost(){
//        let grabTime = 0.10
//        let image = generateThumnail(url: videoURL!, fromTime: Float64(grabTime))
//
//        let customAlert = CustomAlertView(capturedImage: image, contentUrl: videoURL, postDescription: pursuitTitle.text, is_principle: 0, is_step: 0)
//        customAlert.providesPresentationContextTransitionStyle = true
//        customAlert.definesPresentationContext = true
//        customAlert.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
//        customAlert.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
//        self.present(customAlert, animated: true, completion: nil)
        
        isSavedImage = !isSavedImage
        
        if isSavedImage == true {
            saveTitle.setTitle("Post Saved", for: .normal)
        } else {
            saveTitle.setTitle("Save Current Post", for: .normal)
        }
    }
    
    @objc func toggleStepSave(){
//        let grabTime = 0.10
//        let image = generateThumnail(url: videoURL!, fromTime: Float64(grabTime))
//
//        let customAlert = CustomAlertView(capturedImage: image, contentUrl: videoURL, postDescription: pursuitTitle.text, is_principle: 0, is_step: 0)
//        customAlert.providesPresentationContextTransitionStyle = true
//        customAlert.definesPresentationContext = true
//        customAlert.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
//        customAlert.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
//        self.present(customAlert, animated: true, completion: nil)
        
        isStepSaved = !isStepSaved
        
        if isStepSaved == true {
            saveStepTitle.setTitle("Step Saved", for: .normal)
        } else {
            saveStepTitle.setTitle("Save Current Post as a Step", for: .normal)
        }
    }
    
    @objc func togglePrincipleSave(){
//        let grabTime = 0.10
//        let image = generateThumnail(url: videoURL!, fromTime: Float64(grabTime))
//        
//        let customAlert = CustomAlertView(capturedImage: image, contentUrl: videoURL, postDescription: pursuitTitle.text, is_principle: 0, is_step: 0)
//        customAlert.providesPresentationContextTransitionStyle = true
//        customAlert.definesPresentationContext = true
//        customAlert.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
//        customAlert.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
//        self.present(customAlert, animated: true, completion: nil)
        
        isPrincipleSaved = !isPrincipleSaved
        
        if isPrincipleSaved == true {
            savePrincipleTitle.setTitle("Principle Saved", for: .normal)
        } else {
            savePrincipleTitle.setTitle("Save Current Post as a Principle", for: .normal)
        }
    }
    
    @objc func handleSend(){
        
    }
    
    @objc func handleYes(){
    }
    
    @objc func handleCancel(){
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(alertView)
        alertView.addSubview(linkLabel)
        alertView.addSubview(likeTitle)
        alertView.addSubview(saveTitle)
        alertView.addSubview(saveStepTitle)
        alertView.addSubview(savePrincipleTitle)
        alertView.addSubview(shareTitle)
        alertView.addSubview(cancelLabel)
        view.addSubview(cancelBackground)
        view.addSubview(dismissBackground)
        
        alertView.anchor(top: nil, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 385)
        alertView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 10).isActive = true
        linkLabel.anchor(top: alertView.topAnchor, left: alertView.leftAnchor, bottom: nil, right: nil, paddingTop: 18, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: linkLabel.intrinsicContentSize.width, height: linkLabel.intrinsicContentSize.height)
        likeTitle.anchor(top: linkLabel.bottomAnchor, left: alertView.leftAnchor, bottom: nil, right: nil, paddingTop: 18, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: likeTitle.intrinsicContentSize.width * 2, height: likeTitle.intrinsicContentSize.height)
        shareTitle.anchor(top: likeTitle.bottomAnchor, left: alertView.leftAnchor, bottom: nil, right: nil, paddingTop: 18, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: shareTitle.intrinsicContentSize.width, height: shareTitle.intrinsicContentSize.height)
        saveTitle.anchor(top: shareTitle.bottomAnchor, left: alertView.leftAnchor, bottom: nil, right: nil, paddingTop: 18, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: saveTitle.intrinsicContentSize.width, height: saveTitle.intrinsicContentSize.height)
        saveStepTitle.anchor(top: saveTitle.bottomAnchor, left: alertView.leftAnchor, bottom: nil, right: nil, paddingTop: 18, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: saveStepTitle.intrinsicContentSize.width, height: saveStepTitle.intrinsicContentSize.height)
        savePrincipleTitle.anchor(top: saveStepTitle.bottomAnchor, left: alertView.leftAnchor, bottom: nil, right: nil, paddingTop: 18, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: savePrincipleTitle.intrinsicContentSize.width, height: savePrincipleTitle.intrinsicContentSize.height)
        cancelLabel.anchor(top: nil, left: nil, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 14, paddingRight: 0, width: cancelLabel.intrinsicContentSize.width, height: cancelLabel.intrinsicContentSize.height)
        cancelLabel.centerXAnchor.constraint(equalTo: alertView.centerXAnchor).isActive = true
        cancelBackground.anchor(top: nil, left: nil, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 14, paddingRight: 0, width: 100, height: 50)
        cancelBackground.centerXAnchor.constraint(equalTo: alertView.centerXAnchor).isActive = true
        dismissBackground.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: alertView.topAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupView()
        animateView()
    }
    
    func setupView() {
        alertView.layer.cornerRadius = 15
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.4)
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

extension CustomOptionView : UITextViewDelegate {
    
}
