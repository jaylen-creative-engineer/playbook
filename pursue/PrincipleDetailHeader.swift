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
        view.layer.masksToBounds = true
        return view
    }()
    
    let discussionLabelUnderline : UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.translatesAutoresizingMaskIntoConstraints = false
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
        pursuitLabelUnderline.anchor(top: nil, left: pursuitLabel.leftAnchor, bottom: bottomDividerView.topAnchor, right: pursuitLabel.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 2.5)
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
        discussionLabelUnderline.anchor(top: nil, left: discussionLabel.leftAnchor, bottom: bottomDividerView.topAnchor, right: discussionLabel.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 2.5)
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
        aboutLabelUnderline.anchor(top: nil, left: aboutButton.leftAnchor, bottom: bottomDividerView.topAnchor, right: aboutButton.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 2.5)
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
        
        commentsLabelUnderline.anchor(top: nil, left: commentsLabel.leftAnchor, bottom: bottomDividerView.topAnchor, right: commentsLabel.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 2.5)
    }
    
    override func commentsActive(){
        principleDetailController?.changeComment()
        
        aboutLabelUnderline.isHidden = true
        pursuitLabelUnderline.isHidden = true
        commentsLabelUnderline.isHidden = false
        discussionLabelUnderline.isHidden = true
    }
    
    override func pageOptions(){
        bottomDividerView.backgroundColor = UIColor.rgb(red: 211, green: 211, blue: 211)
        let scrollView = UIScrollView()
        
        stackView = UIStackView(arrangedSubviews: [aboutButton, commentsLabel, pursuitLabel, discussionLabel])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 20
        
        addSubview(scrollView)
        scrollView.addSubview(stackView)
        addSubview(bottomDividerView)
        
        scrollView.anchor(top: postImage.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 6, paddingLeft: 10, paddingBottom: 0, paddingRight: 0, width: 0, height: 50)
        stackView.anchor(top: postImage.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 6, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 50)
        bottomDividerView.anchor(top: stackView.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 1)
       
    }
    
    override func setupViews() {
        addSubview(postImage)
        
        postImage.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 44, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 250)
        pageOptions()
    }
}
