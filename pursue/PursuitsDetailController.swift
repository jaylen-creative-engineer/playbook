//
//  PursuitsDetailController.swift
//  pursue
//
//  Created by Jaylen Sanders on 10/17/17.
//  Copyright © 2017 Glory. All rights reserved.
//

import UIKit

class PursuitsDetailController : UICollectionViewController, UICollectionViewDelegateFlowLayout, DetailCellChange, MessageDelegate {
    
    let headerId = "headerId"
    let commentId = "commentId"
    let likeId = "likeId"
    let postId = "postId"
    let relatedId = "relatedId"
    var isAboutView = true
    var isSavedView = false
    var isToolsView = false
    var isTeamView = false
    var isNextView = false
    var isStepsView = false
    var isChallengeView = false
    
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
        case isToolsView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: toolId, for: indexPath) as! PursuitTools
            return cell
        case isTeamView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: likeId, for: indexPath) as! PursuitTeam
            cell.accessDetailController = self
            return cell
        case isChallengeView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: challengeId, for: indexPath) as! PursuitChallenge
            cell.accessPursuitDetailController = self
            return cell
        case isNextView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: nextId, for: indexPath) as! NextPursuitCellsContainer
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
        return CGSize(width: view.frame.width, height: (view.frame.height / 2) + 100)
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath) as! PursuitsDetailHeader
        header.changeDelegate = self
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
        collectionView?.register(PursuitTools.self, forCellWithReuseIdentifier: toolId)
        collectionView?.register(NextPursuitCellsContainer.self, forCellWithReuseIdentifier: nextId)
        collectionView?.register(PursuitSteps.self, forCellWithReuseIdentifier: stepId)
        collectionView?.register(PursuitChallenge.self, forCellWithReuseIdentifier: challengeId)
        collectionView?.register(PursuitsDetailHeader.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerId)
        collectionView?.backgroundColor = .white
    }
}
