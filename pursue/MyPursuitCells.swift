//
//  MyPursuitCells.swift
//  pursue
//
//  Created by Jaylen Sanders on 9/2/18.
//  Copyright © 2018 Glory. All rights reserved.
//

import UIKit


class MyPursuitCells : UICollectionViewCell {
    
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
    
    let usernameLabel : UILabel = {
        let label = UILabel()
        label.text = "Test"
        label.font = UIFont(name: "Lato-Bold", size: 12)
        return label
    }()
    
    let userPhoto : UIImageView = {
        let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "samuel-l").withRenderingMode(.alwaysOriginal)
        iv.contentMode = .scaleAspectFill
        iv.layer.cornerRadius = 15
        iv.layer.masksToBounds = true
        return iv
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
    
    let postCollectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsetsMake(0, 12, 0, 12)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    let tryingLabel : UILabel = {
       let label = UILabel()
        label.text = "People Trying This Pursuit"
        label.font = UIFont(name: "Lato-Bold", size: 12)
        return label
    }()
    
    let userCollectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsetsMake(0, 24, 0, 12)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    let cellId = "cellId"
    let teamId = "teamId"
    
    let peopleUsernames = ["TomFord123", "Versace", "LVME", "Test", "Lit"]
    let peopleImages = ["comment-1", "comment-4", "comment-7", "clean-2", "clean-3"]
    
    @objc func handleHeld(){
    }
    
    func setupPeopleCollectionView(){
        userCollectionView.delegate = self
        userCollectionView.dataSource = self
        userCollectionView.register(TeamRowCells.self, forCellWithReuseIdentifier: teamId)
        addSubview(tryingLabel)
        addSubview(userCollectionView)
        
        tryingLabel.anchor(top: postCollectionView.bottomAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 24, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: tryingLabel.intrinsicContentSize.width, height: 14)
        userCollectionView.anchor(top: tryingLabel.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 12, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 110)
        
    }
    
    func setupCollectionView(){
        postCollectionView.delegate = self
        postCollectionView.dataSource = self
        postCollectionView.register(StoryCell.self, forCellWithReuseIdentifier: cellId)
        addSubview(postCollectionView)
        postCollectionView.anchor(top: teamIcon.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 12, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 200)
        setupPeopleCollectionView()
    }
    
    func setupView(){
        let seperatorCircle = UIView()
        seperatorCircle.backgroundColor = .gray
        seperatorCircle.layer.cornerRadius = 2
        seperatorCircle.layer.masksToBounds = true
        
        addSubview(userPhoto)
        addSubview(usernameLabel)
        addSubview(detailLabel)
        addSubview(teamIcon)
        addSubview(teamCount)
        addSubview(seperatorCircle)
        addSubview(commentIcon)
        addSubview(commentCount)
        
        userPhoto.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: 30, height: 30)
        usernameLabel.anchor(top: userPhoto.topAnchor, left: userPhoto.rightAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 8, paddingBottom: 0, paddingRight: 0, width: usernameLabel.intrinsicContentSize.width, height: 14)
        detailLabel.anchor(top: usernameLabel.bottomAnchor, left: usernameLabel.leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 8, paddingLeft: 0, paddingBottom: 0, paddingRight: 12, width: 0, height: 14)
        teamIcon.anchor(top: detailLabel.bottomAnchor, left: detailLabel.leftAnchor, bottom: nil, right: nil, paddingTop: 16, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 23, height: 16)
        teamCount.anchor(top: nil, left: teamIcon.rightAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 8, paddingBottom: 0, paddingRight: 0, width: teamCount.intrinsicContentSize.width, height: teamCount.intrinsicContentSize.height)
        teamCount.centerYAnchor.constraint(equalTo: teamIcon.centerYAnchor).isActive = true
        seperatorCircle.anchor(top: nil, left: teamCount.rightAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: 4, height: 4)
        seperatorCircle.centerYAnchor.constraint(equalTo: teamCount.centerYAnchor).isActive = true
        commentIcon.anchor(top: teamIcon.topAnchor, left: seperatorCircle.rightAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 8, paddingBottom: 0, paddingRight: 0, width: 22.71, height: 16)
        commentCount.anchor(top: nil, left: commentIcon.rightAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 8, paddingBottom: 0, paddingRight: 0, width: commentCount.intrinsicContentSize.width, height: commentCount.intrinsicContentSize.height)
        commentCount.centerYAnchor.constraint(equalTo: commentIcon.centerYAnchor).isActive = true
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

extension MyPursuitCells : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch collectionView {
        case userCollectionView:
            return CGSize(width: 80, height: 80)
        default:
            return CGSize(width: (frame.width / 1.25) + 20, height: 190)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        switch collectionView {
        case userCollectionView:
            return 2.0
        default:
            return 10.0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case userCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: teamId, for: indexPath) as! TeamRowCells
            cell.profileImage.image = UIImage(named: peopleImages[indexPath.item])
            cell.usernameLabel.text = peopleUsernames[indexPath.item]
            return cell
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! StoryCell
            return cell
        }
    }
}
