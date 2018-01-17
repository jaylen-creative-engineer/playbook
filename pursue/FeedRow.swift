//
//  FeedRow.swift
//  pursue
//
//  Created by Jaylen Sanders on 10/30/17.
//  Copyright © 2017 Glory. All rights reserved.
//

import UIKit


class FeedRow : UICollectionViewCell {
    
    var feedController : FeedController?
    
    lazy var photoImageView : UIImageView = {
        let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "ferrari")
        iv.clipsToBounds = true
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
    
    @objc func handleImageTap(){
        feedController?.imageClicked()
    }
    
    @objc func handleImageHeld(){
        feedController?.imageHeld()
    }
    
    let feedDescription : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight(rawValue: 25))
        label.numberOfLines = 1
        label.text = "Pull up"
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(photoImageView)
        addSubview(feedDescription)
        
        photoImageView.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 8 , paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 185)
        feedDescription.anchor(top: photoImageView.bottomAnchor, left: photoImageView.leftAnchor, bottom: nil, right: photoImageView.rightAnchor, paddingTop: 8, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: feedDescription.intrinsicContentSize.height)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
