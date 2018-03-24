//
//  HomeRowContainer.swift
//  pursue
//
//  Created by Jaylen Sanders on 11/27/17.
//  Copyright © 2017 Glory. All rights reserved.
//

import UIKit
import XLActionController
import iCarousel
import Alamofire
import SwiftyJSON
import Instructions
import Firebase

class HomeController : UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    let cellId = "cellId"
    let labelId = "labelId"
    var isImageView = true
    var isPursuitView = false
    var isPrinciplesView = false
    var isDiscussionView = false
    var isExploreImageView = false
    var isFirstLaunch = false
    
    let backgroundFill = UIView()
    
    lazy var interestsBar : HomeInterestsBar = {
        let hb = HomeInterestsBar()
        hb.accessHomeController = self
        return hb
    }()

    @objc func goBack(){
        navigationController?.popViewController(animated: true)
    }
    
    func scrollToMenuIndex(menuIndex: Int) {
        let indexPath = IndexPath(item: menuIndex, section: 0)
        collectionView?.scrollToItem(at: indexPath, at: [], animated: true)
    }
    
    func setupCollectionView(){
        if let flowLayout = collectionView?.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.scrollDirection = .horizontal
            flowLayout.minimumLineSpacing = 0
        }
        
        collectionView?.register(HomeContainer.self, forCellWithReuseIdentifier: cellId)
        collectionView?.backgroundColor = UIColor.white
        collectionView?.contentInset = UIEdgeInsetsMake(0, 0, 105, 0)
        collectionView?.isScrollEnabled = false
    }
 
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTopBar()
        
        let launchedBefore = UserDefaults.standard.bool(forKey: "launchedBefore")
        if launchedBefore {
            print("Not first launch.")
            setupCollectionView()
        } else {
            print("First launch, setting UserDefault.")
            isFirstLaunch = !isFirstLaunch
            setupIntro()
            UserDefaults.standard.set(true, forKey: "launchedBefore")
        }
        
    }
    
    
    func setupIntro(){
        setupBottomControls()
        if let flowLayout = collectionView?.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.scrollDirection = .horizontal
            flowLayout.minimumLineSpacing = 0
        }
        interestsBar.isUserInteractionEnabled = false
        collectionView?.register(PageCell.self, forCellWithReuseIdentifier: "cellId")
        collectionView?.register(StepsPage.self, forCellWithReuseIdentifier: "stepsId")
        collectionView?.register(PrinciplesPage.self, forCellWithReuseIdentifier: "principleId")
        collectionView?.isPagingEnabled = true
        collectionView?.backgroundColor = .white
        collectionView?.showsHorizontalScrollIndicator = false
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
        view.addSubview(interestsBar)
        
        backgroundFill.backgroundColor = .white
        backgroundFill.anchor(top: view.topAnchor, left: guide.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 50)
        interestsBar.anchor(top: backgroundFill.bottomAnchor, left: backgroundFill.leftAnchor, bottom: nil, right: backgroundFill.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 90)
    }


    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
   
    // MARK: - Setup View
    
    func principleTapped() {
        handleChangeToDetail(viewType: "isPrinciplesDetail")
    }
    
    func principleHeld() {
        let actionController = SkypeActionController()
        actionController.addAction(Action("Save", style: .default, handler: { action in
            // do something useful
        }))
        actionController.addAction(Action("Like", style: .default, handler: { action in
            // do something useful
        }))
        actionController.addAction(Action("Share", style: .default, handler: { action in
            let text = "This is some text that I want to share."
            let textToShare = [ text ]
            let activityViewController = UIActivityViewController(activityItems: textToShare, applicationActivities: nil)
            activityViewController.popoverPresentationController?.sourceView = self.view
            self.present(activityViewController, animated: true, completion: nil)
        }))
        actionController.addAction(Action("Cancel", style: .default, handler: {action in
            
        }))
        present(actionController, animated: true, completion: nil)
    }
    
    func homeRowImageTapped() {
        handleChangeToDetail(viewType: "isImageDetail")
    }
    
    func homeRowImageHeld() {
        let actionController = SkypeActionController()
        actionController.addAction(Action("Save", style: .default, handler: { action in
            // do something useful
        }))
        actionController.addAction(Action("Like", style: .default, handler: { action in
            // do something useful
        }))
        actionController.addAction(Action("Share", style: .default, handler: { action in
            let text = "This is some text that I want to share."
            let textToShare = [ text ]
            let activityViewController = UIActivityViewController(activityItems: textToShare, applicationActivities: nil)
            activityViewController.popoverPresentationController?.sourceView = self.view
            self.present(activityViewController, animated: true, completion: nil)
        }))
        actionController.addAction(Action("Cancel", style: .default, handler: {action in
            
        }))
        present(actionController, animated: true, completion: nil)
    }
 
    func pursuitClicked() {
        handleChangeToDetail(viewType: "isPursuitDetail")
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
            navigationController?.pushViewController(detail, animated: true)
        case "isPursuitDetail":
            let detail = PursuitsDetailController(collectionViewLayout: UICollectionViewFlowLayout())
            navigationController?.pushViewController(detail, animated: true)
        case "isImageDetail":
            let detail = PursuitsDetailController(collectionViewLayout: UICollectionViewFlowLayout())
            navigationController?.pushViewController(detail, animated: true)
        case "isDiscussionDetail":
            let detail = PursuitsDetailController(collectionViewLayout: UICollectionViewFlowLayout())
            navigationController?.pushViewController(detail, animated: true)
        default:
            assert(false, "Not a valid view type")
        }
    }
    
    // MARK: - Setup First Load Screen
 
    private let previousButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Prev", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.init(25))
        button.setTitleColor(.gray, for: .normal)
        button.addTarget(self, action: #selector(handlePrev), for: .touchUpInside)
        return button
    }()
    
    private let nextButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Next", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.init(25))
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(handleNext), for: .touchUpInside)
        return button
    }()
    
    private let pageControl: UIPageControl = {
        let pc = UIPageControl()
        pc.currentPage = 0
        pc.numberOfPages = 3
        pc.currentPageIndicatorTintColor = .black
        pc.pageIndicatorTintColor = .lightGray
        return pc
    }()
    
    private func setupBottomControls(){
        let bottomControlsStackView = UIStackView(arrangedSubviews: [previousButton, pageControl, nextButton])
        bottomControlsStackView.translatesAutoresizingMaskIntoConstraints = false
        bottomControlsStackView.distribution = .fillEqually
        
        view.addSubview(bottomControlsStackView)
        bottomControlsStackView.anchor(top: nil, left: view.safeAreaLayoutGuide.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.safeAreaLayoutGuide.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 50)
    }
    
    
    let pages = [
        Page(imageName: "person-on-phone", headerText: "Post your daily pursuits", bodyText: "Are you ready for loads and loads of fun? Don't wait any longer! We hope to see you in our stores soon."),
        Page(imageName: "heart_second", headerText: "Subscribe and get coupons on our daily events", bodyText: ""),
        Page(imageName: "leaf_third", headerText: "VIP members special services", bodyText: ""),
    ]
    
    @objc private func handlePrev() {
        let nextIndex = max(pageControl.currentPage - 1, 0)
        let indexPath = IndexPath(item: nextIndex, section: 0)
        pageControl.currentPage = nextIndex
        collectionView?.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    
    @objc private func handleNext() {
        let nextIndex = min(pageControl.currentPage + 1, pages.count - 1)
        let indexPath = IndexPath(item: nextIndex, section: 0)
        pageControl.currentPage = nextIndex
        collectionView?.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    
}

extension HomeController {
    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        let x = targetContentOffset.pointee.x
        
        pageControl.currentPage = Int(x / view.frame.width)
        
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        
        coordinator.animate(alongsideTransition: { (_) in
            self.collectionViewLayout.invalidateLayout()
            
            if self.pageControl.currentPage == 0 {
                self.collectionView?.contentOffset = .zero
            } else {
                let indexPath = IndexPath(item: self.pageControl.currentPage, section: 0)
                self.collectionView?.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
            }
            
        }) { (_) in
            
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if isFirstLaunch == true {
            return pages.count
        } else {
            return 5
        }
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        if isFirstLaunch == false {
            return 5
        } else {
            return 1
        }
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if isFirstLaunch == true {
            switch indexPath.item {
            case 0:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! PageCell
                cell.page = pages[indexPath.item]
                return cell
            case 1:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "stepsId", for: indexPath) as! StepsPage
                return cell
            case 2:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "principleId", for: indexPath) as! PrinciplesPage
                return cell
            default:
                assert(false, "Not a valid cell")
            }
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! HomeContainer
            cell.accessHomeController = self
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height)
    }
}
