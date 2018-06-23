//
//  ProfileHeader.swift
//  pursue
//
//  Created by Jaylen Sanders on 6/22/18.
//  Copyright © 2018 Glory. All rights reserved.
//

import UIKit

class ProfileHeader : UICollectionViewCell {
    
    let followId = "followId"
    
    let imageView : CustomImageView = {
        let iv = CustomImageView()
        iv.clipsToBounds = true
        iv.contentMode = .scaleAspectFill
        iv.image = #imageLiteral(resourceName: "comment-1").withRenderingMode(.alwaysOriginal)
        return iv
    }()
    
    let statsBackground : HomeCellRectangleView = {
       let view = HomeCellRectangleView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let statsContainer : UIView = {
       let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 8
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let daysCount : UILabel = {
       let label = UILabel()
        label.text = "120"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.init(25))
        return label
    }()
    
    let daysLabel : UILabel = {
       let label = UILabel()
        label.text = "Days \nIn Pursuit"
        label.font = UIFont.systemFont(ofSize: 10)
        label.numberOfLines = 2
        label.textAlignment = .center
        return label
    }()
    
    let daysSeperator : UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        view.layer.cornerRadius = 4
        return view
    }()
    
    let pursuitCount : UILabel = {
       let label = UILabel()
        label.text = "2"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.init(25))
        return label
    }()
    
    let pursuitLabel : UILabel = {
        let label = UILabel()
        label.text = "Pursuits Completed"
        label.font = UIFont.systemFont(ofSize: 10)
        label.textAlignment = .center
        label.numberOfLines = 2
        return label
    }()
    
    let pursuitSeperator : UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        view.layer.cornerRadius = 4
        return view
    }()
    
    let stepsCount : UILabel = {
        let label = UILabel()
        label.text = "12"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.init(25))
        return label
    }()
    
    let stepsLabel : UILabel = {
        let label = UILabel()
        label.text = "Steps Completed"
        label.font = UIFont.systemFont(ofSize: 10)
        label.numberOfLines = 2
        label.textAlignment = .center
        return label
    }()
    
    let usernameLabel : UILabel = {
       let label = UILabel()
        label.text = "jaylenhu27"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()
    
    let fullnameLabel : UILabel = {
       let label = UILabel()
        label.text = "Jaylen Sanders"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.init(25))
        return label
    }()
    
    let bioText : UILabel = {
        let label = UILabel()
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 2
        paragraphStyle.paragraphSpacing = 5
        
        let attrString = NSMutableAttributedString(string: "Loreum Ipsum is simply dummy text of the printing and typesetting industry. Lorem ipsum has been the industry's.....")
        attrString.addAttribute(NSAttributedStringKey.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, attrString.length))
        
        label.attributedText = attrString
        label.font = UIFont.systemFont(ofSize: 12)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    let messageBackground : CardView = {
       let view = CardView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let followBackground : CardView = {
       let view = CardView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var messageButton : UIButton = {
       let button = UIButton()
        button.backgroundColor = .black
        button.setTitle("Message", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.layer.cornerRadius = 20
        button.layer.masksToBounds = true
        return button
    }()
    
    lazy var followButton : UIButton = {
       let button = UIButton()
        button.backgroundColor = .white
        button.setTitle("Follow", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.layer.cornerRadius = 20
        button.layer.masksToBounds = true
        return button
    }()
    
    lazy var followingCollectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isScrollEnabled = false
        collectionView.isUserInteractionEnabled = true
        return collectionView
    }()
    
    lazy var followersCollectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isScrollEnabled = false
        collectionView.isUserInteractionEnabled = true
        return collectionView
    }()
    
    let followersCountLabel : UILabel = {
        let label = UILabel()
        label.text = "120 Followers"
        label.font = UIFont.systemFont(ofSize: 12, weight: UIFont.Weight.init(25))
        return label
    }()
    
    let followingCountLabel : UILabel = {
        let label = UILabel()
        label.text = "120 Following"
        label.font = UIFont.systemFont(ofSize: 12, weight: UIFont.Weight.init(25))
        return label
    }()
    
    var fakeFollowerArray = [#imageLiteral(resourceName: "samuel-l"), #imageLiteral(resourceName: "comment-4"), #imageLiteral(resourceName: "comment-5")]
    
    func setupFollowersCollectionView(){
        addSubview(followersCollectionView)
        addSubview(followersCountLabel)
        
        followersCollectionView.delegate = self
        followersCollectionView.dataSource = self
        followersCollectionView.register(FollowingCells.self, forCellWithReuseIdentifier: followId)
        
        followersCollectionView.anchor(top: bioText.bottomAnchor, left: statsContainer.leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 48, paddingBottom: 0, paddingRight: 0, width: 100, height: 60)
        followersCountLabel.anchor(top: nil, left: followersCollectionView.rightAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 10, paddingBottom: 0, paddingRight: 0, width: followersCountLabel.intrinsicContentSize.width, height: followersCountLabel.intrinsicContentSize.height)
        followersCountLabel.centerYAnchor.constraint(equalTo: followersCollectionView.centerYAnchor).isActive = true
    }
    
    func setupFollowingCollectionView(){
        addSubview(followingCollectionView)
        addSubview(followingCountLabel)
        
        followingCollectionView.delegate = self
        followingCollectionView.dataSource = self
        followingCollectionView.register(FollowingCells.self, forCellWithReuseIdentifier: followId)
        followingCollectionView.anchor(top: followersCollectionView.bottomAnchor, left: followersCollectionView.leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 100, height: 60)
        followingCountLabel.anchor(top: nil, left: followingCollectionView.rightAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 10, paddingBottom: 0, paddingRight: 0, width: followingCountLabel.intrinsicContentSize.width, height: followingCountLabel.intrinsicContentSize.height)
        followingCountLabel.centerYAnchor.constraint(equalTo: followingCollectionView.centerYAnchor).isActive = true
    }
    
    func setupProfileDetails(){
        addSubview(usernameLabel)
        addSubview(fullnameLabel)
        addSubview(bioText)
        addSubview(messageBackground)
        addSubview(followBackground)
        addSubview(messageButton)
        addSubview(followButton)
        
        usernameLabel.anchor(top: statsContainer.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 24, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: usernameLabel.intrinsicContentSize.width, height: usernameLabel.intrinsicContentSize.height)
        usernameLabel.centerXAnchor.constraint(equalTo: statsContainer.centerXAnchor).isActive = true
        fullnameLabel.anchor(top: usernameLabel.bottomAnchor, left: statsContainer.leftAnchor, bottom: nil, right: statsContainer.rightAnchor, paddingTop: 18, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: fullnameLabel.intrinsicContentSize.width, height: fullnameLabel.intrinsicContentSize.height)
        bioText.anchor(top: fullnameLabel.bottomAnchor, left: statsContainer.leftAnchor, bottom: nil, right: statsContainer.rightAnchor, paddingTop: 8, paddingLeft: 8, paddingBottom: 0, paddingRight: 8, width: 0, height: 70)
        setupFollowersCollectionView()
        setupFollowingCollectionView()
        messageBackground.anchor(top: followingCollectionView.bottomAnchor, left: statsContainer.leftAnchor, bottom: nil, right: nil, paddingTop: 24, paddingLeft: 24, paddingBottom: 0, paddingRight: 0, width: 130, height: 40)
        messageButton.anchor(top: messageBackground.topAnchor, left: messageBackground.leftAnchor, bottom: messageBackground.bottomAnchor, right: messageBackground.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        followBackground.anchor(top: followingCollectionView.bottomAnchor, left: nil, bottom: nil, right: statsContainer.rightAnchor, paddingTop: 24, paddingLeft: 0, paddingBottom: 0, paddingRight: 24, width: 130, height: 40)
        followButton.anchor(top: followBackground.topAnchor, left: followBackground.leftAnchor, bottom: followBackground.bottomAnchor, right: followBackground.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
    }
    
    func setupView(){
        addSubview(imageView)
        addSubview(statsBackground)
        addSubview(statsContainer)
        addSubview(daysCount)
        addSubview(daysLabel)
        addSubview(daysSeperator)
        addSubview(pursuitCount)
        addSubview(pursuitLabel)
        addSubview(pursuitSeperator)
        addSubview(stepsCount)
        addSubview(stepsLabel)
        
        imageView.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 350)
        statsBackground.anchor(top: nil, left: imageView.leftAnchor, bottom: nil, right: imageView.rightAnchor, paddingTop: 0, paddingLeft: 18, paddingBottom: 0, paddingRight: 18, width: 0, height: 80)
        statsBackground.centerYAnchor.constraint(equalTo: imageView.bottomAnchor).isActive = true
        statsContainer.anchor(top: statsBackground.topAnchor, left: statsBackground.leftAnchor, bottom: statsBackground.bottomAnchor, right: statsBackground.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        daysCount.anchor(top: statsContainer.topAnchor, left: statsContainer.leftAnchor, bottom: nil, right: nil, paddingTop: 18, paddingLeft: 24, paddingBottom: 0, paddingRight: 0, width: daysCount.intrinsicContentSize.width, height: daysCount.intrinsicContentSize.height)
        daysLabel.anchor(top: daysCount.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 4, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 60, height: 24)
        daysLabel.centerXAnchor.constraint(equalTo: daysCount.centerXAnchor).isActive = true
        daysSeperator.anchor(top: daysLabel.topAnchor, left: daysLabel.rightAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 32, paddingBottom: 0, paddingRight: 0, width: 8, height: 8)
        pursuitCount.anchor(top: daysCount.topAnchor, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: pursuitCount.intrinsicContentSize.width, height: pursuitCount.intrinsicContentSize.height)
        pursuitCount.centerXAnchor.constraint(equalTo: statsContainer.centerXAnchor).isActive = true
        pursuitLabel.anchor(top: pursuitCount.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 4, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 80, height: 24)
        pursuitLabel.centerXAnchor.constraint(equalTo: pursuitCount.centerXAnchor).isActive = true
        pursuitSeperator.anchor(top: pursuitLabel.topAnchor, left: pursuitLabel.rightAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 32, paddingBottom: 0, paddingRight: 0, width: 8, height: 8)
        stepsCount.anchor(top: pursuitCount.topAnchor, left: nil, bottom: nil, right: statsContainer.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 24, width: stepsCount.intrinsicContentSize.width, height: stepsCount.intrinsicContentSize.height)
        stepsLabel.anchor(top: stepsCount.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 4, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 80, height: 24)
        stepsLabel.centerXAnchor.constraint(equalTo: stepsCount.centerXAnchor).isActive = true
        setupProfileDetails()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ProfileHeader :  UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: followId, for: indexPath) as! FollowingCells
        cell.imageView.image = fakeFollowerArray[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (frame.width / 12) - 15, height: 50)
    }
}
