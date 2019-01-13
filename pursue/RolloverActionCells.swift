//
//  RolloverDayCells.swift
//  Inpursuit
//
//  Created by Jaylen Sanders on 1/11/19.
//  Copyright © 2019 Glory. All rights reserved.
//

import UIKit

class RolloverActionCells : UICollectionViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    let cellId = "cellId"
    
    let cellBackgroundView : LoginRectangleView = {
       let view = LoginRectangleView()
        view.backgroundColor = .white
        return view
    }()
    
    let actionItemsLabel : UILabel = {
       let label = UILabel()
        label.text = "Action Items"
        label.font = UIFont.systemFont(ofSize: 24, weight: UIFont.Weight.init(25))
        return label
    }()
    
    let nameLabel : UILabel = {
       let label = UILabel()
        label.text = "Me"
        label.textColor = .blue
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    
    let nameUnderlineView : UIView = {
       let view = UIView()
        view.backgroundColor = .blue
        return view
    }()
    
    lazy var viewMoreButton : UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("VIEW MORE", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 12)
        return button
    }()
    
    lazy var addStepButton : UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("ADD STEP", for: .normal)
        button.setTitleColor(.gray, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 12)
        return button
    }()
    
    
    let collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.showsVerticalScrollIndicator = false
        cv.isScrollEnabled = false
        cv.backgroundColor = .clear
        cv.layer.cornerRadius = 8
        cv.layer.masksToBounds = true
        return cv
    }()
    
    func setupCollectionView(){
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(RolloverActionItems.self, forCellWithReuseIdentifier: cellId)
        addSubview(collectionView)
        
        collectionView.anchor(top: nameUnderlineView.bottomAnchor, left: cellBackgroundView.leftAnchor, bottom: viewMoreButton.topAnchor, right: cellBackgroundView.rightAnchor, paddingTop: 42, paddingLeft: 0, paddingBottom: 24, paddingRight: 0, width: 0, height: 0)
    }
    
    func setupView(){
        addSubview(cellBackgroundView)
        addSubview(actionItemsLabel)
        addSubview(nameLabel)
        addSubview(nameUnderlineView)
        addSubview(viewMoreButton)
        addSubview(addStepButton)
        
        cellBackgroundView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 24, paddingLeft: 12, paddingBottom: 18, paddingRight: 12, width: 0, height: 0)
        actionItemsLabel.centerXAnchor.constraint(equalTo: cellBackgroundView.centerXAnchor).isActive = true
        actionItemsLabel.anchor(top: cellBackgroundView.topAnchor, left: nil, bottom: nil, right: nil, paddingTop: 28, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 26)
        nameLabel.anchor(top: actionItemsLabel.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 24, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 16)
        nameLabel.centerXAnchor.constraint(equalTo: actionItemsLabel.centerXAnchor).isActive = true
        nameUnderlineView.anchor(top: nameLabel.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 6, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: nameLabel.intrinsicContentSize.width, height: 2.5)
        nameUnderlineView.centerXAnchor.constraint(equalTo: nameLabel.centerXAnchor).isActive = true
        viewMoreButton.anchor(top: nil, left: nil, bottom: cellBackgroundView.bottomAnchor, right: cellBackgroundView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 18, paddingRight: 18, width: viewMoreButton.intrinsicContentSize.width, height: 16)
        addStepButton.centerYAnchor.constraint(equalTo: viewMoreButton.centerYAnchor).isActive = true
        addStepButton.anchor(top: nil, left: cellBackgroundView.leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 18, paddingBottom: 18, paddingRight: 0, width: addStepButton.intrinsicContentSize.width, height: 16)
        setupCollectionView()
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
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! RolloverActionItems
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 45.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 45.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 24)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width, height: 70)
    }
}
