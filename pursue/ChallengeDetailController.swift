//
//  ChallengeDetailController.swift
//  pursue
//
//  Created by Jaylen Sanders on 9/23/18.
//  Copyright © 2018 Glory. All rights reserved.
//

import UIKit

class ChallengeDetailController : UICollectionViewController {
    
    let challengeLabel = UILabel()
    let usernameLabel = UILabel()
    let navBarBackground = UIView()
    
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
    
    let headerId = "headerId"
    let cellId = "cellId"
    
    @objc func handleDismiss(){
        dismiss(animated: true, completion: nil)
    }
    
    func setupCollectionView(){
        collectionView?.backgroundColor = .white
        collectionView?.contentInset = UIEdgeInsets.init(top: 60, left: 0, bottom: 0, right: 0)
        collectionView?.showsVerticalScrollIndicator = false
        collectionView?.register(ChallengeHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerId)
        collectionView?.register(ChallengeListCells.self, forCellWithReuseIdentifier: cellId)
    }
    
    func setupNavigationBar(){
        navBarBackground.backgroundColor = .white
        navBarBackground.translatesAutoresizingMaskIntoConstraints = false
        
        challengeLabel.text = "Challenge"
        challengeLabel.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.init(25))
        challengeLabel.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(navBarBackground)
        view.addSubview(navUnderlineView)
        navBarBackground.addSubview(backButton)
        navBarBackground.addSubview(challengeLabel)
        
        navBarBackground.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 80)
        navUnderlineView.anchor(top: navBarBackground.bottomAnchor, left: navBarBackground.leftAnchor, bottom: nil, right: navBarBackground.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0.5)
        backButton.anchor(top: nil, left: navBarBackground.leftAnchor, bottom: navUnderlineView.topAnchor, right: nil, paddingTop: 0, paddingLeft: 12, paddingBottom: 8, paddingRight: 0, width: 16, height: 16)
        challengeLabel.centerYAnchor.constraint(equalTo: backButton.centerYAnchor).isActive = true
        challengeLabel.anchor(top: nil, left: backButton.rightAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: challengeLabel.intrinsicContentSize.width, height: challengeLabel.intrinsicContentSize.height)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        setupNavigationBar()
    }
}

extension ChallengeDetailController : UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 242)
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath) as! ChallengeHeader
        return header
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ChallengeListCells
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20.0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 20.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 130)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
}
