//
//  ProfilePursuitCells.swift
//  pursue
//
//  Created by Jaylen Sanders on 3/13/18.
//  Copyright © 2018 Glory. All rights reserved.
//

import UIKit

class ProfilePursuitCells : UICollectionViewCell {
    
    lazy var exploreImage : UIImageView = {
        let iv = UIImageView()
        iv.layer.masksToBounds = true
        iv.contentMode = .scaleAspectFill
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleImageTap))
        let longGesture = UILongPressGestureRecognizer(target: self, action: #selector(handleImageHold))
        tapGesture.numberOfTapsRequired = 1
        iv.addGestureRecognizer(tapGesture)
        iv.addGestureRecognizer(longGesture)
        iv.isUserInteractionEnabled = true
        iv.image = #imageLiteral(resourceName: "samuel-l")
        iv.layer.cornerRadius = 4
        return iv
    }()
    
    lazy var secondImage : UIImageView = {
        let iv = UIImageView()
        iv.layer.masksToBounds = true
        iv.contentMode = .scaleAspectFill
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleImageTap))
        let longGesture = UILongPressGestureRecognizer(target: self, action: #selector(handleImageHold))
        tapGesture.numberOfTapsRequired = 1
        iv.addGestureRecognizer(tapGesture)
        iv.addGestureRecognizer(longGesture)
        iv.isUserInteractionEnabled = true
        iv.image = #imageLiteral(resourceName: "samuel-l")
        iv.layer.cornerRadius = 4
        return iv
    }()
    
    lazy var thirdImage : UIImageView = {
        let iv = UIImageView()
        iv.layer.masksToBounds = true
        iv.contentMode = .scaleAspectFill
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleImageTap))
        let longGesture = UILongPressGestureRecognizer(target: self, action: #selector(handleImageHold))
        tapGesture.numberOfTapsRequired = 1
        iv.addGestureRecognizer(tapGesture)
        iv.addGestureRecognizer(longGesture)
        iv.isUserInteractionEnabled = true
        iv.image = #imageLiteral(resourceName: "samuel-l")
        iv.layer.cornerRadius = 4
        return iv
    }()
    
    lazy var fourthImage : UIImageView = {
        let iv = UIImageView()
        iv.layer.masksToBounds = true
        iv.contentMode = .scaleAspectFill
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleImageTap))
        let longGesture = UILongPressGestureRecognizer(target: self, action: #selector(handleImageHold))
        tapGesture.numberOfTapsRequired = 1
        iv.addGestureRecognizer(tapGesture)
        iv.addGestureRecognizer(longGesture)
        iv.isUserInteractionEnabled = true
        iv.image = #imageLiteral(resourceName: "samuel-l")
        iv.layer.cornerRadius = 4
        return iv
    }()
    
    lazy var fifthImage : UIImageView = {
        let iv = UIImageView()
        iv.layer.masksToBounds = true
        iv.contentMode = .scaleAspectFill
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleImageTap))
        let longGesture = UILongPressGestureRecognizer(target: self, action: #selector(handleImageHold))
        tapGesture.numberOfTapsRequired = 1
        iv.addGestureRecognizer(tapGesture)
        iv.addGestureRecognizer(longGesture)
        iv.isUserInteractionEnabled = true
        iv.image = #imageLiteral(resourceName: "samuel-l")
        iv.layer.cornerRadius = 4
        return iv
    }()
    
    lazy var viewMoreOverlay : UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor.init(white: 0.6, alpha: 0.6)
        button.setTitle("View All", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 24, weight: UIFont.Weight.init(25))
        button.titleLabel?.textAlignment = .center
        button.addTarget(self, action: #selector(handleImageTap), for: .touchUpInside)
        return button
    }()
    
    let exploreMainDescription : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight(rawValue: 25))
        label.textAlignment = .justified
        label.text = "Text is here"
        return label
    }()
    
    @objc func handleImageTap(){
    }
    
    @objc func handleImageHold(){
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        exploreMainDescription.sizeToFit()
    }
    
    func setupView() {
        addSubview(exploreImage)
        addSubview(secondImage)
        addSubview(thirdImage)
        addSubview(fourthImage)
        addSubview(fifthImage)
        addSubview(viewMoreOverlay)
        
        exploreImage.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 12, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 225, height: 305)
        secondImage.anchor(top: exploreImage.topAnchor, left: exploreImage.rightAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 16, paddingBottom: 0, paddingRight: 0, width: 200, height: 175)
        thirdImage.anchor(top: secondImage.bottomAnchor, left: secondImage.leftAnchor, bottom: exploreImage.bottomAnchor, right: secondImage.rightAnchor, paddingTop: 12, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        fourthImage.anchor(top: nil, left: thirdImage.rightAnchor, bottom: exploreImage.bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 16, paddingBottom: 0, paddingRight: 0, width: 200, height: 148)
        fifthImage.anchor(top: exploreImage.topAnchor, left: fourthImage.leftAnchor, bottom: fourthImage.topAnchor, right: fourthImage.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 12, paddingRight: 0, width: 0, height: 0)
        viewMoreOverlay.anchor(top: fifthImage.topAnchor, left: fifthImage.leftAnchor, bottom: fifthImage.bottomAnchor, right: fifthImage.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
