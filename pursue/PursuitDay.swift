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
    func handleSave(for cell : PursuitDay)
    func handleTry(for cell : PursuitDay)
    func handleResponse(for cell : PursuitDay)
    func handleMore(for cell : PursuitDay)
}

class PursuitDay : UICollectionViewCell {

    var delegate : PursuitDayDelegate?
    
    var accessPostDetailController: PostDetailController?
    
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
    
    lazy var saveIcon : UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "add").withRenderingMode(.alwaysTemplate), for: .normal)
        button.tintColor = .gray
        button.contentMode = .scaleAspectFill
        button.addTarget(self, action: #selector(handleSave), for: .touchUpInside)
        return button
    }()
    
    let optionsBackground : EngagementsView = {
        let button = EngagementsView()
        button.backgroundColor = .white
        button.clipsToBounds = true
        return button
    }()
    
    lazy var optionsIcon : UIButton = {
        let button = UIButton()
        button.setTitle("•••", for: .normal)
        button.setTitleColor(.gray, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.init(25))
        button.addTarget(self, action: #selector(handleMore), for: .touchUpInside)
        return button
    }()
    
    lazy var tryIcon : UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "try-icon"), for: .normal)
        button.tintColor = .gray
        button.contentMode = .scaleAspectFill
        button.addTarget(self, action: #selector(handleTry), for: .touchUpInside)
        return button
    }()
    
    lazy var shareIcon : UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "share").withRenderingMode(.alwaysTemplate), for: .normal)
        button.tintColor = .gray
        button.contentMode = .scaleAspectFill
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
    
    lazy var saveLabel : UIButton = {
       let button = UIButton()
        button.setTitle("Save", for: .normal)
        button.setTitleColor(.gray, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 12)
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
        button.setTitle("Respond", for: .normal)
        button.setTitleColor(.gray, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 12)
        return button
    }()
    
    lazy var optionLabel : UIButton = {
        let button = UIButton()
        button.setTitle("More", for: .normal)
        button.setTitleColor(.gray, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 12)
        button.addTarget(self, action: #selector(handleMore), for: .touchUpInside)
        return button
    }()
    
    let dayLabel : UILabel = {
        let label = UILabel()
        label.text = "Days"
        label.font = UIFont.boldSystemFont(ofSize: 14)
        return label
    }()
    
    var hasSaved = false
    var hasTried = false
    
    @objc func handleShare(){
        delegate?.handleShare(for: self)
    }
    
    @objc func handleMore(){
        delegate?.handleMore(for: self)
    }
    
    @objc func handleCollaborate(){
        Mixpanel.mainInstance().track(event: "Contribute on Pursuit")
        delegate?.handleResponse(for: self)
    }
    
    @objc func handleSave(){
        Mixpanel.mainInstance().track(event: "Post Saved")
        hasSaved = !hasSaved
        
        if hasSaved == false {
            saveIcon.tintColor = .gray
            saveLabel.setTitleColor(.gray, for: .normal)
        } else if hasSaved == true {
            saveIcon.tintColor = .black
            saveLabel.setTitleColor(.black, for: .normal)
            delegate?.handleSave(for: self)
        }
        
    }
    
    @objc func handleTry(){
        Mixpanel.mainInstance().track(event: "Pursuit Tried")
        hasTried = !hasTried
        
        if hasTried == false {
            tryIcon.tintColor = .gray
            tryIcon.setImage(UIImage(named: "try-icon"), for: .normal)
            tryLabel.setTitleColor(.gray, for: .normal)
            tryLabel.setTitle("Try", for: .normal)
        } else if hasTried == true {
            tryIcon.tintColor = .black
            tryIcon.setImage(UIImage(named: "try-icon-black"), for: .normal)
            tryLabel.setTitle("Tried", for: .normal)
            tryLabel.setTitleColor(.black, for: .normal)
            delegate?.handleTry(for: self)
        }
    }
    
    func setupEngagements(){
        addSubview(tryIcon)
        addSubview(tryLabel)
        addSubview(saveIcon)
        addSubview(saveLabel)
        addSubview(optionsBackground)
        addSubview(optionsIcon)
        addSubview(optionLabel)
        addSubview(shareIcon)
        addSubview(shareLabel)
        addSubview(collaborateIcon)
        addSubview(contributeLabel)
        
        
        tryIcon.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 12, paddingLeft: 16, paddingBottom: 0, paddingRight: 0, width: 20, height: 20)
        tryLabel.anchor(top: tryIcon.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 8, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 40, height: 16)
        tryLabel.centerXAnchor.constraint(equalTo: tryIcon.centerXAnchor).isActive = true
        
        saveIcon.anchor(top: tryIcon.topAnchor, left: tryIcon.rightAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 44, paddingBottom: 0, paddingRight: 0, width: 20, height: 20)
        saveLabel.anchor(top: saveIcon.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 8, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: saveLabel.intrinsicContentSize.width, height: 16)
        saveLabel.centerXAnchor.constraint(equalTo: saveIcon.centerXAnchor).isActive = true
        
        collaborateIcon.anchor(top: saveIcon.topAnchor, left: saveIcon.rightAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 52, paddingBottom: 0, paddingRight: 0, width: 22, height: 22)
        contributeLabel.anchor(top: saveLabel.topAnchor, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: contributeLabel.intrinsicContentSize.width, height: 16)
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
        addSubview(dayLabel)
        addSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(PursuitDayTableViewCell.self, forCellWithReuseIdentifier: cellId)
        
        dayLabel.anchor(top: saveLabel.bottomAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 42, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: dayLabel.intrinsicContentSize.width, height: dayLabel.intrinsicContentSize.height)
        collectionView.anchor(top: dayLabel.bottomAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 8, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        accessPostDetailController?.changeToDetail()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.init(top: 0, left: 12, bottom: 0, right: 12)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width / 2.25, height: frame.height - 100)
    }
}

