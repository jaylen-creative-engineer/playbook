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
    
    let expand : UIImageView = {
       let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "expand_arrow1600").withRenderingMode(.alwaysOriginal)
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    let statsLabel : UILabel = {
       let label = UILabel()
        label.text = "Stats"
        label.font = UIFont(name: "Lato-Bold", size: 14)
        return label
    }()
    
    let dropdownButton : UIButton = {
       let button = UIButton()
        button.setTitle("20", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont(name: "Lato-Bold", size: 12)
        button.titleLabel?.textAlignment = .left
        return button
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
        label.font = UIFont(name: "Lato-Black", size: 18)
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
        button.titleLabel?.font = UIFont(name: "Lato-Bold", size: 14)
        button.layer.cornerRadius = 20
        button.layer.masksToBounds = true
        return button
    }()
    
    lazy var followButton : UIButton = {
       let button = UIButton()
        button.backgroundColor = .white
        button.setTitle("Add", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont(name: "Lato-Bold", size: 14)
        button.layer.cornerRadius = 20
        button.layer.masksToBounds = true
        return button
    }()
    
    lazy var addedCollectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isScrollEnabled = false
        collectionView.isUserInteractionEnabled = true
        return collectionView
    }()
    
    let addedCountLabel : UILabel = {
        let label = UILabel()
        label.text = "120 Added."
        label.font = UIFont(name: "Lato-Bold", size: 14)
        return label
    }()
    
    let pursuitsRowLabel : UILabel = {
       let label = UILabel()
        label.text = "Pursuits."
        label.font = UIFont(name: "Lato-Bold", size: 14)
        return label
    }()
    
    var fakeFollowerArray = [#imageLiteral(resourceName: "samuel-l"), #imageLiteral(resourceName: "comment-4"), #imageLiteral(resourceName: "comment-5"), #imageLiteral(resourceName: "comment-4"), #imageLiteral(resourceName: "comment-7")]
    
    func setupFollowersCollectionView(){
        addSubview(addedCollectionView)
        addSubview(addedCountLabel)
        addSubview(pursuitsRowLabel)
        
        addedCollectionView.delegate = self
        addedCollectionView.dataSource = self
        addedCollectionView.register(FollowingCells.self, forCellWithReuseIdentifier: followId)
        
        addedCountLabel.anchor(top: messageButton.bottomAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 42, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: addedCountLabel.intrinsicContentSize.width, height: addedCountLabel.intrinsicContentSize.height)
        addedCollectionView.anchor(top: addedCountLabel.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 18, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 100, height: 60)
        pursuitsRowLabel.anchor(top: nil, left: leftAnchor, bottom: bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: pursuitsRowLabel.intrinsicContentSize.width, height: pursuitsRowLabel.intrinsicContentSize.height)
    }
    
    
    func setupProfileDetails(){
        addSubview(usernameLabel)
        addSubview(fullnameLabel)
        addSubview(bioText)
        addSubview(messageBackground)
        addSubview(followBackground)
        addSubview(messageButton)
        addSubview(followButton)
        
        usernameLabel.anchor(top: backgroundFill.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 12, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: usernameLabel.intrinsicContentSize.width, height: usernameLabel.intrinsicContentSize.height)
        usernameLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        fullnameLabel.anchor(top: usernameLabel.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 18, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: fullnameLabel.intrinsicContentSize.width, height: fullnameLabel.intrinsicContentSize.height)
        fullnameLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        bioText.anchor(top: fullnameLabel.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 8, paddingLeft: 24, paddingBottom: 0, paddingRight: 24, width: 0, height: 70)
        messageBackground.anchor(top: bioText.bottomAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 24, paddingLeft: 48, paddingBottom: 0, paddingRight: 0, width: 130, height: 40)
        messageButton.anchor(top: messageBackground.topAnchor, left: messageBackground.leftAnchor, bottom: messageBackground.bottomAnchor, right: messageBackground.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        followBackground.anchor(top: bioText.bottomAnchor, left: nil, bottom: nil, right: rightAnchor, paddingTop: 24, paddingLeft: 0, paddingBottom: 0, paddingRight: 48, width: 130, height: 40)
        followButton.anchor(top: followBackground.topAnchor, left: followBackground.leftAnchor, bottom: followBackground.bottomAnchor, right: followBackground.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        setupFollowersCollectionView()
        
    }
    
    let backgroundFill = RectangleView()
    
    func setupStatsLabel(){
        backgroundFill.backgroundColor = .white
        
        addSubview(backgroundFill)
        addSubview(statsLabel)
        addSubview(dropdownButton)
        addSubview(expand)
        
        backgroundFill.anchor(top: imageView.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 50)
        statsLabel.anchor(top: nil, left: leftAnchor, bottom: nil, right: nil, paddingTop: 18, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: statsLabel.intrinsicContentSize.width, height: statsLabel.intrinsicContentSize.height)
        statsLabel.centerYAnchor.constraint(equalTo: backgroundFill.centerYAnchor).isActive = true
        dropdownButton.anchor(top: nil, left: nil, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 32, width: 20, height: 24)
        dropdownButton.centerYAnchor.constraint(equalTo: statsLabel.centerYAnchor).isActive = true
        expand.anchor(top: nil, left: dropdownButton.rightAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 6, paddingBottom: 0, paddingRight: 0, width: 10, height: 10)
        expand.centerYAnchor.constraint(equalTo: dropdownButton.centerYAnchor).isActive = true
    }
    
    func setupView(){
        addSubview(imageView)
        imageView.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 350)
        setupStatsLabel()
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
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: followId, for: indexPath) as! FollowingCells
        cell.imageView.image = fakeFollowerArray[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (frame.width / 7) - 15, height: 50)
    }
}
