//
//  InterestsCell.swift
//  pursue
//
//  Created by Jaylen Sanders on 4/8/18.
//  Copyright © 2018 Glory. All rights reserved.
//

import UIKit
import Firebase

class InterestsCell : UICollectionViewCell, SelectInterestsDelegate {

    var accessSignupController : SignupController?
    let listId = "listId"
    let headerId = "headerId"
    
    let interestsCollection : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.showsVerticalScrollIndicator = false
        collectionView.isScrollEnabled = true
        return collectionView
    }()
    
    let interestsService = InterestServices()
    let engagementService = EngagementServices()
    var interests = [Interests]()
    
    func didSelect(for cell: SelectInterestsList) {
        guard let indexPath = interestsCollection.indexPath(for: cell) else { return }
        var interest = self.interests[indexPath.item]
        guard let interestId = interest.interestId else { return }
        
        if interest.selected_interests == 0 {
            interest.selected_interests = 1
        } else if interest.selected_interests == 1 {
            interest.selected_interests = 0
        }
        self.interests[indexPath.item] = interest
        self.interestsCollection.reloadItems(at: [indexPath])
        engagementService.toggleFollowInterests(interestId: interestId, is_selected: interest.selected_interests)
    }
    
    var userId : String? {
        didSet {
            userId = (Auth.auth().currentUser?.uid)!
            getSelectedInterests()
        }
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
    
    func setupView(){
        addSubview(interestsCollection)
        
        interestsCollection.delegate = self
        interestsCollection.dataSource = self
        interestsCollection.register(SelectInterestsList.self, forCellWithReuseIdentifier: listId)
        interestsCollection.register(SignupInterestsHeader.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerId)
        
        interestsCollection.anchor(top: topAnchor, left: leftAnchor, bottom: safeAreaLayoutGuide.bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 84, paddingRight: 0, width: 0, height: 0)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


extension InterestsCell : UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UICollectionViewDelegate {
    
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
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath) as! SignupInterestsHeader
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: frame.width, height: 185)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: listId, for: indexPath) as! SelectInterestsList
        cell.interest = interests[indexPath.item]
        return cell
    }
}
