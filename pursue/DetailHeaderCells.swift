//
//  DetailHeaderCells.swift
//  pursue
//
//  Created by Jaylen Sanders on 10/18/17.
//  Copyright © 2017 Glory. All rights reserved.
//

import UIKit

protocol PursuitDetailDelegate {
    func aboutLabelSelected()
    func savedLabelSelected()
    func toolsLabelSelected()
    func teamLabelSelected()
    func nextLabelSelected()
    func stepLabelSelected()
    func challengeLabelSelected()
}

class DetailHeaderCells : UICollectionViewCell {
    
    var delegate : PursuitDetailDelegate?
    var pursuitsDetailController : PursuitsDetailController?

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
    
    lazy var toolsLabel : UIButton = {
        let label = UIButton()
        label.setTitle("TOOLS", for: .normal)
        label.titleLabel?.font = UIFont.boldSystemFont(ofSize: 12)
        label.addTarget(self, action: #selector(toggleToolsUnderline), for: .touchUpInside)
        return label
    }()
    
    lazy var teamLabel : UIButton = {
        let label = UIButton()
        label.setTitle("TEAM", for: .normal)
        label.titleLabel?.font = UIFont.boldSystemFont(ofSize: 12)
        label.addTarget(self, action: #selector(toggleTeamLabel), for: .touchUpInside)
        return label
    }()
    
    lazy var challengeLabel : UIButton = {
        let label = UIButton()
        label.setTitle("CHALLENGE", for: .normal)
        label.titleLabel?.font = UIFont.boldSystemFont(ofSize: 12)
        label.addTarget(self, action: #selector(toggleChallengeLabel), for: .touchUpInside)
        return label
    }()
    
    lazy var nextLabel : UIButton = {
        let label = UIButton()
        label.setTitle("NEXT", for: .normal)
        label.titleLabel?.font = UIFont.boldSystemFont(ofSize: 12)
        label.addTarget(self, action: #selector(toggleNextUnderline), for: .touchUpInside)
        return label
    }()
    
    lazy var savedLabel : UIButton = {
        let label = UIButton()
        label.setTitle("SAVED", for: .normal)
        label.titleLabel?.font = UIFont.boldSystemFont(ofSize: 12)
        label.addTarget(self, action: #selector(toggleSavedUnderline), for: .touchUpInside)
        return label
    }()
    
    let leftWhiteSpace : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.widthAnchor.constraint(equalToConstant: 100).isActive = true
        return view
    }()
    
    let rightWhiteSpace : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.widthAnchor.constraint(equalToConstant: 100).isActive = true
        return view
    }()
    
    let teamLabelUnderline = UIView()
    let challengeLabelUnderline = UIView()
    let savedLabelUnderline = UIView()
    let aboutLabelUnderline = UIView()
    let nextLabelUnderline = UIView()
    let toolsLabelUnderline = UIView()
    let stepsLabelUnderline = UIView()
    let stackBackground = UIView()
    var stackView = UIStackView()
    var leading : NSLayoutConstraint?
    var trailing : NSLayoutConstraint?
    
    func setupView(){
        stackView = UIStackView(arrangedSubviews: [aboutButton, stepsLabel, nextLabel, challengeLabel, teamLabel, toolsLabel, savedLabel])
        stackView.axis = .horizontal
        stackView.spacing = 15
        stackView.translatesAutoresizingMaskIntoConstraints = false
    
        addSubview(stackView)
        
        stackView.anchor(top: topAnchor, left: nil, bottom: bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)

    }
    
    @objc func toggleAboutUnderline(){
        aboutLabelUnderline.backgroundColor = .black
        
        stepsLabel.setTitleColor(.gray, for: .normal)
        aboutButton.setTitleColor(.black, for: .normal)
        savedLabel.setTitleColor(.gray, for: .normal)
        toolsLabel.setTitleColor(.gray, for: .normal)
        teamLabel.setTitleColor(.gray, for: .normal)
        nextLabel.setTitleColor(.gray, for: .normal)
        challengeLabel.setTitleColor(.gray, for: .normal)
        
        aboutActive()
        
        addSubview(aboutLabelUnderline)
        aboutLabelUnderline.anchor(top: nil, left: aboutButton.leftAnchor, bottom: bottomAnchor, right: aboutButton.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 2.5)
    }
    
    func aboutActive(){
        delegate?.aboutLabelSelected()
        
        aboutLabelUnderline.isHidden = false
        stepsLabelUnderline.isHidden = true
        teamLabelUnderline.isHidden = true
        toolsLabelUnderline.isHidden = true
        savedLabelUnderline.isHidden = true
        nextLabelUnderline.isHidden = true
        challengeLabelUnderline.isHidden = true
        
        let viewCenter = frame.midX / 3
        let margins = layoutMarginsGuide
        let buttonCenter = aboutButton.frame.midX
        
        if aboutLabelUnderline.isHidden == false {
            stackView.updateConstraints()
            stackView.leadingAnchor.constraint(equalTo: margins.leadingAnchor, constant: buttonCenter + viewCenter + 30).isActive = true
            stackView.trailingAnchor.constraint(equalTo: margins.trailingAnchor, constant: buttonCenter + viewCenter - 45).isActive = true
        } else {
            stackView.trailingAnchor.constraint(equalTo: margins.trailingAnchor, constant: buttonCenter + viewCenter + 50).isActive = true
            stackView.leadingAnchor.constraint(equalTo: margins.leadingAnchor, constant: buttonCenter + viewCenter).isActive = true
        }
        
        stackView.updateConstraints()
        
    }
    
    @objc func toggleTeamLabel(){
        teamLabelUnderline.backgroundColor = .black
        
        stepsLabel.setTitleColor(.gray, for: .normal)
        aboutButton.setTitleColor(.gray, for: .normal)
        savedLabel.setTitleColor(.gray, for: .normal)
        toolsLabel.setTitleColor(.gray, for: .normal)
        teamLabel.setTitleColor(.black, for: .normal)
        nextLabel.setTitleColor(.gray, for: .normal)
        challengeLabel.setTitleColor(.gray, for: .normal)
        
        teamActive()
        
        addSubview(teamLabelUnderline)
        teamLabelUnderline.anchor(top: nil, left: teamLabel.leftAnchor, bottom: bottomAnchor, right: teamLabel.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 2.5)
        
    }
    
    @objc func toggleChallengeLabel(){
        challengeLabelUnderline.backgroundColor = .black
        
        challengeLabel.setTitleColor(.black, for: .normal)
        stepsLabel.setTitleColor(.gray, for: .normal)
        aboutButton.setTitleColor(.gray, for: .normal)
        savedLabel.setTitleColor(.gray, for: .normal)
        toolsLabel.setTitleColor(.gray, for: .normal)
        teamLabel.setTitleColor(.gray, for: .normal)
        nextLabel.setTitleColor(.gray, for: .normal)
        
        challengeActive()
        
        addSubview(challengeLabelUnderline)
        challengeLabelUnderline.anchor(top: nil, left: challengeLabel.leftAnchor, bottom: bottomAnchor, right: challengeLabel.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 2.5)
    }
    
    func challengeActive(){
        delegate?.challengeLabelSelected()
        
        aboutLabelUnderline.isHidden = true
        stepsLabelUnderline.isHidden = true
        toolsLabelUnderline.isHidden = true
        savedLabelUnderline.isHidden = true
        teamLabelUnderline.isHidden = true
        nextLabelUnderline.isHidden = true
        challengeLabelUnderline.isHidden = false
        
        let viewCenter = frame.midX / 12
        let margins = layoutMarginsGuide
        let buttonCenter = aboutButton.frame.midX
        if challengeLabelUnderline.isHidden == false {
            stackView.leadingAnchor.constraint(equalTo: margins.leadingAnchor, constant: buttonCenter + viewCenter - 90).isActive = true
            stackView.trailingAnchor.constraint(equalTo: margins.trailingAnchor, constant: buttonCenter + viewCenter - 100).isActive = true
        } else {
            stackView.trailingAnchor.constraint(equalTo: margins.trailingAnchor, constant: buttonCenter + viewCenter - 100).isActive = true
            stackView.leadingAnchor.constraint(equalTo: margins.leadingAnchor, constant: buttonCenter + viewCenter - 130).isActive = true
        }
        
    }
    
    func teamActive(){
        delegate?.teamLabelSelected()
        
        aboutLabelUnderline.isHidden = true
        stepsLabelUnderline.isHidden = true
        toolsLabelUnderline.isHidden = true
        savedLabelUnderline.isHidden = true
        teamLabelUnderline.isHidden = false
        nextLabelUnderline.isHidden = true
        challengeLabelUnderline.isHidden = true
        
        let viewCenter = frame.midX / 12
        let margins = layoutMarginsGuide
        let buttonCenter = aboutButton.frame.midX
        if teamLabelUnderline.isHidden == false {
            stackView.updateConstraints()
            stackView.leadingAnchor.constraint(equalTo: margins.leadingAnchor, constant: buttonCenter + viewCenter - 100).isActive = true
            stackView.trailingAnchor.constraint(equalTo: margins.trailingAnchor, constant: buttonCenter + viewCenter - 130).isActive = true
        }
        else {
            stackView.trailingAnchor.constraint(equalTo: margins.trailingAnchor, constant: buttonCenter + viewCenter - 100).isActive = true
            stackView.leadingAnchor.constraint(equalTo: margins.leadingAnchor, constant: buttonCenter + viewCenter - 130).isActive = true
        }
        
        stackView.updateConstraints()
    }
    
    @objc func toggleToolsUnderline(){
        toolsLabelUnderline.backgroundColor = .black
        
        stepsLabel.setTitleColor(.gray, for: .normal)
        aboutButton.setTitleColor(.gray, for: .normal)
        savedLabel.setTitleColor(.gray, for: .normal)
        toolsLabel.setTitleColor(.black, for: .normal)
        teamLabel.setTitleColor(.gray, for: .normal)
        nextLabel.setTitleColor(.gray, for: .normal)
        challengeLabel.setTitleColor(.gray, for: .normal)
        
        toolsActive()
        
        addSubview(toolsLabelUnderline)
        toolsLabelUnderline.anchor(top: nil, left: toolsLabel.leftAnchor, bottom: bottomAnchor, right: toolsLabel.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 2.5)
        
    }
    
    func toolsActive(){
        delegate?.toolsLabelSelected()
        
        aboutLabelUnderline.isHidden = true
        stepsLabelUnderline.isHidden = true
        teamLabelUnderline.isHidden = true
        savedLabelUnderline.isHidden = true
        toolsLabelUnderline.isHidden = false
        nextLabelUnderline.isHidden = true
        challengeLabelUnderline.isHidden = true
        
        let viewCenter = frame.midX / 16
        let margins = layoutMarginsGuide
        let buttonCenter = aboutButton.frame.midX
        
        if toolsLabelUnderline.isHidden == false {
            stackView.updateConstraints()
            stackView.leadingAnchor.constraint(equalTo: margins.leadingAnchor, constant: buttonCenter + viewCenter - 155).isActive = true
            stackView.trailingAnchor.constraint(equalTo: margins.trailingAnchor, constant: buttonCenter + viewCenter - 185).isActive = true
        }
        else {
            stackView.trailingAnchor.constraint(equalTo: margins.trailingAnchor, constant: buttonCenter + viewCenter - 155).isActive = true
            stackView.leadingAnchor.constraint(equalTo: margins.leadingAnchor, constant: buttonCenter + viewCenter - 185).isActive = true
        }
        
        stackView.updateConstraints()
    }
    
    @objc func toggleStepsUnderline(){
        stepsLabelUnderline.backgroundColor = .black
        
        stepsLabel.setTitleColor(.black, for: .normal)
        aboutButton.setTitleColor(.gray, for: .normal)
        savedLabel.setTitleColor(.gray, for: .normal)
        toolsLabel.setTitleColor(.gray, for: .normal)
        teamLabel.setTitleColor(.gray, for: .normal)
        nextLabel.setTitleColor(.gray, for: .normal)
        challengeLabel.setTitleColor(.gray, for: .normal)
        
        stepsActive()
        
        addSubview(stepsLabelUnderline)
        stepsLabelUnderline.anchor(top: nil, left: stepsLabel.leftAnchor, bottom: bottomAnchor, right: stepsLabel.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 2.5)
    }
    
    
    func stepsActive(){
        delegate?.stepLabelSelected()
        
        stepsLabelUnderline.isHidden = false
        aboutLabelUnderline.isHidden = true
        savedLabelUnderline.isHidden = true
        toolsLabelUnderline.isHidden = true
        teamLabelUnderline.isHidden = true
        nextLabelUnderline.isHidden = true
        challengeLabelUnderline.isHidden = true
        
        let viewCenter = frame.midX / 3
        let margins = layoutMarginsGuide
        let buttonCenter = aboutButton.frame.midX
       
        if stepsLabelUnderline.isHidden == false {
            stackView.updateConstraints()
            stackView.leadingAnchor.constraint(equalTo: margins.leadingAnchor, constant: buttonCenter + viewCenter - 25).isActive = true
            stackView.trailingAnchor.constraint(equalTo: margins.trailingAnchor, constant: buttonCenter + viewCenter - 55).isActive = true
        }
        else {
            stackView.trailingAnchor.constraint(equalTo: margins.trailingAnchor, constant: buttonCenter + viewCenter - 25).isActive = true
            stackView.leadingAnchor.constraint(equalTo: margins.leadingAnchor, constant: buttonCenter + viewCenter - 55).isActive = true
        }
        
        stackView.updateConstraints()
    }
    
    @objc func toggleSavedUnderline(){
        savedLabelUnderline.backgroundColor = .black
        
        stepsLabel.setTitleColor(.gray, for: .normal)
        aboutButton.setTitleColor(.gray, for: .normal)
        savedLabel.setTitleColor(.black, for: .normal)
        toolsLabel.setTitleColor(.gray, for: .normal)
        teamLabel.setTitleColor(.gray, for: .normal)
        nextLabel.setTitleColor(.gray, for: .normal)
        challengeLabel.setTitleColor(.gray, for: .normal)
        
        savedActive()
        
        addSubview(savedLabelUnderline)
        savedLabelUnderline.anchor(top: nil, left: savedLabel.leftAnchor, bottom: bottomAnchor, right: savedLabel.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 2.5)
    }
    
    func savedActive(){
        delegate?.savedLabelSelected()
        
        savedLabelUnderline.isHidden = false
        aboutLabelUnderline.isHidden = true
        toolsLabelUnderline.isHidden = true
        teamLabelUnderline.isHidden = true
        stepsLabelUnderline.isHidden = true
        nextLabelUnderline.isHidden = true
        challengeLabelUnderline.isHidden = true

        let viewCenter = frame.midX / 16
        let margins = layoutMarginsGuide
        let buttonCenter = aboutButton.frame.midX
        
        if savedLabelUnderline.isHidden == false {
            stackView.updateConstraints()
            stackView.leadingAnchor.constraint(equalTo: margins.leadingAnchor, constant: buttonCenter + viewCenter - 230).isActive = true
            stackView.trailingAnchor.constraint(equalTo: margins.trailingAnchor, constant: buttonCenter + viewCenter - 260).isActive = true
        }
        else {
            stackView.trailingAnchor.constraint(equalTo: margins.trailingAnchor, constant: buttonCenter + viewCenter - 230).isActive = true
            stackView.leadingAnchor.constraint(equalTo: margins.leadingAnchor, constant: buttonCenter + viewCenter - 260).isActive = true
        }
        
        stackView.updateConstraints()
    }
    
    @objc func toggleNextUnderline() {
        nextLabelUnderline.backgroundColor = .black
        
        stepsLabel.setTitleColor(.gray, for: .normal)
        aboutButton.setTitleColor(.gray, for: .normal)
        savedLabel.setTitleColor(.gray, for: .normal)
        toolsLabel.setTitleColor(.gray, for: .normal)
        teamLabel.setTitleColor(.gray, for: .normal)
        nextLabel.setTitleColor(.black, for: .normal)
        challengeLabel.setTitleColor(.gray, for: .normal)
        
        nextActive()
        
        addSubview(nextLabelUnderline)
        nextLabelUnderline.anchor(top: nil, left: nextLabel.leftAnchor, bottom: bottomAnchor, right: nextLabel.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 2.5)
    }
    
    func nextActive(){
        delegate?.nextLabelSelected()
        
        nextLabelUnderline.isHidden = false
        stepsLabelUnderline.isHidden = true
        savedLabelUnderline.isHidden = true
        toolsLabelUnderline.isHidden = true
        teamLabelUnderline.isHidden = true
        aboutLabelUnderline.isHidden = true
        challengeLabelUnderline.isHidden = true
        
        let viewCenter = frame.midX / 8
        let margins = layoutMarginsGuide
        let buttonCenter = aboutButton.frame.midX
        
        if nextLabelUnderline.isHidden == false {
            stackView.updateConstraints()
            stackView.leadingAnchor.constraint(equalTo: margins.leadingAnchor, constant: buttonCenter + viewCenter - 50).isActive = true
            stackView.trailingAnchor.constraint(equalTo: margins.trailingAnchor, constant: buttonCenter + viewCenter - 80).isActive = true
        }
        else {
            stackView.trailingAnchor.constraint(equalTo: margins.trailingAnchor, constant: buttonCenter + viewCenter - 50).isActive = true
            stackView.leadingAnchor.constraint(equalTo: margins.leadingAnchor, constant: buttonCenter + viewCenter - 80).isActive = true
        }
        
        stackView.updateConstraints()
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        toggleAboutUnderline()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
