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

class PursuitsDetailController : UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    
    let headerId = "headerId"
    let commentId = "commentId"
    let principleId = "principleId"
    let postId = "postId"
    let relatedId = "relatedId"
    let discussionId = "discussionId"
    var isAboutView = true
    var isSavedView = false
    var isToolsView = false
    var isPrincipleView = false
    var isNextView = false
    var isStepsView = false
    var isChallengeView = false
    var isDiscussionView = false
    
    @objc func goBack() {
        navigationController?.popViewController(animated: true)
    }
    
    func showStepOptions(){
        let actionController = SkypeActionController()
        actionController.addAction(Action("Update Step", style: .default, handler: { action in
            // do something useful
            let stepsDetailController = PostStepsCells()
            stepsDetailController.skillLabel.isEnabled = true
            stepsDetailController.skillLabel.textColor = .gray
        }))
        
        actionController.addAction(Action("Delete Step", style: .default, handler: { action in
            let alertController = JHTAlertController(title: "Delete Step", message: "Are you sure you want to delete this?", preferredStyle: .alert)
            let cancelAction = JHTAlertAction(title: "Cancel", style: .cancel, bgColor: .white, handler: nil)
            let deleteAction = JHTAlertAction(title: "Delete", style: .default, bgColor: .white) { _ in
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
    
    func changeAbout() {
        isAboutView = true
        isSavedView = false
        isPrincipleView = false
        isNextView = false
        isStepsView = false
        isDiscussionView = false
        collectionView?.reloadData()
        collectionView?.updateConstraints()
    }
    
    func changeDiscussion() {
        isAboutView = false
        isSavedView = false
        isPrincipleView = false
        isNextView = false
        isStepsView = false
        isDiscussionView = true
        collectionView?.reloadData()
        collectionView?.updateConstraints()
    }
    
    func changeChallenge() {
        isAboutView = false
        isSavedView = false
        isPrincipleView = false
        isNextView = false
        isStepsView = false
        isDiscussionView = false
        collectionView?.reloadData()
        collectionView?.updateConstraints()
    }
    
    func changeSaved() {
        isAboutView = false
        isSavedView = true
        isPrincipleView = false
        isNextView = false
        isStepsView = false
        isDiscussionView = false
        collectionView?.reloadData()
        collectionView?.updateConstraints()
    }
    
    func changeTool() {
        isAboutView = false
        isSavedView = false
        isPrincipleView = false
        isNextView = false
        isStepsView = false
        isDiscussionView = false
        collectionView?.reloadData()
        collectionView?.updateConstraints()
    }
    
    func changePrinciple() {
        isAboutView = false
        isSavedView = false
        isPrincipleView = true
        isNextView = false
        isStepsView = false
        isDiscussionView = false
        collectionView?.reloadData()
        collectionView?.updateConstraints()
    }
    
    func changeNext() {
        isAboutView = false
        isSavedView = false
        isPrincipleView = false
        isNextView = true
        isStepsView = false
        isDiscussionView = false
        collectionView?.reloadData()
        collectionView?.updateConstraints()
    }
    
    func changeSteps() {
        isAboutView = false
        isSavedView = false
        isPrincipleView = false
        isNextView = false
        isStepsView = true
        isDiscussionView = false
        collectionView?.reloadData()
        collectionView?.updateConstraints()
    }
    
    let cellId = "cellId"
    let nextId = "nextId"
    let stepId = "stepId"
    let toolId = "toolId"
    let challengeId = "challengeId"
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch indexPath.item {
        case 1:
            return CGSize(width: view.frame.width, height: 130)
        case 2:
            return CGSize(width: view.frame.width, height: 320)
        case 3:
            return CGSize(width: view.frame.width, height: 336)
        case 4:
            return CGSize(width: view.frame.width, height: 382)
        default:
            return CGSize(width: view.frame.width, height: 120)
        }
     
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
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
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
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
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: discussionId, for: indexPath) as! PursuitDiscussion
            return cell
        case 4:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: relatedId, for: indexPath) as! RelatedPost
            return cell
        default:
            assert(false, "Not a valid cell")
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 450)
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath) as! PursuitsDetailHeader
        return header
    }
    
    
    func showStepsDetailForSteps(for cell : PursuitSteps){
        let layout = UICollectionViewFlowLayout()
        let stepsControler = StepsDetailController(collectionViewLayout: layout)
        navigationController?.pushViewController(stepsControler, animated: true)
    }
    
    func showPursuitsDetail(){
        let pursuits = PursuitsDetailController(collectionViewLayout: UICollectionViewFlowLayout())
        navigationController?.pushViewController(pursuits, animated: true)
    }
    
    func showDiscussionDetail(){
        let discussion = DiscussionDetailController(collectionViewLayout: UICollectionViewFlowLayout())
        navigationController?.pushViewController(discussion, animated: true)
    }
    
    func showUserProfile(){
//        let userProfileController = ProfileController(collectionViewLayout: UICollectionViewFlowLayout())
//        navigationController?.pushViewController(userProfileController, animated: true)
    }
    
    func showPostDetailForPost(){
        let layout = UICollectionViewFlowLayout()
        let postDetilController = PostDetailController(collectionViewLayout: layout)
        navigationController?.pushViewController(postDetilController, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView?.register(PostView.self, forCellWithReuseIdentifier: postId)
        collectionView?.register(PursuitPrinciple.self, forCellWithReuseIdentifier: principleId)
        collectionView?.register(RelatedPost.self, forCellWithReuseIdentifier: relatedId)
        collectionView?.register(PursuitSteps.self, forCellWithReuseIdentifier: stepId)
        collectionView?.register(PursuitDiscussion.self, forCellWithReuseIdentifier: discussionId)
        collectionView?.register(PursuitsDetailHeader.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerId)
        collectionView?.backgroundColor = .white
        collectionView?.contentInset = UIEdgeInsetsMake(-45, 0, 135, 0)
        setupFloatingCamera()
    }
}
