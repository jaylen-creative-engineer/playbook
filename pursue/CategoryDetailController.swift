//
//  CategoryDetailController.swift
//  pursue
//
//  Created by Jaylen Sanders on 10/26/17.
//  Copyright © 2017 Glory. All rights reserved.
//

import UIKit

class CategoryDetailController : UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    let headerId = "headerId"
    let cellId = "cellId"
    let peopleId = "peopleId"
    let exerciseId = "exerciseId"
    let challengeId = "challengeId"
    let toolId = "toolId"
    let categoryId = "cateogryId"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView?.backgroundColor = .white
        collectionView?.register(CategoryHeaderRow.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerId)
        collectionView?.register(CategoryImageRow.self, forCellWithReuseIdentifier: cellId)
        collectionView?.register(CategoryPeopleRow.self, forCellWithReuseIdentifier: peopleId)
        collectionView?.register(CategoryChallengeRow.self, forCellWithReuseIdentifier: challengeId)
        collectionView?.register(CategoryExerciseRow.self, forCellWithReuseIdentifier: exerciseId)
        self.navigationController?.isNavigationBarHidden = true
    }
    
    // MARK: - Setup Views
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: (view.frame.width / 8) + 5)
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath) as! CategoryHeaderRow
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if section == 0 {
            return UIEdgeInsetsMake(0, 0, 0, 0)
        } else {
            return UIEdgeInsetsMake(32, 0, 0, 0)
        }
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell : UICollectionViewCell
        switch indexPath.item {
        case 0:
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! CategoryImageRow
            return cell
        case 1:
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: peopleId, for: indexPath) as! CategoryPeopleRow
            return cell
        case 2:
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: challengeId, for: indexPath) as! CategoryChallengeRow
            return cell
        case 3:
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: exerciseId, for: indexPath) as! CategoryExerciseRow
            return cell
        default:
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: exerciseId, for: indexPath) as! CategoryExerciseRow
            return cell
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func showCategoryDetailForCateogry(){
        let layout = UICollectionViewFlowLayout()
        let cateogryDetailController = CategoryDetailController(collectionViewLayout: layout)
        navigationController?.pushViewController(cateogryDetailController, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch indexPath.item {
        case 0:
            return CGSize(width: view.frame.width, height: 260)
        case 1:
            return CGSize(width: view.frame.width, height: 210)
        case 2:
            return CGSize(width: view.frame.width, height: 320)
        default:
            return CGSize(width: view.frame.width, height: 260)
        }
    }
    
    
}
