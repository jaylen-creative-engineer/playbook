//
//  HomeRowContainer.swift
//  pursue
//
//  Created by Jaylen Sanders on 11/27/17.
//  Copyright © 2017 Glory. All rights reserved.
//

import UIKit
import Hero
import KWTransition
import Motion
import ParallaxHeader

class HomeController : UICollectionViewController {
    
    let notificationId = "notificationId"
    let headerId = "headerId"
    let postId = "postId"
    let feedId = "feedId"
    let profileId = "profileId"

    var isFirstLaunch = false
    
    let homeServices = HomeServices()
    let detailController = PostDetailController()

    lazy var userPhoto : UIImageView = {
       let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "samuel-l").withRenderingMode(.alwaysOriginal)
        iv.contentMode = .scaleAspectFill
        iv.layer.cornerRadius = 12.5
        iv.layer.masksToBounds = true
        iv.isUserInteractionEnabled = true
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(goToProfileController))
        tap.numberOfTapsRequired = 1
        iv.addGestureRecognizer(tap)
        return iv
    }()
    
    let navUnderlineView : UIView = {
       let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    lazy var searchButton : UIButton = {
       let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "search_unselected").withRenderingMode(.alwaysOriginal), for: .normal)
        button.contentMode = .scaleAspectFill
        button.motionIdentifier = "searchButton"
        button.addTarget(self, action: #selector(goToSearchController), for: .touchUpInside)
        return button
    }()
    
    lazy var settingsButton : UIButton = {
        let button = UIButton()
        button.setTitle("•••", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.init(25))
        button.addTarget(self, action: #selector(handleSettings), for: .touchUpInside)
        return button
    }()
    
    lazy var homeMenuBar : HomeMenuBar = {
       let hb = HomeMenuBar()
        hb.accessHomeController = self
        return hb
    }()
    
    lazy var notificationsBar : NotificationHeader = {
       let header = NotificationHeader()
        header.accessHomeController = self
//        header.accessNotificationsContainer = self
        return header
    }()
    
    var accessNotificationsContainer : NotificationsContainer?
    
    func scrollToMenuIndex(menuIndex : Int){
        accessNotificationsContainer?.scrollToItem(menuIndex: menuIndex)
    }
    
    func handleCameraTap(){
        let photoSelectorController = SelectCameraController()
        let navController = UINavigationController(rootViewController: photoSelectorController)
        present(navController, animated: true, completion: nil)
    }
    
    func changeToChatDetail(){
        let chatDetail = ChatDetailController()
        navigationController?.pushViewController(chatDetail, animated: true)
    }
    
    @objc func handleSettings(){
        let customAlert = CustomSettingsView()
        customAlert.providesPresentationContextTransitionStyle = true
        customAlert.definesPresentationContext = true
        customAlert.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        customAlert.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        self.showDetailViewController(customAlert, sender: self)
    }
    
    func handleChatPageChange(){
        notificationsBar.isHidden = false
        homeLabel.isHidden = true
        usernameLabel.isHidden = true
        searchButton.isHidden = false
        settingsButton.isHidden = true
        
        homeMenuBar.chatButton.setImage(#imageLiteral(resourceName: "chat_selected").withRenderingMode(.alwaysOriginal), for: .normal)
        homeMenuBar.homeButton.setImage(#imageLiteral(resourceName: "home_unselected").withRenderingMode(.alwaysOriginal), for: .normal)
        
        let indexPath = IndexPath(item: 1, section: 0)
        collectionView?.scrollToItem(at: indexPath, at: [], animated: false)
    }
    
    func handleHomeTap(){
        notificationsBar.isHidden = true
        homeLabel.isHidden = false
        usernameLabel.isHidden = true
        searchButton.isHidden = false
        settingsButton.isHidden = true
        
        homeMenuBar.chatButton.setImage(#imageLiteral(resourceName: "chat").withRenderingMode(.alwaysOriginal), for: .normal)
        homeMenuBar.homeButton.setImage(#imageLiteral(resourceName: "home_selected").withRenderingMode(.alwaysOriginal), for: .normal)
        
        let indexPath = IndexPath(item: 0, section: 0)
        collectionView?.scrollToItem(at: indexPath, at: [], animated: false)
    }
    
    func handleProfileTap(){
        notificationsBar.isHidden = true
        homeLabel.isHidden = true
        usernameLabel.isHidden = false
        searchButton.isHidden = true
        settingsButton.isHidden = false
        
        homeMenuBar.chatButton.setImage(#imageLiteral(resourceName: "chat").withRenderingMode(.alwaysOriginal), for: .normal)
        homeMenuBar.homeButton.setImage(#imageLiteral(resourceName: "home_unselected").withRenderingMode(.alwaysOriginal), for: .normal)

        let indexPath = IndexPath(item: 2, section: 0)
        collectionView?.scrollToItem(at: indexPath, at: [], animated: false)
    }
    
    func setupCustomTabBar(){
        view.addSubview(homeMenuBar)
        homeMenuBar.anchor(top: nil, left: nil, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 280, height: 58)
        homeMenuBar.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    func setupCollectionView(){
        if let flowLayout = collectionView?.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.scrollDirection = .horizontal
            flowLayout.minimumLineSpacing = 0
        }
        
        collectionView?.register(FeedCell.self, forCellWithReuseIdentifier: feedId)
        collectionView?.register(ProfileContainer.self, forCellWithReuseIdentifier: profileId)
        collectionView?.register(NotificationsContainer.self, forCellWithReuseIdentifier: notificationId)
        collectionView?.register(HomeHeader.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerId)
        collectionView?.backgroundColor = .white
        collectionView?.showsHorizontalScrollIndicator = false
        collectionView?.contentInset = UIEdgeInsetsMake(60, 0, 0, 0)
        collectionView?.isScrollEnabled = false
        setupCustomTabBar()
        handleHomeTap()
    }
    
    let homeLabel = UILabel()
    let usernameLabel = UILabel()
    let navBarBackground = UIView()
    
    func setupSettings(){
        view.addSubview(settingsButton)
        settingsButton.centerYAnchor.constraint(equalTo: usernameLabel.centerYAnchor).isActive = true
        settingsButton.anchor(top: nil, left: nil, bottom: nil, right: navBarBackground.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 12, width: settingsButton.intrinsicContentSize.width, height: settingsButton.intrinsicContentSize.height)
    }

    func setupNavigationBar(){
        navBarBackground.backgroundColor = .white
        navBarBackground.translatesAutoresizingMaskIntoConstraints = false
        
        homeLabel.text = "Home"
        homeLabel.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.init(25))
        homeLabel.translatesAutoresizingMaskIntoConstraints = false
        
        usernameLabel.text = "jaylenhu27"
        usernameLabel.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.init(25))
        usernameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(navBarBackground)
        view.addSubview(navUnderlineView)
        navBarBackground.addSubview(homeLabel)
        navBarBackground.addSubview(usernameLabel)
        navBarBackground.addSubview(searchButton)
        view.addSubview(notificationsBar)
        
        navBarBackground.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 80)
        navUnderlineView.anchor(top: navBarBackground.bottomAnchor, left: navBarBackground.leftAnchor, bottom: nil, right: navBarBackground.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0.5)
        homeLabel.anchor(top: nil, left: navBarBackground.leftAnchor, bottom: navUnderlineView.topAnchor, right: nil, paddingTop: 0, paddingLeft: 12, paddingBottom: 8, paddingRight: 0, width: 60, height: homeLabel.intrinsicContentSize.height)
        searchButton.anchor(top: nil, left: nil, bottom: navUnderlineView.topAnchor, right: navBarBackground.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 6, paddingRight: 12, width: 18, height: 18)
        notificationsBar.anchor(top: nil, left: navBarBackground.leftAnchor, bottom: navUnderlineView.topAnchor, right: searchButton.leftAnchor, paddingTop: 0, paddingLeft: 12, paddingBottom: 8, paddingRight: 24, width: 0, height: homeLabel.intrinsicContentSize.height)
        usernameLabel.anchor(top: nil, left: navBarBackground.leftAnchor, bottom: navUnderlineView.topAnchor, right: searchButton.leftAnchor, paddingTop: 0, paddingLeft: 12, paddingBottom: 8, paddingRight: 32, width: 0, height: usernameLabel.intrinsicContentSize.height)
        setupSettings()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if UserDefaults.standard.value(forKey: "homeIntroPopover") == nil {
            setupIntroView()
        } else {
            dismissHomePopover()
        }
        isMotionEnabled = true
        setupNavigationBar()
        setupCollectionView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
        tabBarController?.tabBar.isHidden = true
    }
    
    // MARK: - Setup View
    
    @objc func goToSearchController(){
        let searchView = SearchController(collectionViewLayout: UICollectionViewFlowLayout())
        present(searchView, animated: true, completion: nil)
    }
    
    @objc func goToProfileController(){
        let profileView = ProfileController(collectionViewLayout: UICollectionViewFlowLayout())
        present(profileView, animated: true, completion: nil)
    }
    
    func handleChangeToDetail(transitionId : String){
        let detail = PostDetailController(collectionViewLayout: UICollectionViewFlowLayout())
        detail.imageView.motionIdentifier = transitionId
//        detail.imageView.hero.id = transitionId
        present(detail, animated: true, completion: nil)
    }
    
    // MARK: - Show first load popover
    
    lazy var alertView : UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.isUserInteractionEnabled = true
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissHomePopover))
        tap.numberOfTapsRequired = 1
        view.addGestureRecognizer(tap)
        return view
    }()
    
    lazy var backgroundView : UIView = {
       let view = UIView()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissHomePopover))
        tap.numberOfTapsRequired = 1
        view.addGestureRecognizer(tap)
        return view
    }()
    
    lazy var homeIntroLabel : UILabel = {
       let label = UILabel()
        label.text = "View Pursuits"
        label.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.init(25))
        return label
    }()
    
    lazy var pursuitsDescription : UILabel = {
       let label = UILabel()
        let attributedString = NSMutableAttributedString(string: "Stay inspired and learn steps and principles that can help you on your journey.")
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 5
        attributedString.addAttribute(NSAttributedStringKey.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, attributedString.length))
        label.attributedText = attributedString
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.numberOfLines = 2
        return label
    }()
    
    lazy var gotItButton : UIButton = {
       let button = UIButton()
        button.setTitle("Got It", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.titleLabel?.textAlignment = .justified
        button.isUserInteractionEnabled = true
        button.addTarget(self, action: #selector(dismissHomePopover), for: .touchUpInside)
        return button
    }()
    
    let underlineView = UIView()
    
    @objc func dismissHomePopover(){
        UserDefaults.standard.set("true", forKey: "homeIntroPopover")

        backgroundView.isHidden = true
        alertView.isHidden = true
        homeIntroLabel.isHidden = true
        pursuitsDescription.isHidden = true
        underlineView.isHidden = true
        gotItButton.isHidden = true
        
        self.tabBarController?.tabBar.layer.zPosition = 0
        self.tabBarController?.tabBar.isHidden = false
    }
    
    func setupIntroView() {
        self.tabBarController?.tabBar.layer.zPosition = -1
        self.tabBarController?.tabBar.isHidden = true
        alertView.layer.cornerRadius = 15
        setupIntroConstraints()
        animateView()
    }
    
    func setupIntroConstraints(){
        underlineView.backgroundColor = .lightGray
        
        view.addSubview(backgroundView)
        view.addSubview(alertView)
        view.addSubview(homeIntroLabel)
        view.addSubview(pursuitsDescription)
        view.addSubview(underlineView)
        alertView.addSubview(gotItButton)
        
        backgroundView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        backgroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 50).isActive = true
        alertView.anchor(top: nil, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 250)
        alertView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 50).isActive = true
        homeIntroLabel.anchor(top: alertView.topAnchor, left: alertView.leftAnchor, bottom: nil, right: nil, paddingTop: 12, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: homeIntroLabel.intrinsicContentSize.width, height: homeIntroLabel.intrinsicContentSize.height)
        pursuitsDescription.anchor(top: homeIntroLabel.bottomAnchor, left: homeIntroLabel.leftAnchor, bottom: nil, right: alertView.rightAnchor, paddingTop: 8, paddingLeft: 0, paddingBottom: 0, paddingRight: 12, width: 0, height: 80)
        underlineView.anchor(top: pursuitsDescription.bottomAnchor, left: alertView.leftAnchor, bottom: nil, right: alertView.rightAnchor, paddingTop: 12, paddingLeft: 12, paddingBottom: 0, paddingRight: 12, width: 0, height: 0.5)
        gotItButton.anchor(top: underlineView.bottomAnchor, left: underlineView.leftAnchor, bottom: nil, right: nil, paddingTop: 12, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: gotItButton.intrinsicContentSize.width, height: gotItButton.intrinsicContentSize.height)
    }
    
    func animateView() {
        alertView.alpha = 0;
        self.alertView.frame.origin.y = self.alertView.frame.origin.y + 50
        UIView.animate(withDuration: 0.4, animations: { () -> Void in
            self.alertView.alpha = 1.0;
            self.alertView.frame.origin.y = self.alertView.frame.origin.y - 50
        })
    }
    
}

extension HomeController : UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height - 60)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.item {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: feedId, for: indexPath) as! FeedCell
            cell.accessHomeController = self
            return cell
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: notificationId, for: indexPath) as! NotificationsContainer
            cell.accessHomeController = self
            self.accessNotificationsContainer = cell
            return cell
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: profileId, for: indexPath) as! ProfileContainer
//            self.accessNotificationsContainer = cell
            return cell
        }
    }
    
}
