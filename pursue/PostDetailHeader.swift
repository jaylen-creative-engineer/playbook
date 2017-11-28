//
//  PostDetailHeader.swift
//  pursue
//
//  Created by Jaylen Sanders on 10/14/17.
//  Copyright © 2017 Glory. All rights reserved.
//

import UIKit

protocol PostDetailHeaderDelegate {
    func goBack()
    func didChangeToLikesView()
    func didChangeToCommentsView()
    func didChangeToRelatedView()
    func didChangeToAboutView()
}

protocol PostMessageDelegate {
    func handleMessage(for cell : PostDetailHeader)
}

class PostDetailHeader : UICollectionViewCell {
    
    var postDetailDelegate : PostDetailHeaderDelegate?
    var messageDelegate : PostMessageDelegate?
    
    lazy var backButton : UIButton = {
       let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "back-button").withRenderingMode(.alwaysOriginal), for: .normal)
        button.addTarget(self, action: #selector(dismissView), for: .touchUpInside)
        return button
    }()
    
    lazy var chatIcon : UIButton = {
        let button = UIButton()
        button.setBackgroundImage(#imageLiteral(resourceName: "send2").withRenderingMode(.alwaysOriginal), for: .normal)
        button.addTarget(self, action: #selector(handleChat), for: .touchUpInside)
        return button
    }()
    
    let postImage : UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.image = #imageLiteral(resourceName: "samuel-l")
        return iv
    }()
    
    let postLabel : UILabel = {
        let label = UILabel()
        label.text = "Wonder Woman"
        label.font = UIFont.systemFont(ofSize: 24, weight: UIFont.Weight(rawValue: 25))
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        return label
    }()
    
    lazy var addButton : UIButton = {
        let button = UIButton()
        button.backgroundColor = .black
        button.layer.cornerRadius = 20
        button.layer.masksToBounds = true
        return button
    }()
    
    let plusForButton : UIImageView = {
        let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "add-button-white-hi").withRenderingMode(.alwaysOriginal)
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    lazy var aboutButton : UIButton = {
        let label = UIButton()
        label.setTitle("ABOUT", for: .normal)
        label.titleLabel?.font = UIFont.boldSystemFont(ofSize: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.addTarget(self, action: #selector(toggleAboutUnderline), for: .touchUpInside)
        return label
    }()
    
    lazy var likesLabel : UIButton = {
        let label = UIButton()
        label.setTitle("LIKES", for: .normal)
        label.titleLabel?.font = UIFont.boldSystemFont(ofSize: 12)
        label.addTarget(self, action: #selector(toggleLikesUnderline), for: .touchUpInside)
        return label
    }()
    
    lazy var commentsLabel : UIButton = {
        let label = UIButton()
        label.setTitle("COMMENTS", for: .normal)
        label.titleLabel?.font = UIFont.boldSystemFont(ofSize: 12)
        label.addTarget(self, action: #selector(toggleCommentsUnderline), for: .touchUpInside)
        return label
    }()
    
    lazy var relatedLabel : UIButton = {
        let label = UIButton()
        label.setTitle("RELATED", for: .normal)
        label.titleLabel?.font = UIFont.boldSystemFont(ofSize: 12)
        label.addTarget(self, action: #selector(toggleRelatedUnderline), for: .touchUpInside)
        return label
    }()
    
    var stackView = UIStackView()
    let aboutLabelUnderline = UIView()
    let commentsLabelUnderline = UIView()
    let relatedLabelUnderline = UIView()
    let likesLabelUnderline = UIView()
    let bottomDividerView = UIView()
    
    @objc func dismissView(){
        postDetailDelegate?.goBack()
    }
    
    @objc func handleChat(){
        messageDelegate?.handleMessage(for: self)
    }
    
    func setupTopNavBar(){
        addSubview(backButton)
        addSubview(chatIcon)
        
        backButton.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: 25, height: 25)
        chatIcon.anchor(top: topAnchor, left: nil, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 24, width: 0, height: 20)
    }
    
    func pageOptions(){
        bottomDividerView.backgroundColor = UIColor.init(white: 0, alpha: 0.2)
        
        stackView = UIStackView(arrangedSubviews: [aboutButton, likesLabel, commentsLabel, relatedLabel])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        
        addSubview(stackView)
        addSubview(bottomDividerView)
        
        stackView.anchor(top: postLabel.bottomAnchor, left: postLabel.leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 20, paddingLeft: 0, paddingBottom: 0, paddingRight: 20, width: 0, height: 50)
        bottomDividerView.anchor(top: stackView.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0.5)
    }
    
    func setupViews() {
        setupTopNavBar()
        
        addSubview(postImage)
        addSubview(postLabel)
        addSubview(addButton)
        addButton.addSubview(plusForButton)

        postImage.anchor(top: backButton.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 10, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: (frame.height / 2) + 50)
        postLabel.anchor(top: postImage.bottomAnchor, left: postImage.leftAnchor, bottom: nil, right: nil, paddingTop: 12, paddingLeft: 12, paddingBottom: 0, paddingRight: 12, width: 300, height: 52)
        addButton.anchor(top: postImage.bottomAnchor, left: nil, bottom: nil, right: rightAnchor, paddingTop: 26, paddingLeft: 12, paddingBottom: 0, paddingRight: 12, width: 40, height: 40)
        plusForButton.anchor(top: nil, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 15, height: 15)
        plusForButton.centerYAnchor.constraint(equalTo: addButton.centerYAnchor).isActive = true
        plusForButton.centerXAnchor.constraint(equalTo: addButton.centerXAnchor).isActive = true
        pageOptions()
    }
    
    @objc func toggleAboutUnderline(){
        aboutLabelUnderline.backgroundColor = .black
        
        likesLabel.setTitleColor(.gray, for: .normal)
        aboutButton.setTitleColor(.black, for: .normal)
        commentsLabel.setTitleColor(.gray, for: .normal)
        relatedLabel.setTitleColor(.gray, for: .normal)
        
        aboutActive()
        
        addSubview(aboutLabelUnderline)
        aboutLabelUnderline.anchor(top: nil, left: aboutButton.leftAnchor, bottom: bottomDividerView.topAnchor, right: aboutButton.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 2.5)
    }
    
    func aboutActive(){
        postDetailDelegate?.didChangeToAboutView()
        
        aboutButton.titleLabel?.isHidden = false
        
        aboutLabelUnderline.isHidden = false
        likesLabelUnderline.isHidden = true
        commentsLabelUnderline.isHidden = true
        relatedLabelUnderline.isHidden = true

    }
    
    @objc func toggleLikesUnderline(){
        likesLabelUnderline.backgroundColor = .black
        
        likesLabel.setTitleColor(.black, for: .normal)
        aboutButton.setTitleColor(.gray, for: .normal)
        commentsLabel.setTitleColor(.gray, for: .normal)
        relatedLabel.setTitleColor(.gray, for: .normal)
        
        likesActive()
        
        addSubview(likesLabelUnderline)
        likesLabelUnderline.anchor(top: nil, left: likesLabel.leftAnchor, bottom: bottomDividerView.topAnchor, right: likesLabel.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 2.5)
    }
    
    func likesActive(){
        postDetailDelegate?.didChangeToLikesView()
        
        likesLabelUnderline.isHidden = false
        aboutLabelUnderline.isHidden = true
        commentsLabelUnderline.isHidden = true
        relatedLabelUnderline.isHidden = true
    }
    
    @objc func toggleCommentsUnderline(){
        commentsLabelUnderline.backgroundColor = .black
        
        likesLabel.setTitleColor(.gray, for: .normal)
        aboutButton.setTitleColor(.gray, for: .normal)
        commentsLabel.setTitleColor(.black, for: .normal)
        relatedLabel.setTitleColor(.gray, for: .normal)
        
        commentsActive()
        
        addSubview(commentsLabelUnderline)
        commentsLabelUnderline.anchor(top: nil, left: commentsLabel.leftAnchor, bottom: bottomDividerView.topAnchor, right: commentsLabel.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 2.5)
    }
    
    func commentsActive(){
        postDetailDelegate?.didChangeToCommentsView()
        
        commentsLabelUnderline.isHidden = false
        aboutLabelUnderline.isHidden = true
        relatedLabelUnderline.isHidden = true
        likesLabelUnderline.isHidden = true
    }
    
    @objc func toggleRelatedUnderline() {
        relatedLabelUnderline.backgroundColor = .black
        
        likesLabel.setTitleColor(.gray, for: .normal)
        aboutButton.setTitleColor(.gray, for: .normal)
        commentsLabel.setTitleColor(.gray, for: .normal)
        relatedLabel.setTitleColor(.black, for: .normal)
        relatedActive()
        
        addSubview(relatedLabelUnderline)
        relatedLabelUnderline.anchor(top: nil, left: relatedLabel.leftAnchor, bottom: bottomDividerView.topAnchor, right: relatedLabel.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 2.5)
    }
    
    func relatedActive(){
        postDetailDelegate?.didChangeToRelatedView()
        
        relatedLabelUnderline.isHidden = false
        likesLabelUnderline.isHidden = true
        commentsLabelUnderline.isHidden = true
        aboutLabelUnderline.isHidden = true
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        toggleAboutUnderline()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
