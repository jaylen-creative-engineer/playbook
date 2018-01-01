//
//  ProfilePrincipleCells.swift
//  pursue
//
//  Created by Jaylen Sanders on 11/27/17.
//  Copyright © 2017 Glory. All rights reserved.
//

import UIKit

protocol ProfilePrincipleCellsDelegate {
    func principleTapped()
    func principleHeld()
}

class ProfilePrincipleCells : UICollectionViewCell {
    
    var delegate : ProfilePrincipleCellsDelegate?
    
    let profileLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight(rawValue: 25))
        return label
    }()
    
    lazy var profileImage : UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleHomeTap))
        let longGesture = UILongPressGestureRecognizer(target: self, action: #selector(handleHomeHold))
        tapGesture.numberOfTapsRequired = 1
        iv.addGestureRecognizer(tapGesture)
        iv.addGestureRecognizer(longGesture)
        iv.isUserInteractionEnabled = true
        return iv
    }()
    
    @objc func handleHomeTap(){
        delegate?.principleTapped()
    }
    
    @objc func handleHomeHold(){
        delegate?.principleHeld()
    }
    
    func setupCardDetails(){
        
        addSubview(profileImage)
        addSubview(profileLabel)
        
        profileImage.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 16, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 190)
        profileLabel.anchor(top: profileImage.bottomAnchor, left: profileImage.leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 12, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: profileLabel.intrinsicContentSize.height)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCardDetails()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
