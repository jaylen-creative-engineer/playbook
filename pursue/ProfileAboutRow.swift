//
//  ProfileAboutRow.swift
//  pursue
//
//  Created by Jaylen Sanders on 2/24/18.
//  Copyright © 2018 Glory. All rights reserved.
//

import UIKit

class ProfileAboutRow : UICollectionViewCell, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UICollectionViewDelegate {
    
    let cellId = "cellId"
    
    let fullnameLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.init(25))
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Jaylen Sanders"
        return label
    }()
    
    let usernameLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "JaylenHU27"
        return label
    }()
    
    lazy var notificationsBackground : CardView = {
        let view = CardView()
        view.backgroundColor = .black
        view.layer.cornerRadius = 20
        view.translatesAutoresizingMaskIntoConstraints = false
        
//        let tap = UITapGestureRecognizer(target: self, action: #selector(changeProfilePicture))
//        tap.numberOfTapsRequired = 1
//        view.addGestureRecognizer(tap)
        return view
    }()
    
    lazy var gearImageView : UIImageView = {
       let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "gear").withRenderingMode(.alwaysTemplate)
        iv.tintColor = .white
        iv.contentMode = .scaleAspectFill
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    let followersCount : UILabel = {
       let label = UILabel()
        label.text = "123"
        label.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.init(25))
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let followersLabel : UILabel = {
       let label = UILabel()
        label.text = "Followers"
        label.font = UIFont.systemFont(ofSize: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let followingCount : UILabel = {
        let label = UILabel()
        label.text = "123"
        label.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.init(25))
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let followingLabel : UILabel = {
        let label = UILabel()
        label.text = "Following"
        label.font = UIFont.systemFont(ofSize: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var userBio : UITextView = {
        let tv = UITextView()
        tv.delegate = self
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.font = UIFont.systemFont(ofSize: 12)
        tv.isScrollEnabled = false
        tv.isUserInteractionEnabled = false
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 5
        paragraphStyle.paragraphSpacing = 5
        
        let attrString = NSMutableAttributedString(string: "I m working on Mobile app UI Kit which will have more than 100+ screen in Adobe XD, Adobe Photoshop, and Sketch. From Multipurpose UI Kit I am sharing few Profile Screens total is 24.")
        attrString.addAttribute(NSAttributedStringKey.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, attrString.length))
        
        tv.attributedText = attrString
        return tv
    }()
    
    let collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    let rowLabel : UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.text = "Pursuits"
        label.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight(25))
        return label
    }()

    lazy var moreButton : UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "right-arrow-1").withRenderingMode(.alwaysOriginal), for: .normal)
        return button
    }()
    
    
    func setupCollectionView(){
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(ProfilePostCells.self, forCellWithReuseIdentifier: cellId)
        addSubview(rowLabel)
        addSubview(moreButton)
        addSubview(collectionView)
        
        rowLabel.anchor(top: userBio.bottomAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 24, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: rowLabel.intrinsicContentSize.width, height: rowLabel.intrinsicContentSize.height)
        moreButton.anchor(top: rowLabel.topAnchor, left: nil, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 20, width: 24, height: 12)
        collectionView.anchor(top: rowLabel.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 12, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 370)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(0, 12, 0, 12)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (frame.width / 2) + 60, height: 425)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ProfilePostCells
        return cell
    }
    
    func setupFollowSystem(){
        addSubview(followersCount)
        addSubview(followersLabel)
        addSubview(followingCount)
        addSubview(followingLabel)
        addSubview(userBio)
        
        followersLabel.anchor(top: usernameLabel.bottomAnchor, left: usernameLabel.leftAnchor, bottom: nil, right: nil, paddingTop: 46, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: followersLabel.intrinsicContentSize.width, height: followersLabel.intrinsicContentSize.height)
        followersCount.anchor(top: nil, left: nil, bottom: followersLabel.topAnchor, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 6, paddingRight: 0, width: followersCount.intrinsicContentSize.width, height: followersCount.intrinsicContentSize.height)
        followersCount.centerXAnchor.constraint(equalTo: followersLabel.centerXAnchor).isActive = true
        
        followingCount.anchor(top: followersCount.topAnchor, left: followersLabel.rightAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 62, paddingBottom: 0, paddingRight: 0, width: followingCount.intrinsicContentSize.width, height: followingCount.intrinsicContentSize.height)
        followingLabel.anchor(top: followingCount.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 6, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: followingLabel.intrinsicContentSize.width, height: followingLabel.intrinsicContentSize.height)
        followingLabel.centerXAnchor.constraint(equalTo: followingCount.centerXAnchor).isActive = true
        
        userBio.anchor(top: followingLabel.bottomAnchor, left: leftAnchor, bottom: nil, right: notificationsBackground.rightAnchor, paddingTop: 18, paddingLeft: 8, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        textViewDidChange(userBio)
        setupCollectionView()
    }
    
    func setupView(){
        addSubview(fullnameLabel)
        addSubview(usernameLabel)
        addSubview(notificationsBackground)
        addSubview(gearImageView)
        fullnameLabel.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 12, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: fullnameLabel.intrinsicContentSize.width, height: fullnameLabel.intrinsicContentSize.height)
        usernameLabel.anchor(top: fullnameLabel.bottomAnchor, left: fullnameLabel.leftAnchor, bottom: nil, right: nil, paddingTop: 12, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: usernameLabel.intrinsicContentSize.width, height: usernameLabel.intrinsicContentSize.height)
        notificationsBackground.anchor(top: topAnchor, left: nil, bottom: nil, right: rightAnchor, paddingTop: 12, paddingLeft: 0, paddingBottom: 0, paddingRight: 12, width: 40, height: 40)
        gearImageView.anchor(top: nil, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 15, height: 15)
        gearImageView.centerXAnchor.constraint(equalTo: notificationsBackground.centerXAnchor).isActive = true
        gearImageView.centerYAnchor.constraint(equalTo: notificationsBackground.centerYAnchor).isActive = true
        setupFollowSystem()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ProfileAboutRow : UITextViewDelegate {
    
    func textViewDidChange(_ textView: UITextView) {
        let size = CGSize(width: frame.width - 24, height: .infinity)
        
        let estimatedSize = textView.sizeThatFits(size)
        
        textView.constraints.forEach { (constraint) in
            constraint.constant = estimatedSize.height
        }
    }
}
