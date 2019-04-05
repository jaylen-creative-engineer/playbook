//
//  HomeStandardCell.swift
//  Inpursuit
//
//  Created by Jaylen Sanders on 12/21/18.
//  Copyright © 2018 Glory. All rights reserved.
//

import UIKit
import iCarousel

class HomeStandardCell : UICollectionViewCell {
 
    let teamId = "teamId"
    let standardId = "standardId"
    
    let usernameLabel : UILabel = {
        let label = UILabel()
        label.text = "Test"
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()
    
    let userPhoto : UIImageView = {
       let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.layer.cornerRadius = 15
        iv.layer.masksToBounds = true
        iv.image = UIImage(named: "cafe-768771_1280")?.withRenderingMode(.alwaysOriginal)
        return iv
    }()
    
    let cellBackgroundView : HomeCellConflictShadowView = {
        let view = HomeCellConflictShadowView()
        view.backgroundColor = .white
        return view
    }()
    
    let detailLabel : UILabel = {
       let label = UILabel()
        label.text = "This is filler text"
        label.textColor = .white
        label.numberOfLines = 2
        label.font = UIFont.boldSystemFont(ofSize: 22)
        return label
    }()
    
    let pursuitImageView : UIImageView = {
       let iv = UIImageView()
        iv.image = UIImage(named: "cafe-768771_1280")?.withRenderingMode(.alwaysOriginal)
        iv.contentMode = .scaleAspectFill
        iv.layer.masksToBounds = true
        return iv
    }()
    
    let seperatorView : UIView = {
        let view = UIView()
        view.backgroundColor = .darkGray
        view.layer.cornerRadius = 2
        view.layer.masksToBounds = true
        return view
    }()
    
    let timeLeftLabel : UILabel = {
        let label = UILabel()
        label.text = "3 Weeks Left"
        label.numberOfLines = 1
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()
    
    let overlayView : UIView = {
       let view = UIView()
        return view
    }()
    
    let collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.showsHorizontalScrollIndicator = false
        cv.backgroundColor = .clear
        return cv
    }()
    
    func setupCollectionView(){
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(HomeTeam.self, forCellWithReuseIdentifier: teamId)
        collectionView.register(HomeStandard.self, forCellWithReuseIdentifier: standardId)
        
        addSubview(collectionView)
        collectionView.anchor(top: cellBackgroundView.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 24, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 130)
    }
    
    func setupView(){
        addSubview(cellBackgroundView)
        addSubview(pursuitImageView)
        addSubview(userPhoto)
        addSubview(usernameLabel)
        addSubview(seperatorView)
        addSubview(timeLeftLabel)
        addSubview(overlayView)
        insertSubview(detailLabel, aboveSubview: overlayView)
        
        cellBackgroundView.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 32, paddingLeft: 24, paddingBottom: 0, paddingRight: 24, width: 0, height: 520)
        pursuitImageView.anchor(top: cellBackgroundView.topAnchor, left: cellBackgroundView.leftAnchor, bottom: nil, right: cellBackgroundView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 460)
        userPhoto.anchor(top: nil, left: cellBackgroundView.leftAnchor, bottom: cellBackgroundView.bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 18, paddingBottom: 18, paddingRight: 0, width: 30, height: 30)
        usernameLabel.anchor(top: nil, left: userPhoto.rightAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 10, paddingBottom: 0, paddingRight: 0, width: usernameLabel.intrinsicContentSize.width, height: 16)
        usernameLabel.centerYAnchor.constraint(equalTo: userPhoto.centerYAnchor).isActive = true
        seperatorView.centerYAnchor.constraint(equalTo: usernameLabel.centerYAnchor).isActive = true
        seperatorView.anchor(top: nil, left: usernameLabel.rightAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 4, paddingBottom: 0, paddingRight: 0, width: 4, height: 4)
        timeLeftLabel.anchor(top: nil, left: seperatorView.rightAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 4, paddingBottom: 0, paddingRight: 0, width: timeLeftLabel.intrinsicContentSize.width, height: 16)
        timeLeftLabel.centerYAnchor.constraint(equalTo: userPhoto.centerYAnchor).isActive = true
        overlayView.anchor(top: nil, left: pursuitImageView.leftAnchor, bottom: pursuitImageView.bottomAnchor, right: pursuitImageView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 150)
        detailLabel.anchor(top: nil, left: overlayView.leftAnchor, bottom: overlayView.bottomAnchor, right: overlayView.rightAnchor, paddingTop: 0, paddingLeft: 18, paddingBottom: 28, paddingRight: 12, width: 0, height: 0)
        detailLabel.heightAnchor.constraint(lessThanOrEqualToConstant: 44).isActive = true
        setupCollectionView()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        pursuitImageView.roundCorners(corners: [.topLeft, .topRight], radius: 10)
        overlayView.applyGradient(colours: [.clear, UIColor.init(white: 0.16, alpha: 0.92)], locations: [0.1, 0.8])
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension HomeStandardCell : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 15.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 15.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 24)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.item {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: standardId, for: indexPath) as! HomeStandard
            return cell
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: teamId, for: indexPath) as! HomeTeam
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width / 1.4, height: 120)
    }
}
