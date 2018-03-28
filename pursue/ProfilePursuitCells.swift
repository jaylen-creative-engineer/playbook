//
//  ProfilePursuitCells.swift
//  pursue
//
//  Created by Jaylen Sanders on 3/13/18.
//  Copyright © 2018 Glory. All rights reserved.
//

import UIKit

class ProfilePursuitCells : UICollectionViewCell {
    
    var pursuit : Pursuit? {
        didSet {
            guard let photo = pursuit?.thumbnailUrl else { return }
            pursuitImage.loadImage(urlString: photo)
            pursuitLabel.text = pursuit?.pursuitDescription
        }
    }
    
    lazy var pursuitImage : CustomImageView = {
        let iv = CustomImageView()
        iv.layer.masksToBounds = true
        iv.contentMode = .scaleAspectFill
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleImageTap))
        let longGesture = UILongPressGestureRecognizer(target: self, action: #selector(handleImageHold))
        tapGesture.numberOfTapsRequired = 1
        iv.addGestureRecognizer(tapGesture)
        iv.addGestureRecognizer(longGesture)
        iv.isUserInteractionEnabled = true
        iv.layer.cornerRadius = 4
        return iv
    }()
    
    lazy var pursuitLabel : UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 14)
        label.textAlignment = .justified
        label.numberOfLines = 2
        return label
    }()
    
    lazy var createButton : UIButton = {
       let button = UIButton()
        
        return button
    }()
    
    @objc func handleImageTap(){
    }
    
    @objc func handleImageHold(){
    }
    
    func setupView() {
        addSubview(pursuitImage)
        addSubview(pursuitLabel)
        
        pursuitImage.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 225, height: 305)
        pursuitLabel.anchor(top: pursuitImage.bottomAnchor, left: pursuitImage.leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 12, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 55)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
