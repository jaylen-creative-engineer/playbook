//
//  EmailCell.swift
//  pursue
//
//  Created by Jaylen Sanders on 4/5/18.
//  Copyright © 2018 Glory. All rights reserved.
//

import UIKit

protocol EmailDelegate {
    func handlePasswordKeyboard(for cell : EmailCell)
    func handleEmailNext(for cell : EmailCell)
}

class EmailCell : UICollectionViewCell, UITextFieldDelegate {
    
    var accessSignupController : SignupController?
    var delegate : EmailDelegate?
    
    let hiLabel : UILabel = {
        let label = UILabel()
        label.text = "Email./ Password."
        label.font = UIFont.systemFont(ofSize: 24, weight: UIFont.Weight.init(25))
        return label
    }()
    
    let emailLabel : UILabel = {
       let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.text = "Email"
        return label
    }()
    
    lazy var emailTextField : UITextField = {
        let tf = UITextField()
        tf.font = UIFont.systemFont(ofSize: 14)
        tf.textColor = .black
        tf.layer.cornerRadius = 4
        tf.backgroundColor = UIColor.clear
        
        let attributes = [NSAttributedString.Key.foregroundColor: UIColor.gray,
                           NSAttributedString.Key.font : UIFont.systemFont(ofSize: 14)]
        tf.attributedPlaceholder = NSAttributedString(string: "your@email.com", attributes:attributes)
        tf.addTarget(self, action: #selector(setEmail), for: .editingChanged)
        return tf
    }()
    
    @objc func setEmail(){
        accessSignupController?.emailTextField.text = emailTextField.text
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.endEditing(true)
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
    let enterPasswordPrompt : UILabel = {
        let label = UILabel()
        label.text = "Your password must be 6 characters long or more."
        label.font = UIFont.systemFont(ofSize: 14)
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
    
    lazy var nextButton : UIButton = {
        let button = UIButton()
        button.setTitle("Next", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.addTarget(self, action: #selector(handleNext), for: .touchUpInside)
        button.contentHorizontalAlignment = .right
        button.contentVerticalAlignment = .center
        return button
    }()
    
    @objc func handleNext(){
        delegate?.handleEmailNext(for: self)
    }
    
    @objc func setPassword(){
        accessSignupController?.passwordTextField.text = passwordTextField.text
    }
    
    func setupPasswordView(){
        let passwordUnderline = UIView()
        passwordUnderline.backgroundColor = .black
        
        addSubview(passwordLabel)
        addSubview(enterPasswordPrompt)
        addSubview(passwordTextField)
        addSubview(passwordUnderline)
       
        passwordLabel.anchor(top: emailUnderline.bottomAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 64, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: passwordLabel.intrinsicContentSize.width, height: passwordLabel.intrinsicContentSize.height)
        
        enterPasswordPrompt.anchor(top: passwordLabel.bottomAnchor, left: passwordLabel.leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 18, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 18)
        passwordTextField.anchor(top: enterPasswordPrompt.bottomAnchor, left: passwordLabel.leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 24, paddingLeft: 0, paddingBottom: 0, paddingRight: 12, width: 0, height: passwordTextField.intrinsicContentSize.height)
        passwordUnderline.anchor(top: passwordTextField.bottomAnchor, left: passwordTextField.leftAnchor, bottom: nil, right: passwordTextField.rightAnchor, paddingTop: 18, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0.5)
    }
    
    let emailUnderline = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        emailUnderline.backgroundColor = .black
        
        addSubview(hiLabel)
        addSubview(emailLabel)
        addSubview(emailTextField)
        addSubview(emailUnderline)
        addSubview(nextButton)
        hiLabel.anchor(top: topAnchor, left: nil, bottom: nil, right: nil, paddingTop: 64, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: hiLabel.intrinsicContentSize.width, height: hiLabel.intrinsicContentSize.height)
        hiLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        emailLabel.anchor(top: hiLabel.bottomAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 64, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: emailLabel.intrinsicContentSize.width, height: emailLabel.intrinsicContentSize.height)
        emailTextField.anchor(top: emailLabel.bottomAnchor, left: emailLabel.leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 24, paddingLeft: 0, paddingBottom: 0, paddingRight: 12, width: 0, height: emailTextField.intrinsicContentSize.height)
        emailUnderline.anchor(top: emailTextField.bottomAnchor, left: emailTextField.leftAnchor, bottom: nil, right: emailTextField.rightAnchor, paddingTop: 18, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0.5)
         nextButton.anchor(top: topAnchor, left: nil, bottom: nil, right: safeAreaLayoutGuide.rightAnchor, paddingTop: 18, paddingLeft: 0, paddingBottom: 0, paddingRight: 12, width: 120, height: 34)
        setupPasswordView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
