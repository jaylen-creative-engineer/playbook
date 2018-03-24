//
//  ProfilePursuit.swift
//  pursue
//
//  Created by Jaylen Sanders on 3/13/18.
//  Copyright © 2018 Glory. All rights reserved.
//

import UIKit

class ProfilePursuit : UICollectionViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var pursuits = [Pursuit]()
    var accessProfileController : ProfileController?
    
    let pursuitCollectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isScrollEnabled = false
        return collectionView
    }()
    
    lazy var pursuitsLabel : UIButton = {
        let label = UIButton()
        label.setTitle("Pursuits", for: .normal)
        label.setTitleColor(.black, for: .normal)
        label.isUserInteractionEnabled = true
        label.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: UIFont.Weight(25))
        return label
    }()
    
    let cellId = "cellId"
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width, height: 405)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        print(pursuits)
        if !pursuits.isEmpty {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ProfilePursuitSection
            cell.pursuit = pursuits[indexPath.item]
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ProfilePursuitSection
            return cell
        }
    }
    
    func setupView(){
        pursuitCollectionView.register(ProfilePursuitSection.self, forCellWithReuseIdentifier: cellId)
        pursuitCollectionView.delegate = self
        pursuitCollectionView.dataSource = self
        
        addSubview(pursuitsLabel)
        addSubview(pursuitCollectionView)
        
        pursuitsLabel.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: pursuitsLabel.intrinsicContentSize.width, height: pursuitsLabel.intrinsicContentSize.height)
        pursuitCollectionView.anchor(top: pursuitsLabel.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 18, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: frame.height)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
