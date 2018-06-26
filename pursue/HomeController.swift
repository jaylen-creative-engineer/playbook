//
//  HomeRowContainer.swift
//  pursue
//
//  Created by Jaylen Sanders on 11/27/17.
//  Copyright © 2017 Glory. All rights reserved.
//

import UIKit
import iCarousel
import Alamofire
import SwiftyJSON
import Firebase

class HomeController : UICollectionViewController {
    
    let cellId = "cellId"
    let pursuitsId = "pursuitsId"
    let recommendId = "recommendId"
    let challengeId = "challengeId"
    let peopleId = "peopleId"
    let interestId = "interestId"
    let picksId = "picksId"
    var isImageView = true
    var isPursuitView = false
    var isPrinciplesView = false
    var isDiscussionView = false
    var isExploreImageView = false
    var isFirstLaunch = false
    
    let backgroundFill = UIView()
    let homeServices = HomeServices()
    let detailController = PursuitsDetailController()
    
    lazy var interestsBar : HomeInterestsBar = {
        let hb = HomeInterestsBar()
        hb.accessHomeController = self
        return hb
    }()
    
    let homeLabel : UILabel = {
       let label = UILabel()
        label.text = "Home"
        label.font = UIFont.systemFont(ofSize: 24, weight: UIFont.Weight.init(25))
        return label
    }()
    
    let searchBackground : UIButton = {
       let button = UIButton()
        button.backgroundColor = UIColor.rgb(red: 211, green: 211, blue: 211)
        button.layer.cornerRadius = 12
        return button
    }()
    
    let searchIcon : UIImageView = {
       let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "search_selected").withRenderingMode(.alwaysOriginal)
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    @objc func goBack(){
        navigationController?.popViewController(animated: true)
    }
    
    func scrollToMenuIndex(menuIndex: Int) {
        let indexPath = IndexPath(item: menuIndex, section: 0)
        collectionView?.scrollToItem(at: indexPath, at: [], animated: true)
    }
    
    func setupCollectionView(){
        collectionView?.register(HomePursuitsRow.self, forCellWithReuseIdentifier: pursuitsId)
        collectionView?.register(HomePicksRow.self, forCellWithReuseIdentifier: picksId)
        collectionView?.register(HomePursuitsLists.self, forCellWithReuseIdentifier: recommendId)
        collectionView?.register(HomePeople.self, forCellWithReuseIdentifier: peopleId)
        collectionView?.register(HomeInterestRow.self, forCellWithReuseIdentifier: interestId)
        collectionView?.register(HomeChallengeRow.self, forCellWithReuseIdentifier: challengeId)
        collectionView?.backgroundColor = UIColor.white
        collectionView?.isScrollEnabled = true
        collectionView?.showsVerticalScrollIndicator = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTopBar()
        setupCollectionView()
        if UserDefaults.standard.value(forKey: "homeIntroPopover") == nil {
            setupIntroView()
        } else {
            dismissHomePopover()
        }
    }
    
    func imageView(isExplore : Bool){
        isImageView = true
        isExploreImageView = false
        isPursuitView = false
        isPrinciplesView = false
        isDiscussionView = false
        collectionView?.reloadData()
    }
    
