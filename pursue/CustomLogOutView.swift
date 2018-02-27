//
//  CustomLogOutView.swift
//  pursue
//
//  Created by Jaylen Sanders on 2/26/18.
//  Copyright © 2018 Glory. All rights reserved.
//

import UIKit
import Firebase
import Hero

class CustomLogOutView : UIViewController {
    
    let alertViewGrayColor = UIColor(red: 224.0/255.0, green: 224.0/255.0, blue: 224.0/255.0, alpha: 1)
    
    let cellId = "cellId"
    
    lazy var alertView : UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    lazy var confirmLabel : UILabel = {
        let label = UILabel()
        label.text = "Are you sure you want to log out?"
        label.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.init(25))
        label.textAlignment = .left
        return label
    }()
    
    lazy var yesLabel : UIButton = {
        let label = UIButton()
        label.setTitle("Yes", for: .normal)
        label.setTitleColor(.black, for: .normal)
        label.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        label.titleLabel?.textAlignment = .left
        label.addTarget(self, action: #selector(handleYes), for: .touchUpInside)
        return label
    }()
    
    lazy var noLabel : UIButton = {
        let label = UIButton()
        label.setTitle("No", for: .normal)
        label.setTitleColor(.black, for: .normal)
        label.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        label.titleLabel?.textAlignment = .right
        label.addTarget(self, action: #selector(handleNo), for: .touchUpInside)
        return label
    }()
    
    lazy var dismissBackground : UIButton = {
       let button = UIButton()
        button.backgroundColor = .clear
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleNo), for: .touchUpInside)
        return button
    }()
    
    @objc func handleYes(){
        do {
            try Auth.auth().signOut()
            
            let loginController = LoginController()
            let navController = UINavigationController(rootViewController: loginController)
            self.present(navController, animated: true, completion: nil)
            self.dismiss(animated: true, completion: nil)
            
        } catch let signOutErr {
            
            print("Failed to sign out", signOutErr)
        }
    }
    
    @objc func handleNo(){
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isHeroEnabled = true
        view.addSubview(alertView)
        alertView.isUserInteractionEnabled = false
        alertView.addSubview(confirmLabel)
        alertView.addSubview(yesLabel)
        alertView.addSubview(noLabel)
        view.addSubview(dismissBackground)
        
        alertView.anchor(top: nil, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 150)
        confirmLabel.anchor(top: alertView.topAnchor, left: nil, bottom: nil, right: nil, paddingTop: 18, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: confirmLabel.intrinsicContentSize.width, height: confirmLabel.intrinsicContentSize.height)
        confirmLabel.centerXAnchor.constraint(equalTo: alertView.centerXAnchor).isActive = true
        yesLabel.anchor(top: confirmLabel.bottomAnchor, left: confirmLabel.leftAnchor, bottom: nil, right: confirmLabel.centerXAnchor, paddingTop: 24, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: 0, height: yesLabel.intrinsicContentSize.height)
        noLabel.anchor(top: confirmLabel.bottomAnchor, left: confirmLabel.centerXAnchor, bottom: nil, right: confirmLabel.rightAnchor, paddingTop: 24, paddingLeft: 0, paddingBottom: 12, paddingRight: 12, width: 0, height: noLabel.intrinsicContentSize.height)
        dismissBackground.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: alertView.topAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = true
        setupView()
        animateView()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        tabBarController?.tabBar.isHidden = false
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
