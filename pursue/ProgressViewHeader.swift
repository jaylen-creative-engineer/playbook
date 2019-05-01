//
//  ProgressViewHeader.swift
//  Inpursuit
//
//  Created by Jaylen Sanders on 4/6/19.
//  Copyright © 2019 Glory. All rights reserved.
//

import UIKit

class ProgressViewHeader : UICollectionViewCell {
    
    let progressTitle : UILabel = {
       let label = UILabel()
        label.text = "Hey Test,"
        label.textAlignment = .left
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    
    let progressSubtitle : UILabel = {
       let label = UILabel()
        label.text = "you have 3 tasks to complete today."
        label.font = UIFont.boldSystemFont(ofSize: 14)
        return label
    }()
    
    let pursuitOptions : UIButton = {
       let button = UIButton(type: .system)
        button.setTitle("My Pursuits", for: .normal)
        button.setTitleColor(UIColor.gray, for: .normal)
        button.tintColor = .gray
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.contentHorizontalAlignment = .left
        button.contentVerticalAlignment = .center
        return button
    }()
    
    let dropdownButton : UIButton = {
       let button = UIButton(type: .system)
        button.setImage(UIImage(named: "down_arrow")?.withRenderingMode(.alwaysOriginal), for: .normal)
        button.contentMode = .scaleAspectFill
        button.tintColor = .black
        button.contentHorizontalAlignment = .center
        button.contentVerticalAlignment = .center
        return button
    }()
    
    let firstShapeLayer : CAShapeLayer = {
       let layer = CAShapeLayer()
        return layer
    }()
    
    func setupCircleViews(){
        let viewCenter = center
        let circularPath = UIBezierPath(arcCenter: viewCenter, radius: 60, startAngle: 0, endAngle: 2 * CGFloat.pi, clockwise: true)
        firstShapeLayer.path = circularPath.cgPath
        firstShapeLayer.lineCap = CAShapeLayerLineCap.round
        firstShapeLayer.strokeColor = UIColor.red.cgColor
        firstShapeLayer.fillColor = UIColor.white.cgColor
        firstShapeLayer.lineWidth = 10
        
        layer.addSublayer(firstShapeLayer)
    }
    
    func setupView(){
        addSubview(progressTitle)
        addSubview(progressSubtitle)
        addSubview(pursuitOptions)
        addSubview(dropdownButton)
        
        progressTitle.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 18, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: 0, height: 18)
        progressSubtitle.anchor(top: progressTitle.bottomAnchor, left: progressTitle.leftAnchor, bottom: nil, right: progressTitle.rightAnchor, paddingTop: 4, paddingLeft: 0, paddingBottom: 0, paddingRight: 12, width: 0, height: 18)
        pursuitOptions.anchor(top: progressSubtitle.bottomAnchor, left: progressSubtitle.leftAnchor, bottom: nil, right: nil, paddingTop: 16, paddingLeft: 0, paddingBottom: 0, paddingRight: 12, width: 80, height: 16)
        dropdownButton.anchor(top: nil, left: pursuitOptions.rightAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 2, paddingBottom: 0, paddingRight: 0, width: 10, height: 8)
        dropdownButton.centerYAnchor.constraint(equalTo: pursuitOptions.centerYAnchor).isActive = true
//        setupCircleViews()
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
