//
//  DiscussionDetailController.swift
//  pursue
//
//  Created by Jaylen Sanders on 12/9/17.
//  Copyright © 2017 Glory. All rights reserved.
//

import UIKit
import XLActionController

class DiscussionDetailController : UICollectionViewController, UICollectionViewDelegateFlowLayout, DiscussionDetailDelegate {
    
    let headerId = "headerId"
    let commentId = "commentId"
    let likeId = "likeId"
    let postId = "postId"
    let relatedId = "relatedId"
    let principleId = "principleId"
    let pursuitsId = "pursuitsId"
    var isAboutView = true
    var isCommentsView = false
    var isPursuitsView = false
    var isPrinciplesView = false
    
    func goBack() {
        navigationController?.popViewController(animated: true)
    }
    
    func pursuitsActive() {
        isAboutView = false
        isCommentsView = false
        isPursuitsView = true
        isPrinciplesView = false
        collectionView?.reloadData()
    }
    
    func principlesActive() {
        isAboutView = false
        isCommentsView = false
        isPursuitsView = false
        isPrinciplesView = true
        collectionView?.reloadData()
    }
    
    func changeAbout() {
        isAboutView = true
        isCommentsView = false
        isPursuitsView = false
        isPrinciplesView = false
        collectionView?.reloadData()
    }
    
    func changeComment() {
        isAboutView = false
        isCommentsView = true
        isPursuitsView = false
        isPrinciplesView = false
        collectionView?.reloadData()
    }
    
    let cellId = "cellId"
    
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
        case isCommentsView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: commentId, for: indexPath) as! PostComments
            return cell
        case isPursuitsView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: pursuitsId, for: indexPath) as! DiscussionPursuitsView
            return cell
        case isPrinciplesView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: principleId, for: indexPath) as! DiscussionPrinciples
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
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath) as! DiscussionDetailHeader
        header.delegate = self
        header.detailController = self
        return header
    }
    
    func showUserProfile(){
    
    }
    
    func showPostDetail(){
        let layout = UICollectionViewFlowLayout()
        let postDetilController = PostDetailController(collectionViewLayout: layout)
        navigationController?.pushViewController(postDetilController, animated: true)
    }
    
    func reportPost() {
        let actionController = SkypeActionController()
        actionController.addAction(Action("REPORT", style: .default, handler: { action in
            // do something useful
        }))
        actionController.addAction(Action("CANCEL", style: .default, handler: {action in
            
        }))
        present(actionController, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView?.register(PostView.self, forCellWithReuseIdentifier: postId)
        collectionView?.register(PostComments.self, forCellWithReuseIdentifier: commentId)
        collectionView?.register(DiscussionPursuitsView.self, forCellWithReuseIdentifier: pursuitsId)
        collectionView?.register(DiscussionPrinciples.self, forCellWithReuseIdentifier: principleId)
        collectionView?.register(DiscussionDetailHeader.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerId)
        collectionView?.backgroundColor = .white
    }
}
