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
    
    lazy var likeIcon : UIButton = {
        let button = UIButton()
        button.contentMode = .scaleAspectFill
        button.setImage(#imageLiteral(resourceName: "like_selected").withRenderingMode(.alwaysTemplate), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(toggleLike), for: .touchUpInside)
        return button
    }()
    
    let likeCounter : UILabel = {
        let label = UILabel()
        label.text = "132"
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var saveIcon : UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "add").withRenderingMode(.alwaysTemplate), for: .normal)
        button.contentMode = .scaleAspectFill
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(toggleSave), for: .touchUpInside)
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
    
    lazy var optionButton : UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "option").withRenderingMode(.alwaysOriginal), for: .normal)
        button.contentMode = .scaleAspectFill
        return button
    }()
    
    let scrollView = UIScrollView()

    @objc func dismissView(){
        messageDelegate?.goBack()
    }
    
    @objc func handleChat() {
        messageDelegate?.handleMessage(for: self)
    }
    
    
    func setupTopNavBar(){
        addSubview(postImage)
        
        let topShade = UIView()
        topShade.backgroundColor = UIColor(white: 1, alpha: 0.5)
        
        addSubview(topShade)
        
        postImage.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 365)
        topShade.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 95)
        setupEngagements()
    }
    
    var isSaved = false
    var isLiked = false
    
    @objc func toggleSave(){
        isSaved = !isSaved
        
        if isSaved == true {
            saveIcon.tintColor = .black
        } else {
            saveIcon.tintColor = .gray
        }
    }
    
    @objc func toggleLike(){
        isLiked = !isLiked
        if isLiked == true {
            likeIcon.tintColor = .black
            likeCounter.textColor = .black
        } else {
            likeIcon.tintColor = .gray
            likeCounter.textColor = .gray
        }
    }
    
    func setupEngagements(){
        addSubview(likeIcon)
        addSubview(likeCounter)
        addSubview(saveIcon)
        
        likeIcon.anchor(top: postImage.bottomAnchor, left: postImage.leftAnchor, bottom: nil, right: nil, paddingTop: 24, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: 25, height: 20)
        likeCounter.anchor(top: likeIcon.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 4, paddingLeft: 8, paddingBottom: 0, paddingRight: 0, width: likeCounter.intrinsicContentSize.width, height: likeCounter.intrinsicContentSize.height)
        likeCounter.centerXAnchor.constraint(equalTo: likeIcon.centerXAnchor).isActive = true
        saveIcon.anchor(top: postImage.bottomAnchor, left: likeIcon.rightAnchor, bottom: nil, right: nil, paddingTop: 22, paddingLeft: 32, paddingBottom: 0, paddingRight: 0, width: 22, height: 21)
        toggleLike()
        toggleSave()
        
        addSubview(optionButton)
        optionButton.anchor(top: postImage.bottomAnchor, left: nil, bottom: nil, right: rightAnchor, paddingTop: 24, paddingLeft: 0, paddingBottom: 0, paddingRight: 18, width: 5.2, height: 20)
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupTopNavBar()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
