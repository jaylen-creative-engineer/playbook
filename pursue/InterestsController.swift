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
    let cellId = "cellId"
    
    lazy var categoryBackIcon : UIButton = {
        let button = UIButton()
        button.setBackgroundImage(#imageLiteral(resourceName: "back-arrow").withRenderingMode(.alwaysOriginal), for: .normal)
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
    
    private func setupTopBar(){
        let backgroundFill = UIView()
        backgroundFill.backgroundColor = .white
        
        view.addSubview(backgroundFill)
        view.addSubview(categoryBackIcon)
        view.addSubview(pageTitle)
        view.addSubview(nextTitle)
        
        backgroundFill.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 90)
        categoryBackIcon.anchor(top: nil, left: backgroundFill.leftAnchor, bottom: backgroundFill.bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 12, paddingBottom: 16, paddingRight: 0, width: 20, height: 20)
        pageTitle.anchor(top: nil, left: categoryBackIcon.rightAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 20, paddingBottom: 0, paddingRight: 0, width: pageTitle.intrinsicContentSize.width, height: pageTitle.intrinsicContentSize.height)
        pageTitle.centerYAnchor.constraint(equalTo: categoryBackIcon.centerYAnchor).isActive = true
        nextTitle.anchor(top: nil, left: nil, bottom: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 20, width: nextTitle.intrinsicContentSize.width, height: nextTitle.intrinsicContentSize.height)
        nextTitle.centerYAnchor.constraint(equalTo: categoryBackIcon.centerYAnchor).isActive = true
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 220)
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath) as! InterestsHeader
        return header
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! InterestsRows
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        tabBarController?.tabBar.isHidden = false
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height + 425)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.register(InterestsHeader.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerId)
        collectionView?.register(InterestsRows.self, forCellWithReuseIdentifier: cellId)
        collectionView?.backgroundColor = .white
        collectionView?.contentInset = UIEdgeInsetsMake(0, 0, 105, 0)
        collectionView?.delegate = self
        collectionView?.dataSource = self
        setupTopBar()
        interestViewType()
    }
}
