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
        placeholderLabel.isHidden = false
    }
    
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleTextChange), name: .UITextViewTextDidChange, object: nil)
        
        addSubview(placeholderLabel)
        placeholderLabel.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 8, paddingLeft: 4, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
    }
    
    @objc func handleTextChange() {
        placeholderLabel.isHidden = !self.text.isEmpty
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
