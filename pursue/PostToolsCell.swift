//
//  PostToolsCell.swift
//  pursue
//
//  Created by Jaylen Sanders on 10/20/17.
//  Copyright © 2017 Glory. All rights reserved.
//

import UIKit

class PostToolsCell : UICollectionViewCell {
    
    let toolLabel : UILabel = {
        let label = UILabel()
        label.text = "Click on this when you need a little help."
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    let toolDetailLabel : UILabel = {
        let label = UILabel()
        label.text = "Get in your backpedal"
        label.font = UIFont.systemFont(ofSize: 12, weight: UIFont.Weight.thin)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let toolPhoto : UIImageView = {
        let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "car-3")
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
        
    }()
    
    func setupView(){
        let toolStackUnderLine = UIView()
        toolStackUnderLine.backgroundColor = UIColor.init(white: 0, alpha: 0.2)
        
        addSubview(toolPhoto)
        addSubview(toolLabel)
        addSubview(toolDetailLabel)
        addSubview(toolStackUnderLine)
        
        toolPhoto.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: 100, height: 60)
        toolLabel.anchor(top: toolPhoto.topAnchor, left: toolPhoto.rightAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 12, paddingBottom: 0, paddingRight: 12, width: 0, height: 40)
        toolDetailLabel.anchor(top: toolLabel.bottomAnchor, left: toolLabel.leftAnchor, bottom: toolPhoto.bottomAnchor, right: toolLabel.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        toolStackUnderLine.anchor(top: toolPhoto.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 18, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0.5)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
