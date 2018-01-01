//
//  PursuitsDetailHeader.swift
//  pursue
//
//  Created by Jaylen Sanders on 10/17/17.
//  Copyright © 2017 Glory. All rights reserved.
//

import UIKit


protocol MessageDelegate {
    func handleMessage(for cell : PursuitsDetailHeader)
    func goBack()
}

class PursuitsDetailHeader : UICollectionViewCell {
    var isAboutView = true
    var isSavedView = false
    var isToolsView = false
    var isTeamView = false
    var isNextView = false
    var isStepsView = false
    var isChallenge = false
    
    var pursuitsDetailController : PursuitsDetailController?
    var messageDelegate : MessageDelegate?
    
    let headerId = "headerId"
    var stackView = UIStackView()
    let bottomDividerView = UIView()
    
    let aboutLabelUnderline : UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.masksToBounds = true
        return view
    }()
    
    let stepsLabelUnderline : UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.masksToBounds = true
        return view
    }()
    
    let discusionLabelUnderline : UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.masksToBounds = true
        return view
    }()
    
    let savedLabelUnderline : UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.masksToBounds = true
        return view
    }()
    
    let principleLabelUnderline : UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.masksToBounds = true
        return view
    }()
    
    lazy var backButton : UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "back-arrow").withRenderingMode(.alwaysOriginal), for: .normal)
        button.addTarget(self, action: #selector(dismissView), for: .touchUpInside)
        return button
    }()
    
    let postImage : UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.image = #imageLiteral(resourceName: "tumblr_nbje6dualg1r46py4o1_1280")
        return iv
    }()
    
    let postLabel : UILabel = {
        let label = UILabel()
        label.text = "Wonder Woman"
        label.font = UIFont.systemFont(ofSize: 24, weight: UIFont.Weight(rawValue: 25))
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var aboutButton : UIButton = {
        let label = UIButton()
        label.setTitle("About", for: .normal)
        label.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        label.addTarget(self, action: #selector(toggleAboutUnderline), for: .touchUpInside)
        return label
    }()
    
    lazy var stepsLabel : UIButton = {
        let label = UIButton()
        label.setTitle("Steps", for: .normal)
        label.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        label.addTarget(self, action: #selector(toggleStepsUnderline), for: .touchUpInside)
        return label
    }()
    
    lazy var discussionLabel : UIButton = {
        let label = UIButton()
        label.setTitle("Discussions", for: .normal)
        label.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        label.addTarget(self, action: #selector(toggleDiscussionUnderline), for: .touchUpInside)
        return label
    }()
    
    lazy var principleLabel : UIButton = {
        let label = UIButton()
        label.setTitle("Principles", for: .normal)
        label.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        label.addTarget(self, action: #selector(togglePrinciplesLabel), for: .touchUpInside)
        return label
    }()
    
    
    lazy var savedLabel : UIButton = {
        let label = UIButton()
        label.setTitle("Saved", for: .normal)
        label.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        label.addTarget(self, action: #selector(toggleSavedUnderline), for: .touchUpInside)
        return label
    }()
    
    
    @objc func dismissView(){
        messageDelegate?.goBack()
    }
    
    @objc func handleChat() {
        messageDelegate?.handleMessage(for: self)
    }
    
    @objc func toggleAboutUnderline(){
        aboutLabelUnderline.backgroundColor = .black
        
        stepsLabel.setTitleColor(.gray, for: .normal)
        aboutButton.setTitleColor(.black, for: .normal)
        savedLabel.setTitleColor(.gray, for: .normal)
        principleLabel.setTitleColor(.gray, for: .normal)
        discussionLabel.setTitleColor(.gray, for: .normal)
        
        aboutActive()
        
        addSubview(aboutLabelUnderline)
        aboutLabelUnderline.anchor(top: nil, left: aboutButton.leftAnchor, bottom: bottomDividerView.topAnchor, right: aboutButton.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 2.5)
       
    }
    
    func aboutActive(){
        pursuitsDetailController?.changeAbout()
        
        aboutLabelUnderline.isHidden = false
        stepsLabelUnderline.isHidden = true
        principleLabelUnderline.isHidden = true
        savedLabelUnderline.isHidden = true
        discusionLabelUnderline.isHidden = true
        
    }
    
    @objc func toggleStepsUnderline(){
        stepsLabelUnderline.backgroundColor = .black
        
        stepsLabel.setTitleColor(.black, for: .normal)
        aboutButton.setTitleColor(.gray, for: .normal)
        savedLabel.setTitleColor(.gray, for: .normal)
        principleLabel.setTitleColor(.gray, for: .normal)
        discussionLabel.setTitleColor(.gray, for: .normal)
        
        stepsActive()
        
        addSubview(stepsLabelUnderline)
        stepsLabelUnderline.anchor(top: nil, left: stepsLabel.leftAnchor, bottom: bottomDividerView.topAnchor, right: stepsLabel.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 2.5)
    }
    
    func stepsActive(){
        pursuitsDetailController?.changeSteps()
        
        stepsLabelUnderline.isHidden = false
        aboutLabelUnderline.isHidden = true
        savedLabelUnderline.isHidden = true
        principleLabelUnderline.isHidden = true
        discusionLabelUnderline.isHidden = true
    }
    
    @objc func togglePrinciplesLabel(){
        principleLabelUnderline.backgroundColor = .black
        
        stepsLabel.setTitleColor(.gray, for: .normal)
        aboutButton.setTitleColor(.gray, for: .normal)
        savedLabel.setTitleColor(.gray, for: .normal)
        principleLabel.setTitleColor(.black, for: .normal)
        discussionLabel.setTitleColor(.gray, for: .normal)
        
        principlesActive()
        
        addSubview(principleLabelUnderline)
        principleLabelUnderline.anchor(top: nil, left: principleLabel.leftAnchor, bottom: bottomDividerView.topAnchor, right: principleLabel.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 2.5)
    }
    
    
    func principlesActive(){
        pursuitsDetailController?.changePrinciple()
        
        aboutLabelUnderline.isHidden = true
        stepsLabelUnderline.isHidden = true
        savedLabelUnderline.isHidden = true
        principleLabelUnderline.isHidden = false
        discusionLabelUnderline.isHidden = true
    }
    
    @objc func toggleSavedUnderline(){
        savedLabelUnderline.backgroundColor = .black
        
        stepsLabel.setTitleColor(.gray, for: .normal)
        aboutButton.setTitleColor(.gray, for: .normal)
        savedLabel.setTitleColor(.black, for: .normal)
        principleLabel.setTitleColor(.gray, for: .normal)
        discussionLabel.setTitleColor(.gray, for: .normal)
        
        savedActive()
        
        addSubview(savedLabelUnderline)
        savedLabelUnderline.anchor(top: nil, left: savedLabel.leftAnchor, bottom: bottomDividerView.topAnchor, right: savedLabel.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 2.5)
    }
    
    func savedActive(){
        pursuitsDetailController?.changeSaved()
        
        savedLabelUnderline.isHidden = false
        aboutLabelUnderline.isHidden = true
        principleLabelUnderline.isHidden = true
        stepsLabelUnderline.isHidden = true
        discusionLabelUnderline.isHidden = true
    }
    
    @objc func toggleDiscussionUnderline(){
        discusionLabelUnderline.backgroundColor = .black
        
        stepsLabel.setTitleColor(.gray, for: .normal)
        aboutButton.setTitleColor(.gray, for: .normal)
        savedLabel.setTitleColor(.gray, for: .normal)
        principleLabel.setTitleColor(.gray, for: .normal)
        discussionLabel.setTitleColor(.black, for: .normal)
        
        discussionActive()
        
        addSubview(discusionLabelUnderline)
        discusionLabelUnderline.anchor(top: nil, left: discussionLabel.leftAnchor, bottom: bottomDividerView.topAnchor, right: discussionLabel.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 2.5)
    }
    
    func discussionActive(){
        pursuitsDetailController?.changeDiscussion()
        
        savedLabelUnderline.isHidden = true
        aboutLabelUnderline.isHidden = true
        principleLabelUnderline.isHidden = true
        stepsLabelUnderline.isHidden = true
        discusionLabelUnderline.isHidden = false
    }
    
    func pageOptions(){
        bottomDividerView.backgroundColor = UIColor.rgb(red: 211, green: 211, blue: 211)
        
        let scrollView = UIScrollView()
        scrollView.isScrollEnabled = true
        
        stackView = UIStackView(arrangedSubviews: [aboutButton, stepsLabel, discussionLabel, principleLabel, savedLabel])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 20
        
        addSubview(scrollView)
        scrollView.addSubview(stackView)
        addSubview(bottomDividerView)
        
        scrollView.anchor(top: postImage.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 6, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 50)
        stackView.anchor(top: scrollView.topAnchor, left: scrollView.leftAnchor, bottom: scrollView.bottomAnchor, right: scrollView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 50)
        bottomDividerView.anchor(top: stackView.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 1)
    }
    
    func setupViews() {
        backgroundColor = .clear
        
        addSubview(postImage)
        
        postImage.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 44, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 325)
        pageOptions()
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
