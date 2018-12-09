//
//  InterestsController.swift
//  pursue
//
//  Created by Jaylen Sanders on 11/3/17.
//  Copyright © 2017 Glory. All rights reserved.
//

import UIKit

class InterestsController : UICollectionViewController {
    
    let headerId = "headerId"
    let cellId = "cellId"
    
    lazy var categoryBackIcon : UIButton = {
        let button = UIButton()
        button.setBackgroundImage(#imageLiteral(resourceName: "back-arrow").withRenderingMode(.alwaysOriginal), for: .normal)
        button.addTarget(self, action: #selector(goBack), for: .touchUpInside)
        return button
    }()
    
    lazy var backBackground : UIButton = {
       let button = UIButton()
        button.layer.cornerRadius = 19
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(goBack), for: .touchUpInside)
        return button
    }()
    
    let pageTitle : UILabel = {
        let label = UILabel()
        label.text = "Select Interests"
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var viewType = ""
    
    lazy var nextTitle : UILabel = {
        let label = UILabel()
        label.text = "Next"
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isUserInteractionEnabled = true
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(changeToNext))
        tap.numberOfTapsRequired = 1
        label.addGestureRecognizer(tap)
        return label
    }()
    
    var interests = [Interests]()
    var isVisible = [Bool]()
    let interestsService = InterestServices()
    let engagementService = EngagementServices()
    
    @objc func goBack(){
        dismiss(animated: true, completion: nil)
    }
    
    func interestViewType(){
        if viewType == "signupInterest" {
            nextTitle.isHidden = false
        } else {
            nextTitle.isHidden = true
        }
    }
    
    @objc func changeToNext(){
        let appDelegate = UIApplication.shared.delegate! as! AppDelegate
        appDelegate.window = UIWindow()
        appDelegate.window?.rootViewController = MainTabController()
        appDelegate.window?.makeKeyAndVisible()
        self.dismiss(animated: true, completion: nil)
    }
    
    func createInterests(){
        interestsService.createInterestsList()
    }
    
    func getSelectedInterests(){
        interestsService.getSelectedInterests { (interest) in
            DispatchQueue.main.async {
                interest.forEach({ (value) in
                    self.interests.append(value)
                    self.collectionView?.reloadData()
                })
            }
        }
    }
    
    private func setupTopBar(){
        let backgroundFill = UIView()
        backgroundFill.backgroundColor = .white
        
        view.addSubview(backgroundFill)
        view.addSubview(categoryBackIcon)
        view.addSubview(pageTitle)
        view.addSubview(nextTitle)
        
        backgroundFill.anchor(top: view.topAnchor, left: view.safeAreaLayoutGuide.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 80)
        categoryBackIcon.anchor(top: nil, left: backgroundFill.leftAnchor, bottom: backgroundFill.bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 12, paddingBottom: 16, paddingRight: 0, width: 20, height: 20)
        
        view.addSubview(backBackground)
        backBackground.centerXAnchor.constraint(equalTo: categoryBackIcon.centerXAnchor).isActive = true
        backBackground.centerYAnchor.constraint(equalTo: categoryBackIcon.centerYAnchor).isActive = true
        backBackground.anchor(top: nil, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 38, height: 38)
        
        pageTitle.anchor(top: nil, left: categoryBackIcon.rightAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 20, paddingBottom: 0, paddingRight: 0, width: pageTitle.intrinsicContentSize.width, height: pageTitle.intrinsicContentSize.height)
        pageTitle.centerYAnchor.constraint(equalTo: categoryBackIcon.centerYAnchor).isActive = true
        nextTitle.anchor(top: nil, left: nil, bottom: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 20, width: nextTitle.intrinsicContentSize.width, height: nextTitle.intrinsicContentSize.height)
        nextTitle.centerYAnchor.constraint(equalTo: categoryBackIcon.centerYAnchor).isActive = true
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 45)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        tabBarController?.tabBar.isHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.register(SelectInterestsList.self, forCellWithReuseIdentifier: cellId)
        collectionView?.backgroundColor = .white
        collectionView?.contentInset = UIEdgeInsets.init(top: 0, left: 0, bottom: 105, right: 0)
        collectionView?.delegate = self
        collectionView?.dataSource = self
        collectionView?.showsVerticalScrollIndicator = false
        
        setupTopBar()
        interestViewType()
        getSelectedInterests()
    }
}

extension InterestsController : UICollectionViewDelegateFlowLayout {
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return interests.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 15
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (view.frame.width) / 3
        return CGSize(width: width + 45, height: (width - 20))
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.init(top: 0, left: 12, bottom: 0, right: 12)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            var interest = self.interests[indexPath.item]
            guard let interestId = interest.interestId else { return }
            
//            if interest.selected_interests == 0 {
//                interest.selected_interests = 1
//            } else if interest.selected_interests == 1 {
//                interest.selected_interests = 0
//            }
            self.interests[indexPath.item] = interest
            self.collectionView?.reloadItems(at: [indexPath])
//            engagementService.toggleFollowInterests(interestId: interestId, is_selected: interest.selected_interests)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! SelectInterestsList
        cell.interest = interests[indexPath.item]
        return cell
    }
}
