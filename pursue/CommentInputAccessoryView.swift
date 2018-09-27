//
//  CommentInputAccessoryView.swift
//  pursue
//
//  Created by Jaylen Sanders on 2/19/18.
//  Copyright © 2018 Glory. All rights reserved.
//

import UIKit

//protocol CommentInputAccessoryViewDelegate {
//    func didSubmit(for comment: String)
//}

class CommentInputAccessoryView : UIView {
    
//    var delegate: CommentInputAccessoryViewDelegate?
    
    func clearCommentTextField() {
        commentTextView.text = nil
        commentTextView.showPlaceholderLabel()
    }
    
    fileprivate let commentTextView: CommentInputTextView = {
        let tv = CommentInputTextView()
        tv.layer.cornerRadius = 15
        tv.layer.masksToBounds = true
        tv.isScrollEnabled = false
        tv.font = UIFont.systemFont(ofSize: 14)
        return tv
    }()
    
    let textViewBackground : StoryRectangleView = {
       let view = StoryRectangleView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    fileprivate let submitButton: UIButton = {
        let sb = UIButton(type: .system)
        sb.setTitle("Submit", for: .normal)
        sb.setTitleColor(.black, for: .normal)
        sb.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        sb.addTarget(self, action: #selector(handleSubmit), for: .touchUpInside)
        return sb
    }()
    
    lazy var sendBackground : UIButton = {
       let button = UIButton()
        button.backgroundColor = .black
        button.layer.cornerRadius = 17.5
        button.layer.masksToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var sendIcon : UIImageView = {
       let button = UIImageView()
        button.image = #imageLiteral(resourceName: "send").withRenderingMode(.alwaysTemplate)
        button.tintColor = .white
        button.contentMode = .scaleAspectFill
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    
    fileprivate func setupSendButton() {
        addSubview(sendBackground)
        sendBackground.addSubview(sendIcon)
        
        sendBackground.anchor(top: topAnchor, left: nil, bottom: nil, right: rightAnchor, paddingTop: 2, paddingLeft: 0, paddingBottom: 0, paddingRight: 8, width: 35, height: 35)
        sendIcon.anchor(top: nil, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 16, height: 14)
        sendIcon.centerXAnchor.constraint(equalTo: sendBackground.centerXAnchor).isActive = true
        sendIcon.centerYAnchor.constraint(equalTo: sendBackground.centerYAnchor).isActive = true
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        autoresizingMask = .flexibleHeight
        backgroundColor = .red
        
        setupSendButton()
        
        
        addSubview(textViewBackground)
        addSubview(commentTextView)
        
        if #available(iOS 11.0, *) {
            textViewBackground.anchor(top: sendBackground.topAnchor, left: leftAnchor, bottom: safeAreaLayoutGuide.bottomAnchor, right: sendBackground.leftAnchor, paddingTop: 2, paddingLeft: 12, paddingBottom: 8, paddingRight: 12, width: 0, height: 0)
            commentTextView.anchor(top: textViewBackground.topAnchor, left: textViewBackground.leftAnchor, bottom: textViewBackground.bottomAnchor, right: textViewBackground.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        } else {
            // Fallback on earlier versions
        }
    }
    
    // 2
    override var intrinsicContentSize: CGSize {
        return .zero
    }
    
    @objc func handleSubmit() {
        guard let commentText = commentTextView.text else { return }
//        delegate?.didSubmit(for: commentText)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
