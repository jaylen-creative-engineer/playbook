//
//  HomeRowCells.swift
//  pursue
//
//  Created by Jaylen Sanders on 9/21/17.
//  Copyright © 2017 Glory. All rights reserved.
//

import UIKit

class HomeRowCells : UICollectionViewCell {
    
    let homeImage : UIImageView = {
        let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "tumblr_nbje6dualg1r46py4o1_1280")
        iv.layer.masksToBounds = true
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    let homeMainDescription : UILabel = {
       let label = UILabel()
        label.text = "Wonder Woman Again"
        label.font = UIFont.systemFont(ofSize: 20, weight: UIFont.Weight(rawValue: 25))
        label.numberOfLines = 2
        label.textColor = .black
        return label
    }()
    
    let homeSubDesctiption : UILabel = {
        let label = UILabel()
        label.text = "Return To IMAX"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.thin)
        label.numberOfLines = 2
        return label
    }()
    
    let cardView : HomeView = {
        let card = HomeView()
        card.backgroundColor = .clear
        card.translatesAutoresizingMaskIntoConstraints = false
        return card
    }()
    
    func setupView() {        
        addSubview(homeImage)
        addSubview(homeMainDescription)
        addSubview(homeSubDesctiption)
        
        homeImage.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 42, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 250)
        homeMainDescription.anchor(top: homeImage.bottomAnchor, left: homeImage.leftAnchor, bottom: nil, right: homeImage.rightAnchor, paddingTop: 16, paddingLeft: 0, paddingBottom: 0, paddingRight: 8, width: 0, height: homeMainDescription.intrinsicContentSize.height)
        homeSubDesctiption.anchor(top: homeMainDescription.bottomAnchor, left: homeMainDescription.leftAnchor, bottom: nil, right: homeMainDescription.rightAnchor, paddingTop: 8, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 16)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
