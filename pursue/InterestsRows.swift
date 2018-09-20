
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

class InterestsRows : UICollectionViewCell {
    
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
        interestsService.getSelectedInterests() { (interest) in
            DispatchQueue.main.async {
                interest.forEach({ (value) in
                    self.interests.append(value)
                    self.interestsCollection.reloadData()
                })
            }
        }
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
        cell.interest = interests[indexPath.item]
        return cell
    }
}
