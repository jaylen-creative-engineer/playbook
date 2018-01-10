//
//  ProfilePursuitsCells.swift
//  pursue
//
//  Created by Jaylen Sanders on 10/26/17.
//  Copyright © 2017 Glory. All rights reserved.
//

import UIKit

protocol ProfilePursuitsDelegate {
    func pursuitClicked()
    func pursuitHeld()
}

class ProfilePursuitsCells : UICollectionViewCell {
    
    var delegate : ProfilePursuitsDelegate?
    
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
    
    let profileProgressLabel : UILabel = {
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
        delegate?.pursuitClicked()
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
        addSubview(profileProgressLabel)
        addSubview(progressBar)
        addSubview(pursuitLabel)
        
        pursuitImage.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 44, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 190)
        profileProgressLabel.anchor(top: pursuitImage.bottomAnchor, left: nil, bottom: nil, right: pursuitImage.rightAnchor, paddingTop: 4, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: profileProgressLabel.intrinsicContentSize.width, height: profileProgressLabel.intrinsicContentSize.height)
        progressBar.anchor(top: nil, left: pursuitImage.leftAnchor, bottom: nil, right: profileProgressLabel.leftAnchor, paddingTop: 4, paddingLeft: 0, paddingBottom: 0, paddingRight: 8, width: 0, height: 3)
        progressBar.centerYAnchor.constraint(equalTo: profileProgressLabel.centerYAnchor).isActive = true
        pursuitLabel.anchor(top: pursuitImage.bottomAnchor, left: pursuitImage.leftAnchor, bottom: nil, right: pursuitImage.rightAnchor, paddingTop: 20, paddingLeft: 0, paddingBottom: 0, paddingRight: 8, width: 0, height: 14)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
