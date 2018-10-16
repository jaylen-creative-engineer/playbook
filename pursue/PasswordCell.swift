//
//  PasswordCell.swift
//  pursue
//
//  Created by Jaylen Sanders on 4/5/18.
//  Copyright © 2018 Glory. All rights reserved.
//

import UIKit

class PasswordCell : UICollectionViewCell {
    
    var accessSignupController : SignupController?
    
    let passwordBigLabel : UILabel = {
        let label = UILabel()
        label.text = "Password."
        label.font = UIFont.systemFont(ofSize: 24, weight: UIFont.Weight.init(25))
        return label
    }()
    
    let enterPasswordPrompt : UILabel = {
        let label = UILabel()
        label.text = "Please enter your password."
        label.font = UIFont.boldSystemFont(ofSize: 14)
        return label
    }()
    
    let passwordLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.text = "Password"
        return label
    }()
    
    lazy var passwordTextField : UITextField = {
        let tf = UITextField()
        tf.font = UIFont.systemFont(ofSize: 14)
        tf.textColor = .black
        tf.layer.cornerRadius = 4
        tf.backgroundColor = UIColor.clear
        
        let attributes = [ NSAttributedString.Key.foregroundColor: UIColor.gray,
                           NSAttributedString.Key.font : UIFont.systemFont(ofSize: 14)]
        tf.attributedPlaceholder = NSAttributedString(string: "your password", attributes:attributes)
        tf.isSecureTextEntry = true
        tf.addTarget(self, action: #selector(setPassword), for: .editingChanged)
        return tf
    }()
    
    @objc func setPassword(){
        accessSignupController?.passwordTextField.text = passwordTextField.text
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        let passwordUnderline = UIView()
        passwordUnderline.backgroundColor = .black
        
        addSubview(passwordBigLabel)
        addSubview(enterPasswordPrompt)
        addSubview(passwordLabel)
        addSubview(passwordTextField)
        addSubview(passwordUnderline)
        passwordBigLabel.anchor(top: topAnchor, left: nil, bottom: nil, right: nil, paddingTop: 64, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: passwordBigLabel.intrinsicContentSize.width, height: passwordBigLabel.intrinsicContentSize.height)
        passwordBigLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        enterPasswordPrompt.anchor(top: passwordBigLabel.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 12, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: enterPasswordPrompt.intrinsicContentSize.width, height: enterPasswordPrompt.intrinsicContentSize.height)
        enterPasswordPrompt.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        passwordLabel.anchor(top: enterPasswordPrompt.bottomAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 64, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: passwordLabel.intrinsicContentSize.width, height: passwordLabel.intrinsicContentSize.height)
        passwordTextField.anchor(top: passwordLabel.bottomAnchor, left: passwordLabel.leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 24, paddingLeft: 0, paddingBottom: 0, paddingRight: 12, width: 0, height: passwordTextField.intrinsicContentSize.height)
        passwordUnderline.anchor(top: passwordTextField.bottomAnchor, left: passwordTextField.leftAnchor, bottom: nil, right: passwordTextField.rightAnchor, paddingTop: 18, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0.5)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
