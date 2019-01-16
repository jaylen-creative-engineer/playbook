//
//  CaptureDetailView.swift
//  pursue
//
//  Created by Jaylen Sanders on 10/25/18.
//  Copyright © 2018 Glory. All rights reserved.
//

import UIKit
import Mixpanel
import Photos
import Hero
import ADDatePicker

class CaptureDetailView: UIViewController {
    
    let alertViewGrayColor = UIColor(red: 224.0/255.0, green: 224.0/255.0, blue: 224.0/255.0, alpha: 1)
    let detailId = "detailId"
    let pursuitId = "pursuitId"
    var accessLoginController : LoginController?
    
    let teamId = "teamId"
    let interestId = "interestId"
    let cellId = "cellId"
    let actionId = "actionId"
    let typeId = "typeId"
    let newPursuitId = "newPursuitId"
    
    var interests = [CreateInterests]()
    let interestsService = InterestServices()
    let createService = CreateServices()
    
    lazy var alertView : UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()

    let createLabel : UILabel = {
        let label = UILabel()
        label.text = "Create"
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    
    lazy var backButton : UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named : "cancel")?.withRenderingMode(.alwaysOriginal), for: .normal)
        button.tintColor = .black
        button.contentMode = .scaleAspectFill
        button.addTarget(self, action: #selector(handleCancel), for: .touchUpInside)
        return button
    }()
    
    lazy var nextLabel : UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .black
        button.layer.cornerRadius = 6
        button.layer.masksToBounds = true
        button.setTitle("Send", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.contentHorizontalAlignment = .center
        button.contentVerticalAlignment = .center
        button.addTarget(self, action: #selector(submitPost), for: .touchUpInside)
        return button
    }()
    
    lazy var backBackground : UIButton = {
       let button = UIButton()
        button.layer.cornerRadius = 19
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(handleCancel), for: .touchUpInside)
        return button
    }()
    
    let captureCollectionView : UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.backgroundColor = .clear
        collectionView.showsVerticalScrollIndicator = false
        return collectionView
    }()
    
    let scrollView : UIScrollView = {
       let sv = UIScrollView()
        sv.backgroundColor = .white
        sv.isScrollEnabled = true
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.showsVerticalScrollIndicator = false
        sv.keyboardDismissMode = .onDrag
        return sv
    }()
    
    let backgroundFill = UIView()

    let captionLabel : CaptionInputTextView = {
        let tv = CaptionInputTextView()
        tv.isScrollEnabled = false
        tv.font = UIFont.init(name: "Roboto-Regular", size: 24)
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()
    
    let captionUnderline : UIView = {
        let view = UIView()
        view.backgroundColor = .gray
        return view
    }()
    
    let inviteLabel : UILabel = {
        let label = UILabel()
        label.text = "Team"
        label.font = UIFont.boldSystemFont(ofSize: 14)
        return label
    }()
    
    let teamCollectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    lazy var createNewLabel : UIButton = {
        let button = UIButton()
        button.setTitle("Create New", for: .normal)
        button.setTitleColor(.gray, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.contentHorizontalAlignment = .right
        button.contentVerticalAlignment = .center
        button.addTarget(self, action: #selector(handleCreate), for: .touchUpInside)
        return button
    }()
    
    let interestsLabel : UILabel = {
        let label = UILabel()
        label.text = "Select Interests"
        label.font = UIFont.boldSystemFont(ofSize: 14)
        return label
    }()
    
    let interestsCollectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    let keyPostLabel : UILabel = {
        let label = UILabel()
        label.text = "Mark as a Key Post"
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    
    lazy var keyPostSwitch : UISwitch = {
        let sview = UISwitch()
        sview.onTintColor = .blue
        sview.addTarget(self, action: #selector(keyPostSwitchChanged(mySwitch:)), for: .touchUpInside)
        return sview
    }()
    
    let privateLabel : UILabel = {
        let label = UILabel()
        label.text = "Make Pursuit Public"
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    
    lazy var privatePostSwitch : UISwitch = {
        let sview = UISwitch()
        sview.onTintColor = .blue
        sview.addTarget(self, action: #selector(privatePostSwitchChanged(mySwitch:)), for: .touchUpInside)
        return sview
    }()
    
    let pursuitsLabel : UILabel = {
        let label = UILabel()
        label.text = "Select Pursuits"
        label.font = UIFont.boldSystemFont(ofSize: 14)
        return label
    }()
    
    let createFirstPursuit : UILabel = {
        let label = UILabel()
        label.text = "You have no pursuits to select from."
        label.numberOfLines = 2
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor = .gray
        label.isHidden = true
        return label
    }()
    
    let selectPostLabel : UILabel = {
       let label = UILabel()
        label.text = "Select Post Type"
        label.font = UIFont.init(name: "Roboto-Medium", size: 16)
        label.textColor = .gray
        return label
    }()
    
    let pursuitsCollectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    let postTypeCollectionView : UICollectionView = {
       let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.isScrollEnabled = false
        return collectionView
    }()
    
    let actionCollectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.isScrollEnabled = false
        return collectionView
    }()
    
    let pursuitIcon : UIButton = {
       let button = UIButton()
        button.backgroundColor = .blue
        return button
    }()
    
    let pursuitLabel : UILabel = {
       let label = UILabel()
        label.text = "Pursuit"
        label.font = UIFont.init(name: "Roboto-Medium", size: 16)
        return label
    }()
    
    let pursuitDescription : UILabel = {
       let label = UILabel()
        label.text = "This is filler text"
        label.numberOfLines = 1
        label.font = UIFont.systemFont(ofSize: 13)
        return label
    }()
    
    let pursuitDetailStackView : UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.spacing = 2
        sv.distribution = .fill
        return sv
    }()
    
    let challengeIcon : UIButton = {
        let button = UIButton()
        button.backgroundColor = .blue
        return button
    }()
    
    let challengeLabel : UILabel = {
        let label = UILabel()
        label.text = "Challenge"
        label.font = UIFont.init(name: "Roboto-Medium", size: 16)
        return label
    }()
    
    let challengeDescription : UILabel = {
        let label = UILabel()
        label.text = "This is filler text"
        label.numberOfLines = 1
        label.font = UIFont.systemFont(ofSize: 13)
        return label
    }()
    
    let challengeDetailStackView : UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.spacing = 2
        sv.distribution = .fill
        return sv
    }()
    
    let questionIcon : UIButton = {
        let button = UIButton()
        button.backgroundColor = .blue
        return button
    }()
    
    let questionLabel : UILabel = {
        let label = UILabel()
        label.text = "Question"
        label.font = UIFont.init(name: "Roboto-Medium", size: 16)
        return label
    }()
    
    let questionDescription : UILabel = {
        let label = UILabel()
        label.text = "This is filler text"
        label.numberOfLines = 1
        label.font = UIFont.systemFont(ofSize: 13)
        return label
    }()
    
    let questionDetailStackView : UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.spacing = 2
        sv.distribution = .fill
        return sv
    }()
    
    let postTypeUnderlineView : UIView = {
       let view = UIView()
        view.backgroundColor = .gray
        return view
    }()
    
    let pursuitsUnderlineView : UIView = {
        let view = UIView()
        view.backgroundColor = .gray
        return view
    }()
    
    let actionIcon : UIButton = {
        let button = UIButton()
        button.backgroundColor = .blue
        return button
    }()
    
    let actionLabel : UILabel = {
        let label = UILabel()
        label.text = "Action Items"
        label.font = UIFont.init(name: "Roboto-Medium", size: 16)
        return label
    }()
    
    let actionUnderlineView : UIView = {
        let view = UIView()
        view.backgroundColor = .gray
        return view
    }()
    
    let inviteIcon : UIButton = {
        let button = UIButton()
        button.backgroundColor = .blue
        return button
    }()
    
    let inviteButton : UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Invite people", for: .normal)
        button.tintColor = .gray
        button.titleLabel?.font = UIFont.init(name: "Roboto-Medium", size: 16)
        button.contentHorizontalAlignment = .left
        return button
    }()
    
    let inviteUnderlineView : UIView = {
        let view = UIView()
        view.backgroundColor = .gray
        return view
    }()
    
    let interestIcon : UIButton = {
        let button = UIButton()
        button.backgroundColor = .blue
        return button
    }()
    
    let interestButton : UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Add tags", for: .normal)
        button.tintColor = .gray
        button.titleLabel?.font = UIFont.init(name: "Roboto-Medium", size: 16)
        button.contentHorizontalAlignment = .left
        return button
    }()
    
    let interestUnderlineView : UIView = {
        let view = UIView()
        view.backgroundColor = .gray
        return view
    }()
    
    let dateIcon : UIButton = {
        let button = UIButton()
        button.backgroundColor = .blue
        return button
    }()
    
    let dateLabel : UILabel = {
        let label = UILabel()
        label.text = "Pursuit"
        label.font = UIFont.init(name: "Roboto-Medium", size: 16)
        return label
    }()
    
    func setupSelectPostType(){
//        scrollView.addSubview(selectPostLabel)
        scrollView.addSubview(pursuitIcon)
        scrollView.addSubview(pursuitDetailStackView)
        pursuitDetailStackView.addArrangedSubview(pursuitLabel)
        pursuitDetailStackView.addArrangedSubview(pursuitDescription)
        scrollView.addSubview(postTypeUnderlineView)
        
//        selectPostLabel.anchor(top: captionUnderline.bottomAnchor, left: scrollView.leftAnchor, bottom: nil, right: nil, paddingTop: 18, paddingLeft: 18, paddingBottom: 0, paddingRight: 0, width: selectPostLabel.intrinsicContentSize.width, height: 26)
        pursuitIcon.anchor(top: captionUnderline.bottomAnchor, left: scrollView.leftAnchor, bottom: nil, right: nil, paddingTop: 32, paddingLeft: 18, paddingBottom: 0, paddingRight: 0, width: 22, height: 22)
        pursuitDetailStackView.anchor(top: nil, left: pursuitIcon.rightAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft: 24, paddingBottom: 0, paddingRight: 0, width: 0, height: 45)
        pursuitDetailStackView.centerYAnchor.constraint(equalTo: pursuitIcon.centerYAnchor).isActive = true
        postTypeUnderlineView.anchor(top: pursuitDetailStackView.bottomAnchor, left: view.leftAnchor, bottom: nil, right: scrollView.safeAreaLayoutGuide.rightAnchor, paddingTop: 32, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0.2)
        setupPursuitsCollectionView()
    }
    
    func setupPursuitsCollectionView(){
        pursuitsCollectionView.delegate = self
        pursuitsCollectionView.dataSource = self
        pursuitsCollectionView.register(SavePopoverCells.self, forCellWithReuseIdentifier: cellId)
        pursuitsCollectionView.register(CreateNewPursuitCell.self, forCellWithReuseIdentifier: newPursuitId)
        
        scrollView.addSubview(pursuitsCollectionView)
        scrollView.addSubview(pursuitsUnderlineView)
        
        pursuitsCollectionView.anchor(top: postTypeUnderlineView.bottomAnchor, left: scrollView.leftAnchor, bottom: nil, right: scrollView.safeAreaLayoutGuide.rightAnchor, paddingTop: 18, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 250)
        
        pursuitsUnderlineView.anchor(top: pursuitsCollectionView.bottomAnchor, left: scrollView.leftAnchor, bottom: nil, right: scrollView.safeAreaLayoutGuide.rightAnchor, paddingTop: 32, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0.5)
        setupActionItems()
    }
    
    func setupActionItems(){
        actionCollectionView.delegate = self
        actionCollectionView.dataSource = self
        actionCollectionView.register(CreateActionItemsCell.self, forCellWithReuseIdentifier: actionId)
        view.addSubview(actionIcon)
        view.addSubview(actionLabel)
        view.addSubview(actionCollectionView)
        view.addSubview(actionUnderlineView)
        
        actionIcon.anchor(top: pursuitsUnderlineView.bottomAnchor, left: scrollView.leftAnchor, bottom: nil, right: nil, paddingTop: 32, paddingLeft: 18, paddingBottom: 0, paddingRight: 0, width: 22, height: 22)
        actionCollectionView.anchor(top: actionIcon.topAnchor, left: actionIcon.rightAnchor, bottom: nil, right: scrollView.safeAreaLayoutGuide.rightAnchor, paddingTop: 0, paddingLeft: 24, paddingBottom: 0, paddingRight: 0, width: 0, height: 180)
        actionUnderlineView.anchor(top: actionCollectionView.bottomAnchor, left: scrollView.leftAnchor, bottom: nil, right: scrollView.safeAreaLayoutGuide.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0.2)
        setupSelectInterest()
        setupInvitePeople()
    }
    
    @IBOutlet var calendar: ADDatePicker!
    func setupSelectInterest(){
        view.addSubview(interestIcon)
        view.addSubview(interestButton)
        view.addSubview(interestUnderlineView)
        
        interestIcon.anchor(top: actionUnderlineView.bottomAnchor, left: scrollView.leftAnchor, bottom: nil, right: nil, paddingTop: 32, paddingLeft: 18, paddingBottom: 0, paddingRight: 0, width: 22, height: 22)
        interestButton.centerYAnchor.constraint(equalTo: interestIcon.centerYAnchor).isActive = true
        interestButton.anchor(top: nil, left: interestIcon.rightAnchor, bottom: nil, right: scrollView.rightAnchor, paddingTop: 0, paddingLeft: 24, paddingBottom: 0, paddingRight: 12, width: 0, height: 18)
        interestUnderlineView.anchor(top: interestButton.bottomAnchor, left: view.leftAnchor, bottom: nil, right: scrollView.safeAreaLayoutGuide.rightAnchor, paddingTop: 38, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0.5)
    }
    
    func setupInvitePeople(){
        view.addSubview(inviteIcon)
        view.addSubview(inviteButton)
        view.addSubview(inviteUnderlineView)
        
        inviteIcon.anchor(top: interestUnderlineView.bottomAnchor, left: scrollView.leftAnchor, bottom: nil, right: nil, paddingTop: 32, paddingLeft: 18, paddingBottom: 0, paddingRight: 0, width: 22, height: 22)
        inviteButton.centerYAnchor.constraint(equalTo: inviteIcon.centerYAnchor).isActive = true
        inviteButton.anchor(top: nil, left: inviteIcon.rightAnchor, bottom: nil, right: scrollView.rightAnchor, paddingTop: 0, paddingLeft: 24, paddingBottom: 0, paddingRight: 12, width: 0, height: 18)
        inviteUnderlineView.anchor(top: inviteButton.bottomAnchor, left: view.leftAnchor, bottom: nil, right: scrollView.safeAreaLayoutGuide.rightAnchor, paddingTop: 38, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0.5)
        setupDatePicker()
    }
    
    
    func setupDatePicker(){
        view.addSubview(dateIcon)
        view.addSubview(dateLabel)
        
        dateIcon.anchor(top: inviteUnderlineView.bottomAnchor, left: view.leftAnchor, bottom: nil, right: nil, paddingTop: 32, paddingLeft: 18, paddingBottom: 0, paddingRight: 0, width: 22, height: 22)
        dateLabel.centerYAnchor.constraint(equalTo: dateIcon.centerYAnchor).isActive = true
        dateLabel.anchor(top: nil, left: dateIcon.rightAnchor, bottom: nil, right: scrollView.rightAnchor, paddingTop: 0, paddingLeft: 24, paddingBottom: 0, paddingRight: 12, width: 0, height: 18)
        
        calendar.delegate = self
        calendar.intialDate = Date()
        calendar.yearRange(inBetween: 2019, end: 2022)
        calendar.backgroundColor = .blue
        calendar.deselectedBgColor = .clear
        calendar.selectedBgColor = .white
        calendar.selectedTextColor = .black
        calendar.deselectTextColor = UIColor.init(white: 1.0, alpha: 0.7)
        calendar.selectionType = .circle
        view.addSubview(calendar)
        calendar.anchor(top: dateLabel.bottomAnchor, left: view.leftAnchor, bottom: nil, right: scrollView.safeAreaLayoutGuide.rightAnchor, paddingTop: 24, paddingLeft: 18, paddingBottom: 0, paddingRight: 12, width: 0, height: 200)
    }
    
    var isCreate = false
    
    var createDetail : CreateDetail?
    
    func getCaptureDetail(){
        createService.getCreateDetail { (detailData) in
            DispatchQueue.main.async {
                self.createDetail = detailData
                if detailData.pursuits?.first?.pursuitId == nil {
                    self.scrollView.addSubview(self.createFirstPursuit)
                    self.createFirstPursuit.isHidden = false
                    self.createFirstPursuit.anchor(top: nil, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 18)
                    self.createFirstPursuit.centerYAnchor.constraint(equalTo: self.pursuitsCollectionView.centerYAnchor).isActive = true
                    self.createFirstPursuit.centerXAnchor.constraint(equalTo: self.scrollView.centerXAnchor).isActive = true
                } else {
                    self.createFirstPursuit.isHidden = true
                }
                
                self.interestsCollectionView.reloadData()
                self.teamCollectionView.reloadData()
                self.pursuitsCollectionView.reloadData()
            }
        }
    }
    
    @objc func keyPostSwitchChanged(mySwitch: UISwitch) {
        if mySwitch.isOn {
            is_keyPost = 1
        } else {
            is_keyPost = 0
        }
    }
    
    @objc func privatePostSwitchChanged(mySwitch: UISwitch) {
        if mySwitch.isOn {
            is_public = 1
        } else {
            is_public = 0
        }
    }
    
    @objc func handleCreate(){
        isCreate = !isCreate
        
        if isCreate == true {
            interestsLabel.isHidden = false
            interestsCollectionView.isHidden = false
            inviteLabel.isHidden = false
            teamCollectionView.isHidden = false
            privateLabel.isHidden = false
            privatePostSwitch.isHidden = false
            
            createNewLabel.setTitleColor(.black, for: .normal)
            
        } else {
            interestsLabel.isHidden = true
            interestsCollectionView.isHidden = true
            inviteLabel.isHidden = true
            teamCollectionView.isHidden = true
            privateLabel.isHidden = true
            privatePostSwitch.isHidden = true
            
            createNewLabel.setTitleColor(.gray, for: .normal)
            
        }
    }
    
    
    func setupInterestsCollectionView(){
//        interestsCollectionView.delegate = self
//        interestsCollectionView.dataSource = self
        interestsCollectionView.register(CreateInterestsCells.self, forCellWithReuseIdentifier: interestId)
        
        view.addSubview(interestsLabel)
        view.addSubview(interestsCollectionView)
        
        interestsLabel.isHidden = true
        interestsCollectionView.isHidden = true
        
        interestsLabel.anchor(top: privatePostSwitch.bottomAnchor, left: view.leftAnchor, bottom: nil, right: nil, paddingTop: 48, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: interestsLabel.intrinsicContentSize.width, height: 16)
        interestsCollectionView.anchor(top: interestsLabel.bottomAnchor, left: scrollView.leftAnchor, bottom: nil, right: scrollView.safeAreaLayoutGuide.rightAnchor, paddingTop: 24, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 40)
    }
    
    func setupTeamCollectionView(){
//        teamCollectionView.delegate = self
//        teamCollectionView.dataSource = self
        teamCollectionView.register(TeamCells.self, forCellWithReuseIdentifier: teamId)
        
        view.addSubview(inviteLabel)
        view.addSubview(teamCollectionView)
        view.addSubview(privateLabel)
        view.addSubview(privatePostSwitch)
        
        inviteLabel.isHidden = true
        teamCollectionView.isHidden = true
        privateLabel.isHidden = true
        privatePostSwitch.isHidden = true
        
        
        if createDetail?.team?.first?.userId == nil {
            teamCollectionView.isHidden = true
            inviteLabel.isHidden = true
            privateLabel.anchor(top: pursuitsCollectionView.bottomAnchor, left: scrollView.leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: privateLabel.intrinsicContentSize.width, height: 20)
            privatePostSwitch.centerYAnchor.constraint(equalTo: privateLabel.centerYAnchor).isActive = true
            privatePostSwitch.anchor(top: nil, left: nil, bottom: nil, right: scrollView.safeAreaLayoutGuide.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 80, height: 24)
        } else {
            inviteLabel.anchor(top: pursuitsCollectionView.bottomAnchor, left: scrollView.leftAnchor, bottom: nil, right: nil, paddingTop: 48, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: inviteLabel.intrinsicContentSize.width, height: 16)
            teamCollectionView.anchor(top: inviteLabel.bottomAnchor, left: scrollView.leftAnchor, bottom: nil, right: scrollView.safeAreaLayoutGuide.rightAnchor, paddingTop: 18, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 90)
            privateLabel.anchor(top: teamCollectionView.bottomAnchor, left: view.leftAnchor, bottom: nil, right: nil, paddingTop: 32, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: privateLabel.intrinsicContentSize.width, height: 20)
            privatePostSwitch.centerYAnchor.constraint(equalTo: privateLabel.centerYAnchor).isActive = true
            privatePostSwitch.anchor(top: nil, left: nil, bottom: nil, right: scrollView.safeAreaLayoutGuide.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 80, height: 24)
        }
        
    }
    
    func setupScrollView(){
        view.addSubview(scrollView)
        scrollView.addSubview(captionLabel)
        scrollView.addSubview(captionUnderline)
    
        
        scrollView.anchor(top: backgroundFill.bottomAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        captionLabel.anchor(top: scrollView.topAnchor, left: backButton.rightAnchor, bottom: nil, right: scrollView.safeAreaLayoutGuide.rightAnchor, paddingTop: 42, paddingLeft: 18, paddingBottom: 0, paddingRight: 12, width: 0, height: captionLabel.intrinsicContentSize.height)
        captionUnderline.anchor(top: captionLabel.bottomAnchor, left: view.leftAnchor, bottom: nil, right: scrollView.safeAreaLayoutGuide.rightAnchor, paddingTop: 18, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0.2)
        setupSelectPostType()
//        keyPostLabel.anchor(top: scrollView.centerYAnchor, left: scrollView.leftAnchor, bottom: nil, right: nil, paddingTop: 48, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: keyPostLabel.intrinsicContentSize.width, height: 20)
//        keyPostSwitch.centerYAnchor.constraint(equalTo: keyPostLabel.centerYAnchor).isActive = true
//        keyPostSwitch.anchor(top: nil, left: nil, bottom: nil, right: scrollView.safeAreaLayoutGuide.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 80, height: 24)
//        setupTeamCollectionView()
//        setupInterestsCollectionView()
    }
    
    func setupTopBar(){
        backgroundFill.backgroundColor = .white
        
        view.addSubview(alertView)
        view.addSubview(backgroundFill)
        view.addSubview(backButton)
        view.addSubview(nextLabel)
        
        alertView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        backgroundFill.anchor(top: alertView.topAnchor, left: alertView.safeAreaLayoutGuide.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 80)
        backButton.anchor(top: nil, left: backgroundFill.leftAnchor, bottom: backgroundFill.bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 18, paddingBottom: 0, paddingRight: 0, width: 20, height: 20)
        nextLabel.anchor(top: nil, left: nil, bottom: backgroundFill.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 18, width: nextLabel.intrinsicContentSize.width + 30, height: 34)
        setupScrollView()
//        captureCollectionView.anchor(top: backgroundFill.bottomAnchor, left: alertView.leftAnchor, bottom: nil, right: alertView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: view.frame.height)
    }
    
    static let updateFeedNotificationName = NSNotification.Name(rawValue: "UpdateFeed")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.contentSize = CGSize(width: view.frame.width, height: view.frame.height + 360)
        setupTopBar()
//        getCaptureDetail()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupView()
        animateView()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        tabBarController?.tabBar.isHidden = false
    }
    
    @objc func handleCancel(){
        dismiss(animated: true, completion: nil)
    }
    
    var createPursuitId : Int?
    var is_public = 1
    var is_keyPost = 0
    var createInterestId : Int?
    var thumbnailImage : UIImage?
    var videoURL : URL?
    var team = [User]()
    
    func addTeam(){
        if !team.isEmpty {
            for value in team {
                createService.addTeam(pursuitId: createPursuitId, userId: value.userId)
            }
        }
    }
    
    @objc func submitPost(){
        if createPursuitId == nil {
            nextLabel.setTitle("Sending...", for: .normal)
            submitPursuit()
            
        } else if createPursuitId != nil {
            nextLabel.setTitle("Sending...", for: .normal)
            
            createService.createPost(pursuitId: createPursuitId!, contentUrl: videoURL, thumbnailUrl: thumbnailImage, posts_description: captionLabel.text, is_keyPost: is_keyPost, is_public: is_public)
            addTeam()
            NotificationCenter.default.post(name: CaptureDetailView.updateFeedNotificationName, object: nil)
            
            let appDelegate = UIApplication.shared.delegate! as! AppDelegate
            appDelegate.window = UIWindow()
            appDelegate.window?.rootViewController = MainTabController()
            appDelegate.window?.makeKeyAndVisible()
            self.dismiss(animated: true, completion: nil)
        }
        
    }
    
    
    fileprivate func createPost() {
        self.createService.getUserPursuitsId { (returnPursuit) in
            self.createService.createPost(pursuitId: (returnPursuit.pursuitId)!, contentUrl: self.videoURL, thumbnailUrl: self.thumbnailImage, posts_description: self.captionLabel.text, is_keyPost: self.is_keyPost, is_public: self.is_public)
            
            if !self.team.isEmpty {
                for value in self.team {
                    self.createService.addTeam(pursuitId: (returnPursuit.pursuitId)!, userId: value.userId)
                }
            }
        }
    }
    
    @objc func submitPursuit(){
        DispatchQueue.main.async {
            self.createService.createPursuit(interestId: self.createInterestId, thumbnailUrl: self.thumbnailImage, pursuitDescription: self.captionLabel.text, is_public: self.is_public) {
                self.createPost()
                NotificationCenter.default.post(name: CaptureDetailView.updateFeedNotificationName, object: nil)
                
                let appDelegate = UIApplication.shared.delegate! as! AppDelegate
                appDelegate.window = UIWindow()
                appDelegate.window?.rootViewController = MainTabController()
                appDelegate.window?.makeKeyAndVisible()
                self.dismiss(animated: true, completion: nil)
            }
        }
        
    }
    
    func setupView() {
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.4)
    }
    
    func animateView() {
        alertView.alpha = 0;
        self.alertView.frame.origin.y = self.alertView.frame.origin.y + 50
        UIView.animate(withDuration: 0.4, animations: { () -> Void in
            self.alertView.alpha = 1.0;
            self.alertView.frame.origin.y = self.alertView.frame.origin.y - 50
        })
    }

    func dismissAlertView(action : UIAlertAction) {
        self.dismiss(animated: true, completion: nil)
    }
    
}

