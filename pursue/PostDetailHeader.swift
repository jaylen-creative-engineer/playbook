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
    
    let postLabel : UILabel = {
        let label = UILabel()
        label.text = "Wonder Woman"
        label.font = UIFont.systemFont(ofSize: 24, weight: UIFont.Weight(rawValue: 25))
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        return label
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
        view.layer.cornerRadius = 3
        view.layer.masksToBounds = true
        return view
    }()
    
    let commentsLabelUnderline : UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 3
        view.layer.masksToBounds = true
        return view
    }()
    
    let relatedLabelUnderline : UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 3
        view.layer.masksToBounds = true
        return view
    }()
    
    let likesLabelUnderline : UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 3
        view.layer.masksToBounds = true
        return view
    }()
    
    let bottomDividerView = UIView()
    
    var stackView = UIStackView()
    
    @objc func reportPost(){
        postDetailDelegate?.reportPost()
    }
    
    func pageOptions(){
        bottomDividerView.backgroundColor = .clear
        
        stackView = UIStackView(arrangedSubviews: [aboutButton, likesLabel, commentsLabel, relatedLabel])
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        
        addSubview(stackView)
        addSubview(bottomDividerView)
        
        stackView.anchor(top: postLabel.bottomAnchor, left: postLabel.leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 20, paddingLeft: 0, paddingBottom: 0, paddingRight: 20, width: 0, height: 50)
        bottomDividerView.anchor(top: stackView.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0.5)
    }
    
    func setupViews() {
        
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
    
    @objc func toggleAboutUnderline(){
        likesLabel.setTitleColor(.gray, for: .normal)
        aboutButton.setTitleColor(.black, for: .normal)
        commentsLabel.setTitleColor(.gray, for: .normal)
        relatedLabel.setTitleColor(.gray, for: .normal)
        
        aboutActive()
        
        addSubview(aboutLabelUnderline)
        aboutLabelUnderline.anchor(top: nil, left: nil, bottom: bottomDividerView.topAnchor, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 6, height: 6)
        aboutLabelUnderline.centerXAnchor.constraint(equalTo: aboutButton.centerXAnchor).isActive = true
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
        likesLabelUnderline.anchor(top: nil, left: nil, bottom: bottomDividerView.topAnchor, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 6, height: 6)
        likesLabelUnderline.centerXAnchor.constraint(equalTo: likesLabel.centerXAnchor).isActive = true
        
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
        commentsLabelUnderline.anchor(top: nil, left: nil, bottom: bottomDividerView.topAnchor, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 6, height: 6)
        commentsLabelUnderline.centerXAnchor.constraint(equalTo: commentsLabel.centerXAnchor).isActive = true
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
        relatedLabelUnderline.anchor(top: nil, left: nil, bottom: bottomDividerView.topAnchor, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 6, height: 6)
        relatedLabelUnderline.centerXAnchor.constraint(equalTo: relatedLabel.centerXAnchor).isActive = true
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
