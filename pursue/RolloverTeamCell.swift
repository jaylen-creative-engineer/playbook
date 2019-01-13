//
//  RolloverTeamCell.swift
//  Inpursuit
//
//  Created by Jaylen Sanders on 1/12/19.
//  Copyright © 2019 Glory. All rights reserved.
//

import UIKit

class RolloverTeamCell : UICollectionViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    let cellId = "cellId"
    let inviteId = "inviteId"
    
    let collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.showsHorizontalScrollIndicator = false
        cv.backgroundColor = .clear
        return cv
    }()
    
    let teamLabel : UILabel = {
        let label = UILabel()
        label.text = "TEAM"
        label.font = UIFont.boldSystemFont(ofSize: 12)
        return label
    }()
    
    func setupView(){
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(RolloverAddedCells.self, forCellWithReuseIdentifier: cellId)
        collectionView.register(RolloverInviteCell.self, forCellWithReuseIdentifier: inviteId)
        
        addSubview(teamLabel)
        addSubview(collectionView)
        
        teamLabel.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 18, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: teamLabel.intrinsicContentSize.width, height: 16)
        collectionView.anchor(top: teamLabel.bottomAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 18, paddingLeft: 0, paddingBottom: 24, paddingRight: 0, width: 0, height: 0)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 12)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 15.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 15.0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.item {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: inviteId, for: indexPath) as! RolloverInviteCell
            return cell
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! RolloverAddedCells
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch indexPath.item {
        case 0:
            return CGSize(width: 80, height: 140)
        default:
            return CGSize(width: 120, height: 140)
        }
    }
}

class RolloverInviteCell : UICollectionViewCell {
    
    let outlineButton : UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .black
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.borderWidth = 1.2
        button.layer.cornerRadius = 14
        button.layer.masksToBounds = true
        return button
    }()
    
    let addIcon : UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .black
        button.setImage(UIImage(named: "add")?.withRenderingMode(.alwaysOriginal), for: .normal)
        button.imageView?.contentMode = .scaleAspectFill
        button.contentMode = .scaleAspectFill
        return button
    }()
    
    func setupView(){
        addSubview(outlineButton)
        addSubview(addIcon)
        
        outlineButton.anchor(top: nil, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 40, height: 40)
        outlineButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        outlineButton.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        addIcon.centerXAnchor.constraint(equalTo: outlineButton.centerXAnchor).isActive = true
        addIcon.centerYAnchor.constraint(equalTo: outlineButton.centerYAnchor).isActive = true
        addIcon.anchor(top: nil, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 16, height: 16)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

