//
//  SearchHistoryCell.swift
//  pursue
//
//  Created by Jaylen Sanders on 7/8/18.
//  Copyright © 2018 Glory. All rights reserved.
//

import UIKit

class SearchHistoryCell : UICollectionViewCell {
    
    lazy var searchHistoryButton : UIButton = {
        let button = UIButton()
        button.setTitle("Tom Cat", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont(name: "Lato-Semibold", size: 12)
        button.backgroundColor = UIColor.rgb(red: 192, green: 192, blue: 192)
        button.layer.cornerRadius = 16
        button.layer.masksToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(searchHistoryButton)
        searchHistoryButton.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 35)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
