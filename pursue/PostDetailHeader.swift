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
    func reportPost()
}
class PostDetailHeader : UICollectionViewCell {
    
    var postDetailDelegate : PostDetailHeaderDelegate?
    var postDetailController : PostDetailController?
    
    lazy var chatIcon : UIButton = {
        let button = UIButton()
        button.setBackgroundImage(#imageLiteral(resourceName: "send2").withRenderingMode(.alwaysOriginal), for: .normal)
        return button
    }()
    
    let postImage : UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.image = #imageLiteral(resourceName: "samuel-l")
        return iv
    }()
    
    lazy var optionButton : UIButton = {
        let button = UIButton()
        button.layer.masksToBounds = true
        button.setImage(#imageLiteral(resourceName: "option").withRenderingMode(.alwaysOriginal), for: .normal)
        button.addTarget(self, action: #selector(reportPost), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.contentMode = .scaleAspectFill
        return button
    }()
    
    lazy var optionBackground : UIView = {
       let iv = UIView()
        iv.backgroundColor = .clear
        iv.layer.cornerRadius = 15
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(reportPost))
        tap.numberOfTapsRequired = 1
        iv.addGestureRecognizer(tap)
        return iv
    }()
    
    lazy var aboutButton : UIButton = {
        let label = UIButton()
        label.setTitle("About", for: .normal)
        label.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.addTarget(self, action: #selector(toggleAboutUnderline), for: .touchUpInside)
        return label
    }()
    
    lazy var likesLabel : UIButton = {
        let label = UIButton()
        label.setTitle("Likes", for: .normal)
        label.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        label.addTarget(self, action: #selector(toggleLikesUnderline), for: .touchUpInside)
        return label
    }()
    
    lazy var commentsLabel : UIButton = {
        let label = UIButton()
        label.setTitle("Comments", for: .normal)
        label.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        label.addTarget(self, action: #selector(toggleCommentsUnderline), for: .touchUpInside)
        return label
    }()
    
    lazy var relatedLabel : UIButton = {
        let label = UIButton()
        label.setTitle("Related", for: .normal)
        label.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        label.addTarget(self, action: #selector(toggleRelatedUnderline), for: .touchUpInside)
        return label
    }()
    
    let aboutLabelUnderline : UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.masksToBounds = true
        return view
    }()
    
    let commentsLabelUnderline : UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.masksToBounds = true
        return view
    }()
    
    let relatedLabelUnderline : UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.masksToBounds = true
        return view
    }()
    
    let likesLabelUnderline : UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.masksToBounds = true
        return view
    }()
    
    let bottomDividerView = UIView()
    
    var stackView = UIStackView()
    
    @objc func reportPost(){
        postDetailDelegate?.reportPost()
    }
    
    func pageOptions(){
        bottomDividerView.backgroundColor = UIColor.rgb(red: 211, green: 211, blue: 211)
        let scrollView = UIScrollView()
        
        stackView = UIStackView(arrangedSubviews: [aboutButton, likesLabel, commentsLabel, relatedLabel])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        
        addSubview(scrollView)
        scrollView.addSubview(stackView)
        addSubview(bottomDividerView)
        
        scrollView.anchor(top: postImage.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 6, paddingLeft: 10, paddingBottom: 0, paddingRight: 0, width: 0, height: 50)
        stackView.anchor(top: postImage.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 6, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 50)
        bottomDividerView.anchor(top: stackView.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 1)
    }
    
    func setupViews() {
        
        addSubview(postImage)
        addSubview(optionButton)
        addSubview(optionBackground)

        postImage.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 44, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 250)
        optionButton.anchor(top: postImage.bottomAnchor, left: nil, bottom: nil, right: rightAnchor, paddingTop: 20, paddingLeft: 0, paddingBottom: 0, paddingRight: 22, width: 4.5, height: 20)
        optionBackground.anchor(top: optionButton.topAnchor, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 30, height: 30)
        optionBackground.centerXAnchor.constraint(equalTo: optionButton.centerXAnchor).isActive = true
        pageOptions()
    }
    
    @objc func toggleAboutUnderline(){
        likesLabel.setTitleColor(.gray, for: .normal)
        aboutButton.setTitleColor(.black, for: .normal)
        commentsLabel.setTitleColor(.gray, for: .normal)
        relatedLabel.setTitleColor(.gray, for: .normal)
        
        aboutActive()
        
        addSubview(aboutLabelUnderline)
        aboutLabelUnderline.anchor(top: nil, left: aboutButton.leftAnchor, bottom: bottomDividerView.topAnchor, right: aboutButton.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 6, height: 2.5)
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
