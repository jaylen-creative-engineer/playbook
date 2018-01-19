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

class HomePursuitsCells : UICollectionViewCell {
    
    var delegate : PursuitSelected?
    
    lazy var pursuitLabel : UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight(rawValue: 25))
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleHomeTap))
        let longGesture = UILongPressGestureRecognizer(target: self, action: #selector(handleHomeHold))
        tapGesture.numberOfTapsRequired = 1
        label.addGestureRecognizer(tapGesture)
        label.addGestureRecognizer(longGesture)
        label.textAlignment = .justified
        return label
    }()
    
    lazy var pursuitImage : UIImageView = {
        let iv = UIImageView()
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
    
    let progressLabel : UILabel = {
        let label = UILabel()
        label.text = "30%"
        label.textColor = UIColor.rgb(red: 0, green: 128, blue: 0)
        label.font = UIFont.boldSystemFont(ofSize: 12)
        return label
    }()
    
    let progressBar : UIProgressView = {
        let pv = UIProgressView()
        pv.trackTintColor = UIColor.rgb(red: 211, green: 211, blue: 211)
        pv.progress = 0.3
        pv.progressTintColor = UIColor.rgb(red: 0, green: 128, blue: 0)
        pv.translatesAutoresizingMaskIntoConstraints = false
        return pv
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
        addSubview(progressLabel)
        addSubview(progressBar)
        addSubview(pursuitLabel)
        
        pursuitImage.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 12, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: 140, height: 90)
        pursuitLabel.anchor(top: topAnchor, left: pursuitImage.rightAnchor, bottom: nil, right: rightAnchor, paddingTop: 12, paddingLeft: 8, paddingBottom: 0, paddingRight: 12, width: 0, height: 55)
        progressLabel.anchor(top: nil, left: nil, bottom: pursuitImage.bottomAnchor, right: pursuitLabel.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: progressLabel.intrinsicContentSize.width, height: progressLabel.intrinsicContentSize.height)
        progressBar.anchor(top: nil, left: pursuitLabel.leftAnchor, bottom: nil, right: progressLabel.leftAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 10, width: 0, height: 3)
        progressBar.centerYAnchor.constraint(equalTo: progressLabel.centerYAnchor).isActive = true
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
