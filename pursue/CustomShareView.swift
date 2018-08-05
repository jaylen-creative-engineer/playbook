//
//  CustomShareView.swift
//  pursue
//
//  Created by Jaylen Sanders on 7/15/18.
//  Copyright © 2018 Glory. All rights reserved.
//

import UIKit

class CustomShareView : UIViewController {
    
    let alertViewGrayColor = UIColor(red: 224.0/255.0, green: 224.0/255.0, blue: 224.0/255.0, alpha: 1)
    let cellId = "cellId"
    var accessLoginController : LoginController?
    
    lazy var alertView : UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    let facebookButtonBackground : UIButton = {
       let button = UIButton()
        button.backgroundColor = .gray
        button.layer.cornerRadius = 15
        button.layer.masksToBounds = true
        return button
    }()
    
    let facebookIcon : UIImageView = {
       let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "facebook_white_icon").withRenderingMode(.alwaysOriginal)
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    let instagramButtonBackground : UIButton = {
        let button = UIButton()
        button.backgroundColor = .red
        button.layer.cornerRadius = 15
        button.layer.masksToBounds = true
        return button
    }()
    
    let instagramIcon : UIImageView = {
       let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "instagram-logo").withRenderingMode(.alwaysOriginal)
        iv.contentMode = .scaleAspectFill
        return iv
    }()

    let messagesButton : UIButton = {
       let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "messages-logo").withRenderingMode(.alwaysOriginal), for: .normal)
        button.contentMode = .scaleAspectFill
        return button
    }()
    
    lazy var settingsLabel : UILabel = {
        let label = UILabel()
        label.text = "Settings"
        label.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.init(25))
        label.textAlignment = .left
        return label
    }()
    
    lazy var dismissBackground : UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleCancel), for: .touchUpInside)
        return button
    }()
    
    lazy var cancelBottomButton : UIButton = {
        let button = UIButton()
        button.setTitle("Cancel", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.init(25))
        button.titleLabel?.textAlignment = .center
        button.addTarget(self, action: #selector(handleCancel), for: .touchUpInside)
        return button
    }()
    
    func setupOptions(){
        view.addSubview(instagramButtonBackground)
        view.addSubview(instagramIcon)
        view.addSubview(facebookButtonBackground)
        view.addSubview(facebookIcon)
        view.addSubview(messagesButton)
        
        instagramButtonBackground.anchor(top: nil, left: nil, bottom: alertView.bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 30, height: 30)
        instagramButtonBackground.centerXAnchor.constraint(equalTo: alertView.centerXAnchor).isActive = true
        instagramIcon.anchor(top: nil, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 17, height: 17)
        instagramIcon.centerXAnchor.constraint(equalTo: instagramButtonBackground.centerXAnchor).isActive = true
        instagramIcon.centerYAnchor.constraint(equalTo: instagramButtonBackground.centerYAnchor).isActive = true
        facebookButtonBackground.anchor(top: instagramButtonBackground.topAnchor, left: nil, bottom: nil, right: instagramButtonBackground.leftAnchor, paddingTop: 0, paddingLeft: 18, paddingBottom: 0, paddingRight: 0, width: 30, height: 30)
        facebookIcon.centerXAnchor.constraint(equalTo: facebookButtonBackground.centerXAnchor).isActive = true
        facebookIcon.centerYAnchor.constraint(equalTo: facebookButtonBackground.centerYAnchor).isActive = true
        messagesButton.anchor(top: instagramButtonBackground.topAnchor, left: instagramButtonBackground.rightAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 18, paddingBottom: 0, paddingRight: 0, width: 17, height: 17)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(alertView)
        view.addSubview(dismissBackground)
        
        alertView.anchor(top: nil, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 270)
        alertView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 10).isActive = true
        dismissBackground.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: alertView.topAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        setupOptions()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupView()
        animateView()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        tabBarController?.tabBar.isHidden = false
    }
    
    @objc func handleCancel(){
        dismiss(animated: true, completion: nil)
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
