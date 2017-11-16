//
//  NextPursuitCells.swift
//  pursue
//
//  Created by Jaylen Sanders on 10/20/17.
//  Copyright © 2017 Glory. All rights reserved.
//

import UIKit

class NextPursuitCells : UICollectionViewCell {
    
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
    
    let execeriseCompletedLabel : UILabel = {
        let label = UILabel()
        label.text = "123,456 Completions •"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 12, weight: UIFont.Weight.thin)
        return label
    }()
    
    let execeriseTimeLabel : UILabel = {
        let label = UILabel()
        label.text = "01:23:45"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 12, weight: UIFont.Weight.thin)
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
        addSubview(execeriseCompletedLabel)
        addSubview(execeriseTimeLabel)
        
        exerciseLabel.anchor(top: nextImage.bottomAnchor, left: nextImage.leftAnchor, bottom: nil, right: nextImage.rightAnchor, paddingTop: 8, paddingLeft: 0, paddingBottom: 0, paddingRight: 8, width: 0, height: 18)
        execeriseCompletedLabel.anchor(top: exerciseLabel.bottomAnchor, left: exerciseLabel.leftAnchor, bottom: nil, right: nil, paddingTop: 8, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 130, height: 16)
        execeriseTimeLabel.anchor(top: execeriseCompletedLabel.topAnchor, left: execeriseCompletedLabel.rightAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 120, height: 16)
    }
    
    func setupView(){
        addSubview(nextButton)
        addSubview(dayLabel)
        addSubview(percentageLabel)
        nextButton.addSubview(nextImage)
        
        dayLabel.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 88, height: 18)
        percentageLabel.anchor(top: dayLabel.topAnchor, left: dayLabel.rightAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 120, height: 18)
        nextButton.anchor(top: percentageLabel.bottomAnchor, left: dayLabel.leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 12, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        nextImage.anchor(top: nextButton.topAnchor, left: nextButton.leftAnchor, bottom: nextButton.bottomAnchor, right: nextButton.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
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
