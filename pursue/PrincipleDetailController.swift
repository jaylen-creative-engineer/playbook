//
//  PrincipleDetailController.swift
//  pursue
//
//  Created by Jaylen Sanders on 12/11/17.
//  Copyright © 2017 Glory. All rights reserved.
//

import UIKit

class PrincipleDetailController : DiscussionDetailController {
    
    let principleDetailId = "principleDetailId"
    let discussionId = "discussionId"
    
    var isDiscussionView = false
    
    func discussionActive(){
        isAboutView = false
        isCommentsView = false
        isPursuitsView = false
        isDiscussionView = true
        collectionView?.reloadData()
    }
    
    override func pursuitsActive() {
        isAboutView = false
        isCommentsView = false
        isPursuitsView = true
        isDiscussionView = false
        collectionView?.reloadData()
    }
    
    override func changeAbout() {
        isAboutView = true
        isCommentsView = false
        isPursuitsView = false
        isDiscussionView = false
        collectionView?.reloadData()
    }
    
    override func changeComment() {
        isAboutView = false
        isCommentsView = true
        isPursuitsView = false
        isDiscussionView = false
        collectionView?.reloadData()
    }
    
    lazy var principleBackButton : UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "back-arrow").withRenderingMode(.alwaysOriginal), for: .normal)
        button.addTarget(self, action: #selector(dismissView), for: .touchUpInside)
        return button
    }()
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: principleDetailId, for: indexPath) as! PrincipleDetailHeader
        header.principleDetailController = self
        return header
    }
    
    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width + 54, height: (view.frame.height / 2) - 5)
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
        case isDiscussionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: discussionId, for: indexPath) as! PrincipleDiscussion
            return cell
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: postId, for: indexPath) as! PostView
            return cell
        }
    }
    
    override func setupView() {
        collectionView?.backgroundColor = .white
        collectionView?.register(PrincipleDetailHeader.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: principleDetailId)
        collectionView?.register(PostView.self, forCellWithReuseIdentifier: postId)
        collectionView?.register(PostComments.self, forCellWithReuseIdentifier: commentId)
        collectionView?.register(PrincipleDiscussion.self, forCellWithReuseIdentifier: discussionId)
        collectionView?.register(DiscussionPursuitsView.self, forCellWithReuseIdentifier: pursuitsId)
        setupNavBar()
    }
}
