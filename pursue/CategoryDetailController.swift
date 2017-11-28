//
//  CategoryDetailController.swift
//  pursue
//
//  Created by Jaylen Sanders on 10/26/17.
//  Copyright © 2017 Glory. All rights reserved.
//

import UIKit

class CategoryDetailController : UICollectionViewController, UICollectionViewDelegateFlowLayout, CategoryHeaderDelegate {
    
    let headerId = "headerId"
    let cellId = "cellId"
    let peopleId = "peopleId"
    let exerciseId = "exerciseId"
    let challengeId = "challengeId"
    let toolId = "toolId"
    let categoryId = "cateogryId"
    let principleId = "principleId"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView?.backgroundColor = .white
        collectionView?.register(CategoryHeaderRow.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerId)
        collectionView?.register(CategoryImageRow.self, forCellWithReuseIdentifier: cellId)
        collectionView?.register(CategoryPeopleRow.self, forCellWithReuseIdentifier: peopleId)
        collectionView?.register(CategoryExerciseRow.self, forCellWithReuseIdentifier: exerciseId)
        collectionView?.register(CategoryPrincipleRow.self, forCellWithReuseIdentifier: principleId)
        
        self.navigationController?.isNavigationBarHidden = true
    }
    
    // MARK: - Setup Views
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: (view.frame.width / 8) + 5)
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath) as! CategoryHeaderRow
        header.categoryDelegate = self
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if section == 0 {
            return UIEdgeInsetsMake(0, 0, 0, 0)
        } else {
            return UIEdgeInsetsMake(32, 0, 0, 0)
        }
    }
    
    func handleMessage(for cell: CategoryHeaderRow) {
        let messageController = MessagesController()
        let navController = UINavigationController(rootViewController: messageController)
        present(navController, animated: true, completion: nil)
    }
    
    func goBack() {
        navigationController?.popViewController(animated: true)
    }
    
    func showUserProfile(){
        
    }
    
    func showChallengesDetail(){
        
    }
    
    func showPursuitsDetail(){
        let pursuits = PursuitsDetailController(collectionViewLayout: UICollectionViewFlowLayout())
        navigationController?.pushViewController(pursuits, animated: true)
    }
    
    func showPostDetailForPost(){
        let layout = UICollectionViewFlowLayout()
        let postDetilController = PostDetailController(collectionViewLayout: layout)
        navigationController?.pushViewController(postDetilController, animated: true)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell : UICollectionViewCell
        switch indexPath.item {
        case 0:
            let imageCell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! CategoryImageRow
            imageCell.accessCategoryController = self
            return imageCell
        case 1:
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: peopleId, for: indexPath) as! CategoryPeopleRow
            return cell
        case 2:
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: principleId, for: indexPath) as! CategoryPrincipleRow
            return cell
        case 3:
            let pursuitCell = collectionView.dequeueReusableCell(withReuseIdentifier: exerciseId, for: indexPath) as! CategoryExerciseRow
            pursuitCell.accessCategoryController = self
            return pursuitCell
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
            return CGSize(width: view.frame.width, height: 360)
        default:
            return CGSize(width: view.frame.width, height: 260)
        }
    }
    
    
}
