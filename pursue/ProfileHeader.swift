//
//  ProfileHeader.swift
//  pursue
//
//  Created by Jaylen Sanders on 9/12/17.
//  Copyright © 2017 Glory. All rights reserved.
//

import UIKit

protocol ProfileHeaderDelegate {
    func handleMessage()
    func handleSettings()
}

class ProfileHeader : UICollectionViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var accessHomeController : HomeController?
    var delegate : ProfileHeaderDelegate?
    
    let cellId = "cellId"
    
    let postCollection : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    lazy var settingsButton : UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "gear").withRenderingMode(.alwaysOriginal), for: .normal)
        button.addTarget(self, action: #selector(handleSettings), for: .touchUpInside)
        button.backgroundColor = .white
        return button
    }()
    
    lazy var chatButton : UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "chat_2").withRenderingMode(.alwaysOriginal), for: .normal)
        button.addTarget(self, action: #selector(handleChat), for: .touchUpInside)
        button.backgroundColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var chatBackground : UIButton = {
       let button = UIButton()
        button.backgroundColor = .white
        button.layer.cornerRadius = 20
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(handleChat), for: .touchUpInside)
        return button
    }()
    
    lazy var settingsBackground : UIButton = {
        let button = UIButton()
        button.backgroundColor = .white
        button.layer.cornerRadius = 20
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(handleSettings), for: .touchUpInside)
        return button
    }()
    
    let photoImageView : UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.layer.cornerRadius = 50
        iv.clipsToBounds = true
        iv.image = #imageLiteral(resourceName: "profile-2")
        return iv
    }()
    
    let usernameLabel : UILabel = {
        let label = UILabel()
        label.text = "Jubilee"
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let fullnameLabel : UILabel = {
        let label = UILabel()
        label.text = "Thomas Sanders"
        label.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.thin)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let userBio : UILabel = {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 5
        let label = UILabel()
        label.numberOfLines = 0
        
        let attrString = NSMutableAttributedString(string: "Being the richest man")
        attrString.addAttribute(NSAttributedStringKey.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, attrString.length))
        
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.attributedText = attrString
        label.backgroundColor = .clear
        label.translatesAutoresizingMaskIntoConstraints = false
        label.sizeToFit()
        return label
    }()
    
    @objc func handleSettings() {
        delegate?.handleSettings()
    }
    
    @objc func handleChat(){
        delegate?.handleMessage()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 8
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: ((frame.width - 2) / 5) + 20, height: ((frame.width - 2) / 6) - 25)
    }
    
    
    let interestsNames = ["Adventure", "Animals", "Art", "Business"]
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ProfileAboutCells
        cell.selectInterests.text = interestsNames[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(0, 12, 0, 12)
    }
    
    func setupProfileOptions(){
        addSubview(settingsButton)
        addSubview(chatButton)
        
        settingsButton.anchor(top: topAnchor, left: nil, bottom: nil, right: rightAnchor, paddingTop: 64, paddingLeft: 0, paddingBottom: 0, paddingRight: 20, width: 26, height: 26)
        chatButton.anchor(top: settingsButton.topAnchor, left: nil, bottom: nil, right: settingsButton.leftAnchor, paddingTop: 2, paddingLeft: 0, paddingBottom: 0, paddingRight: 32, width: 30, height: 22)
    }
    
    func setupView(){
        let userInfoStack = UIStackView(arrangedSubviews: [usernameLabel, fullnameLabel])
        userInfoStack.axis = .vertical
        userInfoStack.spacing = 10
        userInfoStack.translatesAutoresizingMaskIntoConstraints = false
                
        addSubview(photoImageView)
        addSubview(userInfoStack)
        addSubview(userBio)
        addSubview(postCollection)
        photoImageView.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 64, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: 100, height: 100)
        userInfoStack.anchor(top: nil, left: photoImageView.rightAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 12, paddingBottom: 0, paddingRight: 12, width: 0, height: 0)
        userInfoStack.centerYAnchor.constraint(equalTo: photoImageView.centerYAnchor).isActive = true
        userBio.anchor(top: photoImageView.bottomAnchor, left: photoImageView.leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 24, paddingLeft: 0, paddingBottom: 0, paddingRight: 12, width: 0, height: userBio.intrinsicContentSize.height)
        postCollection.anchor(top: userBio.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 80)
        setupProfileOptions()
    }
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        
        postCollection.register(ProfileAboutCells.self, forCellWithReuseIdentifier: cellId)
        postCollection.dataSource = self
        postCollection.delegate = self
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
