//
//  FeedChallengeRowCells.swift
//  pursue
//
//  Created by Jaylen Sanders on 10/30/17.
//  Copyright © 2017 Glory. All rights reserved.
//

import UIKit

class FeedChallengeCells : UICollectionViewCell {
    
    let usernameLabel : UILabel = {
        let label = UILabel()
        label.text = "Test27"
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let fullnameLabel : UILabel = {
        let label = UILabel()
        label.text = "Jaylen Sanders"
        label.font = UIFont.systemFont(ofSize: 12, weight: UIFont.Weight.thin)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let userPhoto : UIImageView = {
        let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "samuel-l")
        iv.layer.cornerRadius = 30
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
        
    }()
    
    let addedUsernameLabel : UILabel = {
        let label = UILabel()
        label.text = "Tom"
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .right
        return label
    }()
    
    let addedFullnameLabel : UILabel = {
        let label = UILabel()
        label.text = "Tom Hanks"
        label.font = UIFont.systemFont(ofSize: 12, weight: UIFont.Weight.thin)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .right
        return label
    }()
    
    let addedUserPhoto : UIImageView = {
        let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "clean-8")
        iv.layer.cornerRadius = 30
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
        
    }()
    
    let userPercentage : UILabel = {
        let label = UILabel()
        label.text = "82  -"
        label.font = UIFont.systemFont(ofSize: 24, weight: UIFont.Weight(rawValue: 25))
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let addedUserPercentage : UILabel = {
        let label = UILabel()
        label.text = "40"
        label.font = UIFont.systemFont(ofSize: 24, weight: UIFont.Weight(rawValue: 25))
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let pursuitName : UILabel = {
        let label = UILabel()
        label.text = "Design"
        label.font = UIFont.systemFont(ofSize: 12, weight: UIFont.Weight(rawValue: 25))
        return label
    }()
    
    let finishingDateLabel : UILabel = {
        let label = UILabel()
        label.text = "End Date - 10/23/2017"
        label.font = UIFont.systemFont(ofSize: 12, weight: UIFont.Weight(rawValue: 25))
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()
    
    let postUsernameLabel : UILabel = {
        let label = UILabel()
        label.text = "Test27"
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let postTimeDetail : UILabel = {
        let label = UILabel()
        label.text = "6 minutes ago"
        label.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.thin)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let postUserPhoto : UIImageView = {
        let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "samuel-l")
        iv.layer.cornerRadius = 30
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
        
    }()
    
    let bottomDividerView = UIView()
    var stackView = UIStackView()
    let pathView = PathView()
    
    func setupScores(){
        stackView = UIStackView(arrangedSubviews: [userPercentage, addedUserPercentage])
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(stackView)
        addSubview(pursuitName)
        addSubview(finishingDateLabel)
        
        stackView.anchor(top: nil, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 24)
        stackView.centerYAnchor.constraint(equalTo: userPhoto.centerYAnchor).isActive = true
        stackView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        pursuitName.anchor(top: fullnameLabel.topAnchor, left: userPercentage.centerXAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 14)
        finishingDateLabel.anchor(top: usernameLabel.topAnchor, left:  nil, bottom: nil, right: nil, paddingTop: 4, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 14)
        finishingDateLabel.centerXAnchor.constraint(equalTo: pursuitName.centerXAnchor).isActive = true
    }
    
    func setupAddedUser(){
        addSubview(addedUserPhoto)
        addSubview(addedFullnameLabel)
        addSubview(addedUsernameLabel)
        addSubview(pathView)
        
        pathView.translatesAutoresizingMaskIntoConstraints = false
        
        addedUserPhoto.anchor(top: topAnchor, left: nil, bottom: nil, right: rightAnchor, paddingTop: 32, paddingLeft: 0, paddingBottom: 0, paddingRight: 12, width: 60, height: 60)
        addedFullnameLabel.anchor(top: addedUserPhoto.bottomAnchor, left: nil, bottom: nil, right: addedUserPhoto.rightAnchor, paddingTop: 12, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 150, height: 16)
        addedUsernameLabel.anchor(top: addedFullnameLabel.bottomAnchor, left: nil, bottom: nil, right: addedFullnameLabel.rightAnchor, paddingTop: 8, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: addedUsernameLabel.intrinsicContentSize.width, height: 18)
    }
    
    func setupView(){
        addSubview(userPhoto)
        addSubview(fullnameLabel)
        addSubview(usernameLabel)
        addSubview(bottomDividerView)
        addSubview(userPercentage)
        
        userPhoto.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 32, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: 60, height: 60)
        fullnameLabel.anchor(top: userPhoto.bottomAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 12, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: 150, height: 16)
        usernameLabel.anchor(top: fullnameLabel.bottomAnchor, left: fullnameLabel.leftAnchor, bottom: nil, right: nil, paddingTop: 8, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: usernameLabel.intrinsicContentSize.width, height: 18)
        
        setupAddedUser()
        setupScores()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
