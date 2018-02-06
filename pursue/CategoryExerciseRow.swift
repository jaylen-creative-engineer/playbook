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
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: categoryExerciseId, for: indexPath) as! CategoryExerciseCells
        cell.categoryDelegate = self
        rowLabel.text = "Animal Pursuits"
        return cell
    }
    
    func handlePursuitsChange() {
        categoryDetailController?.handleChangeToFeed(viewType: "isPursuitFeed")
    }
    
    func categoryTapped() {
        categoryDetailController?.pursuitTapped()
    }
    
    func categoryHeld() {
        categoryDetailController?.pursuitHeld()
    }
 
    override func setupView() {
        super.setupView()
        homePursuitsCollection.register(CategoryExerciseCells.self, forCellWithReuseIdentifier: categoryExerciseId)
    }
}
