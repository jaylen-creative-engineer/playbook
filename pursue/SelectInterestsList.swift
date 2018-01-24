//
//  SelectInterestsList.swift
//  pursue
//
//  Created by Jaylen Sanders on 11/3/17.
//  Copyright © 2017 Glory. All rights reserved.
//

import UIKit

class SelectInterestsList : UICollectionViewCell {
    
    lazy var cellBackgroundImage : UIImageView = {
       let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.layer.cornerRadius = 4
        iv.layer.masksToBounds = true
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleImageTapped))
        tap.numberOfTapsRequired = 1
        iv.addGestureRecognizer(tap)
        iv.isUserInteractionEnabled = true
        return iv
    }()
    
    lazy var imageLightOverlay : UIView = {
       let view = UIView()
        view.backgroundColor = UIColor.init(white: 0.7, alpha: 0.3)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleImageTapped))
        tap.numberOfTapsRequired = 1
        view.addGestureRecognizer(tap)
        view.isUserInteractionEnabled = true
        return view
    }()
    
    lazy var interestsLabel : UILabel = {
       let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight(rawValue: 25))
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleImageTapped))
        tap.numberOfTapsRequired = 1
        label.addGestureRecognizer(tap)
        label.isUserInteractionEnabled = true
        return label
    }()
    
    lazy var checkMark : UIImageView = {
       let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "check").withRenderingMode(.alwaysOriginal)
        iv.contentMode = .scaleAspectFill
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    let checkMarkBackground : UIView = {
       let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 12
        view.layer.masksToBounds = true
        return view
    }()
    
    var isInterestsed = true
    
    @objc func handleImageTapped(){
        isInterestsed = !isInterestsed
        
        if isInterestsed == true {
            checkMarkBackground.isHidden = false
            checkMark.isHidden = false
        } else {
            checkMarkBackground.isHidden = true
            checkMark.isHidden = true
        }
    }
    
    var interestsNames : [String] = []
    let cellId = "cellId"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(cellBackgroundImage)
        cellBackgroundImage.addSubview(imageLightOverlay)
        addSubview(interestsLabel)
        imageLightOverlay.addSubview(checkMarkBackground)
        checkMarkBackground.addSubview(checkMark)
        cellBackgroundImage.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 2, paddingLeft: 2, paddingBottom: 2, paddingRight: 2, width: 0, height: 0)
        imageLightOverlay.anchor(top: cellBackgroundImage.topAnchor, left: cellBackgroundImage.leftAnchor, bottom: cellBackgroundImage.bottomAnchor, right: cellBackgroundImage.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        interestsLabel.anchor(top: nil, left: imageLightOverlay.leftAnchor, bottom: nil, right: imageLightOverlay.rightAnchor, paddingTop: 0, paddingLeft: 8, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        interestsLabel.centerYAnchor.constraint(equalTo: imageLightOverlay.centerYAnchor).isActive = true
        checkMarkBackground.anchor(top: imageLightOverlay.topAnchor, left: nil, bottom: nil, right: imageLightOverlay.rightAnchor, paddingTop: 8, paddingLeft: 0, paddingBottom: 0, paddingRight: 12, width: 24, height: 24)
        checkMark.anchor(top: nil, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 12, height: 12)
        checkMark.centerXAnchor.constraint(equalTo: checkMarkBackground.centerXAnchor).isActive = true
        checkMark.centerYAnchor.constraint(equalTo: checkMarkBackground.centerYAnchor).isActive = true
        handleImageTapped()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
