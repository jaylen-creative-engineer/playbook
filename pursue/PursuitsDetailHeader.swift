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
    func changeChallenge()
}

protocol MessageDelegate {
    func handleMessage(for cell : PursuitsDetailHeader)
    func goBack()
}

class PursuitsDetailHeader : UICollectionViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, PursuitDetailDelegate {
    
    var isAboutView = true
    var isSavedView = false
    var isToolsView = false
    var isTeamView = false
    var isNextView = false
    var isStepsView = false
    var isChallenge = false
    
    func aboutLabelSelected() {
        changeDelegate?.changeAbout()
        isAboutView = true
        isSavedView = false
        isToolsView = false
        isTeamView = false
        isNextView = false
        isStepsView = false
        isChallenge = false
        
        collectionViewContainer.reloadData()
        collectionViewContainer.updateConstraints()
    }
    
    func challengeLabelSelected() {
        changeDelegate?.changeChallenge()
        
        isAboutView = false
        isSavedView = false
        isToolsView = false
        isTeamView = false
        isNextView = false
        isStepsView = false
        isChallenge = true
        collectionViewContainer.reloadData()
        collectionViewContainer.updateConstraints()
    }
    
    func savedLabelSelected() {
        changeDelegate?.changeSaved()
        isAboutView = false
        isSavedView = true
        isToolsView = false
        isTeamView = false
        isNextView = false
        isStepsView = false
        isChallenge = false
        collectionViewContainer.reloadData()
        collectionViewContainer.updateConstraints()

    }
    
    func toolsLabelSelected() {
        changeDelegate?.changeTool()
        isAboutView = false
        isSavedView = false
        isToolsView = true
        isTeamView = false
        isNextView = false
        isStepsView = false
        isChallenge = false
        collectionViewContainer.reloadData()
        collectionViewContainer.updateConstraints()
    }
    
    func teamLabelSelected() {
        changeDelegate?.changeTeam()
        isAboutView = false
        isSavedView = false
        isToolsView = false
        isTeamView = true
        isNextView = false
        isStepsView = false
        isChallenge = false
        
        collectionViewContainer.reloadData()
        collectionViewContainer.updateConstraints()
        
    }
    
    func nextLabelSelected() {
        changeDelegate?.changeNext()
        isAboutView = false
        isSavedView = false
        isToolsView = false
        isTeamView = false
        isNextView = true
        isStepsView = false
        isChallenge = false
        
        collectionViewContainer.reloadData()
        collectionViewContainer.updateConstraints()
        
    }
    
    func stepLabelSelected() {
        changeDelegate?.changeSteps()
        isAboutView = false
        isSavedView = false
        isToolsView = false
        isTeamView = false
        isNextView = false
        isStepsView = true
        isChallenge = false
        
        collectionViewContainer.reloadData()
        collectionViewContainer.updateConstraints()
    }
    
    
    var pursuitsDetailController : PursuitsDetailController?
    var delegate : PursuitDetailDelegate?
    var changeDelegate : DetailCellChange?
    var messageDelegate : MessageDelegate?
    
    lazy var backButton : UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "back-button").withRenderingMode(.alwaysOriginal), for: .normal)
        button.addTarget(self, action: #selector(dismissView), for: .touchUpInside)
        return button
    }()
    
    lazy var chatIcon : UIButton = {
        let button = UIButton()
        button.setBackgroundImage(#imageLiteral(resourceName: "send2").withRenderingMode(.alwaysOriginal), for: .normal)
        button.addTarget(self, action: #selector(handleChat), for: .touchUpInside)
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
    
    let collectionViewContainer : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.isScrollEnabled = true
        return collectionView
    }()
    
    let headerId = "headerId"
    
    var stackView = UIStackView()
    var trailing : NSLayoutConstraint?
    var leading : NSLayoutConstraint?
    
    let bottomDividerView = UIView()
    
    @objc func dismissView(){
        messageDelegate?.goBack()
    }
    
    @objc func handleChat() {
        messageDelegate?.handleMessage(for: self)
    }
    
    func setupTopNavBar(){
        addSubview(backButton)
        addSubview(chatIcon)
        
        backButton.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: 25, height: 25)
        chatIcon.anchor(top: topAnchor, left: nil, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 24, width: 0, height: 20)
    }
    
    func pageOptions(){
        bottomDividerView.backgroundColor = UIColor.init(white: 0, alpha: 0.2)
        
        addSubview(collectionViewContainer)
        addSubview(bottomDividerView)
        
        collectionViewContainer.anchor(top: postLabel.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 20, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 50)
        bottomDividerView.anchor(top: collectionViewContainer.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0.5)
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
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionViewContainer.dequeueReusableCell(withReuseIdentifier: headerId, for: indexPath) as! DetailHeaderCells
        cell.delegate = self
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(0, 4, 0, 12)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width + 58, height: 50)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        collectionViewContainer.register(DetailHeaderCells.self, forCellWithReuseIdentifier: headerId)
        collectionViewContainer.delegate = self
        collectionViewContainer.dataSource = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
