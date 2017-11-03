//
//  ToolsCell.swift
//  pursue
//
//  Created by Jaylen Sanders on 9/25/17.
//  Copyright © 2017 Glory. All rights reserved.
//

import UIKit

class ToolsCell: UICollectionViewCell {
    
    let toolsButton : UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor.init(white: 0.4, alpha: 0.05)
        return button
    }()
    
    let exerciseLabel : UILabel = {
       let label = UILabel()
        label.text = "Adobe"
        label.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight(rawValue: 25))
        return label
    }()
    
    let toolImage : UIImageView = {
       let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "car-3")
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
    }()

    
    
    func setupCardDetails(){
        addSubview(exerciseLabel)
        
        exerciseLabel.anchor(top: toolImage.bottomAnchor, left: toolImage.leftAnchor, bottom: nil, right: toolImage.rightAnchor, paddingTop: 8, paddingLeft: 0, paddingBottom: 0, paddingRight: 8, width: 0, height: 14)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(toolsButton)
        toolsButton.addSubview(toolImage)
        
        toolsButton.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 175, height: 100)
        toolImage.anchor(top: toolsButton.topAnchor, left: toolsButton.leftAnchor, bottom: toolsButton.bottomAnchor, right: toolsButton.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        setupCardDetails()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
