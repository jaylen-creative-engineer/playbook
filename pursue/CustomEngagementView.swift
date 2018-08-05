//
//  CustomOptionView.swift
//  pursue
//
//  Created by Jaylen Sanders on 3/12/18.
//  Copyright © 2018 Glory. All rights reserved.
//

import UIKit
import Hero

class CustomEngagementView : UIViewController {
    
    let alertViewGrayColor = UIColor(red: 224.0/255.0, green: 224.0/255.0, blue: 224.0/255.0, alpha: 1)
    let cellId = "cellId"
    
    lazy var alertView : UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
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
    
    lazy var cancelButton : UIButton = {
       let button = UIButton()
        button.setTitle("Cancel", for: .normal)
        button.titleLabel?.textAlignment = .center
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont(name: "Lato-Bold", size: 14)
        return button
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
    
    lazy var shareTitle : UIButton = {
        let button = UIButton()
        button.setTitle("Share", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var photo : UIImageView = {
        let iv = UIImageView()
        iv.layer.cornerRadius = 8
        iv.image = #imageLiteral(resourceName: "health").withRenderingMode(.alwaysOriginal)
        iv.layer.masksToBounds = true
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    let saveButton : UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "bookmark").withRenderingMode(.alwaysTemplate), for: .normal)
        button.imageView?.contentMode = .scaleAspectFill
        button.tintColor = .gray
        return button
    }()
    
    let saveLabel : UILabel = {
        let label = UILabel()
        label.text = "Save"
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()
    
    let addButton : UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "add").withRenderingMode(.alwaysTemplate), for: .normal)
        button.imageView?.contentMode = .scaleAspectFill
        button.tintColor = .gray
        return button
    }()
    
    let contributeLabel : UILabel = {
        let label = UILabel()
        label.text = "Contribute"
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()
    
    let commentButton : UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "highlight").withRenderingMode(.alwaysTemplate), for: .normal)
        button.imageView?.contentMode = .scaleAspectFill
        button.tintColor = .gray
        return button
    }()
    
    let commentLabel : UILabel = {
        let label = UILabel()
        label.text = "Comment"
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()
    
    lazy var shareButton : UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "share").withRenderingMode(.alwaysTemplate), for: .normal)
        button.imageView?.contentMode = .scaleAspectFill
        button.tintColor = .gray
        button.addTarget(self, action: #selector(shareSelected), for: .touchUpInside)
        return button
    }()
    
    lazy var shareLabel : UILabel = {
        let label = UILabel()
        label.text = "Share"
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 12)
        label.isUserInteractionEnabled = true
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(shareSelected))
        tap.numberOfTapsRequired = 1
        label.addGestureRecognizer(tap)
        return label
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
    
    @objc func shareSelected(){
        
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

    }
    
    @objc func handleSend(){
        
    }
    
    @objc func handleYes(){
    }
    
    @objc func handleCancel(){
        dismiss(animated: true, completion: nil)
    }
    
    func setupPhoto(){
        view.addSubview(photo)
        photo.anchor(top: nil, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 220, height: 280)
        photo.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        photo.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        setupEngagements()
    }
    
    func setupEngagements(){
        view.addSubview(saveButton)
        view.addSubview(saveLabel)
        view.addSubview(addButton)
        view.addSubview(contributeLabel)
        view.addSubview(commentButton)
        view.addSubview(commentLabel)
        view.addSubview(shareButton)
        view.addSubview(shareLabel)
        view.addSubview(cancelButton)
        
        saveButton.anchor(top: alertView.topAnchor, left: alertView.leftAnchor, bottom: nil, right: nil, paddingTop: 24, paddingLeft: 48, paddingBottom: 0, paddingRight: 0, width: 16, height: 24)
        saveLabel.anchor(top: saveButton.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 8, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: saveLabel.intrinsicContentSize.width, height: saveLabel.intrinsicContentSize.height)
        saveLabel.centerXAnchor.constraint(equalTo: saveButton.centerXAnchor).isActive = true
        
        addButton.anchor(top: alertView.topAnchor, left: saveButton.rightAnchor, bottom: nil, right: nil, paddingTop: 24, paddingLeft: 64, paddingBottom: 0, paddingRight: 0, width: 24, height: 24)
        contributeLabel.anchor(top: saveLabel.topAnchor, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: contributeLabel.intrinsicContentSize.width, height: contributeLabel.intrinsicContentSize.height)
        contributeLabel.centerXAnchor.constraint(equalTo: addButton.centerXAnchor).isActive = true
        
        commentButton.anchor(top: alertView.topAnchor, left: addButton.rightAnchor, bottom: nil, right: nil, paddingTop: 24, paddingLeft: 64, paddingBottom: 0, paddingRight: 0, width: 22, height: 24)
        commentLabel.anchor(top: saveLabel.topAnchor, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: commentLabel.intrinsicContentSize.width, height: commentLabel.intrinsicContentSize.height)
        commentLabel.centerXAnchor.constraint(equalTo: commentButton.centerXAnchor).isActive = true
        shareButton.anchor(top: alertView.topAnchor, left: commentButton.rightAnchor, bottom: nil, right: nil, paddingTop: 24, paddingLeft: 60, paddingBottom: 0, paddingRight: 0, width: 28, height: 24)
        shareLabel.anchor(top: saveLabel.topAnchor, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: shareLabel.intrinsicContentSize.width, height: shareLabel.intrinsicContentSize.height)
        shareLabel.centerXAnchor.constraint(equalTo: shareButton.centerXAnchor).isActive = true
        cancelButton.anchor(top: nil, left: alertView.leftAnchor, bottom: alertView.bottomAnchor, right: alertView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 32, paddingRight: 0, width: 0, height: cancelButton.intrinsicContentSize.height)
        cancelButton.centerXAnchor.constraint(equalTo: alertView.centerXAnchor).isActive = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(alertView)
        view.addSubview(dismissBackground)
        
        alertView.anchor(top: nil, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 155)
        alertView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 10).isActive = true
        dismissBackground.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: alertView.topAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        setupPhoto()
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
