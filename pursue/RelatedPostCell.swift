//
//  RelatedPostCell.swift
//  pursue
//
//  Created by Jaylen Sanders on 10/16/17.
//  Copyright © 2017 Glory. All rights reserved.
//

import UIKit

class RelatedPostCell : UICollectionViewCell {
    
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
    
    let relatedSubDesctiption : UILabel = {
        let label = UILabel()
        label.text = "Return To IMAX"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 12, weight: UIFont.Weight.thin)
        return label
    }()
    
    func setupView(){
        addSubview(relatedImage)
        addSubview(relatedMainDescription)
        addSubview(relatedSubDesctiption)
        
        relatedImage.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 185)
        relatedMainDescription.anchor(top: relatedImage.bottomAnchor, left: relatedImage.leftAnchor, bottom: nil, right: relatedImage.rightAnchor, paddingTop: 16, paddingLeft: 0, paddingBottom: 0, paddingRight: 8, width: 0, height: 14)
        relatedSubDesctiption.anchor(top: relatedMainDescription.bottomAnchor, left: relatedMainDescription.leftAnchor, bottom: nil, right: relatedMainDescription.rightAnchor, paddingTop: 8, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 16)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
