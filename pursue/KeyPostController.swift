//
//  KeyPostController.swift
//  pursue
//
//  Created by Jaylen Sanders on 9/24/18.
//  Copyright © 2018 Glory. All rights reserved.
//

import UIKit

class KeyPostController : UICollectionViewController, KeyPostListDelegate {
    
    let keyPostLabel = UILabel()
    let usernameLabel = UILabel()
    let navBarBackground = UIView()
    
    let cellId = "cellId"
    
    let navUnderlineView : UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    lazy var backButton : UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "back-arrow").withRenderingMode(.alwaysOriginal), for: .normal)
        button.contentMode = .scaleAspectFill
        button.addTarget(self, action: #selector(handleDismiss), for: .touchUpInside)
        return button
    }()
    
    var pursuitId : Int?
    let homeServices = HomeServices()
    var keyPost = [Post]()
    
    func keyPostData(){
        homeServices.getKeyPosts(pursuitId: pursuitId) { (homeDetail) in
            DispatchQueue.main.async {
                self.keyPost = homeDetail.key_posts!
                self.collectionView?.reloadData()
            }
        }
    }
    
    func setupCollectionView(){
        collectionView?.backgroundColor = .white
        collectionView?.showsVerticalScrollIndicator = false
        collectionView?.register(KeyPostListCells.self, forCellWithReuseIdentifier: cellId)
        collectionView?.contentInset = UIEdgeInsets.init(top: 50, left: 0, bottom: 0, right: 0)
    }
    
    @objc func handleDismiss(){
        dismiss(animated: true, completion: nil)
    }
    
    func handleSave(for cell: KeyPostListCells) {
        let customAlert = CustomSavePopover()
        customAlert.providesPresentationContextTransitionStyle = true
        customAlert.definesPresentationContext = true
        customAlert.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        customAlert.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        self.showDetailViewController(customAlert, sender: self)
    }
    
    func setupNavigationBar(){
        navBarBackground.backgroundColor = .white
        navBarBackground.translatesAutoresizingMaskIntoConstraints = false
        
        keyPostLabel.text = "Key Post"
        keyPostLabel.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.init(25))
        keyPostLabel.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(navBarBackground)
        view.addSubview(navUnderlineView)
        navBarBackground.addSubview(backButton)
        navBarBackground.addSubview(keyPostLabel)
        
        navBarBackground.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 80)
        navUnderlineView.anchor(top: navBarBackground.bottomAnchor, left: navBarBackground.leftAnchor, bottom: nil, right: navBarBackground.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0.5)
        backButton.anchor(top: nil, left: navBarBackground.leftAnchor, bottom: navUnderlineView.topAnchor, right: nil, paddingTop: 0, paddingLeft: 12, paddingBottom: 8, paddingRight: 0, width: 16, height: 16)
        keyPostLabel.centerYAnchor.constraint(equalTo: backButton.centerYAnchor).isActive = true
        keyPostLabel.anchor(top: nil, left: backButton.rightAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: keyPostLabel.intrinsicContentSize.width, height: keyPostLabel.intrinsicContentSize.height)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        keyPostData()
        setupNavigationBar()
        setupCollectionView()
    }
}

extension KeyPostController : UICollectionViewDelegateFlowLayout {
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return keyPost.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! KeyPostListCells
        cell.delegate = self
        cell.post = keyPost[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 20.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 115)
    }
}
