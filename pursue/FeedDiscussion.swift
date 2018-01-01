//
//  FeedDiscussion.swift
//  pursue
//
//  Created by Jaylen Sanders on 12/14/17.
//  Copyright © 2017 Glory. All rights reserved.
//

import UIKit

class FeedDiscussion : UICollectionViewCell {
    
    let relatedImage : UIImageView = {
        let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "samuel-l")
        iv.layer.masksToBounds = true
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    let relatedMainDescription : UILabel = {
        let label = UILabel()
        label.text = "Wonder Woman"
        label.font = UIFont.systemFont(ofSize: 12, weight: UIFont.Weight(rawValue: 25))
        label.numberOfLines = 2
        label.textColor = .black
        return label
    }()
    
    func setupView(){
        addSubview(relatedImage)
        addSubview(relatedMainDescription)
        
        relatedImage.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 125)
        relatedMainDescription.anchor(top: relatedImage.bottomAnchor, left: relatedImage.leftAnchor, bottom: nil, right: relatedImage.rightAnchor, paddingTop: 16, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 14)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
