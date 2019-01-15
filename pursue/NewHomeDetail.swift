//
//  NewHomeDetail.swift
//  Inpursuit
//
//  Created by Jaylen Sanders on 1/13/19.
//  Copyright © 2019 Glory. All rights reserved.
//

import UIKit

class NewHomeDetail : UICollectionViewCell {
    
    let cellBackgroundView : SmallerCardView = {
        let view = SmallerCardView()
        view.backgroundColor = .white
        return view
    }()
    
    let standardLabel : UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = .gray
        label.font = UIFont.init(name: "Roboto-Black", size: 14)
        label.text = "DAYS"
        return label
    }()
    
    let numberOfDaysActiveLabel : UILabel = {
        let label = UILabel()
        label.text = "30"
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    
    let donePerDayLabel : UILabel = {
        let label = UILabel()
        label.text = "5"
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    
    let onTrackPercentageLabel : UILabel = {
        let label = UILabel()
        label.text = "70%"
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    
    let daysLabel : UILabel = {
        let label = UILabel()
        label.text = "Days Active"
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()
    
    let activityLabel : UILabel = {
        let label = UILabel()
        label.text = "Tasks Completed"
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()
    
    let onTrackLabel : UILabel = {
        let label = UILabel()
        label.text = "On Track"
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()
    
    func setupPerDayLabel(){
        addSubview(numberOfDaysActiveLabel)
        addSubview(daysLabel)
        
        daysLabel.anchor(top: nil, left: cellBackgroundView.leftAnchor, bottom: cellBackgroundView.bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 12, paddingBottom: 28, paddingRight: 0, width: daysLabel.intrinsicContentSize.width, height: 14)
        numberOfDaysActiveLabel.centerXAnchor.constraint(equalTo: daysLabel.centerXAnchor).isActive = true
        numberOfDaysActiveLabel.anchor(top: nil, left: nil, bottom: daysLabel.topAnchor, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 12, paddingRight: 0, width: numberOfDaysActiveLabel.intrinsicContentSize.width, height: 18)
    }
    
    func setupDailyActiveLabel(){
        addSubview(activityLabel)
        addSubview(donePerDayLabel)
        
        activityLabel.anchor(top: daysLabel.topAnchor, left: daysLabel.rightAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 32, paddingBottom: 0, paddingRight: 0, width: activityLabel.intrinsicContentSize.width, height: 14)
        donePerDayLabel.centerXAnchor.constraint(equalTo: activityLabel.centerXAnchor).isActive = true
        donePerDayLabel.anchor(top: nil, left: nil, bottom: activityLabel.topAnchor, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 12, paddingRight: 0, width: donePerDayLabel.intrinsicContentSize.width, height: 18)
    }
    
    func setupOnTrackLabel(){
        addSubview(onTrackLabel)
        addSubview(onTrackPercentageLabel)
        
        onTrackLabel.anchor(top: activityLabel.topAnchor, left: nil, bottom: nil, right: cellBackgroundView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 12, width: onTrackLabel.intrinsicContentSize.width, height: 14)
        onTrackPercentageLabel.centerXAnchor.constraint(equalTo: onTrackLabel.centerXAnchor).isActive = true
        onTrackPercentageLabel.anchor(top: nil, left: nil, bottom: onTrackLabel.topAnchor, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 12, paddingRight: 0, width: onTrackPercentageLabel.intrinsicContentSize.width, height: 18)
    }
    
    func setupView(){
        addSubview(cellBackgroundView)
        addSubview(standardLabel)
        
        cellBackgroundView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        standardLabel.anchor(top: cellBackgroundView.topAnchor, left: cellBackgroundView.leftAnchor, bottom: nil, right: nil, paddingTop: 12, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: standardLabel.intrinsicContentSize.width, height: 16)
        setupPerDayLabel()
        setupDailyActiveLabel()
        setupOnTrackLabel()
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
