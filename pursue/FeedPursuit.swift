//
//  FeedPursuit.swift
//  pursue
//
//  Created by Jaylen Sanders on 12/14/17.
//  Copyright © 2017 Glory. All rights reserved.
//

import UIKit

class FeedPursuit : UICollectionViewCell {
    
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
        label.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight(rawValue: 25))
        label.numberOfLines = 2
        label.textColor = .black
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

    func setupView(){
        addSubview(relatedImage)
        addSubview(relatedMainDescription)
        addSubview(progressBar)
        
        relatedImage.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 115)
        relatedMainDescription.anchor(top: relatedImage.bottomAnchor, left: relatedImage.leftAnchor, bottom: nil, right: relatedImage.rightAnchor, paddingTop: 16, paddingLeft: 0, paddingBottom: 0, paddingRight: 8, width: 0, height: 14)
        
        progressBar.anchor(top: relatedImage.bottomAnchor, left: relatedImage.leftAnchor, bottom: nil, right: relatedImage.rightAnchor, paddingTop: 4, paddingLeft: 0, paddingBottom: 0, paddingRight: 8, width: 0, height: 3)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
