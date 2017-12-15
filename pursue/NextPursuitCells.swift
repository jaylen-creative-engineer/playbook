//
//  NextPursuitCells.swift
//  pursue
//
//  Created by Jaylen Sanders on 10/20/17.
//  Copyright © 2017 Glory. All rights reserved.
//

import UIKit

class NextPursuitCells : UICollectionViewCell {

    let exerciseLabel : UILabel = {
        let label = UILabel()
        label.text = "Design"
        label.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight(rawValue: 25))
        return label
    }()
    
    let dayLabel : UILabel = {
        let label = UILabel()
        label.text = "TOMORROW • "
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.textColor = .gray
        return label
    }()
    
    let percentageLabel : UILabel = {
        let label = UILabel()
        label.text = "42% Complete"
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.textColor = .gray
        return label
    }()
    
    let nextImage : UIImageView = {
        let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "trees")
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
    }()
    
    func setupCardDetails(){
        addSubview(exerciseLabel)
        
        exerciseLabel.anchor(top: nextImage.bottomAnchor, left: nextImage.leftAnchor, bottom: nil, right: nextImage.rightAnchor, paddingTop: 8, paddingLeft: 0, paddingBottom: 0, paddingRight: 8, width: 0, height: 18)
    }
    
    func setupView(){
        addSubview(percentageLabel)
        addSubview(nextImage)
        
        percentageLabel.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: percentageLabel.intrinsicContentSize.width, height: percentageLabel.intrinsicContentSize.height)
        nextImage.anchor(top: percentageLabel.bottomAnchor, left: dayLabel.leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 12, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 190)
        setupCardDetails()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
