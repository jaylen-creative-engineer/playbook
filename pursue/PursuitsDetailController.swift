//
//  PursuitsDetailController.swift
//  pursue
//
//  Created by Jaylen Sanders on 10/17/17.
//  Copyright © 2017 Glory. All rights reserved.
//

import UIKit
import XLActionController
import JHTAlertController
import Hero
import ParallaxHeader

class PursuitsDetailController : UICollectionViewController {
    
    
    let headerId = "headerId"
    let commentId = "commentId"
    let principleId = "principleId"
    let postId = "postId"
    let relatedId = "relatedId"
    let discussionId = "discussionId"
    let pursuitId = "discussionPursuitId"
    let cellId = "cellId"
    let nextId = "nextId"
    let stepId = "stepId"
    let challengeId = "challengeId"
    let followId = "followId"
    
    var isImageView = false
    var isPursuitView = false
    var isPrinciplesView = false
    var isDiscussionView = false
    
    let homeService = HomeServices()
        
    func imageView(postId : String){
        isImageView = true
        isPursuitView = false
        isPrinciplesView = false
        isDiscussionView = false
        
        homeService.getPost(postId: postId) { (post) in
            
        }
        
        collectionView?.reloadData()
    }
    
    func stepView(stepId : String){
        isImageView = false
        isPursuitView = true
        isPrinciplesView = false
        isDiscussionView = false
        
        homeService.getStep(stepId: stepId) { (step) in
            
        }
        collectionView?.reloadData()
    }
    
    func principleView(principleId : String){
        isImageView = false
        isPursuitView = false
        isPrinciplesView = true
        isDiscussionView = false
        
        homeService.getPrinciple(principleId: principleId) { (principle) in
            
        }
        
        collectionView?.reloadData()
    }
    
    @objc func goBack() {
        navigationController?.popViewController(animated: true)
    }
    
    func showStepOptions(){
        let customAlert = CustomDetailView()
        customAlert.providesPresentationContextTransitionStyle = true
        customAlert.definesPresentationContext = true
        customAlert.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        customAlert.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        self.showDetailViewController(customAlert, sender: self)
    }
    
