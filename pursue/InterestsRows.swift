
//
//  InterestsRows.swift
//  pursue
//
//  Created by Jaylen Sanders on 1/23/18.
//  Copyright © 2018 Glory. All rights reserved.
//

import UIKit
import Alamofire
import Firebase
import SwiftyJSON

class InterestsRows : UICollectionViewCell, SelectInterestsDelegate {
    
    let listId = "listId"
    
    let interestsCollection : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.isScrollEnabled = false
        return collectionView
    }()
    
    var interests = [Interests]()
    var isVisible = [Bool]()
    let interestsService = InterestServices()
    let engagementService = EngagementServices()
    
    func createInterests(){
        interestsService.createInterestsList()
    }
    
    func getSelectedInterests(){
        guard let userId = Auth.auth().currentUser?.uid else { return }
        interestsService.getSelectedInterests(userId: userId) { (interest) in
            DispatchQueue.main.async {
                interest.forEach({ (value) in
                    self.interests.append(value)
                    self.interestsCollection.reloadData()
                })
            }
        }
    }
    
    func didSelect(for cell: SelectInterestsList) {
        guard let indexPath = interestsCollection.indexPath(for: cell) else { return }
        var interest = self.interests[indexPath.item]
        guard let interestId = interest.interestId else { return }
        print(interest)
        
        if interest.selected_interests == 0 {
            interest.selected_interests = 1
        } else if interest.selected_interests == 1 {
            interest.selected_interests = 0
        }
        self.interests[indexPath.item] = interest
        self.interestsCollection.reloadItems(at: [indexPath])
        engagementService.toggleFollowInterests(interestId: interestId, is_selected: interest.selected_interests)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        interestsCollection.register(SelectInterestsList.self, forCellWithReuseIdentifier: listId)
        interestsCollection.delegate = self
        interestsCollection.dataSource = self
        addSubview(interestsCollection)
        interestsCollection.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        getSelectedInterests()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension InterestsRows : UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return interests.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 15
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (frame.width) / 3
        return CGSize(width: width + 45, height: (width - 20))
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(0, 12, 0, 12)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: listId, for: indexPath) as! SelectInterestsList
        cell.delegate = self
        cell.interest = interests[indexPath.item]
        return cell
    }
}
