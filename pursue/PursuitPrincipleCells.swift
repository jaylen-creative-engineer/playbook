//
//  PursuitPrincipleCells.swift
//  pursue
//
//  Created by Jaylen Sanders on 12/12/17.
//  Copyright © 2017 Glory. All rights reserved.
//

import UIKit

class PursuitPrincipleCells : UICollectionViewCell {
    
    var principle : SearchedPrinciples? {
        didSet {
//            principleLabel.text = principle?.principleDescription
            guard let photo = principle?.thumbnailUrl else { return }
            principleImage.image = UIImage(named: photo)
        }
    }

    let principleDescription : UILabel = {
        let label = UILabel()
        label.text = "Have a vision to work towards"
        label.font = UIFont.systemFont(ofSize: 12)
        label.numberOfLines = 2
        return label
    }()
    
    let timeLabel : UILabel = {
        let label = UILabel()
        label.text = "00:24"
        label.font = UIFont.systemFont(ofSize: 10)
        label.textColor = .lightGray
        return label
    }()
    
    let photoBackground : HomeCellRectangleView = {
        let iv = HomeCellRectangleView()
        iv.layer.cornerRadius = 8
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    lazy var principleImage : UIImageView = {
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
        addSubview(principleImage)
        addSubview(principleDescription)
        addSubview(timeLabel)
        addSubview(optionButton)
        
        photoBackground.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 30, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 150, height: 150)
        principleImage.anchor(top: photoBackground.topAnchor, left: photoBackground.leftAnchor, bottom: photoBackground.bottomAnchor, right: photoBackground.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        principleDescription.anchor(top: principleImage.bottomAnchor, left: principleImage.leftAnchor, bottom: nil, right: photoBackground.rightAnchor, paddingTop: 10, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: (principleDescription.intrinsicContentSize.height * 2) + 5)
        timeLabel.anchor(top: principleDescription.bottomAnchor, left: principleDescription.leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 8, paddingBottom: 0, paddingRight: 0, width: timeLabel.intrinsicContentSize.width, height: timeLabel.intrinsicContentSize.height)
        optionButton.anchor(top: principleImage.bottomAnchor, left: nil, bottom: nil, right: principleImage.rightAnchor, paddingTop: 18, paddingLeft: 0, paddingBottom: 0, paddingRight: 4, width: 8, height: 16)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCardDetails()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
