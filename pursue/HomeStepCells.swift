//
//  HomePursuitsCells.swift
//  pursue
//
//  Created by Jaylen Sanders on 12/6/17.
//  Copyright © 2017 Glory. All rights reserved.
//

import UIKit

protocol PursuitSelected {
    func pursuitTapped()
    func pursuitHeld()
}

class HomeStepCells : UICollectionViewCell {
    
    let stepLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.text = "Step"
        return label
    }()
    
    let stepDescription : UILabel = {
        let label = UILabel()
        label.text = "Pushing through the tough terrain"
        label.numberOfLines = 2
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()
    
    let usernameLabel : UILabel = {
        let label = UILabel()
        label.text = "Test"
        label.font = UIFont.systemFont(ofSize: 10)
        label.textColor = .lightGray
        return label
    }()
    
    let circleView : UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        view.layer.cornerRadius = 2
        return view
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
    
    let optionButton : UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "options").withRenderingMode(.alwaysTemplate), for: .normal)
        button.imageView?.contentMode = .scaleAspectFill
        button.tintColor = .gray
        return button
    }()
    
    @objc func handleHomeTap(){
    }
    
    @objc func handleHomeHold(){
    }
    
    func setupCardDetails(){
        addSubview(photoBackground)
        addSubview(stepImage)
        addSubview(stepLabel)
        addSubview(stepDescription)
        addSubview(usernameLabel)
        addSubview(circleView)
        addSubview(timeLabel)
        addSubview(optionButton)
        
        photoBackground.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 12, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 145, height: 210)
        stepImage.anchor(top: photoBackground.topAnchor, left: photoBackground.leftAnchor, bottom: photoBackground.bottomAnchor, right: photoBackground.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        stepLabel.anchor(top: stepImage.bottomAnchor, left: stepImage.leftAnchor, bottom: nil, right: nil, paddingTop: 18, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: stepLabel.intrinsicContentSize.width, height: stepLabel.intrinsicContentSize.height)
        stepDescription.anchor(top: stepLabel.bottomAnchor, left: stepLabel.leftAnchor, bottom: nil, right: photoBackground.rightAnchor, paddingTop: 10, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: stepDescription.intrinsicContentSize.height)
        usernameLabel.anchor(top: stepDescription.bottomAnchor, left: stepDescription.leftAnchor, bottom: nil, right: nil, paddingTop: 10, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: usernameLabel.intrinsicContentSize.width, height: usernameLabel.intrinsicContentSize.height)
        circleView.anchor(top: nil, left: usernameLabel.rightAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 8, paddingBottom: 0, paddingRight: 0, width: 4, height: 4)
        circleView.centerYAnchor.constraint(equalTo: usernameLabel.centerYAnchor).isActive = true
        timeLabel.anchor(top: usernameLabel.topAnchor, left: circleView.rightAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 8, paddingBottom: 0, paddingRight: 0, width: timeLabel.intrinsicContentSize.width, height: timeLabel.intrinsicContentSize.height)
        optionButton.anchor(top: stepImage.bottomAnchor, left: nil, bottom: nil, right: stepImage.rightAnchor, paddingTop: 18, paddingLeft: 0, paddingBottom: 0, paddingRight: 4, width: 8, height: 16)

    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCardDetails()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