    private func setupTopBar(){
        let guide = view.safeAreaLayoutGuide
        view.addSubview(backgroundFill)
        view.addSubview(homeLabel)
        view.addSubview(searchBackground)
        view.addSubview(searchIcon)
        
        backgroundFill.backgroundColor = .white
        backgroundFill.anchor(top: view.topAnchor, left: guide.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 75)
        homeLabel.anchor(top: nil, left: backgroundFill.leftAnchor, bottom: backgroundFill.bottomAnchor, right: backgroundFill.rightAnchor, paddingTop: 0, paddingLeft: 12, paddingBottom: 5, paddingRight: 0, width: homeLabel.intrinsicContentSize.width, height: homeLabel.intrinsicContentSize.height)
        searchBackground.anchor(top: nil, left: nil, bottom: nil, right: backgroundFill.rightAnchor, paddingTop: 8, paddingLeft: 0, paddingBottom: 0, paddingRight: 12, width: 55, height: 25)
        searchBackground.centerYAnchor.constraint(equalTo: homeLabel.centerYAnchor).isActive = true
        searchIcon.anchor(top: nil, left: nil, bottom: nil, right: searchBackground.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 8, width: 13.36, height: 14)
        searchIcon.centerYAnchor.constraint(equalTo: searchBackground.centerYAnchor).isActive = true
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
    // MARK: - Setup View
    
    func principleTapped() {
//        handleChangeToDetail(viewType: "isPrinciplesDetail")
        detailController.standardView()
    }
    
    func stepTapped(){
//        handleChangeToDetail(viewType: "isStepDetail")
        detailController.standardView()
    }
    
    func pursuitTapped() {
//        handleChangeToDetail(viewType: "isPursuitDetail")
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
        let customAlert = CustomPeopleView()
        customAlert.providesPresentationContextTransitionStyle = true
        customAlert.definesPresentationContext = true
        customAlert.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        customAlert.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        self.showDetailViewController(customAlert, sender: self)
    }
    
    
    func pursuitHeld() {
        //        let customAlert = CustomAlertView()
        //        customAlert.providesPresentationContextTransitionStyle = true
        //        customAlert.definesPresentationContext = true
        //        customAlert.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        //        customAlert.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        //        self.showDetailViewController(customAlert, sender: self)
    }
    
    func showOptionClicked(){
        let customAlert = CustomOptionView()
        customAlert.providesPresentationContextTransitionStyle = true
        customAlert.definesPresentationContext = true
        customAlert.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        customAlert.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        self.showDetailViewController(customAlert, sender: self)
    }
    
    func handleChangeToDetail(viewType : String) {
        switch viewType {
        case "isPrinciplesDetail":
            let detail = PursuitsDetailController(collectionViewLayout: UICollectionViewFlowLayout())
            detail.standardView()
            navigationController?.pushViewController(detail, animated: true)
        case "isPursuitDetail":
            let detail = PursuitsDetailController(collectionViewLayout: UICollectionViewFlowLayout())
            detail.standardView()
            navigationController?.pushViewController(detail, animated: true)
        case "isStepDetail":
            let detail = PursuitsDetailController(collectionViewLayout: UICollectionViewFlowLayout())
            detail.standardView()
            navigationController?.pushViewController(detail, animated: true)
        case "isChallengeDetail":
            let detail = PursuitsDetailController(collectionViewLayout: UICollectionViewFlowLayout())
            detail.challengeView()
            navigationController?.pushViewController(detail, animated: true)
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
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 50)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       return 6
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch indexPath.item {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: pursuitsId, for: indexPath) as! HomePursuitsRow
            cell.accessHomeController = self
            return cell
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: picksId, for: indexPath) as! HomePicksRow
            cell.accessHomeController = self
            return cell
        case 2:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: recommendId, for: indexPath) as! HomePursuitsLists
            return cell
        case 3:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: peopleId, for: indexPath) as! HomePeople
            return cell
        case 4:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: interestId, for: indexPath) as! HomeInterestRow
            cell.accessHomeController = self
            return cell
        case 5:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: challengeId, for: indexPath) as! HomeChallengeRow
            cell.accessHomeController = self
            return cell
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: pursuitsId, for: indexPath) as! HomePursuitsRow
            return cell
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch indexPath.item {
        case 0:
            return CGSize(width: view.frame.width, height: 370)
        case 1:
            return CGSize(width: view.frame.width, height: 430)
        case 2:
            return CGSize(width: view.frame.width, height: 630)
        case 3:
            return CGSize(width: view.frame.width, height: 240)
        case 4:
            return CGSize(width: view.frame.width, height: 430)
        case 5:
            return CGSize(width: view.frame.width, height: 370)
        default:
            return CGSize(width: view.frame.width, height: 370)
        }
    }
}
