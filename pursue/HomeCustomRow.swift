//
//  HomeCustomRow.swift
//  pursue
//
//  Created by Jaylen Sanders on 9/26/17.
//  Copyright © 2017 Glory. All rights reserved.
//

import UIKit

class HomeCustomRow: UICollectionViewCell, UICollectionViewDelegateFlowLayout {
    
    let cardInfoLabel : UILabel = {
        let label = UILabel()
        label.text = "Samuel L. Jackson"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight(rawValue: 25))
        return label
    }()
    
    let viewsNumber : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 42, weight: UIFont.Weight(rawValue: 25))
        label.numberOfLines = 0
        label.text = "36"
        label.textColor = .white
        return label
    }()
    
    let viewsLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.text = "Videos"
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
        iv.image = #imageLiteral(resourceName: "samuel-l")
        iv.layer.cornerRadius = 8
        iv.layer.masksToBounds = true
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    let topPostCover : UIView = {
        let film = UIView()
        film.backgroundColor = UIColor(red: 255/255, green: 153/255, blue: 51/255, alpha: 0.5)
        film.layer.cornerRadius = 8
        film.layer.masksToBounds = true
        return film
    }()
    
    let topPostImage : UIImageView = {
        let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "scarlett")
        iv.contentMode = .scaleAspectFill
        iv.layer.cornerRadius = 8
        iv.layer.masksToBounds = true
        return iv
    }()
    
    let topCardInfoLabel : UILabel = {
        let label = UILabel()
        label.text = "Scarlett Johansson"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 12, weight: UIFont.Weight(rawValue: 25))
        return label
    }()
    
    let topViewsNumber : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 42, weight: UIFont.Weight(rawValue: 25))
        label.numberOfLines = 0
        label.text = "28"
        label.textColor = .blue
        return label
    }()
    
    let topViewsLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.text = "Videos"
        label.textColor = .blue
        return label
    }()
    
    let topExerciseCard : SmallerCardView = {
        let view = SmallerCardView()
        view.backgroundColor = .green
        return view
    }()
    
    let bottomPostCover : UIView = {
        let film = UIView()
        film.backgroundColor = UIColor(red: 51/255, green: 255/255, blue: 51/255, alpha: 0.5)
        film.layer.cornerRadius = 8
        film.layer.masksToBounds = true
        return film
    }()
    
    let bottomPostImage : UIImageView = {
        let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "tom-2")
        iv.contentMode = .scaleAspectFill
        iv.layer.cornerRadius = 8
        iv.layer.masksToBounds = true
        return iv
    }()
    
    let bottomCardInfoLabel : UILabel = {
        let label = UILabel()
        label.text = "Tom Hanks"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 12, weight: UIFont.Weight(rawValue: 25))
        return label
    }()
    
    let bottomViewsNumber : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 42, weight: UIFont.Weight(rawValue: 25))
        label.numberOfLines = 0
        label.text = "56"
        label.textColor = .white
        return label
    }()
    
    let bottomViewsLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.text = "Videos"
        label.textColor = .white
        return label
    }()
    
    let bottomExerciseCard : SmallerCardView = {
        let view = SmallerCardView()
        view.backgroundColor = .green
        return view
    }()
    
    func setupView(){
        backgroundColor = .clear
        addSubview(exerciseCard)
        exerciseCard.addSubview(postImage)
        exerciseCard.addSubview(cardInfoLabel)
        exerciseCard.addSubview(viewsNumber)
        exerciseCard.addSubview(viewsLabel)
        
        addSubview(topExerciseCard)
        topExerciseCard.addSubview(topPostImage)
        topExerciseCard.addSubview(topPostCover)
        topExerciseCard.addSubview(topCardInfoLabel)
        topExerciseCard.addSubview(topViewsNumber)
        topExerciseCard.addSubview(topViewsLabel)
        
        addSubview(bottomExerciseCard)
        bottomExerciseCard.addSubview(bottomPostImage)
        bottomExerciseCard.addSubview(bottomPostCover)
        bottomExerciseCard.addSubview(bottomCardInfoLabel)
        bottomExerciseCard.addSubview(bottomViewsNumber)
        bottomExerciseCard.addSubview(bottomViewsLabel)
        
        exerciseCard.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 32, paddingBottom: 0, paddingRight: 8, width: (frame.width / 2) - 50, height: 0)
        postImage.anchor(top: exerciseCard.topAnchor, left: exerciseCard.leftAnchor, bottom: exerciseCard.bottomAnchor, right: exerciseCard.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        cardInfoLabel.anchor(top: exerciseCard.topAnchor, left: exerciseCard.leftAnchor, bottom: nil, right: exerciseCard.rightAnchor, paddingTop: 12, paddingLeft: 16, paddingBottom: 0, paddingRight: 8, width: 0, height: 15)
        viewsNumber.anchor(top: cardInfoLabel.bottomAnchor, left: cardInfoLabel.leftAnchor, bottom: nil, right: cardInfoLabel.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 12, width: 0, height: 45)
        viewsLabel.anchor(top: viewsNumber.bottomAnchor, left: viewsNumber.leftAnchor, bottom: nil, right: viewsNumber.rightAnchor, paddingTop: 4, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 50, height: 15)
        
        topExerciseCard.anchor(top: topAnchor, left: exerciseCard.rightAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 8, paddingBottom: 0, paddingRight: 32, width: 0, height: (frame.height / 2))
        topPostImage.anchor(top: topExerciseCard.topAnchor, left: topExerciseCard.leftAnchor, bottom: topExerciseCard.bottomAnchor, right: topExerciseCard.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        topPostCover.anchor(top: topPostImage.topAnchor, left: topPostImage.leftAnchor, bottom: topPostImage.bottomAnchor, right: topPostImage.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        topCardInfoLabel.anchor(top: topPostCover.topAnchor, left: topPostCover.leftAnchor, bottom: nil, right: topPostCover.rightAnchor, paddingTop: 12, paddingLeft: 16, paddingBottom: 0, paddingRight: 8, width: 0, height: 15)
        topViewsNumber.anchor(top: topCardInfoLabel.bottomAnchor, left: topCardInfoLabel.leftAnchor, bottom: nil, right: topCardInfoLabel.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 12, width: 0, height: 45)
        topViewsLabel.anchor(top: topViewsNumber.bottomAnchor, left: topViewsNumber.leftAnchor, bottom: nil, right: topViewsNumber.rightAnchor, paddingTop: 4, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 50, height: 15)
        
        bottomExerciseCard.anchor(top: topExerciseCard.bottomAnchor, left: topExerciseCard.leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 8, paddingLeft: 0, paddingBottom: 0, paddingRight: 32, width: 0, height: 0)
        bottomPostImage.anchor(top: bottomExerciseCard.topAnchor, left: bottomExerciseCard.leftAnchor, bottom: bottomExerciseCard.bottomAnchor, right: bottomExerciseCard.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        bottomPostCover.anchor(top: bottomPostImage.topAnchor, left: bottomPostImage.leftAnchor, bottom: bottomPostImage.bottomAnchor, right: bottomPostImage.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        bottomCardInfoLabel.anchor(top: bottomPostCover.topAnchor, left: bottomPostCover.leftAnchor, bottom: nil, right: bottomPostCover.rightAnchor, paddingTop: 12, paddingLeft: 16, paddingBottom: 0, paddingRight: 8, width: 0, height: 15)
        bottomViewsNumber.anchor(top: bottomCardInfoLabel.bottomAnchor, left: bottomCardInfoLabel.leftAnchor, bottom: nil, right: bottomCardInfoLabel.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 12, width: 0, height: 45)
        bottomViewsLabel.anchor(top: bottomViewsNumber.bottomAnchor, left: bottomViewsNumber.leftAnchor, bottom: nil, right: bottomViewsNumber.rightAnchor, paddingTop: 4, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 50, height: 15)

    
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
