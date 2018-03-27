//
//  HomePrinciplesCells.swift
//  pursue
//
//  Created by Jaylen Sanders on 12/6/17.
//  Copyright © 2017 Glory. All rights reserved.
//

import UIKit

protocol HomePrinciplesCellDelegate {
    func principleTapped()
    func principleHeld()
}

class HomePrinciplesCells : UICollectionViewCell {
    
    var principle : SearchedPrinciples? {
        didSet {
            principleLabel.text = principle?.principleDescription
            guard let photo = principle?.thumbnailUrl else { return }
            principleImage.image = UIImage(named: photo)
        }
    }
    
    let principleLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.numberOfLines = 2
        return label
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
        iv.layer.cornerRadius = 4
        return iv
    }()
    
    @objc func handleHomeTap(){
    }
    
    @objc func handleHomeHold(){
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        principleLabel.sizeToFit()
    }
    
    func setupCardDetails(){
        
        addSubview(principleImage)
        addSubview(principleLabel)
        
        principleImage.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 8, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: 90, height: 90)
        principleLabel.anchor(top: topAnchor, left: principleImage.rightAnchor, bottom: nil, right: rightAnchor, paddingTop: 8, paddingLeft: 8, paddingBottom: 0, paddingRight: 12, width: 0, height: 55)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCardDetails()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
