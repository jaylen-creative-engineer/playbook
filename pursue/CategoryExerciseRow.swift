//
//  CategoryExerciseRow.swift
//  pursue
//
//  Created by Jaylen Sanders on 10/26/17.
//  Copyright © 2017 Glory. All rights reserved.
//

import UIKit

class CategoryExerciseRow : HomePursuits, CategoryExerciseDelegate {
    
    let categoryExerciseId = "categoryExerciseId"
    var categoryDetailController : CategoryDetailController?
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: categoryExerciseId, for: indexPath) as! CategoryExerciseCells
        cell.categoryDelegate = self
        rowLabel.text = "ANIMAL PURSUITS"
        return cell
    }
    
    func categoryTapped() {
        categoryDetailController?.pursuitTapped()
    }
    
    func categoryHeld() {
        categoryDetailController?.pursuitHeld()
    }
 
    override func setupView() {
        super.setupView()
        postCollection.register(CategoryExerciseCells.self, forCellWithReuseIdentifier: categoryExerciseId)
    }
}
