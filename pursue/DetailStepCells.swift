//
//  DiscussionPursuitsCells.swift
//  pursue
//
//  Created by Jaylen Sanders on 12/9/17.
//  Copyright © 2017 Glory. All rights reserved.
//

import UIKit

class DetailStepCells : UICollectionViewCell {
    
    let stepDescription : UILabel = {
        let label = UILabel()
        label.text = "Pushing through the tough terrain"
        label.numberOfLines = 2
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()
    
    let dayLabel : UILabel = {
       let label = UILabel()
        label.text = "Day 5"
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()
    
    let timeLabel : UILabel = {
        let label = UILabel()
        label.text = "00:24"
        label.textColor = .lightGray
        label.font = UIFont.systemFont(ofSize: 10)
        return label
    }()
    
    let photoBackground : HomeCellRectangleView = {
        let iv = HomeCellRectangleView()
        iv.layer.cornerRadius = 8
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    lazy var stepImage : UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleHomeTap))
        let longGesture = UILongPressGestureRecognizer(target: self, action: #selector(handleHomeHold))
        tapGesture.numberOfTapsRequired = 1
        iv.addGestureRecognizer(tapGesture)
        iv.addGestureRecognizer(longGesture)
        iv.isUserInteractionEnabled = true
        iv.layer.cornerRadius = 8
        return iv
    }()
    
    @objc func handleHomeTap(){
    }
    
    @objc func handleHomeHold(){
    }
    
    func setupCardDetails(){
        addSubview(dayLabel)
        addSubview(photoBackground)
        addSubview(stepImage)
        addSubview(stepDescription)
        addSubview(timeLabel)
        
        dayLabel.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: dayLabel.intrinsicContentSize.width, height: dayLabel.intrinsicContentSize.height)
        photoBackground.anchor(top: dayLabel.bottomAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 24, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 145, height: 210)
        stepImage.anchor(top: photoBackground.topAnchor, left: photoBackground.leftAnchor, bottom: photoBackground.bottomAnchor, right: photoBackground.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        stepDescription.anchor(top: photoBackground.bottomAnchor, left: photoBackground.leftAnchor, bottom: nil, right: photoBackground.rightAnchor, paddingTop: 10, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: (stepDescription.intrinsicContentSize.height * 2) + 5)
        timeLabel.anchor(top: stepDescription.bottomAnchor, left: stepDescription.leftAnchor, bottom: nil, right: nil, paddingTop: 6, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: timeLabel.intrinsicContentSize.width, height: timeLabel.intrinsicContentSize.height)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCardDetails()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
