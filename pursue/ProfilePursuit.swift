//
//  ProfilePursuit.swift
//  pursue
//
//  Created by Jaylen Sanders on 3/13/18.
//  Copyright © 2018 Glory. All rights reserved.
//

import UIKit

class ProfilePursuit : UICollectionViewCell {
    
    lazy var photo : UIImageView = {
        let iv = UIImageView()
        iv.layer.cornerRadius = 8
        iv.layer.masksToBounds = true
        iv.contentMode = .scaleAspectFill
        //        iv.heroID = "photoId-1"
        return iv
    }()
    
    let photoBackground : HomeCellRectangleView = {
        let view = HomeCellRectangleView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let detailLabel : UILabel = {
        let label = UILabel()
        label.text = "Have a vision to work towards"
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()
    
    let teamIcon : UIImageView = {
        let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "Collaborate-Icon").withRenderingMode(.alwaysTemplate)
        iv.contentMode = .scaleAspectFill
        iv.tintColor = .gray
        return iv
    }()
    
    let teamCount : UILabel = {
        let label = UILabel()
        label.text = "8"
        label.textColor = .gray
        label.font = UIFont(name: "Lato-Bold", size: 12)
        return label
    }()
    
    let commentCount : UILabel = {
        let label = UILabel()
        label.text = "3"
        label.textColor = .gray
        label.font = UIFont(name: "Lato-Bold", size: 12)
        return label
    }()
    
    let commentIcon : UIImageView = {
        let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "chat_1").withRenderingMode(.alwaysTemplate)
        iv.contentMode = .scaleAspectFill
        iv.tintColor = .gray
        return iv
    }()
    
    let labelCollectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsetsMake(0, 14, 0, 12)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    let postCollectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsetsMake(0, 12, 0, 12)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    let cellId = "cellId"
    let labelId = "labelId"
    
    var interestsLabel = ["Day 1", "Day 2", "Day 3", "Day 4", "Day 5"]
    
    @objc func handleHeld(){
    }
    
    func setupLabelCollectionView(){
        addSubview(labelCollectionView)
        labelCollectionView.delegate = self
        labelCollectionView.dataSource = self
        labelCollectionView.register(InterestsLabelCell.self, forCellWithReuseIdentifier: labelId)
        
        labelCollectionView.anchor(top: teamIcon.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 18, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 40)
        setupCollectionView()
    }
    
    func setupCollectionView(){
        postCollectionView.delegate = self
        postCollectionView.dataSource = self
        postCollectionView.register(StoryCell.self, forCellWithReuseIdentifier: cellId)
        addSubview(postCollectionView)
        postCollectionView.anchor(top: labelCollectionView.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 12, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 200)
    }
    
    func setupView(){
        let seperatorCircle = UIView()
        seperatorCircle.backgroundColor = .gray
        seperatorCircle.layer.cornerRadius = 2
        seperatorCircle.layer.masksToBounds = true

        addSubview(detailLabel)
        addSubview(teamIcon)
        addSubview(teamCount)
        addSubview(seperatorCircle)
        addSubview(commentIcon)
        addSubview(commentCount)

        detailLabel.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 8, paddingLeft: 12, paddingBottom: 0, paddingRight: 12, width: 0, height: 14)
        teamIcon.anchor(top: detailLabel.bottomAnchor, left: detailLabel.leftAnchor, bottom: nil, right: nil, paddingTop: 16, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 23, height: 16)
        teamCount.anchor(top: nil, left: teamIcon.rightAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 8, paddingBottom: 0, paddingRight: 0, width: teamCount.intrinsicContentSize.width, height: teamCount.intrinsicContentSize.height)
        teamCount.centerYAnchor.constraint(equalTo: teamIcon.centerYAnchor).isActive = true
        seperatorCircle.anchor(top: nil, left: teamCount.rightAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: 4, height: 4)
        seperatorCircle.centerYAnchor.constraint(equalTo: teamCount.centerYAnchor).isActive = true
        commentIcon.anchor(top: teamIcon.topAnchor, left: seperatorCircle.rightAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 8, paddingBottom: 0, paddingRight: 0, width: 22.71, height: 16)
        commentCount.anchor(top: nil, left: commentIcon.rightAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 8, paddingBottom: 0, paddingRight: 0, width: commentCount.intrinsicContentSize.width, height: commentCount.intrinsicContentSize.height)
        commentCount.centerYAnchor.constraint(equalTo: commentIcon.centerYAnchor).isActive = true
        setupLabelCollectionView()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ProfilePursuit : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch collectionView {
        case postCollectionView:
            return CGSize(width: (frame.width / 1.25) + 40, height: 190)
        default:
            return CGSize(width: 60, height: 24)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        switch collectionView {
        case postCollectionView:
            return 20.0
        default:
            return 0.0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case labelCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: labelId, for: indexPath) as! InterestsLabelCell
            cell.interestsLabel.text = interestsLabel[indexPath.item]
            return cell
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! StoryCell
            return cell
        }
    }
}


