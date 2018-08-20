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

class HomeController : UICollectionViewController {
    
    let cellId = "cellId"
    let headerId = "headerId"
    let labelId = "labelId"

    var isFirstLaunch = false
    var days = ["Day 1", "Day 2", "Day 3", "Day 4", "Day 5"]
    
    let backgroundFill = UIView()
    let homeServices = HomeServices()
    let detailController = PursuitsDetailController()
    
    lazy var interestsBar : HomeInterestsBar = {
        let hb = HomeInterestsBar()
        hb.accessHomeController = self
        return hb
    }()
    
    let transition = KWTransition.manager()
    
    func scrollToMenuIndex(menuIndex: Int) {
//        let indexPath = IndexPath(item: menuIndex, section: 0)
//        collectionView?.scrollToItem(at: indexPath, at: [], animated: true)
    }
    
    let contentCollectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.showsVerticalScrollIndicator = false
        return collectionView
    }()
    
    let labelCollectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    let postCollectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isScrollEnabled = true
        collectionView.isPagingEnabled = true
        
        return collectionView
    }()
    
    let homeLabel : UILabel = {
       let label = UILabel()
        label.text = "HOME"
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    
    func setupNavBar(){
        
    }
    
    func setupCollectionView(){
        collectionView?.register(HomeContainer.self, forCellWithReuseIdentifier: cellId)
        collectionView?.register(HomeHeader.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerId)
        collectionView?.backgroundColor = .white
        collectionView?.showsVerticalScrollIndicator = false
    }
    
    func setupLabelCollection(){
        view.addSubview(labelCollectionView)
        labelCollectionView.delegate = self
        labelCollectionView.dataSource = self
        labelCollectionView.register(InterestsLabelCell.self, forCellWithReuseIdentifier: labelId)
        labelCollectionView.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 50)
        
        let selectedIndexPath = IndexPath(item: 0, section: 0)
        labelCollectionView.selectItem(at: selectedIndexPath, animated: false, scrollPosition: [])
        setupPostCollection()
    }
    
    func setupPostCollection(){
        view.addSubview(postCollectionView)
        postCollectionView.delegate = self
        postCollectionView.dataSource = self
        postCollectionView.register(PursuitDayCells.self, forCellWithReuseIdentifier: cellId)
        postCollectionView.anchor(top: labelCollectionView.bottomAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
    }
    
    func setupTopBar(){
        view.addSubview(interestsBar)
        interestsBar.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 50)
    }
    
//    func setupCollectionView(){
//        if let flowLayout = collectionView?.collectionViewLayout as? UICollectionViewFlowLayout {
//            flowLayout.scrollDirection = .horizontal
//            flowLayout.minimumLineSpacing = 0
//        }
//
//        collectionView?.backgroundColor = UIColor.white
//        collectionView?.isScrollEnabled = true
//        collectionView?.register(HomeContainer.self, forCellWithReuseIdentifier: cellId)
//        collectionView?.register(HomeHeader.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerId)
//        collectionView?.backgroundColor = UIColor.white
//        collectionView?.isScrollEnabled = true
//        collectionView?.showsHorizontalScrollIndicator = false
//        hero.isEnabled = true
//        setupTopBar()
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        if UserDefaults.standard.value(forKey: "homeIntroPopover") == nil {
            setupIntroView()
        } else {
            dismissHomePopover()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
    // MARK: - Setup View
    
    func goToFeedView(){}
    
    func principleTapped() {
        detailController.standardView()
    }
    
    func stepTapped(){
        detailController.standardView()
    }
    
    func pursuitTapped() {
        detailController.standardView()
    }
    
    func challengeTapped(){
        detailController.challengeView()
    }
    
    func principleHeld() {
        
    }
    
    func homeRowImageHeld() {
        
    }
    
    func showPeople(){
        let customAlert = CustomEngagementView()
        customAlert.providesPresentationContextTransitionStyle = true
        customAlert.definesPresentationContext = true
        customAlert.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        customAlert.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        self.showDetailViewController(customAlert, sender: self)
    }
    
    func openSearchModal(){
        let searchView = CustomSearchView()
        let transition = CATransition()
        transition.duration = 0.5
        transition.type = kCATransitionPush
        transition.subtype = kCATransitionFromTop
        transition.timingFunction = CAMediaTimingFunction(name:kCAMediaTimingFunctionEaseInEaseOut)
        view.window!.layer.add(transition, forKey: kCATransition)
        
//        searchView.providesPresentationContextTransitionStyle = true
//        searchView.definesPresentationContext = true
//        searchView.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
//        searchView.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        self.showDetailViewController(searchView, sender: self)
    }
    
    func postHeld(transitionId : String) {
        let customAlert = CustomEngagementView()
        customAlert.providesPresentationContextTransitionStyle = true
        customAlert.definesPresentationContext = true
        customAlert.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        customAlert.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        self.showDetailViewController(customAlert, sender: self)
    }
    
    func showOptionClicked(){
    }
    
    func handleChangeToDetail(viewType : String, transitionId : String) {
        switch viewType {
        case "isPursuitDetail":
            let detail = PursuitsDetailController(collectionViewLayout: UICollectionViewFlowLayout())
//            detail.imageView.heroID = transitionId
            detail.standardView()
            navigationController?.pushViewController(detail, animated: true)
//            navigationController?.present(detail, animated: true, completion: nil)
        case "isChallengeDetail":
            let detail = PursuitsDetailController(collectionViewLayout: UICollectionViewFlowLayout())
//            detail.imageView.heroID = transitionId
            detail.challengeView()
            navigationController?.pushViewController(detail, animated: true)
//            navigationController?.present(detail, animated: true, completion: nil)
        default:
            assert(false, "Not a valid view type")
        }
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
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 20)
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath) as! HomeHeader
        return header
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! HomeContainer
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height)
    }
}

extension HomeController : UIViewControllerTransitioningDelegate{
    
}
