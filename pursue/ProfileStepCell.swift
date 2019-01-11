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
        view.backgroundColor = .white
        return view
    }()
    
    let stepLabel : UILabel = {
       let label = UILabel()
        label.text = "Practice Text"
        label.font = UIFont.systemFont(ofSize: 20, weight: UIFont.Weight.init(25))
        label.textAlignment = .justified
        label.numberOfLines = 2
        return label
    }()
    
    let dayLabel : UILabel = {
       let label = UILabel()
        label.text = "1"
        label.numberOfLines = 1
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    
    let dayUnderlineView : UIView = {
       let view = UIView()
        view.backgroundColor = .black
        return view
    }()
    
    let stepsToCompleteLabel : UILabel = {
       let label = UILabel()
        label.text = "5 Steps"
        label.font = UIFont.systemFont(ofSize: 22, weight: UIFont.Weight.init(25))
        return label
    }()
    
    let pursuitLabel : UILabel = {
       let label = UILabel()
        label.text = "This is filler text"
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .gray
        return label
    }()
    
    let pursuitImageView : UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named : "cafe-768771_1280")?.withRenderingMode(.alwaysOriginal)
        iv.contentMode = .scaleAspectFill
        iv.layer.cornerRadius = 15
        iv.layer.masksToBounds = true
        return iv
    }()
    
    let descriptionStackView : UIStackView = {
       let sv = UIStackView()
        sv.axis = .vertical
        sv.distribution = .fill
        sv.spacing = 8
        return sv
    }()
    
    let timeAgoLabel : UILabel = {
       let label = UILabel()
        label.text = "3 mins ago"
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()
    
    lazy var optionButton : UIButton = {
       let button = UIButton(type: .system)
        button.setTitle("•••", for: .normal)
        button.tintColor = .black
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.init(25))
        return button
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
    
//    func setupView(){
//        addSubview(cellBackgroundColor)
//        addSubview(dayLabel)
//        addSubview(stepLabel)
//
//
//        dayLabel.anchor(top: cellBackgroundColor.topAnchor, left: cellBackgroundColor.leftAnchor, bottom: nil, right: cellBackgroundColor.rightAnchor, paddingTop: 18, paddingLeft: 18, paddingBottom: 0, paddingRight: 12, width: 0, height: 16)
//        stepLabel.anchor(top: dayLabel.bottomAnchor, left: dayLabel.leftAnchor, bottom: nil, right: cellBackgroundColor.rightAnchor, paddingTop: 24, paddingLeft: 0, paddingBottom: 0, paddingRight: 8, width: 0, height: 0)
//        stepLabel.heightAnchor.constraint(lessThanOrEqualToConstant: 46).isActive = true
//        setupCollectionView()
//    }
    
    func setupView(){
        addSubview(cellBackgroundColor)
        addSubview(dayLabel)
        addSubview(dayUnderlineView)
        addSubview(stepsToCompleteLabel)
        addSubview(pursuitLabel)
        addSubview(pursuitImageView)
        addSubview(timeAgoLabel)
        addSubview(optionButton)
        
        cellBackgroundColor.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        dayLabel.anchor(top: cellBackgroundColor.topAnchor, left: cellBackgroundColor.leftAnchor, bottom: nil, right: nil, paddingTop: 18, paddingLeft: 18, paddingBottom: 0, paddingRight: 0, width: dayLabel.intrinsicContentSize.width, height: 15)
        dayUnderlineView.centerXAnchor.constraint(equalTo: dayLabel.centerXAnchor).isActive = true
        dayUnderlineView.anchor(top: dayLabel.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 4, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: dayLabel.intrinsicContentSize.width + 2.5, height: 2)
        stepsToCompleteLabel.anchor(top: dayUnderlineView.bottomAnchor, left: cellBackgroundColor.leftAnchor, bottom: nil, right: nil, paddingTop: 32, paddingLeft: 18, paddingBottom: 0, paddingRight: 12, width: stepsToCompleteLabel.intrinsicContentSize.width, height: 26)
        pursuitLabel.anchor(top: stepsToCompleteLabel.bottomAnchor, left: stepsToCompleteLabel.leftAnchor, bottom: nil, right: cellBackgroundColor.rightAnchor, paddingTop: 12, paddingLeft: 0, paddingBottom: 0, paddingRight: 12, width: 0, height: 16)
        pursuitImageView.anchor(top: nil, left: stepsToCompleteLabel.leftAnchor, bottom: cellBackgroundColor.bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 18, paddingRight: 0, width: 30, height: 30)
        timeAgoLabel.centerYAnchor.constraint(equalTo: pursuitImageView.centerYAnchor).isActive = true
        timeAgoLabel.anchor(top: nil, left: nil, bottom: nil, right: cellBackgroundColor.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 12, width: timeAgoLabel.intrinsicContentSize.width, height: 14)
        optionButton.anchor(top: cellBackgroundColor.topAnchor, left: nil, bottom: nil, right: cellBackgroundColor.rightAnchor, paddingTop: 18, paddingLeft: 0, paddingBottom: 0, paddingRight: 12, width: optionButton.intrinsicContentSize.width, height: 16)
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
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.cornerRadius = 10
        return button
    }()
    
    let itemLabel : UILabel = {
       let label = UILabel()
        label.numberOfLines = 1
        label.text = "Test Item"
        label.font = UIFont.boldSystemFont(ofSize: 16)
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
