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
    
    var days : [Post]? {
        didSet {
            collectionView.reloadData()
        }
    }
    
    var engagements : Engagements? {
        didSet {
            
            if engagements?.saved == 1 {
                saveIcon.tintColor = .black
                saveLabel.setTitleColor(.black, for: .normal)
            } else {
                saveIcon.tintColor = .gray
                saveLabel.setTitleColor(.gray, for: .normal)
            }
            
            if engagements?.tried == 1 {
                tryIcon.tintColor = .black
                tryLabel.setTitleColor(.black, for: .normal)
            } else {
                tryIcon.tintColor = .gray
                tryLabel.setTitleColor(.gray, for: .normal)
            }
        }
    }
    
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
    
    lazy var saveBackground : UIButton = {
       let button = UIButton()
        button.layer.cornerRadius = 18
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(handleSave), for: .touchUpInside)
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
    
    lazy var optionsBackground : UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 18
        button.layer.masksToBounds = true
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
    
    lazy var tryBackground : UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 18
        button.layer.masksToBounds = true
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
    
    lazy var shareBackground : UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 18
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(handleShare), for: .touchUpInside)
        return button
    }()
    
    lazy var collaborateIcon : UIButton = {
       let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "custom-create-button").withRenderingMode(.alwaysOriginal), for: .normal)
        button.contentMode = .scaleAspectFill
        button.addTarget(self, action: #selector(handleCollaborate), for: .touchUpInside)
        return button
    }()
    
    lazy var collaborateBackground : UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 18
        button.layer.masksToBounds = true
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
        label.text = "Posts"
        label.font = UIFont.boldSystemFont(ofSize: 14)
        return label
    }()
    
    var hasSaved = false
    var hasTried = false
    
    let engagementService = EngagementServices()
    
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
        Mixpanel.mainInstance().track(event: "Post Save Clicked")
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
        Mixpanel.mainInstance().track(event: "Pursuit Try Clicked")
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
        
        addSubview(tryBackground)
        tryBackground.centerXAnchor.constraint(equalTo: tryIcon.centerXAnchor).isActive = true
        tryBackground.centerYAnchor.constraint(equalTo: tryIcon.centerYAnchor).isActive = true
        tryBackground.anchor(top: nil, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 36, height: 36)
        
        saveIcon.anchor(top: tryIcon.topAnchor, left: tryIcon.rightAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 44, paddingBottom: 0, paddingRight: 0, width: 20, height: 20)
        saveLabel.anchor(top: saveIcon.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 8, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: saveLabel.intrinsicContentSize.width, height: 16)
        saveLabel.centerXAnchor.constraint(equalTo: saveIcon.centerXAnchor).isActive = true
        
        addSubview(saveBackground)
        saveBackground.centerXAnchor.constraint(equalTo: saveIcon.centerXAnchor).isActive = true
        saveBackground.centerYAnchor.constraint(equalTo: saveIcon.centerYAnchor).isActive = true
        saveBackground.anchor(top: nil, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 36, height: 36)
        
        collaborateIcon.anchor(top: saveIcon.topAnchor, left: saveIcon.rightAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 52, paddingBottom: 0, paddingRight: 0, width: 22, height: 22)
        contributeLabel.anchor(top: saveLabel.topAnchor, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: contributeLabel.intrinsicContentSize.width, height: 16)
        contributeLabel.centerXAnchor.constraint(equalTo: collaborateIcon.centerXAnchor).isActive = true
        
        addSubview(collaborateBackground)
        collaborateBackground.centerXAnchor.constraint(equalTo: collaborateIcon.centerXAnchor).isActive = true
        collaborateBackground.centerYAnchor.constraint(equalTo: collaborateIcon.centerYAnchor).isActive = true
        collaborateBackground.anchor(top: nil, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 36, height: 36)
        
        shareIcon.anchor(top: collaborateIcon.topAnchor, left: collaborateIcon.rightAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 62, paddingBottom: 0, paddingRight: 0, width: 20, height: 20)
        shareLabel.anchor(top: shareIcon.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 8, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: shareLabel.intrinsicContentSize.width, height: 16)
        shareLabel.centerXAnchor.constraint(equalTo: shareIcon.centerXAnchor).isActive = true
        
        addSubview(shareBackground)
        shareBackground.centerXAnchor.constraint(equalTo: shareIcon.centerXAnchor).isActive = true
        shareBackground.centerYAnchor.constraint(equalTo: shareIcon.centerYAnchor).isActive = true
        shareBackground.anchor(top: nil, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 36, height: 36)
        
        optionsIcon.centerYAnchor.constraint(equalTo: shareIcon.centerYAnchor).isActive = true
        optionsIcon.anchor(top: nil, left: shareIcon.rightAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 54, paddingBottom: 0, paddingRight: 0, width: optionsIcon.intrinsicContentSize.width, height: 16)
        optionLabel.anchor(top: shareLabel.topAnchor, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: optionLabel.intrinsicContentSize.width, height: 16)
        optionLabel.centerXAnchor.constraint(equalTo: optionsIcon.centerXAnchor).isActive = true
        
        addSubview(optionsBackground)
        optionsBackground.centerXAnchor.constraint(equalTo: optionsIcon.centerXAnchor).isActive = true
        optionsBackground.centerYAnchor.constraint(equalTo: optionsIcon.centerYAnchor).isActive = true
        optionsBackground.anchor(top: nil, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 36, height: 36)
        
    }
    
    func setupView(){
        setupEngagements()
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
        return days?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! PursuitDayTableViewCell
        cell.post = days?[indexPath.item]
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

