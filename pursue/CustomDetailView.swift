//
//  CustomDetailView.swift
//  pursue
//
//  Created by Jaylen Sanders on 2/28/18.
//  Copyright © 2018 Glory. All rights reserved.
//

import UIKit

class CustomDetailView : UIViewController {
    
    let alertViewGrayColor = UIColor(red: 224.0/255.0, green: 224.0/255.0, blue: 224.0/255.0, alpha: 1)
    let cellId = "cellId"
    
    lazy var alertView : UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    lazy var linkLabel : UILabel = {
        let label = UILabel()
        label.text = "Options"
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
    
    lazy var reportTitle : UIButton = {
        let button = UIButton()
        button.setTitle("Report Post", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleYes), for: .touchUpInside)
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
        alertView.addSubview(reportTitle)
        alertView.addSubview(shareTitle)
        alertView.addSubview(cancelLabel)
        view.addSubview(cancelBackground)
        view.addSubview(dismissBackground)
        
        alertView.anchor(top: nil, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 225)
        linkLabel.anchor(top: alertView.topAnchor, left: alertView.leftAnchor, bottom: nil, right: nil, paddingTop: 18, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: linkLabel.intrinsicContentSize.width, height: linkLabel.intrinsicContentSize.height)
        reportTitle.anchor(top: linkLabel.bottomAnchor, left: alertView.leftAnchor, bottom: nil, right: nil, paddingTop: 26, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: reportTitle.intrinsicContentSize.width, height: reportTitle.intrinsicContentSize.height)
        shareTitle.anchor(top: reportTitle.bottomAnchor, left: alertView.leftAnchor, bottom: nil, right: nil, paddingTop: 26, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: shareTitle.intrinsicContentSize.width, height: shareTitle.intrinsicContentSize.height)
        cancelLabel.anchor(top: nil, left: nil, bottom: alertView.safeAreaLayoutGuide.bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 8, paddingRight: 0, width: cancelLabel.intrinsicContentSize.width, height: cancelLabel.intrinsicContentSize.height)
        cancelLabel.centerXAnchor.constraint(equalTo: alertView.centerXAnchor).isActive = true
        cancelBackground.anchor(top: nil, left: nil, bottom: alertView.safeAreaLayoutGuide.bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 8, paddingRight: 0, width: 100, height: 50)
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

extension CustomDetailView : UITextViewDelegate {
    
}
