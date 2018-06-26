//
//  TeamRow.swift
//  pursue
//
//  Created by Jaylen Sanders on 6/25/18.
//  Copyright © 2018 Glory. All rights reserved.
//

import UIKit


class TeamRow : UICollectionViewCell {
    
    let rowLabel : UILabel = {
        let label = UILabel()
        label.text = "People."
        label.font = UIFont.boldSystemFont(ofSize: 14)
        return label
    }()
    
    lazy var followButton : UIButton = {
       let button = UIButton()
        button.setTitle("Follow", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 10)
        button.backgroundColor = .white
        button.layer.cornerRadius = 12
        button.layer.masksToBounds = true
        return button
    }()
    
    let buttonBackground : FollowRectangleView = {
       let view = FollowRectangleView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let cellId = "cellId"
    
    let peopleFullname = ["Tom Ford", "Versace", "LVME", "Test", "Lit"]
    let peopleUsernames = ["TomFord123", "Versace", "LVME", "Test", "Lit"]
    let peopleImages = ["comment-1", "comment-4", "comment-7", "clean-2", "clean-3"]
    
    let collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    func setupView(){
        addSubview(rowLabel)
        addSubview(collectionView)
        addSubview(buttonBackground)
        addSubview(followButton)
        
        rowLabel.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: rowLabel.intrinsicContentSize.width, height: rowLabel.intrinsicContentSize.height)
        buttonBackground.anchor(top: topAnchor, left: nil, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 12, width: 75, height: 25)
        followButton.anchor(top: buttonBackground.topAnchor, left: buttonBackground.leftAnchor, bottom: buttonBackground.bottomAnchor, right: buttonBackground.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        collectionView.anchor(top: rowLabel.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 28, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 200)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(TeamRowCells.self, forCellWithReuseIdentifier: cellId)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension TeamRow : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! TeamRowCells
        cell.profileImage.image = UIImage(named: peopleImages[indexPath.item])
        cell.usernameLabel.text = peopleUsernames[indexPath.item]
        cell.fullnameLabel.text = peopleFullname[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 12)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 80, height: 200)
    }
}
