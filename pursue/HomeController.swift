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

class HomeController : UICollectionViewController, UICollectionViewDelegateFlowLayout, HomeRowImageEngagements, HomePursuitsRowDelegate, HomePrinciplesDelegate, HomeDiscussionDelegate {
    
    let cellId = "cellId"
    let secondaryId = "secondaryId"
    let customRowId = "customRowId"
    let pursuitId = "pursuitId"
    let principleId = "principleId"
    let imageCarouselId = "imageCarouselId"
    let pursuitCarouselId = "pursuitCarouselId"
    let principleCarouselId = "principleCarouselId"
    let discussionCarouselId = "discussionCarouselId"
    let imageDetailViewId = "imageDetailViewId"
    var homeController : HomeController?
    let discussionId = "discussionId"
    let labelId = "labelId"
    
    let homeCollection : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    lazy var floatingCamera : UIButton = {
        let button = UIButton()
        button.backgroundColor = .white
        button.layer.cornerRadius = 30
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(switchToCamera), for: .touchUpInside)
        return button
    }()
    
    lazy var cameraIcon : UIImageView = {
        let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "add").withRenderingMode(.alwaysOriginal)
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFill
        iv.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(switchToCamera)))
        return iv
    }()
    
    lazy var homeIcon : UIImageView = {
       let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "Pursuit-typed").withRenderingMode(.alwaysOriginal)
        iv.contentMode = .scaleAspectFill
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    @objc func switchToCamera() {
        let layout = UICollectionViewFlowLayout()
        let cameraController = SelectCameraController(collectionViewLayout: layout)
        navigationController?.present(cameraController, animated: true, completion: nil)
    }
    
    lazy var backButton : UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "back-arrow").withRenderingMode(.alwaysOriginal), for: .normal)
        button.addTarget(self, action: #selector(goBack), for: .touchUpInside)
        return button
    }()
    
    var isImageView = true
    var isPursuitView = false
    var isPrinciplesView = false
    var isDiscussionView = false
    var isExploreImageView = false
    
    func imageView(isExplore : Bool){
        if isExplore == true {
            isImageView = false
            isExploreImageView = true
            isPursuitView = false
            isPrinciplesView = false
            isDiscussionView = false
            collectionView?.reloadData()
        } else {
            isImageView = true
            isExploreImageView = false
            isPursuitView = false
            isPrinciplesView = false
            isDiscussionView = false
            collectionView?.reloadData()
        }
    }
    
    func pursuitView(){
        isImageView = false
        isPursuitView = true
        isPrinciplesView = false
        isDiscussionView = false
        
        collectionView?.reloadData()
    }
    
    func principleView(){
        isImageView = false
        isPursuitView = false
        isPrinciplesView = true
        isDiscussionView = false
        collectionView?.reloadData()
    }
    
    func discussionView(){
        isImageView = false
        isPursuitView = false
        isPrinciplesView = false
        isDiscussionView = true
        collectionView?.reloadData()
    }
    
    @objc func goBack(){
        navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBarController?.navigationController?.navigationBar.isHidden = true
        collectionView?.register(HomeRow.self, forCellWithReuseIdentifier: cellId)
        collectionView?.register(HomePursuits.self, forCellWithReuseIdentifier: pursuitId)
        collectionView?.register(HomePrinciples.self, forCellWithReuseIdentifier: principleId)
        collectionView?.register(HomeDiscussion.self, forCellWithReuseIdentifier: discussionId)
        collectionView?.register(HomeInterestsRow.self, forCellWithReuseIdentifier: labelId)
        collectionView?.register(HomePrincipleCarousel.self, forCellWithReuseIdentifier: principleCarouselId)
        collectionView?.register(HomePursuitCarousel.self, forCellWithReuseIdentifier: pursuitCarouselId)
        collectionView?.register(HomeDiscussionCarousel.self, forCellWithReuseIdentifier: discussionCarouselId)
        collectionView?.register(HomeImageCarousel.self, forCellWithReuseIdentifier: imageCarouselId)
        collectionView?.register(HomeImageDetailView.self, forCellWithReuseIdentifier: imageDetailViewId)
        collectionView?.backgroundColor = .white
        collectionView?.contentInset = UIEdgeInsetsMake(0, 0, 105, 0)
  
        setupTopBar()
    }
    
    let backgroundFill = UIView()
    
    private func setupTopBar(){
        let guide = view.safeAreaLayoutGuide
        view.addSubview(backgroundFill)
        view.addSubview(homeIcon)
        view.addSubview(cameraIcon)
        
        backgroundFill.backgroundColor = .white
        backgroundFill.anchor(top: view.topAnchor, left: guide.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: (view.frame.height / 8.5) - 5)
        cameraIcon.anchor(top: nil, left: nil, bottom: backgroundFill.bottomAnchor, right: backgroundFill.rightAnchor, paddingTop: 8, paddingLeft: 0, paddingBottom: 14, paddingRight: 22, width: 18, height: 16)
        setupBackButton()
    }
    
    private func setupBackButton(){
        let guide = view.safeAreaLayoutGuide
        
        if isImageView == true {
            backButton.isHidden = true
             homeIcon.anchor(top: nil, left: backgroundFill.leftAnchor, bottom: backgroundFill.bottomAnchor, right: nil, paddingTop: 8, paddingLeft: 28, paddingBottom: 14, paddingRight: 0, width: 50, height: 18)
        } else {
            view.addSubview(backButton)
            
            backButton.anchor(top: nil, left: guide.leftAnchor, bottom: backgroundFill.bottomAnchor, right: nil, paddingTop: 8, paddingLeft: 12, paddingBottom: 12, paddingRight: 24, width: 25, height: 25)
            homeIcon.anchor(top: nil, left: backButton.rightAnchor, bottom: backgroundFill.bottomAnchor, right: nil, paddingTop: 8, paddingLeft: 32, paddingBottom: 14, paddingRight: 0, width: 50, height: 18)
            
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
    // MARK: - Setup View
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: (view.frame.height / 8.5) - 55)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch true {
        case isImageView:
            return 5
        default:
            return 4
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func homeDiscussionTapped() {
        handleChangeToDetail(viewType: "isDiscussionDetail")
    }
    
    func homeDiscussionHeld() {
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
    
    func pursuitHeld() {
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
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch true {
        case isImageView:
            switch indexPath.item {
            case 0:
                return CGSize(width: view.frame.width, height: 75)
            case 1:
                return CGSize(width: view.frame.width, height: 510)
            case 2:
                return CGSize(width: view.frame.width, height: 390)
            case 3:
                return CGSize(width: view.frame.width, height: 430)
            case 4:
                return CGSize(width: view.frame.width, height: 430)
            default:
                assert(false, "Not a valid row")
            }
        case isExploreImageView:
            switch indexPath.item {
            case 0:
                return CGSize(width: view.frame.width, height: 510)
            case 1:
                return CGSize(width: view.frame.width, height: 390)
            case 2:
                return CGSize(width: view.frame.width, height: 430)
            case 3:
                return CGSize(width: view.frame.width, height: 430)
            default:
                assert(false, "Not a valid row")
            }
        case isPursuitView:
            switch indexPath.item {
            case 0:
                return CGSize(width: view.frame.width, height: 350)
            case 1:
                return CGSize(width: view.frame.width, height: 390)
            case 2:
                return CGSize(width: view.frame.width, height: 430)
            case 3:
                return CGSize(width: view.frame.width, height: 535)
            default:
                assert(false, "Not a valid row")
            }
        case isPrinciplesView:
            switch indexPath.item {
            case 0:
                return CGSize(width: view.frame.width, height: 400)
            case 1:
                return CGSize(width: view.frame.width, height: 430)
            case 2:
                return CGSize(width: view.frame.width, height: 430)
            case 3:
                return CGSize(width: view.frame.width, height: 535)
            default:
                assert(false, "Not a valid row")
            }
        case isDiscussionView :
            switch indexPath.item {
            case 0:
                return CGSize(width: view.frame.width, height: 290)
            case 1:
                return CGSize(width: view.frame.width, height: 390)
            case 2:
                return CGSize(width: view.frame.width, height: 430)
            case 3:
                return CGSize(width: view.frame.width, height: 535)
            default:
                assert(false, "Not a valid row")
            }
        default:
            assert(false, "Not a valid view")
        }
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch true {
        case isImageView:
            switch indexPath.item {
            case 0:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: labelId, for: indexPath) as! HomeInterestsRow
                return cell
            case 1:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! HomeRow
                cell.homeDelegate = self
                return cell
            case 2:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: principleId, for: indexPath) as! HomePrinciples
                cell.principlesDelegate = self
                return cell
            case 3:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: pursuitId, for: indexPath) as! HomePursuits
                cell.pursuitsDelegate = self
                return cell
            case 4:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: discussionId, for: indexPath) as! HomeDiscussion
                cell.delegate = self
                return cell
            default:
                assert(false, "Not a valid row")
            }
        case isExploreImageView:
            switch indexPath.item {
            case 0:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: imageCarouselId, for: indexPath) as! HomeImageCarousel
                return cell
            case 1:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: principleId, for: indexPath) as! HomePrinciples
                cell.principlesDelegate = self
                return cell
            case 2:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: pursuitId, for: indexPath) as! HomePursuits
                cell.pursuitsDelegate = self
                return cell
            case 3:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: discussionId, for: indexPath) as! HomeDiscussion
                cell.delegate = self
                return cell
            default:
                assert(false, "Not a valid row")
            }
        case isPursuitView:
            switch indexPath.item {
            case 0:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: pursuitCarouselId, for: indexPath) as! HomePursuitCarousel
                return cell
            case 1:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: principleId, for: indexPath) as! HomePrinciples
                cell.principlesDelegate = self
                return cell
            case 2:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: discussionId, for: indexPath) as! HomeDiscussion
                cell.delegate = self
                return cell
            case 3:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: imageDetailViewId, for: indexPath) as! HomeImageDetailView
                return cell
            default:
                assert(false, "Not a valid row")
            }
        case isPrinciplesView:
            switch indexPath.item {
            case 0:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: principleCarouselId, for: indexPath) as! HomePrincipleCarousel
                return cell
            case 1:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: discussionId, for: indexPath) as! HomeDiscussion
                cell.delegate = self
                return cell
            case 2:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: pursuitId, for: indexPath) as! HomePursuits
                cell.pursuitsDelegate = self
                return cell
            case 3:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: imageDetailViewId, for: indexPath) as! HomeImageDetailView
                return cell
            default:
                assert(false, "Not a valid row")
            }
        case isDiscussionView:
            switch indexPath.item {
            case 0:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: discussionCarouselId, for: indexPath) as! HomeDiscussionCarousel
                return cell
            case 1:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: principleId, for: indexPath) as! HomePrinciples
                cell.principlesDelegate = self
                return cell
            case 2:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: pursuitId, for: indexPath) as! HomePursuits
                cell.pursuitsDelegate = self
                return cell
            case 3:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: imageDetailViewId, for: indexPath) as! HomeImageDetailView
                return cell
            default:
                assert(false, "Not a valid row")
            }
        default:
            assert(false, "Not a valid view")
        }
    }
    
    func handleChangeToDetail(viewType : String) {
        switch viewType {
        case "isPrinciplesDetail":
            let detail = PursuitsDetailController(collectionViewLayout: UICollectionViewFlowLayout())
            detail.principleView()
            print("isPrinciple")
            navigationController?.pushViewController(detail, animated: true)
        case "isPursuitDetail":
            let detail = PursuitsDetailController(collectionViewLayout: UICollectionViewFlowLayout())
            detail.pursuitView()
            navigationController?.pushViewController(detail, animated: true)
        case "isImageDetail":
            let detail = PursuitsDetailController(collectionViewLayout: UICollectionViewFlowLayout())
            detail.imageView()
            navigationController?.pushViewController(detail, animated: true)
        case "isDiscussionDetail":
            let detail = PursuitsDetailController(collectionViewLayout: UICollectionViewFlowLayout())
            detail.discussionView()
            navigationController?.pushViewController(detail, animated: true)
        default:
            assert(false, "Not a valid view type")
        }
    }
    
}
