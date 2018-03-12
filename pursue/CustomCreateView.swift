//
//  CustomCreateView.swift
//  pursue
//
//  Created by Jaylen Sanders on 2/23/18.
//  Copyright © 2018 Glory. All rights reserved.
//

import UIKit
import Hero

class CustomCreateView : UIViewController {
    
    let alertViewGrayColor = UIColor(red: 224.0/255.0, green: 224.0/255.0, blue: 224.0/255.0, alpha: 1)
    let cellId = "cellId"
    
    lazy var alertView : UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    lazy var pursuitPhoto : UIImageView = {
       let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "samuel-l").withRenderingMode(.alwaysOriginal)
        iv.contentMode = .scaleAspectFill
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.layer.cornerRadius = 4
        iv.layer.masksToBounds = true
        return iv
    }()
    
    lazy var sendButton : UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "send").withRenderingMode(.alwaysOriginal), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.contentMode = .scaleAspectFill
        button.addTarget(self, action: #selector(handleSend), for: .touchUpInside)
        return button
    }()
    
    lazy var sendLabel : UILabel = {
        let label = UILabel()
        label.text = "Create pursuit"
        label.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.init(25))
        label.textAlignment = .left
        return label
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
    
    lazy var pursuitTitle : UITextView = {
        let tv = UITextView()
        tv.delegate = self
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.font = UIFont.boldSystemFont(ofSize: 12)
        tv.isScrollEnabled = false
        tv.isUserInteractionEnabled = false
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 60
        paragraphStyle.paragraphSpacing = 15
        
        let attrString = NSMutableAttributedString(string: "")
        attrString.addAttribute(NSAttributedStringKey.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, attrString.length))
        
        tv.attributedText = attrString
        return tv
    }()
    
    lazy var pursuitUnderline : UIView = {
       let view = UIView()
        view.backgroundColor = .black
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var dismissBackground : UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleCancel), for: .touchUpInside)
        return button
    }()
    
    let createService = CreateServices()
    
    @objc func handleSend(){
//        createService.createPursuit(pursuitId: <#T##String#>, contentUrl: <#T##String#>, thumbnailUrl: <#T##String#>, pursuitDescription: <#T##String#>, is_visible: 1)
    }
    
    @objc func handleDismiss(){
        let customAlert = CustomAlertView()
        customAlert.providesPresentationContextTransitionStyle = true
        customAlert.definesPresentationContext = true
        customAlert.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        customAlert.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        self.present(customAlert, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(alertView)
        alertView.addSubview(sendLabel)
        alertView.addSubview(cancelLabel)
        alertView.addSubview(pursuitPhoto)
        alertView.addSubview(pursuitTitle)
        alertView.addSubview(pursuitUnderline)
        alertView.addSubview(sendButton)
        alertView.addSubview(cancelBackground)
        view.addSubview(dismissBackground)
        
        alertView.anchor(top: nil, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 325)
       
        sendLabel.anchor(top: alertView.topAnchor, left: alertView.leftAnchor, bottom: nil, right: nil, paddingTop: 18, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: sendLabel.intrinsicContentSize.width, height: sendLabel.intrinsicContentSize.height)
        pursuitPhoto.anchor(top: sendLabel.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 18, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 105, height: 120)
        pursuitPhoto.centerXAnchor.constraint(equalTo: alertView.centerXAnchor).isActive = true
        pursuitTitle.anchor(top: pursuitPhoto.bottomAnchor, left: pursuitPhoto.leftAnchor, bottom: nil, right: pursuitPhoto.rightAnchor, paddingTop: 12, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: pursuitTitle.intrinsicContentSize.height)
        pursuitUnderline.anchor(top: pursuitTitle.bottomAnchor, left: pursuitTitle.leftAnchor, bottom: nil, right: pursuitTitle.rightAnchor, paddingTop: 8, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0.5)
        sendButton.anchor(top: alertView.topAnchor, left: nil, bottom: nil, right: alertView.rightAnchor, paddingTop: 18, paddingLeft: 0, paddingBottom: 0, paddingRight: 12, width: 18, height: 18)
        
        cancelLabel.anchor(top: nil, left: nil, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 8, paddingRight: 0, width: cancelLabel.intrinsicContentSize.width, height: cancelLabel.intrinsicContentSize.height)
        cancelLabel.centerXAnchor.constraint(equalTo: alertView.centerXAnchor).isActive = true
        cancelBackground.anchor(top: nil, left: nil, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 8, paddingRight: 0, width: 100, height: 50)
        cancelBackground.centerXAnchor.constraint(equalTo: alertView.centerXAnchor).isActive = true
        dismissBackground.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: alertView.topAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupView()
        animateView()
    }
    
    @objc func handleCancel(){
        navigationController?.isHeroEnabled = true
        navigationController?.heroNavigationAnimationType =  .fade
        navigationController?.popViewController(animated: true)
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

extension CustomCreateView : UITextViewDelegate {
    
}
