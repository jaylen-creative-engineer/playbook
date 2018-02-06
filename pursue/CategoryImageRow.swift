//
//  CategoryImageRow.swift
//  pursue
//
//  Created by Jaylen Sanders on 10/26/17.
//  Copyright © 2017 Glory. All rights reserved.
//

import UIKit

class CategoryImageRow : HomeRow, CategoryImageDelegate {
    
//    let imageId = "imageId"

    func homeImageTapped() {
        categoryDetailController?.categoryImageTapped()
    }

    func homeImageHeld() {
        categoryDetailController?.categoryImageHeld()
    }
//
//    override func feedChange() {
//        super.feedChange()
//        categoryDetailController?.handleChangeToFeed(viewType: "isImageFeed")
//    }
//
//    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: imageId, for: indexPath) as! CategoryImageCells
//        rowLabel.text = "Animals"
//        cell.categoryImageDelegate = self
//        return cell
//    }
//
//    override func setupView() {
//        super.setupView()
//        postCollection.register(CategoryImageCells.self, forCellWithReuseIdentifier: imageId)
//    }
}
