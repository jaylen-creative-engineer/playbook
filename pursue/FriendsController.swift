//
//  FriendsController.swift
//  pursue
//
//  Created by Jaylen Sanders on 2/27/18.
//  Copyright © 2018 Glory. All rights reserved.
//

import UIKit

class FriendsController : UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    lazy var backIcon : UIButton = {
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
        label.text = "Added"
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let cellId = "cellId"
    
    @objc func goBack(){
        navigationController?.popViewController(animated: true)
    }
    
    private func setupTopBar(){
        let backgroundFill = UIView()
        backgroundFill.backgroundColor = .white
        
        view.addSubview(backgroundFill)
        view.addSubview(backIcon)
        view.addSubview(pageTitle)
        
        backgroundFill.anchor(top: view.topAnchor, left: view.safeAreaLayoutGuide.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 80)
        backIcon.anchor(top: nil, left: backgroundFill.leftAnchor, bottom: backgroundFill.bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 12, paddingBottom: 16, paddingRight: 0, width: 20, height: 20)
        
        view.addSubview(backBackground)
        backBackground.centerYAnchor.constraint(equalTo: backIcon.centerYAnchor).isActive = true
        backBackground.centerXAnchor.constraint(equalTo: backIcon.centerXAnchor).isActive = true
        backBackground.anchor(top: nil, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 38, height: 38)
        pageTitle.anchor(top: nil, left: backIcon.rightAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 20, paddingBottom: 0, paddingRight: 0, width: pageTitle.intrinsicContentSize.width, height: pageTitle.intrinsicContentSize.height)
        pageTitle.centerYAnchor.constraint(equalTo: backIcon.centerYAnchor).isActive = true
    }
    
    let profileService = ProfileServices()
    var added : Added?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTopBar()
        
        collectionView?.register(FriendsCells.self, forCellWithReuseIdentifier: cellId)
        collectionView?.backgroundColor = .white
        collectionView?.contentInset = UIEdgeInsets.init(top: 0, left: 0, bottom: 105, right: 0)
        collectionView?.delegate = self
        collectionView?.dataSource = self
        collectionView?.showsVerticalScrollIndicator = false
        
        profileService.getUsersAdded { (added) in
            self.added = added
        }
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        tabBarController?.tabBar.isHidden = true
//    }
//
//    override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillDisappear(animated)
//        tabBarController?.tabBar.isHidden = false
//    }
//
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! FriendsCells
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 90)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 45)
    }
}
