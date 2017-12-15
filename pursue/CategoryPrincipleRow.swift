//
//  CategoryChallengeRow.swift
//  pursue
//
//  Created by Jaylen Sanders on 10/26/17.
//  Copyright © 2017 Glory. All rights reserved.
//

import UIKit

class CategoryPrincipleRow : HomePrinciples, CategoryPrincipleDelegate {
    
    let categoryPrincipleId = "categoryPrincipleId"
    var categoryDetailController : CategoryDetailController?
    
    override func principleTapped() {
        categoryDetailController?.principleTapped()
    }
    
    override func principleHeld() {
        categoryDetailController?.principleHeld()
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: categoryPrincipleId, for: indexPath) as! CategoryPrincipleCells
        cell.categoryDelegate = self
        rowLabel.text = "ANIMAL PRINCIPLES"
        return cell
    }
    
    override func setupView() {
        super.setupView()
        postCollection.register(CategoryPrincipleCells.self, forCellWithReuseIdentifier: categoryPrincipleId)
    }
}

