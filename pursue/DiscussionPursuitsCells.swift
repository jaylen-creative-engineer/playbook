//
//  DiscussionPursuitsCells.swift
//  pursue
//
//  Created by Jaylen Sanders on 12/9/17.
//  Copyright © 2017 Glory. All rights reserved.
//

import UIKit

class DiscussionPursuitsCells : UICollectionViewCell {
    
    let nextButton : UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor.init(white: 0.4, alpha: 0.05)
        return button
    }()
    
    let exerciseLabel : UILabel = {
        let label = UILabel()
        label.text = "Design"
        label.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight(rawValue: 25))
        return label
    }()
    
    let percentageLabel : UILabel = {
        let label = UILabel()
        label.text = "30%"
        label.textColor = UIColor.rgb(red: 0, green: 128, blue: 0)
        label.font = UIFont.boldSystemFont(ofSize: 12)
        return label
    }()
    
    let nextImage : UIImageView = {
        let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "trees")
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
    }()
    
    let progressBar : UIProgressView = {
        let pv = UIProgressView()
        pv.trackTintColor = UIColor.rgb(red: 211, green: 211, blue: 211)
        pv.progress = 0.3
        pv.progressTintColor = UIColor.rgb(red: 0, green: 128, blue: 0)
        pv.translatesAutoresizingMaskIntoConstraints = false
        return pv
    }()
    
    func setupCardDetails(){
        addSubview(exerciseLabel)
        addSubview(progressBar)
        addSubview(percentageLabel)
        
        exerciseLabel.anchor(top: nextImage.bottomAnchor, left: nextImage.leftAnchor, bottom: nil, right: nextImage.rightAnchor, paddingTop: 20, paddingLeft: 0, paddingBottom: 0, paddingRight: 8, width: exerciseLabel.intrinsicContentSize.width, height: exerciseLabel.intrinsicContentSize.height)
       
        progressBar.anchor(top: nil, left: nextImage.leftAnchor, bottom: nil, right: percentageLabel.leftAnchor, paddingTop: 4, paddingLeft: 0, paddingBottom: 0, paddingRight: 8, width: 0, height: 3)
        progressBar.centerYAnchor.constraint(equalTo: percentageLabel.centerYAnchor).isActive = true
        
        percentageLabel.anchor(top: nextImage.bottomAnchor, left: nil, bottom: nil, right: nextImage.rightAnchor, paddingTop: 4, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: percentageLabel.intrinsicContentSize.width, height: percentageLabel.intrinsicContentSize.height)
    }
    
    func setupView(){
        addSubview(nextImage)
       
        nextImage.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 12, paddingLeft: 6, paddingBottom: 0, paddingRight: 6, width: 0, height: 190)
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
