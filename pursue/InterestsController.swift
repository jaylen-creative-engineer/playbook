//
//  InterestsController.swift
//  pursue
//
//  Created by Jaylen Sanders on 11/3/17.
//  Copyright © 2017 Glory. All rights reserved.
//

import UIKit

class InterestsController : UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    let headerId = "headerId"
    let listId = "listId"
   
    var interestsNames = ["Adventure & Travel", "Animals & Pets", "Art", "Business", "Cars", "Design", "Finance", "Fashion", "Food", "Health & Mindfulness", "Home", "Math", "Music", "Self", "Science", "Sports", "Tech", "Writing"]
    var interstsSubcategories = [["Outdoors", "Travel"], ["Dogs", "Cats", "Birds", "Fish"], ["Film", "Photography", "Illustration", "Painting"], ["Entrepreneurship", "Marketing", "Freelancing", "Public Speaking"], ["DIY Repair", "Modifications"], ["Interior", "UI/UX", "Fashion"], ["Retirement", "Growth Theory", "Savings", "Markets"], ["Men's Fashion", "Women's Fashion"],["Recipes", "Technical Skills"], ["Meditation", "Weight Training", "Nutrition", "Cardio"],["Repair", "Automation", "Cleaning", "Gardening"], ["Calculus", "Algebra", "Geometry", "Logic"], ["Theory", "Production", "Instrumental", "Signing"], ["Creativity", "Productivity", "Critical Thought", "Learning", "Speed Reading"], ["Phenomena", "Chemistry", "Physics", "Biology", "Neuroscience"], ["Badminton", "Baseball", "Basketball", "Bowling", "Cycling", "Football", "Golf", "Hiking", "MMA", "Pool", "Skateboarding", "Snowboarding", "Soccer", "Surfing", "Swimming", "Volleyball"], ["Android", "iOS", "Web", "Back-end", "VR/AR", "Blockchain", "ML & AI"],["Professional", "Creative"]]
    
    lazy var categoryBackIcon : UIButton = {
        let button = UIButton()
        button.setBackgroundImage(#imageLiteral(resourceName: "back-arrow").withRenderingMode(.alwaysOriginal), for: .normal)
        return button
    }()
    
    let pageTitle : UILabel = {
        let label = UILabel()
        label.text = "Select Interests"
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.register(SelectInterestsList.self, forCellWithReuseIdentifier: listId)
        collectionView?.backgroundColor = .white
        setupTopBar()
    }
    
    private func setupTopBar(){
        let backgroundFill = UIView()
        backgroundFill.backgroundColor = .white
        
        view.addSubview(backgroundFill)
        view.addSubview(categoryBackIcon)
        view.addSubview(pageTitle)
        
        backgroundFill.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 90)
        categoryBackIcon.anchor(top: nil, left: backgroundFill.leftAnchor, bottom: backgroundFill.bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 12, paddingBottom: 16, paddingRight: 0, width: 20, height: 20)
        pageTitle.anchor(top: nil, left: categoryBackIcon.rightAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 20, paddingBottom: 0, paddingRight: 0, width: pageTitle.intrinsicContentSize.width, height: pageTitle.intrinsicContentSize.height)
        pageTitle.centerYAnchor.constraint(equalTo: categoryBackIcon.centerYAnchor).isActive = true
    }
    
    func switchToProfile() {
        guard let mainTabBarController = UIApplication.shared.keyWindow?.rootViewController as? MainTabController
            else { return }
        mainTabBarController.setupViewControllers()
        self.dismiss(animated: true, completion: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 90)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 18
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 155)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: listId, for: indexPath) as! SelectInterestsList
        cell.setupInterestsText(namesOfSubcategories: interstsSubcategories[indexPath.item])
        cell.interestsLabel.text = interestsNames[indexPath.item]
        return cell
    }
    
}
