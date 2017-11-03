//
//  HomeSecondaryRow.swift
//  pursue
//
//  Created by Jaylen Sanders on 9/26/17.
//  Copyright © 2017 Glory. All rights reserved.
//

import UIKit

class HomeSecondaryRow: UICollectionViewCell, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UICollectionViewDelegate {
    
    let ratingsId = "ratingsId"
    
    let cardInfoLabel : UILabel = {
        let label = UILabel()
        label.text = "WINTER IS HERE"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    let cardLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 24, weight: UIFont.Weight(rawValue: 25))
        label.numberOfLines = 0
        label.text = "Game of Thrones Season 7"
        label.textColor = .white
        return label
    }()
    
    let exerciseCard : CardView = {
        let view = CardView()
        view.backgroundColor = .green
        return view
    }()
    
    let postImage : UIImageView = {
       let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "ice-king")
        iv.layer.cornerRadius = 8
        iv.layer.masksToBounds = true
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    let postViews : UILabel = {
       let label = UILabel()
        label.text = "123,456 views"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()
    
    let ratingsCollectionView : UICollectionView = {
       let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
     func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell : RatingsCell
        
        switch indexPath.item {
        case 0:
            cell = ratingsCollectionView.dequeueReusableCell(withReuseIdentifier: ratingsId, for: indexPath) as! RatingsCell
            return cell
        case 1:
            cell = ratingsCollectionView.dequeueReusableCell(withReuseIdentifier: ratingOneId, for: indexPath) as! RatingOne
            return cell
        case 2:
            cell = ratingsCollectionView.dequeueReusableCell(withReuseIdentifier: ratingTwoId, for: indexPath) as! RatingTwo
            return cell
        case 3:
            cell = ratingsCollectionView.dequeueReusableCell(withReuseIdentifier: ratingThreeId, for: indexPath) as! RatingThree
            return cell
        case 4:
            cell = ratingsCollectionView.dequeueReusableCell(withReuseIdentifier: ratingFourId, for: indexPath) as! RatingFour
            return cell
        case 5:
            cell = ratingsCollectionView.dequeueReusableCell(withReuseIdentifier: moreOptionsId, for: indexPath) as! MoreOptions
            return cell
        default:
            cell = ratingsCollectionView.dequeueReusableCell(withReuseIdentifier: ratingsId, for: indexPath) as! RatingsCell
            return cell
        }
    }
    
     func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 60, height: 60)
    }
    
    let ratingOneId = "ratingOneId"
    let ratingTwoId = "ratingTwoId"
    let ratingThreeId = "ratingThreeId"
    let ratingFourId = "ratingFourId"
    let moreOptionsId = "moreOptionsId"

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        ratingsCollectionView.register(RatingsCell.self, forCellWithReuseIdentifier: ratingsId)
        ratingsCollectionView.register(RatingOne.self, forCellWithReuseIdentifier: ratingOneId)
        ratingsCollectionView.register(RatingTwo.self, forCellWithReuseIdentifier: ratingTwoId)
        ratingsCollectionView.register(RatingThree.self, forCellWithReuseIdentifier: ratingThreeId)
        ratingsCollectionView.register(RatingFour.self, forCellWithReuseIdentifier: ratingFourId)
        ratingsCollectionView.register(MoreOptions.self, forCellWithReuseIdentifier: moreOptionsId)

        ratingsCollectionView.dataSource = self
        ratingsCollectionView.delegate = self
        
        addSubview(exerciseCard)
        exerciseCard.addSubview(postImage)
        exerciseCard.addSubview(cardInfoLabel)
        exerciseCard.addSubview(cardLabel)
        exerciseCard.addSubview(ratingsCollectionView)
        exerciseCard.addSubview(postViews)
        
        exerciseCard.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 32, paddingBottom: 16, paddingRight: 32, width: 0, height: 0)
        postImage.anchor(top: exerciseCard.topAnchor, left: exerciseCard.leftAnchor, bottom: exerciseCard.bottomAnchor, right: exerciseCard.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        cardInfoLabel.anchor(top: postImage.topAnchor, left: postImage.leftAnchor, bottom: nil, right: nil, paddingTop: 12, paddingLeft: 16, paddingBottom: 0, paddingRight: 0, width: 0, height: 15)
        cardLabel.anchor(top: cardInfoLabel.bottomAnchor, left: cardInfoLabel.leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 250, height: 80)
        ratingsCollectionView.anchor(top: nil, left: cardInfoLabel.leftAnchor, bottom: postImage.bottomAnchor, right: postImage.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 12, paddingRight: 0, width: 0, height: 60)
        postViews.anchor(top: nil, left: ratingsCollectionView.leftAnchor, bottom: ratingsCollectionView.topAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 12, paddingRight: 0, width: 0, height: 15)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
