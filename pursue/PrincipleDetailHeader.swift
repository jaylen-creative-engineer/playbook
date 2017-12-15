//
//  PrincipleDetailHeader.swift
//  pursue
//
//  Created by Jaylen Sanders on 12/11/17.
//  Copyright © 2017 Glory. All rights reserved.
//

import UIKit

class PrincipleDetailHeader : PostDetailHeader {
    
    var principleDetailController : PrincipleDetailController?
    
    lazy var pursuitLabel : UIButton = {
        let label = UIButton()
        label.setTitle("Pursuits", for: .normal)
        label.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.addTarget(self, action: #selector(togglePursuitUnderline), for: .touchUpInside)
        return label
    }()
    
    lazy var discussionLabel : UIButton = {
        let label = UIButton()
        label.setTitle("Discussions", for: .normal)
        label.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.addTarget(self, action: #selector(toggleDiscussionUnderline), for: .touchUpInside)
        return label
    }()
    
    let pursuitLabelUnderline : UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 3
        view.layer.masksToBounds = true
        return view
    }()
    
    let discussionLabelUnderline : UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 3
        view.layer.masksToBounds = true
        return view
    }()
    

    @objc func togglePursuitUnderline(){
        pursuitLabelUnderline.backgroundColor = .black
        
        aboutButton.setTitleColor(.gray, for: .normal)
        commentsLabel.setTitleColor(.gray, for: .normal)
        discussionLabel.setTitleColor(.gray, for: .normal)
        pursuitLabel.setTitleColor(.black, for: .normal)
        
        pursuitActive()
        
        addSubview(pursuitLabelUnderline)
        pursuitLabelUnderline.anchor(top: nil, left: nil, bottom: bottomDividerView.topAnchor, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 6, height: 6)
        pursuitLabelUnderline.centerXAnchor.constraint(equalTo: pursuitLabel.centerXAnchor).isActive = true
    }
    
    func pursuitActive(){
        principleDetailController?.pursuitsActive()
        
        pursuitLabel.titleLabel?.isHidden = false
        
        aboutLabelUnderline.isHidden = true
        pursuitLabelUnderline.isHidden = false
        commentsLabelUnderline.isHidden = true
        discussionLabelUnderline.isHidden = true
        
    }
    
    @objc func toggleDiscussionUnderline(){
        discussionLabelUnderline.backgroundColor = .black
        
        aboutButton.setTitleColor(.gray, for: .normal)
        commentsLabel.setTitleColor(.gray, for: .normal)
        discussionLabel.setTitleColor(.black, for: .normal)
        pursuitLabel.setTitleColor(.gray, for: .normal)
        
        discussionActive()
        
        addSubview(discussionLabelUnderline)
        discussionLabelUnderline.anchor(top: nil, left: nil, bottom: bottomDividerView.topAnchor, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 6, height: 6)
        discussionLabelUnderline.centerXAnchor.constraint(equalTo: discussionLabel.centerXAnchor).isActive = true
    }
    
    func discussionActive(){
        principleDetailController?.discussionActive()

        discussionLabel.titleLabel?.isHidden = false
        
        aboutLabelUnderline.isHidden = true
        pursuitLabelUnderline.isHidden = true
        commentsLabelUnderline.isHidden = true
        discussionLabelUnderline.isHidden = false
    }
    
    @objc override func toggleAboutUnderline(){
        aboutLabelUnderline.backgroundColor = .black
        
        aboutButton.setTitleColor(.black, for: .normal)
        commentsLabel.setTitleColor(.gray, for: .normal)
        discussionLabel.setTitleColor(.gray, for: .normal)
        pursuitLabel.setTitleColor(.gray, for: .normal)
        
        aboutActive()
        
        addSubview(aboutLabelUnderline)
        aboutLabelUnderline.anchor(top: nil, left: nil, bottom: bottomDividerView.topAnchor, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 6, height: 6)
        aboutLabelUnderline.centerXAnchor.constraint(equalTo: aboutButton.centerXAnchor).isActive = true
    }
    
    override func aboutActive(){
        principleDetailController?.changeAbout()
        
        aboutButton.titleLabel?.isHidden = false
        
        aboutLabelUnderline.isHidden = false
        pursuitLabelUnderline.isHidden = true
        commentsLabelUnderline.isHidden = true
        discussionLabelUnderline.isHidden = true
        
    }
    
    @objc override func toggleCommentsUnderline(){
        commentsLabelUnderline.backgroundColor = .black
        
        aboutButton.setTitleColor(.gray, for: .normal)
        commentsLabel.setTitleColor(.black, for: .normal)
        discussionLabel.setTitleColor(.gray, for: .normal)
        pursuitLabel.setTitleColor(.gray, for: .normal)
        
        commentsActive()
        
        addSubview(commentsLabelUnderline)
        
        commentsLabelUnderline.anchor(top: nil, left: nil, bottom: bottomDividerView.topAnchor, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 6, height: 6)
        commentsLabelUnderline.centerXAnchor.constraint(equalTo: commentsLabel.centerXAnchor).isActive = true
    }
    
    override func commentsActive(){
        principleDetailController?.changeComment()
        
        aboutLabelUnderline.isHidden = true
        pursuitLabelUnderline.isHidden = true
        commentsLabelUnderline.isHidden = false
        discussionLabelUnderline.isHidden = true
    }
    
    override func pageOptions(){
        bottomDividerView.backgroundColor = .clear
        
        stackView = UIStackView(arrangedSubviews: [aboutButton, commentsLabel, pursuitLabel, discussionLabel])
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        
        addSubview(stackView)
        addSubview(bottomDividerView)
        stackView.anchor(top: postLabel.bottomAnchor, left: postLabel.leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 20, paddingLeft: 0, paddingBottom: 0, paddingRight: 20, width: 0, height: 50)
        bottomDividerView.anchor(top: stackView.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0.5)
       
    }
    
    override func setupViews() {
        addSubview(postImage)
        addSubview(postLabel)
        addSubview(optionButton)
        addSubview(optionBackground)
        
        postImage.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 44, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: (frame.height / 2) + 50)
        optionButton.anchor(top: postImage.bottomAnchor, left: nil, bottom: nil, right: rightAnchor, paddingTop: 20, paddingLeft: 0, paddingBottom: 0, paddingRight: 22, width: 4.5, height: 20)
        optionBackground.anchor(top: optionButton.topAnchor, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 30, height: 30)
        optionBackground.centerXAnchor.constraint(equalTo: optionButton.centerXAnchor).isActive = true
        postLabel.anchor(top: postImage.bottomAnchor, left: postImage.leftAnchor, bottom: nil, right: optionButton.rightAnchor, paddingTop: 12, paddingLeft: 12, paddingBottom: 0, paddingRight: 12, width: 0, height: 52)
        pageOptions()
    }
}
