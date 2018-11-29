//
//  ProfilePursuit.swift
//  pursue
//
//  Created by Jaylen Sanders on 3/13/18.
//  Copyright © 2018 Glory. All rights reserved.
//

import UIKit

class ProfilePursuit : UICollectionViewCell {
    
    var pursuits : [Post]? {
        didSet {
            postCollectionView.reloadData()
        }
    }
    
    let postCollectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    let pursuitsLabel : UILabel = {
       let label = UILabel()
        label.text = "Pursuits"
        label.font = UIFont(name: "Lato-Bold", size: 14)
        return label
    }()
    
    let cellId = "cellId"
    let labelId = "labelId"
    
    @objc func handleHeld(){
    }

    func setupCollectionView(){
        postCollectionView.delegate = self
        postCollectionView.dataSource = self
        postCollectionView.register(RecommenedPursuitCell.self, forCellWithReuseIdentifier: cellId)
        addSubview(pursuitsLabel)
        addSubview(postCollectionView)
        
        pursuitsLabel.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: pursuitsLabel.intrinsicContentSize.width, height: pursuitsLabel.intrinsicContentSize.height)
        postCollectionView.anchor(top: pursuitsLabel.bottomAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 12, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
    }
    
    func changeToDetail(for cell: ProfilePursuit) {
//        guard let indexPath = postCollectionView.indexPath(for: cell) else { return }
//        let detail = PostDetailController(collectionViewLayout: UICollectionViewFlowLayout())
//        detail.post = self.pursuits
//        present(detail, animated: true, completion: nil)
    }
    
    var accessProfileController : ProfileController?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCollectionView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ProfilePursuit : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if pursuits?.first?.created_at == nil {
            return 0
        } else {
            return pursuits?.count ?? 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (frame.width / 1.25) + 40, height: 465)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        accessProfileController?.handleChangeToDetail(pursuitNumber: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! RecommenedPursuitCell
        cell.post = pursuits?[indexPath.item]
        return cell
    }
}


