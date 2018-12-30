//
//  ProfileStepCell.swift
//  Inpursuit
//
//  Created by Jaylen Sanders on 12/22/18.
//  Copyright © 2018 Glory. All rights reserved.
//

import UIKit

class ProfileStepCell : UICollectionViewCell {
    
    let cellId = "cellId"
    
    let cellBackgroundColor : HomeCellRectangleView = {
       let view = HomeCellRectangleView()
        
        return view
    }()
    
    let stepLabel : UILabel = {
       let label = UILabel()
        label.text = "Practice Text"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 20, weight: UIFont.Weight.init(25))
        label.textAlignment = .justified
        label.numberOfLines = 2
        return label
    }()
    
    let dayLabel : UILabel = {
       let label = UILabel()
        label.text = "Day 1"
        label.numberOfLines = 1
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    let checklistCollectionView : UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.isScrollEnabled = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    func setupCollectionView(){
        checklistCollectionView.delegate = self
        checklistCollectionView.dataSource = self
        checklistCollectionView.register(ChecklistCell.self, forCellWithReuseIdentifier: cellId)
        addSubview(checklistCollectionView)
        checklistCollectionView.anchor(top: stepLabel.bottomAnchor, left: cellBackgroundColor.leftAnchor, bottom: cellBackgroundColor.bottomAnchor, right: cellBackgroundColor.rightAnchor, paddingTop: 18, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
    }
    
    func setupView(){
        addSubview(cellBackgroundColor)
        addSubview(dayLabel)
        addSubview(stepLabel)
        
        cellBackgroundColor.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        dayLabel.anchor(top: cellBackgroundColor.topAnchor, left: cellBackgroundColor.leftAnchor, bottom: nil, right: cellBackgroundColor.rightAnchor, paddingTop: 18, paddingLeft: 18, paddingBottom: 0, paddingRight: 12, width: 0, height: 16)
        stepLabel.anchor(top: dayLabel.bottomAnchor, left: dayLabel.leftAnchor, bottom: nil, right: cellBackgroundColor.rightAnchor, paddingTop: 24, paddingLeft: 0, paddingBottom: 0, paddingRight: 8, width: 0, height: 0)
        stepLabel.heightAnchor.constraint(lessThanOrEqualToConstant: 46).isActive = true
        setupCollectionView()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


extension ProfileStepCell : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: frame.width, height: 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width, height: 20)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 25.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 25.0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ChecklistCell
        return cell
    }
}

class ChecklistCell : UICollectionViewCell {
    
    let checkMark : UIButton = {
       let button = UIButton()
        button.layer.borderWidth = 1.5
        button.layer.masksToBounds = true
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.cornerRadius = 10
        return button
    }()
    
    let itemLabel : UILabel = {
       let label = UILabel()
        label.numberOfLines = 1
        label.text = "Test Item"
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = .white
        return label
    }()
    
    func setupView(){
        addSubview(checkMark)
        addSubview(itemLabel)
        
        checkMark.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        checkMark.anchor(top: nil, left: leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 18, paddingBottom: 0, paddingRight: 0, width: 20, height: 20)
        itemLabel.centerYAnchor.constraint(equalTo: checkMark.centerYAnchor).isActive = true
        itemLabel.anchor(top: nil, left: checkMark.rightAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: 0, height: 18)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
