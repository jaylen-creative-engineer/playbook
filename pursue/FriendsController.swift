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
    
    let inviteContacts : UIButton = {
        let button = UIButton()
        button.setTitle("Invite Contacts", for: .normal)
        button.setTitleColor(.gray, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.init(25))
        button.addTarget(self, action: #selector(handleChangeToInvite), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
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
        
        if added == nil {
            view.addSubview(inviteContacts)
            
            inviteContacts.anchor(top: nil, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 24)
            inviteContacts.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            inviteContacts.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        }
    }
    
    let profileService = ProfileServices()
    var friends : Added?
    var added : [User]?
    
    func getData(){
        profileService.getUsersAdded { (addedUser) in
            DispatchQueue.main.async{
                self.added = addedUser.added
                self.collectionView?.reloadData()
            }
        }
    }
    
    @objc func handleChangeToInvite(){
        let inviteController = InviteController(collectionViewLayout: UICollectionViewFlowLayout())
        present(inviteController, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTopBar()
        
        collectionView?.register(FriendsCells.self, forCellWithReuseIdentifier: cellId)
        collectionView?.backgroundColor = .white
        collectionView?.contentInset = UIEdgeInsets.init(top: 0, left: 0, bottom: 105, right: 0)
        collectionView?.delegate = self
        collectionView?.dataSource = self
        collectionView?.showsVerticalScrollIndicator = false
        getData()
       
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
        return added?.count ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! FriendsCells
        cell.added = added?[indexPath.item]
        cell.accessFriendsController = self
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 90)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 45)
    }
}
