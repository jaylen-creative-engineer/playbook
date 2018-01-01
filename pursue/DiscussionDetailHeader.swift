//
//  DiscussionDetailHeader.swift
//  pursue
//
//  Created by Jaylen Sanders on 12/9/17.
//  Copyright © 2017 Glory. All rights reserved.
//

import UIKit

protocol DiscussionDetailDelegate {
    func changeAbout()
    func changeComment()
    func pursuitsActive()
    func principlesActive()
}

class DiscussionDetailHeader : UICollectionViewCell {
    
    var delegate : DiscussionDetailDelegate?
    var messageDelegate : MessageDelegate?
    
    let headerId = "headerId"
    var stackView = UIStackView()
    let bottomDividerView = UIView()
    
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
    
    let pursuitsLabelUnderline : UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 3
        view.layer.masksToBounds = true
        return view
    }()
    
    let principlesLabelUnderline : UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 3
        view.layer.masksToBounds = true
        return view
    }()
    
    let postImage : UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.image = #imageLiteral(resourceName: "social-marketing")
        return iv
    }()
    
    let postLabel : UILabel = {
        let label = UILabel()
        label.text = "Instagram Marketing"
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
    
    lazy var pursuitsLabel : UIButton = {
        let label = UIButton()
        label.setTitle("Pursuits", for: .normal)
        label.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        label.addTarget(self, action: #selector(togglePursuitsUnderline), for: .touchUpInside)
        return label
    }()

    lazy var principlesLabel : UIButton = {
        let label = UIButton()
        label.setTitle("Principles", for: .normal)
        label.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        label.addTarget(self, action: #selector(togglePrinciplesUnderline), for: .touchUpInside)
        return label
    }()
    
    lazy var commentsLabel : UIButton = {
        let label = UIButton()
        label.setTitle("Comments", for: .normal)
        label.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        label.addTarget(self, action: #selector(toggleCommentsUnderline), for: .touchUpInside)
        return label
    }()
    

    var detailController : DiscussionDetailController?
    
    
    @objc func toggleAboutUnderline(){
        aboutLabelUnderline.backgroundColor = .black
        
        aboutButton.setTitleColor(.black, for: .normal)
        commentsLabel.setTitleColor(.gray, for: .normal)
        principlesLabel.setTitleColor(.gray, for: .normal)
        pursuitsLabel.setTitleColor(.gray, for: .normal)
        
        aboutActive()
        
        addSubview(aboutLabelUnderline)
        aboutLabelUnderline.anchor(top: nil, left: nil, bottom: bottomDividerView.topAnchor, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 6, height: 6)
        aboutLabelUnderline.centerXAnchor.constraint(equalTo: aboutButton.centerXAnchor).isActive = true
    }
    
    func aboutActive(){
        delegate?.changeAbout()
        
        aboutLabelUnderline.isHidden = false
        commentsLabelUnderline.isHidden = true
        pursuitsLabelUnderline.isHidden = true
        principlesLabelUnderline.isHidden = true
    }
    
    @objc func toggleCommentsUnderline(){
        commentsLabelUnderline.backgroundColor = .black
        
        aboutButton.setTitleColor(.gray, for: .normal)
        commentsLabel.setTitleColor(.black, for: .normal)
        principlesLabel.setTitleColor(.gray, for: .normal)
        pursuitsLabel.setTitleColor(.gray, for: .normal)
        
        commentsActive()
        
        addSubview(commentsLabelUnderline)
        commentsLabelUnderline.anchor(top: nil, left: nil, bottom: bottomDividerView.topAnchor, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 6, height: 6)
        commentsLabelUnderline.centerXAnchor.constraint(equalTo: commentsLabel.centerXAnchor).isActive = true
    }
    
    func commentsActive(){
        delegate?.changeComment()
        
        aboutLabelUnderline.isHidden = true
        commentsLabelUnderline.isHidden = false
        pursuitsLabelUnderline.isHidden = true
        principlesLabelUnderline.isHidden = true
    }
    
    @objc func togglePursuitsUnderline(){
        pursuitsLabelUnderline.backgroundColor = .black
        
        aboutButton.setTitleColor(.gray, for: .normal)
        commentsLabel.setTitleColor(.gray, for: .normal)
        principlesLabel.setTitleColor(.gray, for: .normal)
        pursuitsLabel.setTitleColor(.black, for: .normal)
        
        pursuitsActive()
        
        addSubview(pursuitsLabelUnderline)
        pursuitsLabelUnderline.anchor(top: nil, left: nil, bottom: bottomDividerView.topAnchor, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 6, height: 6)
        pursuitsLabelUnderline.centerXAnchor.constraint(equalTo: pursuitsLabel.centerXAnchor).isActive = true
    }
    
    func pursuitsActive(){
        delegate?.pursuitsActive()
        
        aboutLabelUnderline.isHidden = true
        commentsLabelUnderline.isHidden = true
        pursuitsLabelUnderline.isHidden = false
        principlesLabelUnderline.isHidden = true
    }
    
    
    @objc func togglePrinciplesUnderline(){
        aboutButton.setTitleColor(.gray, for: .normal)
        commentsLabel.setTitleColor(.gray, for: .normal)
        principlesLabel.setTitleColor(.black, for: .normal)
        pursuitsLabel.setTitleColor(.gray, for: .normal)
        
        principlesActive()
        
        addSubview(principlesLabelUnderline)
        principlesLabelUnderline.anchor(top: nil, left: nil, bottom: bottomDividerView.topAnchor, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 6, height: 6)
        principlesLabelUnderline.centerXAnchor.constraint(equalTo: principlesLabel.centerXAnchor).isActive = true
    }
    
    func principlesActive(){
        delegate?.principlesActive()
        
        aboutLabelUnderline.isHidden = true
        commentsLabelUnderline.isHidden = true
        pursuitsLabelUnderline.isHidden = true
        principlesLabelUnderline.isHidden = false
    }
    
    func pageOptions(){
        bottomDividerView.backgroundColor = .clear
        
        stackView = UIStackView(arrangedSubviews: [aboutButton, commentsLabel, pursuitsLabel, principlesLabel])
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        
        addSubview(stackView)
        addSubview(bottomDividerView)
        
        stackView.anchor(top: postLabel.bottomAnchor, left: postImage.leftAnchor, bottom: nil, right: postImage.rightAnchor, paddingTop: 20, paddingLeft: 10, paddingBottom: 0, paddingRight: 10, width: 0, height: 50)
        bottomDividerView.anchor(top: stackView.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0.5)
    }
    
    func setupViews() {
        backgroundColor = .clear
        
        addSubview(postImage)
        addSubview(postLabel)
        
        postImage.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 44, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: (frame.height / 2) + 50)
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

