//
//  PostDetail.swift
//  pursue
//
//  Created by Jaylen Sanders on 10/12/17.
//  Copyright © 2017 Glory. All rights reserved.
//

import UIKit

class PostDetailController : UICollectionViewController, UICollectionViewDelegateFlowLayout, PostDetailHeaderDelegate {
    
    let headerId = "headerId"
    let commentId = "commentId"
    let likeId = "likeId"
    let postId = "postId"
    let relatedId = "relatedId"
    var isAboutView = true
    var isCommentsView = false
    var isRelatedView = false
    var isLikesView = false
    
    func goBack() {
        self.dismiss(animated: true, completion: nil)
    }
    
    func didChangeToCommentsView() {
        isAboutView = false
        isCommentsView = true
        isRelatedView = false
        isLikesView = false
        
        collectionView?.reloadData()
    }
    
    func didChangeToLikesView() {
        isAboutView = false
        isCommentsView = false
        isRelatedView = false
        isLikesView = true
        
        collectionView?.reloadData()
    }
    
    func didChangeToRelatedView() {
        isAboutView = false
        isCommentsView = false
        isRelatedView = true
        isLikesView = false
        
        collectionView?.reloadData()
    }
    
    func didChangeToAboutView() {
        isAboutView = true
        isCommentsView = false
        isRelatedView = false
        isLikesView = false
        
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
        case isLikesView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: likeId, for: indexPath) as! PostLikes
            return cell
        case isRelatedView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: relatedId, for: indexPath) as! RelatedPost
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
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath) as! PostDetailHeader
        header.postDetailDelegate = self
        return header
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView?.register(PostView.self, forCellWithReuseIdentifier: postId)
        collectionView?.register(PostLikes.self, forCellWithReuseIdentifier: likeId)
        collectionView?.register(RelatedPost.self, forCellWithReuseIdentifier: relatedId)
        collectionView?.register(PostComments.self, forCellWithReuseIdentifier: commentId)
        collectionView?.register(PostDetailHeader.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerId)
        collectionView?.backgroundColor = .white
    }
}
