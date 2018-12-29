//
//  HomeConflict.swift
//  Inpursuit
//
//  Created by Jaylen Sanders on 12/20/18.
//  Copyright © 2018 Glory. All rights reserved.
//

import UIKit

class HomeConflict : UICollectionViewCell {
    
    let cellBackgroundView : SolutionCardView = {
        let view = SolutionCardView()
        view.backgroundColor = .white
        return view
    }()
    
    let dayImageView : UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "cafe-768771_1280")?.withRenderingMode(.alwaysOriginal)
        iv.contentMode = .scaleAspectFill
        iv.layer.cornerRadius = 4
        iv.layer.masksToBounds = true
        return iv
    }()
    
    let dayLabel : UILabel = {
        let label = UILabel()
        label.text = "3 Days Active"
        label.numberOfLines = 1
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 13)
        return label
    }()
    
    let pursuitLabel : UILabel = {
        let label = UILabel()
        label.text = "Getting into an art gallery"
        label.numberOfLines = 1
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 11)
        return label
    }()
    
    func setupView(){
        addSubview(cellBackgroundView)
        addSubview(dayImageView)
        addSubview(dayLabel)
        addSubview(pursuitLabel)
        
        cellBackgroundView.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 120)
        dayImageView.anchor(top: cellBackgroundView.topAnchor, left: cellBackgroundView.leftAnchor, bottom: cellBackgroundView.bottomAnchor, right: cellBackgroundView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        dayLabel.anchor(top: dayImageView.bottomAnchor, left: dayImageView.leftAnchor, bottom: nil, right: dayImageView.rightAnchor, paddingTop: 12, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 16)
        pursuitLabel.anchor(top: dayLabel.bottomAnchor, left: dayLabel.leftAnchor, bottom: nil, right: dayLabel.rightAnchor, paddingTop: 6, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 14)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
