//
//  InterestsCell.swift
//  pursue
//
//  Created by Jaylen Sanders on 4/8/18.
//  Copyright © 2018 Glory. All rights reserved.
//

import UIKit
import Firebase

protocol InterestsDelegate {
    func handleInterestsCell(for cell : InterestsCell)
}

class InterestsCell : UICollectionViewCell, SelectInterestsDelegate {

    var accessSignupController : SignupController?
    var delegate : InterestsDelegate?
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
    
    lazy var nextButton : UIButton = {
        let button = UIButton()
        button.setTitle("Sign Up", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.addTarget(self, action: #selector(handleNext), for: .touchUpInside)
        button.contentHorizontalAlignment = .right
        button.contentVerticalAlignment = .center
        return button
    }()
    
    let interestsService = InterestServices()
    let engagementService = EngagementServices()
    var interests = [Interests]()
    
    @objc func handleNext(){
        nextButton.setTitle("Sending...", for: .normal)
        delegate?.handleInterestsCell(for: self)
        nextButton.isEnabled = false
    }
    
    
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
    
    var user : User! {
        didSet {
            loggedInUserId = String(user.userId!)
        }
    }
    
    var loggedInUserId : String?
    var isSignup : Bool?
    var email : String?
    
    let profileService = ProfileServices()
    
    func getSelectedInterests(){
        interestsService.getSelectedInterests { (interest) in
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
        addSubview(nextButton)
        
        interestsCollection.delegate = self
        interestsCollection.dataSource = self
        interestsCollection.register(SelectInterestsList.self, forCellWithReuseIdentifier: listId)
        interestsCollection.register(SignupInterestsHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerId)
        
        interestsCollection.anchor(top: topAnchor, left: leftAnchor, bottom: safeAreaLayoutGuide.bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 84, paddingRight: 0, width: 0, height: 0)
        nextButton.anchor(top: topAnchor, left: nil, bottom: nil, right: safeAreaLayoutGuide.rightAnchor, paddingTop: 18, paddingLeft: 0, paddingBottom: 0, paddingRight: 12, width: 120, height: 34)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        getSelectedInterests()
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
        return UIEdgeInsets.init(top: 0, left: 12, bottom: 0, right: 12)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath) as! SignupInterestsHeader
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: frame.width, height: 125)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
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
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: listId, for: indexPath) as! SelectInterestsList
        cell.delegate = self
        cell.interest = interests[indexPath.item]
        return cell
    }
}
