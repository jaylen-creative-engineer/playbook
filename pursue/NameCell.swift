//
//  NameCell.swift
//  pursue
//
//  Created by Jaylen Sanders on 4/5/18.
//  Copyright © 2018 Glory. All rights reserved.
//

import UIKit

class NameCell : UICollectionViewCell, UITextFieldDelegate {
    
    var accessSignupController : SignupController?
    
    let enterNamePrompt : UILabel = {
        let label = UILabel()
        label.text = "Please enter your full name."
        label.font = UIFont.boldSystemFont(ofSize: 14)
        return label
    }()
    
    let fullnameLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.text = "Full Name"
        return label
    }()
    
    let nameBigLabel : UILabel = {
        let label = UILabel()
        label.text = "Welcome."
        label.font = UIFont.systemFont(ofSize: 24, weight: UIFont.Weight.init(25))
        return label
    }()
    
    lazy var fullnameTextField : UITextField = {
        let tf = UITextField()
        tf.font = UIFont.systemFont(ofSize: 14)
        tf.textColor = .black
        tf.layer.cornerRadius = 4
        tf.backgroundColor = UIColor.clear
        
        let attributes = [ NSAttributedString.Key.foregroundColor: UIColor.gray,
                           NSAttributedString.Key.font : UIFont.systemFont(ofSize: 14)]
        tf.attributedPlaceholder = NSAttributedString(string: "your first and last name", attributes:attributes)
        tf.addTarget(self, action: #selector(setFullname), for: .editingChanged)
        return tf
    }()
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @objc func setFullname(){
        accessSignupController?.fullnameTextField.text = fullnameTextField.text
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        let fullnameUnderline = UIView()
        fullnameUnderline.backgroundColor = .black
        
        addSubview(nameBigLabel)
        addSubview(enterNamePrompt)
        addSubview(fullnameLabel)
        addSubview(fullnameTextField)
        addSubview(fullnameUnderline)
        
        nameBigLabel.anchor(top: topAnchor, left: nil, bottom: nil, right: nil, paddingTop: 64, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: nameBigLabel.intrinsicContentSize.width, height: nameBigLabel.intrinsicContentSize.height)
        nameBigLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        enterNamePrompt.anchor(top: nameBigLabel.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 12, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: enterNamePrompt.intrinsicContentSize.width, height: enterNamePrompt.intrinsicContentSize.height)
        enterNamePrompt.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        fullnameLabel.anchor(top: enterNamePrompt.bottomAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 64, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: fullnameLabel.intrinsicContentSize.width, height: fullnameLabel.intrinsicContentSize.height)
        fullnameTextField.anchor(top: fullnameLabel.bottomAnchor, left: fullnameLabel.leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 24, paddingLeft: 0, paddingBottom: 0, paddingRight: 12, width: 0, height: fullnameTextField.intrinsicContentSize.height)
        fullnameUnderline.anchor(top: fullnameTextField.bottomAnchor, left: fullnameTextField.leftAnchor, bottom: nil, right: fullnameTextField.rightAnchor, paddingTop: 18, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0.5)
        fullnameTextField.delegate = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
