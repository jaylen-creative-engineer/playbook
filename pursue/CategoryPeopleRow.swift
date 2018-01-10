//
//  CategoryPeopleRow.swift
//  pursue
//
//  Created by Jaylen Sanders on 10/26/17.
//  Copyright © 2017 Glory. All rights reserved.
//

import UIKit

class CategoryPeopleRow : PeopleRow, CategoryPeopleDelegate {
    
    let categoryPeopleId = "categoryPeopleId"
    var categoryDetailController: CategoryDetailController?
    var homeController : HomeController?
    
    override func profileTapped() {
        categoryDetailController?.changeToProfile()
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: categoryPeopleId, for: indexPath) as! CategoryPeopleCells
        cell.categoryPeopleDelegate = self
        rowLabel.text = "People"
        return cell
    }
    
    override func setupView() {
        super.setupView()
        postCollection.register(CategoryPeopleCells.self, forCellWithReuseIdentifier: categoryPeopleId)
    }
}

