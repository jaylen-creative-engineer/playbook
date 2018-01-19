//
//  CategoryDiscussionRow.swift
//  pursue
//
//  Created by Jaylen Sanders on 12/11/17.
//  Copyright © 2017 Glory. All rights reserved.
//

import UIKit

class CategoryDiscussionRow : HomeDiscussion, CategoryDiscussionCellDelegate {
    
    let categoryDiscussionId = "categoryDiscussionId"
    var categoryDetailController : CategoryDetailController?
    
    func discussionCellTapped() {
        categoryDetailController?.discussionTapped()
    }
    
    func discussionCellHeld() {
        categoryDetailController?.discussionHeld()
    }
    
    func handleDiscussionFeed() {
        categoryDetailController?.handleChangeToFeed(viewType: "isDiscussionFeed")
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: categoryDiscussionId, for: indexPath) as! CategoryDiscussionCells
        cell.discussionDelegate = self
        rowLabel.text = "Animal Discussions"
        return cell
    }
    
    override func setupView() {
        super.setupView()
        discussionCollection.register(CategoryDiscussionCells.self, forCellWithReuseIdentifier: categoryDiscussionId)
    }
}
