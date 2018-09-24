//
//  PursuitDay.swift
//  pursue
//
//  Created by Jaylen Sanders on 7/2/18.
//  Copyright © 2018 Glory. All rights reserved.
//

import UIKit
import Mixpanel

protocol PursuitDayDelegate {
    func handleShare(for cell : PursuitDay)
}

class PursuitDay : UICollectionViewCell {

    var delegate : PursuitDayDelegate?
    
    let collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    let cellId = "cellId"
    let headerId = "headerId"
    
    var days = ["Day 1", "Day 2", "Day 3", "Day 4", "Day 5"]
    let images = ["788572ee949285fae33dca5d846a4664", "clean-2", "academics", "fashion-design", "690dae66bfe860df34fc7a756b53c15d"]
    
    lazy var firstProfileImageView : UIImageView = {
       let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "comment-1").withRenderingMode(.alwaysOriginal)
        iv.contentMode = .scaleAspectFill
        iv.layer.cornerRadius = 20
        iv.layer.masksToBounds = true
        return iv
    }()
    
    lazy var secondProfileImageView : UIImageView = {
       let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "comment-2").withRenderingMode(.alwaysOriginal)
        iv.contentMode = .scaleAspectFill
        iv.layer.cornerRadius = 20
        iv.layer.masksToBounds = true
        return iv
    }()
    
    lazy var addButton : UIButton = {
       let button = UIButton()
        button.setTitle("Invite Team", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        return button
    }()
    
    let saveBackground : EngagementsView = {
        let button = EngagementsView()
        button.backgroundColor = .white
        button.clipsToBounds = true
        button.motionIdentifier = "saveBackground"
        return button
    }()
    
    lazy var saveIcon : UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "bookmark").withRenderingMode(.alwaysOriginal), for: .normal)
        button.contentMode = .scaleAspectFill
        button.motionIdentifier = "saveIcon"
        return button
    }()
    
    let tryBackground : EngagementsView = {
        let button = EngagementsView()
        button.backgroundColor = .white
        button.clipsToBounds = true
        button.motionIdentifier = "tryBackground"
        return button
    }()
    
    lazy var tryIcon : UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "add").withRenderingMode(.alwaysTemplate), for: .normal)
        button.tintColor = .gray
        button.contentMode = .scaleAspectFill
        button.motionIdentifier = "tryIcon"
        button.addTarget(self, action: #selector(handleTry), for: .touchUpInside)
        return button
    }()
    
    let optionsBackground : EngagementsView = {
        let button = EngagementsView()
        button.backgroundColor = .white
        button.clipsToBounds = true
        return button
    }()
    
    let optionsIcon : UIButton = {
        let button = UIButton()
        button.setTitle("•••", for: .normal)
        button.setTitleColor(.gray, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.init(25))
        return button
    }()
    
    lazy var shareIcon : UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "share").withRenderingMode(.alwaysTemplate), for: .normal)
        button.tintColor = .gray
        button.contentMode = .scaleAspectFill
        button.motionIdentifier = "shareIcon"
        button.addTarget(self, action: #selector(handleShare), for: .touchUpInside)
        return button
    }()
    
    lazy var followIcon : UIButton = {
       let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "add-profile").withRenderingMode(.alwaysTemplate), for: .normal)
        button.tintColor = .gray
        return button
    }()
    
    lazy var collaborateIcon : UIButton = {
       let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "custom-create-button").withRenderingMode(.alwaysOriginal), for: .normal)
        button.contentMode = .scaleAspectFill
        button.addTarget(self, action: #selector(handleCollaborate), for: .touchUpInside)
        return button
    }()
    
    lazy var tryLabel : UIButton = {
       let button = UIButton()
        button.setTitle("Try", for: .normal)
        button.setTitleColor(.gray, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 12)
        return button
    }()
    
    lazy var shareLabel : UIButton = {
        let button = UIButton()
        button.setTitle("Share", for: .normal)
        button.setTitleColor(.gray, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 12)
        return button
    }()
    
    lazy var contributeLabel : UIButton = {
        let button = UIButton()
        button.setTitle("Contribute", for: .normal)
        button.setTitleColor(.gray, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 12)
        return button
    }()
    
    lazy var optionLabel : UIButton = {
        let button = UIButton()
        button.setTitle("More", for: .normal)
        button.setTitleColor(.gray, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 12)
        return button
    }()
    
    @objc func handleShare(){
        delegate?.handleShare(for: self)
    }
    
    @objc func handleCollaborate(){
        Mixpanel.mainInstance().track(event: "Contribute on pursuit button pressed")
    }
    
    @objc func handleTry(){
        Mixpanel.mainInstance().track(event: "Pursuit tried")
    }
    
    func setupTeamPictures(){
        addSubview(firstProfileImageView)
        addSubview(secondProfileImageView)
        addSubview(addButton)
        
        firstProfileImageView.anchor(top: tryLabel.bottomAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 42, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: 40, height: 40)
        secondProfileImageView.anchor(top: firstProfileImageView.topAnchor, left: firstProfileImageView.leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 35, paddingBottom: 0, paddingRight: 0, width: 40, height: 40)
        addButton.anchor(top: nil, left: secondProfileImageView.rightAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 18, paddingBottom: 0, paddingRight: 12, width: addButton.intrinsicContentSize.width, height: 16)
        addButton.centerYAnchor.constraint(equalTo: firstProfileImageView.centerYAnchor).isActive = true
    }
    
    func setupEngagements(){
        addSubview(tryIcon)
        addSubview(tryLabel)
        addSubview(optionsBackground)
        addSubview(optionsIcon)
        addSubview(optionLabel)
        addSubview(shareIcon)
        addSubview(shareLabel)
        addSubview(collaborateIcon)
        addSubview(contributeLabel)
        
        
        tryIcon.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 16, paddingBottom: 0, paddingRight: 0, width: 20, height: 20)
        tryLabel.anchor(top: tryIcon.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 8, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: tryLabel.intrinsicContentSize.width, height: 16)
        tryLabel.centerXAnchor.constraint(equalTo: tryIcon.centerXAnchor).isActive = true
        
        collaborateIcon.anchor(top: tryIcon.topAnchor, left: tryIcon.rightAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 52, paddingBottom: 0, paddingRight: 0, width: 22, height: 22)
        contributeLabel.anchor(top: tryLabel.topAnchor, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: contributeLabel.intrinsicContentSize.width, height: 16)
        contributeLabel.centerXAnchor.constraint(equalTo: collaborateIcon.centerXAnchor).isActive = true
        
        shareIcon.anchor(top: collaborateIcon.topAnchor, left: collaborateIcon.rightAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 62, paddingBottom: 0, paddingRight: 0, width: 20, height: 20)
        shareLabel.anchor(top: shareIcon.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 8, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: shareLabel.intrinsicContentSize.width, height: 16)
        shareLabel.centerXAnchor.constraint(equalTo: shareIcon.centerXAnchor).isActive = true
        
        optionsIcon.centerYAnchor.constraint(equalTo: shareIcon.centerYAnchor).isActive = true
        optionsIcon.anchor(top: nil, left: shareIcon.rightAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 54, paddingBottom: 0, paddingRight: 0, width: optionsIcon.intrinsicContentSize.width, height: 16)
        optionLabel.anchor(top: shareLabel.topAnchor, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: optionLabel.intrinsicContentSize.width, height: 16)
        optionLabel.centerXAnchor.constraint(equalTo: optionsIcon.centerXAnchor).isActive = true
        
    }
    
    func setupView(){
        setupEngagements()
//        setupTeamPictures()
        addSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(PursuitDayTableViewCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.anchor(top: tryLabel.bottomAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 32, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension PursuitDay : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! PursuitDayTableViewCell
        cell.setupView(index: indexPath.item)
        if indexPath.item != 0 {
            cell.dayLabel.isHidden = true
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(0, 12, 0, 12)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width / 2.25, height: frame.height - 100)
    }
}