extension CaptureDetailView : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
//        switch collectionView {
//        case teamCollectionView:
//            return createDetail?.team?.count ?? 0
//        case interestsCollectionView:
//            return createDetail?.interests?.count ?? 0
//        case pursuitsCollectionView:
//            if createDetail?.pursuits?.first?.pursuitId == nil {
//                return 0
//            } else {
//                return createDetail?.pursuits?.count ?? 0
//            }
//        default:
//            return 1
//        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        switch collectionView {
        case pursuitsCollectionView:
            return UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 12)
        case actionCollectionView:
            return UIEdgeInsets(top: 0, left: 18, bottom: 0, right: 0)
        default:
            return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        }
        

//        switch collectionView {
//        case teamCollectionView:
//            return UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
//        default:
//            return UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 12)
//        }
    }
//
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case pursuitsCollectionView:
            switch indexPath.item {
            case 0:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: newPursuitId, for: indexPath) as! CreateNewPursuitCell
                return cell
            default:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! SavePopoverCells
                //        cell.pursuit = createDetail?.pursuits?[indexPath.item]
                return cell
            }
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: actionId, for: indexPath) as! CreateActionItemsCell
            return cell
        }
       
//        switch collectionView {
//        case teamCollectionView:
//            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: teamId, for: indexPath) as! TeamCells
//            cell.accessDetailView = self
//            cell.team = createDetail?.team?[indexPath.item]
//            return cell
//        case interestsCollectionView:
//            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: interestId, for: indexPath) as! CreateInterestsCells
//            cell.accessDetailView = self
//            cell.interest = createDetail?.interests?[indexPath.item]
//            return cell
//        case pursuitsCollectionView:
//            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! SavePopoverCells
//            cell.pursuit = createDetail?.pursuits?[indexPath.item]
//            return cell
//        default:
//            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "randomCell", for: indexPath)
//            return cell
//        }
    }
