//
//  ProfilePursuitSection.swift
//  pursue
//
//  Created by Jaylen Sanders on 3/13/18.
//  Copyright © 2018 Glory. All rights reserved.
//

import UIKit

class ProfilePursuitSection : UICollectionViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var accessProfileController : ProfileController?
    
    var pursuit : Pursuit? {
        didSet{
            userAddedLabel.setTitle(pursuit?.pursuitDescription, for: .normal)
        }
    }
    
    lazy var userAddedLabel : UIButton = {
        let label = UIButton()
        label.setTitle("Build a great company", for: .normal)
        label.setTitleColor(.black, for: .normal)
        label.isUserInteractionEnabled = true
        label.titleLabel?.font = .boldSystemFont(ofSize: 14)
        return label
    }()
    
    let pursuitCollectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isScrollEnabled = true
        return collectionView
    }()
    
    let cellId = "cellId"
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (frame.width * 2) - 60, height: 305)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(0, 12, 0, 12)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ProfilePursuitCells
        return cell
    }
    
    func setupView(){
        pursuitCollectionView.register(ProfilePursuitCells.self, forCellWithReuseIdentifier: cellId)
        pursuitCollectionView.delegate = self
        pursuitCollectionView.dataSource = self
        
        addSubview(userAddedLabel)
        addSubview(pursuitCollectionView)
        userAddedLabel.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: userAddedLabel.intrinsicContentSize.width, height: userAddedLabel.intrinsicContentSize.height)
        pursuitCollectionView.anchor(top: userAddedLabel.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 335)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
