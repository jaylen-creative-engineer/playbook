//
//  UsernameCell.swift
//  pursue
//
//  Created by Jaylen Sanders on 4/5/18.
//  Copyright © 2018 Glory. All rights reserved.
//

import UIKit

class UsernameCell : UICollectionViewCell, UITextFieldDelegate {
    
    var accessSignupController : SignupController?
    
    let enterUserNamePrompt : UILabel = {
        let label = UILabel()
        label.text = "Please enter a username."
        label.font = UIFont.boldSystemFont(ofSize: 14)
        return label
    }()
    
    let usernameBigLabel : UILabel = {
        let label = UILabel()
        label.text = "Username."
        label.font = UIFont.systemFont(ofSize: 24, weight: UIFont.Weight.init(25))
        return label
    }()
    
    let usernameLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.text = "Username"
        return label
    }()
    
    lazy var usernameTextField : UITextField = {
        let tf = UITextField()
        tf.font = UIFont.systemFont(ofSize: 14)
        tf.textColor = .black
        tf.layer.cornerRadius = 4
        tf.backgroundColor = UIColor.clear
        
        let attributes = [ NSAttributedString.Key.foregroundColor: UIColor.gray,
                           NSAttributedString.Key.font : UIFont.systemFont(ofSize: 14)]
        tf.attributedPlaceholder = NSAttributedString(string: "your username", attributes:attributes)
        tf.addTarget(self, action: #selector(setUsername), for: .editingChanged)
        return tf
    }()
    
    @objc func setUsername(){
        accessSignupController?.usernameTextField.text = usernameTextField.text
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        let usernameUnderline = UIView()
        usernameUnderline.backgroundColor = .black
        
        addSubview(usernameBigLabel)
        addSubview(enterUserNamePrompt)
        addSubview(usernameLabel)
        addSubview(usernameTextField)
        addSubview(usernameUnderline)
        usernameBigLabel.anchor(top: topAnchor, left: nil, bottom: nil, right: nil, paddingTop: 64, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: usernameBigLabel.intrinsicContentSize.width, height: usernameBigLabel.intrinsicContentSize.height)
        usernameBigLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        enterUserNamePrompt.anchor(top: usernameBigLabel.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 12, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: enterUserNamePrompt.intrinsicContentSize.width, height: enterUserNamePrompt.intrinsicContentSize.height)
        enterUserNamePrompt.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        usernameLabel.anchor(top: enterUserNamePrompt.bottomAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 64, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: usernameLabel.intrinsicContentSize.width, height: usernameLabel.intrinsicContentSize.height)
        usernameTextField.anchor(top: usernameLabel.bottomAnchor, left: usernameLabel.leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 24, paddingLeft: 0, paddingBottom: 0, paddingRight: 12, width: 0, height: usernameTextField.intrinsicContentSize.height)
        usernameUnderline.anchor(top: usernameTextField.bottomAnchor, left: usernameTextField.leftAnchor, bottom: nil, right: usernameTextField.rightAnchor, paddingTop: 18, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0.5)
        usernameTextField.delegate = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

