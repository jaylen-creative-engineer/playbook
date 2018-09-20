//
//  BioInputTextView.swift
//  pursue
//
//  Created by Jaylen Sanders on 1/9/18.
//  Copyright © 2018 Glory. All rights reserved.
//

import UIKit

class BioInputTextView : UITextView {
    
    fileprivate let placeholderLabel: UILabel = {
        let label = UILabel()
        label.text = "Enter bio"
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor.black
        return label
    }()
    
    func showPlaceholderLabel() {
        if self.text.isEmpty {
            placeholderLabel.isHidden = false
        } else {
            placeholderLabel.isHidden = true
        }
    }
    
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleTextChange), name: .UITextViewTextDidChange, object: nil)
        
        addSubview(placeholderLabel)
        placeholderLabel.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 8, paddingLeft: 4, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        showPlaceholderLabel()
    }
    
    @objc func handleTextChange() {
        placeholderLabel.isHidden = !self.text.isEmpty
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


class CreateInputTextView : UITextView {
    
    fileprivate let placeholderLabel: UILabel = {
        let label = UILabel()
        label.text = "Add Caption"
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor.gray
        return label
    }()
    
    func showPlaceholderLabel() {
        if self.text.isEmpty {
            placeholderLabel.isHidden = false
        } else {
            placeholderLabel.isHidden = true
        }
    }
    
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleTextChange), name: .UITextViewTextDidChange, object: nil)
        
        addSubview(placeholderLabel)
        placeholderLabel.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 14, paddingLeft: 14, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        showPlaceholderLabel()
    }
    
    @objc func handleTextChange() {
        placeholderLabel.isHidden = !self.text.isEmpty
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

