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

func + (left: CGPoint, right: CGPoint) -> CGPoint {
    return CGPoint(x: left.x + right.x, y: left.y + right.y)
}

class PursuitsDetailController : UICollectionViewController {
    
    
    let headerId = "headerId"
    let commentId = "commentId"
    let principleId = "principleId"
    let postId = "postId"
    let relatedId = "relatedId"
    let discussionId = "discussionId"
    let pursuitId = "discussionPursuitId"
    let discussionPrincipleId = "discussionPrincipleId"
    let principlePostId = "principlePostId"
    let principleCommentId = "principleCommentId"
    let principlePursuitsId = "principlePursuitsId"
    let principleDiscussionId = "principleDiscussionId"
    let cellId = "cellId"
    let nextId = "nextId"
    let stepId = "stepId"
    let toolId = "toolId"
    let challengeId = "challengeId"
    
    var isImageView = false
    var isPursuitView = false
    var isPrinciplesView = false
    var isDiscussionView = false
        
    func imageView(){
        isImageView = true
        isPursuitView = false
        isPrinciplesView = false
        isDiscussionView = false
        
        collectionView?.reloadData()
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
    
    @objc func goBack() {
        navigationController?.popViewController(animated: true)
    }
    
    func showStepOptions(){
        let actionController = SkypeActionController()
        
        actionController.addAction(Action("Report Post", style: .default, handler: { action in
            let alertController = JHTAlertController(title: "Report Post", message: "Are you sure you want to report this post?", preferredStyle: .alert)
            let cancelAction = JHTAlertAction(title: "Cancel", style: .cancel, bgColor: .white, handler: nil)
            let deleteAction = JHTAlertAction(title: "Yes", style: .default, bgColor: .white) { _ in
                print("Do something here!")
            }
            
            alertController.addAction(cancelAction)
            alertController.addAction(deleteAction)
            alertController.alertBackgroundColor = .white
            
            alertController.titleTextColor = .black
            alertController.titleFont = UIFont.boldSystemFont(ofSize: 18)
            alertController.titleViewBackgroundColor = .white
            
            alertController.messageFont = .systemFont(ofSize: 16)
            alertController.messageTextColor = .black
            
            alertController.hasRoundedCorners = false
            alertController.dividerColor = .clear
            alertController.setButtonTextColorFor(.default, to: .black)
            alertController.setButtonTextColorFor(.cancel, to: .black)
            self.present(alertController, animated: true, completion: nil)
        }))
        actionController.addAction(Action("Cancel", style: .default, handler: {action in
            
        }))
        present(actionController, animated: true, completion: nil)
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
        let guide = view.safeAreaLayoutGuide
        
        view.addSubview(backButton)
        backButton.anchor(top: guide.topAnchor, left: guide.leftAnchor, bottom: nil, right: nil, paddingTop: 16, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: 25, height: 25)
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
        
        collectionView?.register(PostView.self, forCellWithReuseIdentifier: postId)
        collectionView?.register(PursuitPrinciple.self, forCellWithReuseIdentifier: principleId)
        collectionView?.register(RelatedPost.self, forCellWithReuseIdentifier: relatedId)
        collectionView?.register(PursuitSteps.self, forCellWithReuseIdentifier: stepId)
        collectionView?.register(PostComments.self, forCellWithReuseIdentifier: commentId)
        collectionView?.register(DiscussionPursuitsView.self, forCellWithReuseIdentifier: pursuitId)
        collectionView?.register(PursuitsDetailHeader.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerId)
        collectionView?.backgroundColor = .white
        collectionView?.contentInset = UIEdgeInsetsMake(-45, 0, 135, 0)
        collectionView?.alwaysBounceVertical = true
        collectionView?.keyboardDismissMode = .interactive
        setupFloatingCamera()
    }
    
}

extension PursuitsDetailController : UICollectionViewDelegateFlowLayout {
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch true {
        case isPrinciplesView:
            return 3
        case isDiscussionView:
            return 3
        case isPursuitView:
            return 4
        case isImageView:
            return 5
        default:
            assert(false, "Not a valid view")
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch true {
        case isPursuitView:
            switch indexPath.item {
            case 0:
                return CGSize(width: view.frame.width, height: 200)
            case 1:
                return CGSize(width: view.frame.width, height: 220)
            case 2:
                return CGSize(width: view.frame.width, height: 320)
            case 3:
                return CGSize(width: view.frame.width, height: 382)
            default:
                return CGSize(width: view.frame.width, height: 120)
            }
        case isPrinciplesView:
            switch indexPath.item {
            case 0:
                return CGSize(width: view.frame.width, height: 200)
            case 1:
                return CGSize(width: view.frame.width, height: 170)
            case 2:
                return CGSize(width: view.frame.width, height: 390)
            case 3:
                return CGSize(width: view.frame.width, height: 380)
            default:
                return CGSize(width: view.frame.width, height: 120)
            }
        case isImageView:
            switch indexPath.item {
            case 0:
                return CGSize(width: view.frame.width, height: 200)
            case 1:
                return CGSize(width: view.frame.width, height: 170)
            case 2:
                return CGSize(width: view.frame.width, height: 390)
            case 3:
                return CGSize(width: view.frame.width, height: 330)
            case 4:
                return CGSize(width: view.frame.width, height: 382)
            default:
                return CGSize(width: view.frame.width, height: 120)
            }
        default:
            assert(false, "Not a valid view")
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let isTrue = true
        switch isTrue {
        case isPrinciplesView:
            switch indexPath.item {
            case 0:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: postId, for: indexPath) as! PostView
                return cell
            case 1:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: commentId, for: indexPath) as! PostComments
                return cell
            case 2:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: pursuitId, for: indexPath) as! DiscussionPursuitsView
                return cell
            default:
                assert(false, "Not a valid cell")
            }
        case isDiscussionView:
            switch indexPath.item {
            case 0:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: postId, for: indexPath) as! PostView
                return cell
            case 1:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: commentId, for: indexPath) as! PostComments
                return cell
            case 2:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: principleId, for: indexPath) as! PursuitPrinciple
                return cell
            default:
                assert(false, "Not a valid cell")
            }
        case isPursuitView:
            switch indexPath.item {
            case 0:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: postId, for: indexPath) as! PostView
                return cell
            case 1:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: stepId, for: indexPath) as! PursuitSteps
                return cell
            case 2:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: principleId, for: indexPath) as! PursuitPrinciple
                return cell
            case 3:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: relatedId, for: indexPath) as! RelatedPost
                return cell
            default:
                assert(false, "Not a valid cell")
            }
        case isImageView:
            switch indexPath.item {
            case 0:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: postId, for: indexPath) as! PostView
                return cell
            case 1:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: commentId, for: indexPath) as! PostComments
                return cell
            case 2:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: pursuitId, for: indexPath) as! DiscussionPursuitsView
                return cell
            case 3:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: principleId, for: indexPath) as! PursuitPrinciple
                return cell
            case 4:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: relatedId, for: indexPath) as! RelatedPost
                return cell
            default:
                assert(false, "Not a valid cell")
            }
        default:
            assert(false, "Not a valid view type")
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 450)
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath) as! PursuitsDetailHeader
        header.pursuitsDetailController = self
        return header
    }
    
}
