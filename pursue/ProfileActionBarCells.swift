//
//  ProfileActionBarCells.swift
//  Inpursuit
//
//  Created by Jaylen Sanders on 4/7/19.
//  Copyright © 2019 Glory. All rights reserved.
//

import UIKit


class ProfileActionBarCells : UICollectionViewCell {
    
    let headerLabel : UILabel = {
       let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textAlignment = .left
        label.textColor = .gray
        return label
    }()
    
    let activeLabel : UILabel = {
       let label = UILabel()
        label.text = "6 Active"
        label.textAlignment = .left
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()
    
    let completeLabel : UILabel = {
        let label = UILabel()
        label.text = "1 Complete"
        label.textAlignment = .left
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()
    
    override var isSelected: Bool {
        didSet {
            headerLabel.textColor = isSelected ? .black : .gray
            activeLabel.textColor = isSelected ? .black : .gray
            completeLabel.textColor = isSelected ? .black : .gray
        }
    }
    
    override var isHighlighted: Bool {
        didSet {
            headerLabel.textColor = isHighlighted ? .black : .gray
            activeLabel.textColor = isHighlighted ? .black : .gray
            completeLabel.textColor = isHighlighted ? .black : .gray
        }
    }
    
    func setupView(){
        addSubview(headerLabel)
        addSubview(activeLabel)
        addSubview(completeLabel)
        
        headerLabel.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 18)
        activeLabel.anchor(top: headerLabel.bottomAnchor, left: headerLabel.leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 4, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 14)
        completeLabel.anchor(top: activeLabel.bottomAnchor, left: activeLabel.leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 4, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 14)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
