//
//  ProfilePursuitsRow.swift
//  pursue
//
//  Created by Jaylen Sanders on 10/26/17.
//  Copyright © 2017 Glory. All rights reserved.
//

import UIKit

protocol ProfilePursuitsRowDelegate {
    func pursuitClicked()
    func pursuitHeld()
}

class ProfilePursuitsRow : UICollectionViewCell, UICollectionViewDelegate, UICollectionViewDataSource, ProfilePursuitsDelegate {
    
    let profilePursuitsId = "profilePursuitsId"
    let imageNames = ["winter", "fall", "home-remodel", "food"]
    let profileLabelText = ["Winter Fashion", "Fall Fasion", "Home", "Food"]
    
    let rowLabel : UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.init(25))
        return label
    }()
    
    let postCollection : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    lazy var moreButton : UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "right-arrow-1").withRenderingMode(.alwaysOriginal), for: .normal)
        button.addTarget(self, action: #selector(handleShowMore), for: .touchUpInside)
        return button
    }()

    var delegate : ProfilePursuitsRowDelegate?
    var accessProfileController : ProfileController?
    
    func pursuitClicked() {
        accessProfileController?.handleChangeToDetail(viewType: "isPursuitDetail")
    }
    
    func pursuitHeld() {
        delegate?.pursuitHeld()
    }
    
    @objc func handleShowMore() {
        accessProfileController?.handleChangeToFeed(viewType: "isPursuitFeed")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: profilePursuitsId, for: indexPath) as! ProfilePursuitsCells
        cell.delegate = self
        cell.pursuitImage.image = UIImage(named: imageNames[indexPath.item])?.withRenderingMode(.alwaysOriginal)
        cell.pursuitLabel.text = profileLabelText[indexPath.item]
        rowLabel.text = "Pursuits"
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: ((frame.width - 2) / 2) + 125, height: 310)
    }

    func setupView(){
        addSubview(rowLabel)
        addSubview(postCollection)
        addSubview(moreButton)
        
        rowLabel.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 24, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: rowLabel.intrinsicContentSize.width, height: 45)
        postCollection.anchor(top: rowLabel.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 255)
        moreButton.anchor(top: rowLabel.topAnchor, left: nil, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 20, width: 24, height: 12)
        
        postCollection.showsHorizontalScrollIndicator = false
        postCollection.register(ProfilePursuitsCells.self, forCellWithReuseIdentifier: profilePursuitsId)
        postCollection.dataSource = self
        postCollection.delegate = self
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
