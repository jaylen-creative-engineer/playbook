//
//  EmailCell.swift
//  pursue
//
//  Created by Jaylen Sanders on 4/5/18.
//  Copyright © 2018 Glory. All rights reserved.
//

import UIKit

class EmailCell : UICollectionViewCell {
    
    let hiLabel : UILabel = {
        let label = UILabel()
        label.text = "Welcome."
        label.font = UIFont.systemFont(ofSize: 24, weight: UIFont.Weight.init(25))
        return label
    }()
    
    let enterEmailPrompt : UILabel = {
       let label = UILabel()
        label.text = "Please enter your email address."
        label.font = UIFont.boldSystemFont(ofSize: 14)
        return label
    }()
    
    let emailLabel : UILabel = {
       let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.text = "Email"
        return label
    }()
    
    let emailTextField : UITextField = {
        let tf = UITextField()
        tf.font = UIFont.systemFont(ofSize: 14)
        tf.textColor = .black
        tf.layer.cornerRadius = 4
        tf.backgroundColor = UIColor.clear
        
        let attributes = [ NSAttributedStringKey.foregroundColor: UIColor.gray,
                           NSAttributedStringKey.font : UIFont.systemFont(ofSize: 14)]
        tf.attributedPlaceholder = NSAttributedString(string: "your@email.com", attributes:attributes)
        return tf
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let emailUnderline = UIView()
        emailUnderline.backgroundColor = .black
        
        addSubview(hiLabel)
        addSubview(enterEmailPrompt)
        addSubview(emailLabel)
        addSubview(emailTextField)
        addSubview(emailUnderline)
        hiLabel.anchor(top: topAnchor, left: nil, bottom: nil, right: nil, paddingTop: 64, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: hiLabel.intrinsicContentSize.width, height: hiLabel.intrinsicContentSize.height)
        hiLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        enterEmailPrompt.anchor(top: hiLabel.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 12, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: enterEmailPrompt.intrinsicContentSize.width, height: enterEmailPrompt.intrinsicContentSize.height)
        enterEmailPrompt.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        emailLabel.anchor(top: enterEmailPrompt.bottomAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 64, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: emailLabel.intrinsicContentSize.width, height: emailLabel.intrinsicContentSize.height)
        emailTextField.anchor(top: emailLabel.bottomAnchor, left: emailLabel.leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 24, paddingLeft: 0, paddingBottom: 0, paddingRight: 12, width: 0, height: emailTextField.intrinsicContentSize.height)
        emailUnderline.anchor(top: emailTextField.bottomAnchor, left: emailTextField.leftAnchor, bottom: nil, right: emailTextField.rightAnchor, paddingTop: 18, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0.5)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
