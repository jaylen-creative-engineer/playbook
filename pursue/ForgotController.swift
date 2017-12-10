//
//  ForgotController.swift
//  pursue
//
//  Created by Jaylen Sanders on 12/4/17.
//  Copyright © 2017 Glory. All rights reserved.
//

import UIKit

class ForgotController : UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.backgroundColor = .white
        setupNavBar()
    }
    
    let emailLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 10
        
        let attrString = NSMutableAttributedString(string:  "We will send a password reset link to your email.")
        attrString.addAttribute(NSAttributedStringKey.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, attrString.length))
        label.attributedText = attrString
        
        label.numberOfLines = 2
        label.textAlignment = .justified
        label.textColor = .black
        return label
    }()
    
    let submitButton : UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("SUBMIT", for: .normal)
        button.backgroundColor = UIColor.black
        button.layer.cornerRadius = 20
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.setTitleColor(.white, for: .normal)
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.borderWidth = 1
        button.addTarget(self, action: #selector(handleSignup), for: .touchUpInside)
        button.isEnabled = false
        return button
    }()
    
    
    let emailTextField : UITextField = {
        let tf = UITextField()
        tf.font = UIFont.boldSystemFont(ofSize: 16)
        tf.textColor = .black
        
        let attributes = [ NSAttributedStringKey.foregroundColor: UIColor.black,
                           NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: 16)]
        tf.attributedPlaceholder = NSAttributedString(string: "EMAIL", attributes:attributes)
        return tf
    }()
    
    lazy var backButton : UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "back-arrow").withRenderingMode(.alwaysOriginal), for: .normal)
        button.addTarget(self, action: #selector(handleDismiss), for: .touchUpInside)
        return button
    }()
    
    let forgotLabel : UILabel = {
        let label = UILabel()
        label.text = "FORGOT"
        label.font = UIFont.boldSystemFont(ofSize: 18)
        return label
    }()
    
    
    
    @objc func handleDismiss(){
        navigationController?.popViewController(animated: true)
    }
    
    func setupNavBar() {
        view.addSubview(backButton)
        view.addSubview(forgotLabel)
        
        backButton.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: nil, paddingTop: 48, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: 20, height: 20)
        forgotLabel.anchor(top: backButton.topAnchor, left: backButton.rightAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 18, paddingBottom: 0, paddingRight: 0, width: forgotLabel.intrinsicContentSize.width, height: forgotLabel.intrinsicContentSize.height)
        setupEmail()
    }
    
    @objc func handleSignup() {
        
    }
    
    func setupEmail(){
        view.addSubview(emailLabel)
        view.addSubview(emailTextField)
        view.addSubview(submitButton)
        
        emailLabel.anchor(top: forgotLabel.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 42, paddingLeft: 12, paddingBottom: 0, paddingRight: 40, width: 0, height: 60)
        emailTextField.anchor(top: emailLabel.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 24, paddingLeft: 12, paddingBottom: 0, paddingRight: 40, width: 0, height: 50)
        submitButton.anchor(top: emailTextField.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 42, paddingLeft: 40, paddingBottom: 0, paddingRight: 40, width: 0, height: 40)
    }
}
