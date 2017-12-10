//
//  FeedRowCells.swift
//  pursue
//
//  Created by Jaylen Sanders on 10/30/17.
//  Copyright © 2017 Glory. All rights reserved.
//

import UIKit

class FeedRowCells : UICollectionViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    let timeDetail : UILabel = {
        let label = UILabel()
        label.text = "6 minutes ago"
        label.font = UIFont.systemFont(ofSize: 12, weight: UIFont.Weight.thin)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        return label
    }()
    
    let postLabel : UILabel = {
        let label = UILabel()
        label.text = "I just wanted you guys to see what I did yesterday."
        label.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight(rawValue: 25))
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        return label
    }()
    
    let userPhoto : UIImageView = {
        let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "samuel-l")
        iv.layer.cornerRadius = 25
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
    }()
    
    let exerciseCardImage : UIImageView = {
        let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "backpack")
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
    }()
    
    let cardButton : UIButton = {
       let button = UIButton()
        return button
    }()
    
    let likeId = "likeId"
    
    let likesCollection : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    lazy var addButton : UIButton = {
        let button = UIButton()
        button.backgroundColor = .black
        button.layer.cornerRadius = 20
        button.layer.masksToBounds = true
        return button
    }()
    
    let usernameLabel : UILabel = {
        let label = UILabel()
        label.text = "Test27"
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let plusForButton : UIImageView = {
        let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "add-button-white-hi").withRenderingMode(.alwaysOriginal)
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: ((frame.width - 2) / 8) - 10, height: ((frame.width - 2) / 8))
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: likeId, for: indexPath) as! FeedLikesCell
        return cell
    }
    
    func setupCardView(){
        addSubview(cardButton)
        cardButton.addSubview(exerciseCardImage)
        
        cardButton.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 12, paddingLeft: 12, paddingBottom: 0, paddingRight: 12, width: 0, height: 240)
        exerciseCardImage.anchor(top: cardButton.topAnchor, left: cardButton.leftAnchor, bottom: cardButton.bottomAnchor, right: cardButton.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
    }
    
    func postDetailSetup(){
        let postInfoStack = UIStackView(arrangedSubviews: [usernameLabel, timeDetail])
        postInfoStack.axis = .vertical
        postInfoStack.spacing = 10
        postInfoStack.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(postInfoStack)
        
        postInfoStack.anchor(top: nil, left: userPhoto.rightAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 12, paddingBottom: 0, paddingRight: 12, width: 0, height: 0)
        postInfoStack.centerYAnchor.constraint(equalTo: userPhoto.centerYAnchor).isActive = true
        
    }
    
    func setupView(){
        exerciseCardImage.addSubview(userPhoto)
        userPhoto.anchor(top: exerciseCardImage.topAnchor, left: exerciseCardImage.leftAnchor, bottom: nil, right: nil, paddingTop: 12, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: 50, height: 50)
        setupCardView()
        
        addSubview(postLabel)
        postLabel.anchor(top: cardButton.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 8, paddingLeft: 12, paddingBottom: 0, paddingRight: 16, width: 0, height: 48)
        postDetailSetup()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        likesCollection.delegate = self
        likesCollection.dataSource = self
        likesCollection.register(FeedLikesCell.self, forCellWithReuseIdentifier: likeId)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
