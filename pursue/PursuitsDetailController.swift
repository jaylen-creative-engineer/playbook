//
//  PursuitsDetailController.swift
//  pursue
//
//  Created by Jaylen Sanders on 10/17/17.
//  Copyright © 2017 Glory. All rights reserved.
//

import UIKit
import XLActionController

class PursuitsDetailController : UICollectionViewController, UICollectionViewDelegateFlowLayout, DetailCellChange, MessageDelegate {
    
    
    let headerId = "headerId"
    let commentId = "commentId"
    let likeId = "likeId"
    let postId = "postId"
    let relatedId = "relatedId"
    let discussionId = "discussionId"
    var isAboutView = true
    var isSavedView = false
    var isToolsView = false
    var isTeamView = false
    var isNextView = false
    var isStepsView = false
    var isChallengeView = false
    var isDiscussionView = false
    
    func goBack() {
        navigationController?.popViewController(animated: true)
    }
    
    func changeAbout() {
        isAboutView = true
        isSavedView = false
        isToolsView = false
        isTeamView = false
        isNextView = false
        isStepsView = false
        isChallengeView = false
        isDiscussionView = false
        collectionView?.reloadData()
        collectionView?.updateConstraints()
    }
    
    func changeDiscussion() {
        isAboutView = false
        isSavedView = false
        isToolsView = false
        isTeamView = false
        isNextView = false
        isStepsView = false
        isChallengeView = false
        isDiscussionView = true
        collectionView?.reloadData()
        collectionView?.updateConstraints()
    }
    
    func changeChallenge() {
        isAboutView = false
        isSavedView = false
        isToolsView = false
        isTeamView = false
        isNextView = false
        isStepsView = false
        isChallengeView = true
        isDiscussionView = false
        collectionView?.reloadData()
        collectionView?.updateConstraints()
    }
    
    func changeSaved() {
        isAboutView = false
        isSavedView = true
        isToolsView = false
        isTeamView = false
        isNextView = false
        isStepsView = false
        isChallengeView = false
        isDiscussionView = false
        collectionView?.reloadData()
        collectionView?.updateConstraints()
    }
    
    func changeTool() {
        isAboutView = false
        isSavedView = false
        isToolsView = true
        isTeamView = false
        isNextView = false
        isStepsView = false
        isChallengeView = false
        isDiscussionView = false
        collectionView?.reloadData()
        collectionView?.updateConstraints()
    }
    
    func changeTeam() {
        isAboutView = false
        isSavedView = false
        isToolsView = false
        isTeamView = true
        isNextView = false
        isStepsView = false
        isChallengeView = false
        isDiscussionView = false
        collectionView?.reloadData()
        collectionView?.updateConstraints()
    }
    
    func changeNext() {
        isAboutView = false
        isSavedView = false
        isToolsView = false
        isTeamView = false
        isNextView = true
        isStepsView = false
        isChallengeView = false
        isDiscussionView = false
        collectionView?.reloadData()
        collectionView?.updateConstraints()
    }
    
    func changeSteps() {
        isAboutView = false
        isSavedView = false
        isToolsView = false
        isTeamView = false
        isNextView = false
        isStepsView = true
        isChallengeView = false
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
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height)
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
    
    @objc func addSteps(){
        let actionController = SkypeActionController()
        actionController.addAction(Action("ADD STEPS", style: .default, handler: { action in
            // do something useful
        }))
        actionController.addAction(Action("START A DISCUSSION", style: .default, handler: { action in
            // do something useful
        }))
        actionController.addAction(Action("SHARE", style: .default, handler: { action in
            // do something useful
        }))
        actionController.addAction(Action("CANCEL", style: .default, handler: {action in
            
        }))
        present(actionController, animated: true, completion: nil)
    }
    
    private func setupFloatingCamera(){
        let guide = view.safeAreaLayoutGuide
        view.addSubview(floatingCamera)
        floatingCamera.addSubview(stepIcon)
        
        floatingCamera.anchor(top: nil, left: nil, bottom: guide.bottomAnchor, right: guide.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 12, paddingRight: 12, width: 40, height: 40)
        
        stepIcon.anchor(top: nil, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 20, height: 20)
        stepIcon.centerXAnchor.constraint(equalTo: floatingCamera.centerXAnchor).isActive = true
        stepIcon.centerYAnchor.constraint(equalTo: floatingCamera.centerYAnchor).isActive = true
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let isTrue = true
        
        switch isTrue {
        case isAboutView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: postId, for: indexPath) as! PostView
            return cell
        case isSavedView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: relatedId, for: indexPath) as! RelatedPost
            cell.accessPursuitDetailController = self
            return cell
        case isTeamView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: likeId, for: indexPath) as! PursuitTeam
            cell.accessDetailController = self
            return cell
        case isDiscussionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: discussionId, for: indexPath) as! PursuitDiscussion
            cell.accessPursuitDetailController = self
            return cell
        case isStepsView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: stepId, for: indexPath) as! PursuitSteps
            cell.accessPursuitDetailController = self
            return cell
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: postId, for: indexPath) as! PostView
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width - 10, height: (view.frame.height / 2) + 100)
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath) as! PursuitsDetailHeader
        header.delegate = self
        header.messageDelegate = self
        return header
    }
    
    func handleMessage(for cell: PursuitsDetailHeader) {
        let messageController = MessagesController()
        let navController = UINavigationController(rootViewController: messageController)
        present(navController, animated: true, completion: nil)
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
    
    func showChallengesDetail(){
        let challenge = ChallengesController(collectionViewLayout: UICollectionViewFlowLayout())
        navigationController?.pushViewController(challenge, animated: true)
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
        collectionView?.register(PursuitTeam.self, forCellWithReuseIdentifier: likeId)
        collectionView?.register(RelatedPost.self, forCellWithReuseIdentifier: relatedId)
        collectionView?.register(PursuitSteps.self, forCellWithReuseIdentifier: stepId)
        collectionView?.register(PursuitDiscussion.self, forCellWithReuseIdentifier: discussionId)
        collectionView?.register(PursuitsDetailHeader.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerId)
        collectionView?.backgroundColor = .white
        setupFloatingCamera()
    }
}