    lazy var floatingCamera : UIButton = {
        let button = UIButton()
        button.backgroundColor = .black
        button.layer.cornerRadius = 20
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(addSteps), for: .touchUpInside)
        return button
    }()
    
    lazy var stepIcon : UIImageView = {
        let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "add").withRenderingMode(.alwaysTemplate)
        iv.tintColor = .white
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFill
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(addSteps))
        iv.addGestureRecognizer(tap)
        return iv
    }()
    
    lazy var backButton : UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "back-arrow").withRenderingMode(.alwaysOriginal), for: .normal)
        button.addTarget(self, action: #selector(goBack), for: .touchUpInside)
        return button
    }()
    
    let topBackground : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.init(white: 0.8, alpha: 0.3)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 15
        return view
    }()
    
    @objc func addSteps(){
        let actionController = SkypeActionController()
        
        actionController.addAction(Action("Start a Discussion", style: .default, handler: { action in
            // do something useful
        }))
        actionController.addAction(Action("Share", style: .default, handler: { action in
            // do something useful
        }))
        actionController.addAction(Action("Cancel", style: .default, handler: {action in
            
        }))
        present(actionController, animated: true, completion: nil)
    }
    
    func setupBackButton(){
        view.addSubview(topBackground)
        topBackground.addSubview(backButton)
        
        topBackground.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.safeAreaLayoutGuide.leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: 30, height: 30)
        backButton.anchor(top: nil, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 25, height: 25)
        backButton.centerXAnchor.constraint(equalTo: topBackground.centerXAnchor).isActive = true
        backButton.centerYAnchor.constraint(equalTo: topBackground.centerYAnchor).isActive = true
        
    }
    
    private func setupFloatingCamera(){
        let guide = view.safeAreaLayoutGuide
        view.addSubview(floatingCamera)
        floatingCamera.addSubview(stepIcon)
        
        floatingCamera.anchor(top: nil, left: nil, bottom: guide.bottomAnchor, right: guide.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 12, paddingRight: 12, width: 40, height: 40)
        
        stepIcon.anchor(top: nil, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 20, height: 20)
        stepIcon.centerXAnchor.constraint(equalTo: floatingCamera.centerXAnchor).isActive = true
        stepIcon.centerYAnchor.constraint(equalTo: floatingCamera.centerYAnchor).isActive = true
        setupBackButton()
    }
    
    func showPursuitsDetail(){
        handleChangeToDetail(viewType: "isPursuitDetail")
    }
    
    func showDiscussionDetail(){
        handleChangeToDetail(viewType: "isDiscussionDetail")
    }
    
    func showUserProfile(){
//        let userProfileController = ProfileController(collectionViewLayout: UICollectionViewFlowLayout())
//        navigationController?.pushViewController(userProfileController, animated: true)
    }
    
    func showPostDetailForPost(){
        handleChangeToDetail(viewType: "isImageDetail")
    }
    
    func handleChangeToDetail(viewType : String) {
        switch viewType {
        case "isPrinciplesDetail":
            let detail = PursuitsDetailController(collectionViewLayout: UICollectionViewFlowLayout())
            navigationController?.pushViewController(detail, animated: true)
        case "isStepDetail":
            let detail = PursuitsDetailController(collectionViewLayout: UICollectionViewFlowLayout())
            navigationController?.pushViewController(detail, animated: true)
        case "isImageDetail":
            let detail = PursuitsDetailController(collectionViewLayout: UICollectionViewFlowLayout())
            navigationController?.pushViewController(detail, animated: true)
        default:
            assert(false, "Not a valid view type")
        }
    }
    
    lazy var containerView: CommentInputAccessoryView = {
        let container = CGRect(x: 0, y: 0, width: view.frame.width, height: 50)
        let commentInputAccessoryView = CommentInputAccessoryView(frame: container)
        return commentInputAccessoryView
    }()
    
    override var inputAccessoryView: UIView? {
        get {
            return containerView
        }
    }
    
    override var canBecomeFirstResponder: Bool {
        return true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        tabBarController?.tabBar.isHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView?.register(PursuitPrinciple.self, forCellWithReuseIdentifier: principleId)
        collectionView?.register(PostComments.self, forCellWithReuseIdentifier: commentId)
        collectionView?.register(DetailSteps.self, forCellWithReuseIdentifier: pursuitId)
        collectionView?.register(PursuitsDetailHeader.self, forCellWithReuseIdentifier: headerId)
        
        collectionView?.backgroundColor = .white
        collectionView?.contentInset = UIEdgeInsetsMake(0, 0, 105, 0)
        collectionView?.showsVerticalScrollIndicator = false
        containerView.isHidden = true
        
        setupCollectionViewHeader()
    }
    
    func setupCollectionViewHeader(){
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "music").withRenderingMode(.alwaysOriginal)
        imageView.contentMode = .scaleAspectFill
        
        let leftTapView = UIImageView()
        leftTapView.translatesAutoresizingMaskIntoConstraints = false
        
        let rightTapView = UIImageView()
        rightTapView.translatesAutoresizingMaskIntoConstraints = false
        
        let label = UILabel()
        label.text = "Label"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 32, weight: UIFont.Weight.init(25))
        
        let subLabel = UILabel()
        subLabel.text = "Simple way to add parallax header to UIScrollView or it's subclasses."
        subLabel.font = UIFont.boldSystemFont(ofSize: 16)
        subLabel.numberOfLines = 2
        subLabel.textColor = .white
        
        let viewMoreLabel = UILabel()
        viewMoreLabel.text = "Scroll Down For Details"
        viewMoreLabel.textColor = .white
        viewMoreLabel.font = UIFont.systemFont(ofSize: 16)
        
        let playBackground = CardView()
        playBackground.layer.cornerRadius = 20
        playBackground.translatesAutoresizingMaskIntoConstraints = false
        playBackground.backgroundColor = .white
        playBackground.layer.masksToBounds = true
        
        let playIcon = UIImageView()
        playIcon.image = #imageLiteral(resourceName: "view-more").withRenderingMode(.alwaysOriginal)
        playIcon.contentMode = .scaleAspectFill
        playIcon.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(imageView)
        imageView.addSubview(leftTapView)
        imageView.addSubview(rightTapView)
        imageView.addSubview(label)
        imageView.addSubview(subLabel)
        imageView.addSubview(playBackground)
        imageView.addSubview(playIcon)
        imageView.addSubview(viewMoreLabel)
        
        leftTapView.anchor(top: imageView.topAnchor, left: imageView.leftAnchor, bottom: imageView.bottomAnchor, right: imageView.centerXAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        rightTapView.anchor(top: imageView.topAnchor, left: imageView.centerXAnchor, bottom: imageView.bottomAnchor, right: imageView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        label.anchor(top: leftTapView.centerYAnchor, left: leftTapView.leftAnchor, bottom: nil, right: nil, paddingTop: 24, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: label.intrinsicContentSize.width, height: label.intrinsicContentSize.height)
        subLabel.anchor(top: label.bottomAnchor, left: label.leftAnchor, bottom: nil, right: imageView.rightAnchor, paddingTop: 12, paddingLeft: 0, paddingBottom: 0, paddingRight: 18, width: 0, height: 40)
        playBackground.anchor(top: subLabel.bottomAnchor, left: subLabel.leftAnchor, bottom: nil, right: nil, paddingTop: 42, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 40, height: 40)
        playIcon.anchor(top: nil, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 15, height: 15)
        playIcon.centerXAnchor.constraint(equalTo: playBackground.centerXAnchor).isActive = true
        playIcon.centerYAnchor.constraint(equalTo: playBackground.centerYAnchor).isActive = true
        viewMoreLabel.anchor(top: playBackground.bottomAnchor, left: playBackground.leftAnchor, bottom: nil, right: nil, paddingTop: 84, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: viewMoreLabel.intrinsicContentSize.width, height: viewMoreLabel.intrinsicContentSize.height)
        
        
        collectionView?.parallaxHeader.view = imageView
        collectionView?.parallaxHeader.height = view.frame.height
        collectionView?.parallaxHeader.minimumHeight = 0
        collectionView?.parallaxHeader.mode = .topFill
        collectionView?.alwaysBounceVertical = true
        setupBackButton()
    }
    
    var postDescription = ""
}

