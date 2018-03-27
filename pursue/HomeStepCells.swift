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
    
    var delegate : PursuitSelected?
    
    var step : SearchedSteps? {
        didSet {
            pursuitLabel.text = step?.stepDescription
            guard let photo = step?.thumbnailUrl else { return }
            pursuitImage.loadImage(urlString: photo)
        }
    }
    
    lazy var pursuitLabel : UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.font = UIFont.boldSystemFont(ofSize: 14)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleHomeTap))
        let longGesture = UILongPressGestureRecognizer(target: self, action: #selector(handleHomeHold))
        tapGesture.numberOfTapsRequired = 1
        label.addGestureRecognizer(tapGesture)
        label.addGestureRecognizer(longGesture)
        label.textAlignment = .justified
        return label
    }()
    
    lazy var pursuitImage : CustomImageView = {
        let iv = CustomImageView()
        iv.contentMode = .scaleAspectFill
        iv.layer.masksToBounds = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleHomeTap))
        let longGesture = UILongPressGestureRecognizer(target: self, action: #selector(handleHomeHold))
        tapGesture.numberOfTapsRequired = 1
        iv.addGestureRecognizer(tapGesture)
        iv.addGestureRecognizer(longGesture)
        iv.isUserInteractionEnabled = true
        iv.layer.cornerRadius = 4
        return iv
    }()
    
    @objc func handleHomeTap(){
        delegate?.pursuitTapped()
    }
    
    @objc func handleHomeHold() {
        delegate?.pursuitHeld()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        pursuitLabel.sizeToFit()
    }
    
    func setupView(){
        addSubview(pursuitImage)
        addSubview(pursuitLabel)
        
        pursuitImage.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 12, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: 140, height: 90)
        pursuitLabel.anchor(top: topAnchor, left: pursuitImage.rightAnchor, bottom: nil, right: rightAnchor, paddingTop: 12, paddingLeft: 8, paddingBottom: 0, paddingRight: 12, width: 0, height: 55)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