//
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        switch collectionView {
//        case pursuitsCollectionView:
//            createPursuitId = createDetail?.pursuits?[indexPath.item].pursuitId ?? 0
//        case interestsCollectionView:
//            createInterestId = createDetail?.interests?[indexPath.item].interestId ?? 0
//        default:
//            assert(false, "Not a valid selection")
//        }
//    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 15.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 15.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch collectionView {
        case pursuitsCollectionView:
            return CGSize(width: 200, height: 220)
        default:
            return CGSize(width: view.frame.width, height: 24)
        }
        

//        switch collectionView {
//        case teamCollectionView:
//            return CGSize(width: 80, height: 80)
//        case pursuitsCollectionView:
//            return CGSize(width: 200, height: 220)
//        case interestsCollectionView:
//            if !interests.isEmpty {
//                if let interest_name = interests[indexPath.item].interest_name {
//                    let approximateHeightOfLabel = view.frame.width - 20 - 8
//                    let size = CGSize(width: .infinity, height: approximateHeightOfLabel)
//                    let attributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12)]
//                    let estimatedFrame = NSString(string: interest_name).boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: attributes, context: nil)
//                    return CGSize(width: estimatedFrame.width + 50, height: 43)
//                }
//            }
//            return CGSize(width: view.frame.width / 4, height: 40)
//        default:
//            return CGSize(width: view.frame.width, height: view.frame.height / 1.6)
//        }

    }
}

extension CaptureDetailView : ADDatePickerDelegate {
    func ADDatePickerDidChange(didChange date: Date) {
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "MMM d, yyyy"
        //        btnGetDate.setTitle(dateformatter.string(from: date) , for: .normal)
    }
}
