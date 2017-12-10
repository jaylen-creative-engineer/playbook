//
//  PursuitsDetailHeader.swift
//  pursue
//
//  Created by Jaylen Sanders on 10/17/17.
//  Copyright © 2017 Glory. All rights reserved.
//

import UIKit

protocol DetailCellChange {
    func changeAbout()
    func changeSaved()
    func changeTool()
    func changeTeam()
    func changeNext()
    func changeSteps()
    func changeDiscussion()
    func changeChallenge()
}

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
    var delegate : DetailCellChange?

    let headerId = "headerId"
    var stackView = UIStackView()
    let bottomDividerView = UIView()
    let aboutLabelUnderline = UIView()
    let stepsLabelUnderline = UIView()
    let teamLabelUnderline = UIView()
    let savedLabelUnderline = UIView()
    let discusionLabelUnderline = UIView()
    
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
        label.setTitle("ABOUT", for: .normal)
        label.titleLabel?.font = UIFont.boldSystemFont(ofSize: 12)
        label.addTarget(self, action: #selector(toggleAboutUnderline), for: .touchUpInside)
        return label
    }()
    
    lazy var stepsLabel : UIButton = {
        let label = UIButton()
        label.setTitle("STEPS", for: .normal)
        label.titleLabel?.font = UIFont.boldSystemFont(ofSize: 12)
        label.addTarget(self, action: #selector(toggleStepsUnderline), for: .touchUpInside)
        return label
    }()
    
    lazy var discussionLabel : UIButton = {
        let label = UIButton()
        label.setTitle("DISCUSSIONS", for: .normal)
        label.titleLabel?.font = UIFont.boldSystemFont(ofSize: 12)
        label.addTarget(self, action: #selector(toggleDiscussionUnderline), for: .touchUpInside)
        return label
    }()
    
    lazy var teamLabel : UIButton = {
        let label = UIButton()
        label.setTitle("ADDED", for: .normal)
        label.titleLabel?.font = UIFont.boldSystemFont(ofSize: 12)
        label.addTarget(self, action: #selector(toggleTeamLabel), for: .touchUpInside)
        return label
    }()
    
    
    lazy var savedLabel : UIButton = {
        let label = UIButton()
        label.setTitle("SAVED", for: .normal)
        label.titleLabel?.font = UIFont.boldSystemFont(ofSize: 12)
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
        teamLabel.setTitleColor(.gray, for: .normal)
        discussionLabel.setTitleColor(.gray, for: .normal)
        
        aboutActive()
        
        addSubview(aboutLabelUnderline)
        aboutLabelUnderline.anchor(top: nil, left: aboutButton.leftAnchor, bottom: bottomDividerView.topAnchor, right: aboutButton.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 2.5)
    }
    
    func aboutActive(){
        delegate?.changeAbout()
        
        aboutLabelUnderline.isHidden = false
        stepsLabelUnderline.isHidden = true
        teamLabelUnderline.isHidden = true
        savedLabelUnderline.isHidden = true
        discusionLabelUnderline.isHidden = true
        
    }
    
    @objc func toggleStepsUnderline(){
        stepsLabelUnderline.backgroundColor = .black
        
        stepsLabel.setTitleColor(.black, for: .normal)
        aboutButton.setTitleColor(.gray, for: .normal)
        savedLabel.setTitleColor(.gray, for: .normal)
        teamLabel.setTitleColor(.gray, for: .normal)
        discussionLabel.setTitleColor(.gray, for: .normal)
        
        stepsActive()
        
        addSubview(stepsLabelUnderline)
        stepsLabelUnderline.anchor(top: nil, left: stepsLabel.leftAnchor, bottom: bottomDividerView.topAnchor, right: stepsLabel.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 2.5)
    }
    func stepsActive(){
        delegate?.changeSteps()
        
        stepsLabelUnderline.isHidden = false
        aboutLabelUnderline.isHidden = true
        savedLabelUnderline.isHidden = true
        teamLabelUnderline.isHidden = true
        discusionLabelUnderline.isHidden = true
    }
    
    @objc func toggleTeamLabel(){
        teamLabelUnderline.backgroundColor = .black
        
        stepsLabel.setTitleColor(.gray, for: .normal)
        aboutButton.setTitleColor(.gray, for: .normal)
        savedLabel.setTitleColor(.gray, for: .normal)
        teamLabel.setTitleColor(.black, for: .normal)
        discussionLabel.setTitleColor(.gray, for: .normal)
        
        teamActive()
        
        addSubview(teamLabelUnderline)
        teamLabelUnderline.anchor(top: nil, left: teamLabel.leftAnchor, bottom: bottomDividerView.topAnchor, right: teamLabel.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 2.5)
        
    }
    
    
    func teamActive(){
        delegate?.changeTeam()
        
        aboutLabelUnderline.isHidden = true
        stepsLabelUnderline.isHidden = true
        savedLabelUnderline.isHidden = true
        teamLabelUnderline.isHidden = false
        discusionLabelUnderline.isHidden = true
    }
    
    @objc func toggleSavedUnderline(){
        savedLabelUnderline.backgroundColor = .black
        
        stepsLabel.setTitleColor(.gray, for: .normal)
        aboutButton.setTitleColor(.gray, for: .normal)
        savedLabel.setTitleColor(.black, for: .normal)
        teamLabel.setTitleColor(.gray, for: .normal)
        discussionLabel.setTitleColor(.gray, for: .normal)
        
        savedActive()
        
        addSubview(savedLabelUnderline)
        savedLabelUnderline.anchor(top: nil, left: savedLabel.leftAnchor, bottom: bottomDividerView.topAnchor, right: savedLabel.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 2.5)
    }
    
    func savedActive(){
        delegate?.changeSaved()
        
        savedLabelUnderline.isHidden = false
        aboutLabelUnderline.isHidden = true
        teamLabelUnderline.isHidden = true
        stepsLabelUnderline.isHidden = true
        discusionLabelUnderline.isHidden = true
    }
    
    @objc func toggleDiscussionUnderline(){
        discusionLabelUnderline.backgroundColor = .black
        
        stepsLabel.setTitleColor(.gray, for: .normal)
        aboutButton.setTitleColor(.gray, for: .normal)
        savedLabel.setTitleColor(.gray, for: .normal)
        teamLabel.setTitleColor(.gray, for: .normal)
        discussionLabel.setTitleColor(.black, for: .normal)
        
        discussionActive()
        
        addSubview(discusionLabelUnderline)
        discusionLabelUnderline.anchor(top: nil, left: discussionLabel.leftAnchor, bottom: bottomDividerView.topAnchor, right: discussionLabel.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 2.5)
    }
    
    func discussionActive(){
        delegate?.changeDiscussion()
        
        savedLabelUnderline.isHidden = true
        aboutLabelUnderline.isHidden = true
        teamLabelUnderline.isHidden = true
        stepsLabelUnderline.isHidden = true
        discusionLabelUnderline.isHidden = false
    }
    
    
    func setupTopNavBar(){
        addSubview(backButton)
        
        backButton.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 16, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: 20, height: 20)
    }
    
    func pageOptions(){
        bottomDividerView.backgroundColor = UIColor.init(white: 0, alpha: 0.2)
                
        stackView = UIStackView(arrangedSubviews: [aboutButton, stepsLabel, discussionLabel, teamLabel, savedLabel])
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        
        addSubview(stackView)
        addSubview(bottomDividerView)
        
        stackView.anchor(top: postLabel.bottomAnchor, left: postImage.leftAnchor, bottom: nil, right: postImage.rightAnchor, paddingTop: 20, paddingLeft: 10, paddingBottom: 0, paddingRight: 10, width: 0, height: 50)
        bottomDividerView.anchor(top: stackView.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0.5)
    }
    
    func setupViews() {
        backgroundColor = .clear
        setupTopNavBar()
        
        addSubview(postImage)
        addSubview(postLabel)
        
        postImage.anchor(top: backButton.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 10, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: (frame.height / 2) + 50)
        postLabel.anchor(top: postImage.bottomAnchor, left: postImage.leftAnchor, bottom: nil, right: nil, paddingTop: 12, paddingLeft: 12, paddingBottom: 0, paddingRight: 12, width: 300, height: 52)
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
