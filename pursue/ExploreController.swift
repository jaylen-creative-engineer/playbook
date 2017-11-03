//
//  ExploreController.swift
//  pursue
//
//  Created by Jaylen Sanders on 9/11/17.
//  Copyright © 2017 Glory. All rights reserved.
//

import UIKit

class ExploreController: UICollectionViewController, UICollectionViewDelegateFlowLayout, ExploreHeaderDelegate {
    
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
        collectionView?.register(ExploreHeaderRow.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerId)
        collectionView?.register(ExploreImageRow.self, forCellWithReuseIdentifier: cellId)
        collectionView?.register(PeopleRow.self, forCellWithReuseIdentifier: peopleId)
        collectionView?.register(ExploreChallengeRow.self, forCellWithReuseIdentifier: challengeId)
        collectionView?.register(ExploreExerciseRow.self, forCellWithReuseIdentifier: exerciseId)
        collectionView?.register(ExploreCategoryRow.self, forCellWithReuseIdentifier: categoryId)
        self.navigationController?.isNavigationBarHidden = true
    }
    
    // MARK: - Setup Views
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: (view.frame.width / 8) + 5)
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath) as! ExploreHeaderRow
        header.delegate = self
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
            let categoryCell = collectionView.dequeueReusableCell(withReuseIdentifier: categoryId, for: indexPath) as! ExploreCategoryRow
             categoryCell.accessExploreController = self
            return categoryCell
        case 1:
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ExploreImageRow
            return cell
        case 2:
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: peopleId, for: indexPath) as! PeopleRow
            return cell
        case 3:
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: challengeId, for: indexPath) as! ExploreChallengeRow
            return cell
        case 4:
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: exerciseId, for: indexPath) as! ExploreExerciseRow
            return cell
        default:
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: exerciseId, for: indexPath) as! ExploreExerciseRow
            return cell
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func switchToDetail() {
        let layout = UICollectionViewFlowLayout()
        let appDetailController = CategoryDetailController(collectionViewLayout: layout)
        navigationController?.pushViewController(appDetailController, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch indexPath.item {
        case 0:
            return CGSize(width: view.frame.width, height: 110)
        case 1:
            return CGSize(width: view.frame.width, height: 260)
        case 2:
            return CGSize(width: view.frame.width, height: 210)
        case 3:
            return CGSize(width: view.frame.width, height: 320)
        default:
            return CGSize(width: view.frame.width, height: 260)
        }
    }
 
    func handleMessage(for cell: ExploreHeaderRow) {
        let messageController = MessagesController()
        let navController = UINavigationController(rootViewController: messageController)
        present(navController, animated: true, completion: nil)
    }

}
