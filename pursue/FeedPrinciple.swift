//
//  FeedPrinciple.swift
//  pursue
//
//  Created by Jaylen Sanders on 12/14/17.
//  Copyright © 2017 Glory. All rights reserved.
//

import UIKit

class FeedPrinciple : UICollectionViewCell {
    
    var feedController : FeedController?
    
    lazy var relatedImage : UIImageView = {
        let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "samuel-l")
        iv.layer.masksToBounds = true
        iv.contentMode = .scaleAspectFill
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleImageTap))
        let longGesture = UILongPressGestureRecognizer(target: self, action: #selector(handleImageHeld))
        tapGesture.numberOfTapsRequired = 1
        iv.addGestureRecognizer(tapGesture)
        iv.addGestureRecognizer(longGesture)
        iv.isUserInteractionEnabled = true
        iv.layer.cornerRadius = 4
        return iv
    }()
    
    let relatedMainDescription : UILabel = {
        let label = UILabel()
        label.text = "Wonder Woman"
        label.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight(rawValue: 25))
        label.numberOfLines = 2
        label.textColor = .black
        return label
    }()
    
    @objc func handleImageTap(){
        feedController?.imageClicked()
    }
    
    @objc func handleImageHeld(){
        feedController?.imageHeld()
    }
    
    func setupView(){
        addSubview(relatedImage)
        addSubview(relatedMainDescription)
        
        relatedImage.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 120)
        relatedMainDescription.anchor(top: relatedImage.bottomAnchor, left: relatedImage.leftAnchor, bottom: nil, right: relatedImage.rightAnchor, paddingTop: 8, paddingLeft: 0, paddingBottom: 0, paddingRight: 8, width: 0, height: 14)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
