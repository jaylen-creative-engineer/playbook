//
//  ChallengesRowCells.swift
//  pursue
//
//  Created by Jaylen Sanders on 10/23/17.
//  Copyright © 2017 Glory. All rights reserved.
//

import UIKit

class ExploreChallengeCells : UICollectionViewCell {
    
    let exploreButton : UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor.init(white: 0.4, alpha: 0.05)
        return button
    }()
    
    let exploreLabel : UILabel = {
        let label = UILabel()
        label.text = "DRAW"
        label.font = UIFont.systemFont(ofSize: 12, weight: UIFont.Weight(rawValue: 25))
        return label
    }()
    
    let exploreDetailLabel : UILabel = {
        let label = UILabel()
        label.text = "Put In More Effort"
        label.font = UIFont.systemFont(ofSize: 18, weight: UIFont.Weight(rawValue: 25))
        return label
    }()
    
    let finishingDateLabel : UILabel = {
        let label = UILabel()
        label.text = "End Date - 10/23/2017"
        label.font = UIFont.systemFont(ofSize: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .gray
        label.textAlignment = .left
        return label
    }()
    
    let exploreImage : UIImageView = {
        let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "samuel-l")
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
    }()
 
    let addedImage : UIImageView = {
        let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "scarlett")
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
    }()
    
    let containerView = UIView()
    let leftContainerView = UIView()
    
    func setupCardDetails(){
        containerView.layer.cornerRadius = 8
        containerView.clipsToBounds = true
        
        leftContainerView.layer.cornerRadius = 8
        leftContainerView.clipsToBounds = true
        
        addSubview(containerView)
        addSubview(leftContainerView)
        addSubview(exploreImage)
        addSubview(exploreLabel)
        addSubview(exploreDetailLabel)
        addSubview(finishingDateLabel)
        addSubview(addedImage)
        
        containerView.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 8, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 135, height: 190)
        leftContainerView.anchor(top: topAnchor, left: nil, bottom: nil, right: rightAnchor, paddingTop: 8, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 135, height: 190)
        
        exploreImage.anchor(top: containerView.topAnchor, left: containerView.leftAnchor, bottom: containerView.bottomAnchor, right: containerView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        addedImage.anchor(top: leftContainerView.topAnchor, left: leftContainerView.leftAnchor, bottom: leftContainerView.bottomAnchor, right: leftContainerView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        exploreLabel.anchor(top: containerView.bottomAnchor, left: containerView.leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 12, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: exploreLabel.intrinsicContentSize.height)
        exploreDetailLabel.anchor(top: exploreLabel.bottomAnchor, left: exploreLabel.leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 4, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: exploreDetailLabel.intrinsicContentSize.height)
        finishingDateLabel.anchor(top: exploreDetailLabel.bottomAnchor, left: exploreLabel.leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 4, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: finishingDateLabel.intrinsicContentSize.height)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCardDetails()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
