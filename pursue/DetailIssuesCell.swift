//
//  DetailIssuesCell.swift
//  Inpursuit
//
//  Created by Jaylen Sanders on 1/9/19.
//  Copyright © 2019 Glory. All rights reserved.
//

import UIKit

class DetailIssuesCell : UICollectionViewCell {
    
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
        label.textAlignment = .left
        label.font = UIFont.boldSystemFont(ofSize: 12)
        return label
    }()
    
    let pursuitLabel : UILabel = {
        let label = UILabel()
        label.text = "Getting into an art gallery"
        label.numberOfLines = 1
        label.textAlignment = .left
        label.font = UIFont.boldSystemFont(ofSize: 14)
        return label
    }()
    
    let detailStackView : UIStackView = {
       let sv = UIStackView()
        sv.axis = .vertical
        sv.spacing = 5
        sv.distribution = .fill
        return sv
    }()
    
    func setupView(){
        addSubview(cellBackgroundView)
        addSubview(dayImageView)
        addSubview(detailStackView)
        addSubview(pursuitLabel)
        addSubview(dayLabel)
        
        cellBackgroundView.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: 180, height: 120)
        dayImageView.anchor(top: cellBackgroundView.topAnchor, left: cellBackgroundView.leftAnchor, bottom: cellBackgroundView.bottomAnchor, right: cellBackgroundView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        pursuitLabel.anchor(top: dayImageView.topAnchor, left: dayImageView.rightAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 12, paddingBottom: 0, paddingRight: 12, width: 0, height: 0)
        pursuitLabel.heightAnchor.constraint(lessThanOrEqualToConstant: 70).isActive = true
        dayLabel.anchor(top: pursuitLabel.bottomAnchor, left: pursuitLabel.leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 12, paddingLeft: 0, paddingBottom: 0, paddingRight: 12, width: 0, height: 14)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