extension PursuitsDetailController : UICollectionViewDelegateFlowLayout {
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch true {
        case isPrinciplesView:
            return 4
        case isPursuitView:
            return 4
        case isImageView:
            return 1
        default:
            assert(false, "Not a valid view")
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch true {
        case isPursuitView:
            switch indexPath.item {
            case 0:
                let approximateWidthOfCell = view.frame.width
                let size = CGSize(width: approximateWidthOfCell, height: .infinity)
                let attributes = [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 18)]
                let estimatedFrame = NSString(string: postDescription).boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: attributes, context: nil)
                return CGSize(width: view.frame.width, height: estimatedFrame.height + 80)
            case 1:
                return CGSize(width: view.frame.width, height: 390)
            case 2:
                return CGSize(width: view.frame.width, height: 330)
            case 3:
                let approximateWidthOfCell = view.frame.width
                let size = CGSize(width: approximateWidthOfCell, height: .infinity)
                let attributes = [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 18)]
                let estimatedFrame = NSString(string: postDescription).boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: attributes, context: nil)
                return CGSize(width: view.frame.width, height: estimatedFrame.height + 80)
            default:
                assert(false, "Not a valid cell")
            }
        case isPrinciplesView:
            switch indexPath.item {
            case 0:
                let approximateWidthOfCell = view.frame.width
                let size = CGSize(width: approximateWidthOfCell, height: .infinity)
                let attributes = [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 18)]
                let estimatedFrame = NSString(string: postDescription).boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: attributes, context: nil)
                return CGSize(width: view.frame.width, height: estimatedFrame.height + 80)
            case 1:
                return CGSize(width: view.frame.width, height: 390)
            case 2:
                return CGSize(width: view.frame.width, height: 330)
            case 3:
                let approximateWidthOfCell = view.frame.width
                let size = CGSize(width: approximateWidthOfCell, height: .infinity)
                let attributes = [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 18)]
                let estimatedFrame = NSString(string: postDescription).boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: attributes, context: nil)
                return CGSize(width: view.frame.width, height: estimatedFrame.height + 80)
            default:
                assert(false, "Not a valid cell")
            }
        case isImageView:
            return CGSize(width: view.frame.width, height: view.frame.height * 1.5)
        default:
            assert(false, "Not a valid view")
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch true {
        case isPrinciplesView:
            switch indexPath.item {
            case 0:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: headerId, for: indexPath) as! PursuitsDetailHeader
                cell.pursuitsDetailController = self
                return cell
            case 1:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: pursuitId, for: indexPath) as! DetailSteps
                return cell
            case 2:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: principleId, for: indexPath) as! PursuitPrinciple
                return cell
            case 3:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: commentId, for: indexPath) as! PostComments
                return cell
            default:
                assert(false, "Not a valid cell")
            }
        case isPursuitView:
            switch indexPath.item {
            case 0:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: headerId, for: indexPath) as! PursuitsDetailHeader
                cell.pursuitsDetailController = self
                return cell
            case 1:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: pursuitId, for: indexPath) as! DetailSteps
                return cell
            case 2:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: principleId, for: indexPath) as! PursuitPrinciple
                return cell
            case 3:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: commentId, for: indexPath) as! PostComments
                return cell
            default:
                assert(false, "Not a valid cell")
            }
        case isImageView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: headerId, for: indexPath) as! PursuitsDetailHeader
            cell.pursuitsDetailController = self
            return cell
        default:
            assert(false, "Not a valid view type")
        }
    }
    
}
