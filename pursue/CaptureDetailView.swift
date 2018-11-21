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


class CaptureDetailView: UIViewController {
    
    let alertViewGrayColor = UIColor(red: 224.0/255.0, green: 224.0/255.0, blue: 224.0/255.0, alpha: 1)
    let detailId = "detailId"
    let pursuitId = "pursuitId"
    var accessLoginController : LoginController?
    
    let peopleFullname = ["Tom Ford", "Versace", "LVME", "Test", "Lit"]
    let peopleUsernames = ["TomFord123", "Versace", "LVME", "Test", "Lit"]
    let peopleImages = ["comment-1", "comment-4", "comment-7", "clean-2", "clean-3"]
    
    let teamId = "teamId"
    let interestId = "interestId"
    let cellId = "cellId"
    
    var interests = [CreateInterests]()
    let interestsService = InterestServices()
    let createService = CreateServices()
    
    var descriptions = ["Home Redesign", "Road trip", "A foodie's weakness"]
    var pursuitImages = [#imageLiteral(resourceName: "home-remodel"), #imageLiteral(resourceName: "ghost"), #imageLiteral(resourceName: "food")]
    
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
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "back-arrow").withRenderingMode(.alwaysOriginal), for: .normal)
        button.contentMode = .scaleAspectFill
        button.addTarget(self, action: #selector(handleCancel), for: .touchUpInside)
        return button
    }()
    
    lazy var nextLabel : UIButton = {
       let button = UIButton()
        button.setTitle("Send", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.contentHorizontalAlignment = .right
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
        tv.font = UIFont.systemFont(ofSize: 14)
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()
    
    let captionUnderline : UIView = {
        let view = UIView()
        view.backgroundColor = .black
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
    
    let pursuitsCollectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    var isCreate = false
    
    var createDetail : CreateDetail?
    
    func getCaptureDetail(){
        createService.getCreateDetail { (detailData) in
            DispatchQueue.main.async {
                self.createDetail = detailData
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
    
    func setupPursuitCollectionView(){
        pursuitsCollectionView.delegate = self
        pursuitsCollectionView.dataSource = self
        pursuitsCollectionView.register(SavePopoverCells.self, forCellWithReuseIdentifier: cellId)
        
        scrollView.addSubview(pursuitsLabel)
        scrollView.addSubview(pursuitsCollectionView)
        scrollView.addSubview(createNewLabel)
        
        pursuitsLabel.anchor(top: keyPostSwitch.bottomAnchor, left: scrollView.leftAnchor, bottom: nil, right: nil, paddingTop: 48, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: pursuitsLabel.intrinsicContentSize.width, height: 16)
        pursuitsCollectionView.anchor(top: pursuitsLabel.bottomAnchor, left: scrollView.leftAnchor, bottom: nil, right: scrollView.safeAreaLayoutGuide.rightAnchor, paddingTop: 24, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 250)
        createNewLabel.anchor(top: nil, left: nil, bottom: nil, right: scrollView.safeAreaLayoutGuide.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 12, width: 120, height: 34)
        createNewLabel.centerYAnchor.constraint(equalTo: pursuitsLabel.centerYAnchor).isActive = true
        
    }
    
    func setupInterestsCollectionView(){
        interestsCollectionView.delegate = self
        interestsCollectionView.dataSource = self
        interestsCollectionView.register(CreateInterestsCells.self, forCellWithReuseIdentifier: interestId)
        
        view.addSubview(interestsLabel)
        view.addSubview(interestsCollectionView)
        
        interestsLabel.isHidden = true
        interestsCollectionView.isHidden = true
        
        interestsLabel.anchor(top: privatePostSwitch.bottomAnchor, left: view.leftAnchor, bottom: nil, right: nil, paddingTop: 48, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: interestsLabel.intrinsicContentSize.width, height: 16)
        interestsCollectionView.anchor(top: interestsLabel.bottomAnchor, left: scrollView.leftAnchor, bottom: nil, right: scrollView.safeAreaLayoutGuide.rightAnchor, paddingTop: 24, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 40)
    }
    
    func setupTeamCollectionView(){
        teamCollectionView.delegate = self
        teamCollectionView.dataSource = self
        teamCollectionView.register(TeamCells.self, forCellWithReuseIdentifier: teamId)
        
        view.addSubview(inviteLabel)
        view.addSubview(teamCollectionView)
        view.addSubview(privateLabel)
        view.addSubview(privatePostSwitch)
        
        inviteLabel.isHidden = true
        teamCollectionView.isHidden = true
        privateLabel.isHidden = true
        privatePostSwitch.isHidden = true
        
        inviteLabel.anchor(top: pursuitsCollectionView.bottomAnchor, left: scrollView.leftAnchor, bottom: nil, right: nil, paddingTop: 48, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: inviteLabel.intrinsicContentSize.width, height: 16)
        teamCollectionView.anchor(top: inviteLabel.bottomAnchor, left: scrollView.leftAnchor, bottom: nil, right: scrollView.safeAreaLayoutGuide.rightAnchor, paddingTop: 18, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 90)
        privateLabel.anchor(top: teamCollectionView.bottomAnchor, left: view.leftAnchor, bottom: nil, right: nil, paddingTop: 32, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: privateLabel.intrinsicContentSize.width, height: 20)
        privatePostSwitch.centerYAnchor.constraint(equalTo: privateLabel.centerYAnchor).isActive = true
        privatePostSwitch.anchor(top: nil, left: nil, bottom: nil, right: scrollView.safeAreaLayoutGuide.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 80, height: 24)
    }

    func setupScrollView(){
        view.addSubview(scrollView)
        scrollView.addSubview(captionLabel)
        scrollView.addSubview(captionUnderline)
        scrollView.addSubview(keyPostLabel)
        scrollView.addSubview(keyPostSwitch)
        
        scrollView.anchor(top: backgroundFill.bottomAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        captionLabel.anchor(top: scrollView.topAnchor, left: scrollView.leftAnchor, bottom: nil, right: scrollView.safeAreaLayoutGuide.rightAnchor, paddingTop: 42, paddingLeft: 12, paddingBottom: 0, paddingRight: 12, width: 0, height: captionLabel.intrinsicContentSize.height)
        captionUnderline.anchor(top: captionLabel.bottomAnchor, left: captionLabel.leftAnchor, bottom: nil, right: scrollView.safeAreaLayoutGuide.rightAnchor, paddingTop: 12, paddingLeft: 0, paddingBottom: 0, paddingRight: 12, width: 0, height: 0.5)
        keyPostLabel.anchor(top: captionUnderline.bottomAnchor, left: scrollView.leftAnchor, bottom: nil, right: nil, paddingTop: 48, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: keyPostLabel.intrinsicContentSize.width, height: 20)
        keyPostSwitch.centerYAnchor.constraint(equalTo: keyPostLabel.centerYAnchor).isActive = true
        keyPostSwitch.anchor(top: nil, left: nil, bottom: nil, right: scrollView.safeAreaLayoutGuide.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 80, height: 24)
        
        setupPursuitCollectionView()
        setupTeamCollectionView()
        setupInterestsCollectionView()
    }
    
    func setupTopBar(){
        backgroundFill.backgroundColor = .white
        
        view.addSubview(alertView)
        view.addSubview(backgroundFill)
        view.addSubview(backButton)
        view.addSubview(backBackground)
        view.addSubview(createLabel)
        view.addSubview(captureCollectionView)
        view.addSubview(nextLabel)
        
        captureCollectionView.delegate = self
        captureCollectionView.dataSource = self
        captureCollectionView.register(CaptureDetailCell.self, forCellWithReuseIdentifier: cellId)
        
        alertView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        backgroundFill.anchor(top: alertView.topAnchor, left: alertView.safeAreaLayoutGuide.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 80)
        backButton.anchor(top: nil, left: backgroundFill.leftAnchor, bottom: backgroundFill.bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 12, paddingBottom: 16, paddingRight: 0, width: 20, height: 20)
        backBackground.centerXAnchor.constraint(equalTo: backButton.centerXAnchor).isActive = true
        backBackground.centerYAnchor.constraint(equalTo: backButton.centerYAnchor).isActive = true
        backBackground.anchor(top: nil, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 38, height: 38)
        createLabel.anchor(top: nil, left: backButton.rightAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 20, paddingBottom: 0, paddingRight: 0, width: createLabel.intrinsicContentSize.width, height: createLabel.intrinsicContentSize.height)
        createLabel.centerYAnchor.constraint(equalTo: backButton.centerYAnchor).isActive = true
        nextLabel.anchor(top: nil, left: nil, bottom: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 12, width: 120, height: 34)
        nextLabel.centerYAnchor.constraint(equalTo: createLabel.centerYAnchor).isActive = true
        setupScrollView()
//        captureCollectionView.anchor(top: backgroundFill.bottomAnchor, left: alertView.leftAnchor, bottom: nil, right: alertView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: view.frame.height)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.contentSize = CGSize(width: view.frame.width, height: view.frame.height + 360)
        setupTopBar()
        getCaptureDetail()
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
    
    @objc func submitPost(){
        if createPursuitId == nil {
            submitPursuit()
        } else if createPursuitId != nil {
             createService.createPost(pursuitId: createPursuitId!, contentUrl: videoURL, thumbnailUrl: thumbnailImage, posts_description: captionLabel.text, is_keyPost: is_keyPost, is_public: is_public)
            addTeam()
        }
        
//        let appDelegate = UIApplication.shared.delegate! as! AppDelegate
//        appDelegate.window = UIWindow()
//        appDelegate.window?.rootViewController = MainTabController()
//        appDelegate.window?.makeKeyAndVisible()
//        self.dismiss(animated: true, completion: nil)
    }
    
    var createPursuitId : Int?
    var is_public = 0
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
    
    @objc func submitPursuit(){
        createService.createPursuit(interestId: createInterestId, thumbnailUrl: thumbnailImage, pursuitDescription: captionLabel.text, is_public: is_public)
        createService.getUserPursuitsId { (returnPursuit) in
            DispatchQueue.main.async{
                self.createService.createPost(pursuitId: (returnPursuit.pursuitId)!, contentUrl: self.videoURL, thumbnailUrl: self.thumbnailImage, posts_description: self.captionLabel.text, is_keyPost: self.is_keyPost, is_public: self.is_public)
                if !self.team.isEmpty {
                    for value in self.team {
                        self.createService.addTeam(pursuitId: (returnPursuit.pursuitId)!, userId: value.userId)
                    }
                }
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
        switch collectionView {
        case teamCollectionView:
            return createDetail?.team?.count ?? 0
        case interestsCollectionView:
            return createDetail?.interests?.count ?? 0
        case pursuitsCollectionView:
            return createDetail?.pursuits?.count ?? 0
        default:
            return 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        switch collectionView {
        case teamCollectionView:
            return UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
        default:
            return UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 12)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch collectionView {
        case teamCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: teamId, for: indexPath) as! TeamCells
            cell.accessDetailView = self
            cell.team = createDetail?.team?[indexPath.item]
            return cell
        case interestsCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: interestId, for: indexPath) as! CreateInterestsCells
            cell.accessDetailView = self
            cell.interest = createDetail?.interests?[indexPath.item]
            return cell
        case pursuitsCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! SavePopoverCells
            cell.pursuit = createDetail?.pursuits?[indexPath.item]
            return cell
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: pursuitId, for: indexPath) as! CreatePursuitsCells
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch collectionView {
        case pursuitsCollectionView:
            createPursuitId = createDetail?.pursuits?[indexPath.item].pursuitId ?? 0
        case interestsCollectionView:
            createInterestId = createDetail?.interests?[indexPath.item].interestId ?? 0
        default:
            assert(false, "Not a valid selection")
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch collectionView {
        case teamCollectionView:
            return CGSize(width: 80, height: 80)
        case pursuitsCollectionView:
            return CGSize(width: 200, height: 220)
        case interestsCollectionView:
            if !interests.isEmpty {
                if let interest_name = interests[indexPath.item].interest_name {
                    let approximateHeightOfLabel = view.frame.width - 20 - 8
                    let size = CGSize(width: .infinity, height: approximateHeightOfLabel)
                    let attributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12)]
                    let estimatedFrame = NSString(string: interest_name).boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: attributes, context: nil)
                    return CGSize(width: estimatedFrame.width + 50, height: 43)
                }
            }
            return CGSize(width: view.frame.width / 4, height: 40)
        default:
            return CGSize(width: view.frame.width, height: view.frame.height / 1.6)
        }
        
    }
}
