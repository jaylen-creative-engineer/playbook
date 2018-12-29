//
//  HomeMenuCells.swift
//  Inpursuit
//
//  Created by Jaylen Sanders on 12/23/18.
//  Copyright © 2018 Glory. All rights reserved.
//

import UIKit

class HomeMenuCells : UICollectionViewCell {
    
    let sectionLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.textColor = .black
        return label
    }()
    
    let cellBackgroundView : HomeMenuCellShadowView = {
       let view = HomeMenuCellShadowView()
        view.backgroundColor = .white
        return view
    }()
    
    override var isHighlighted: Bool {
        didSet {
            sectionLabel.textColor = isHighlighted ? .white : .black
            sectionLabel.font = isHighlighted ? UIFont.systemFont(ofSize: 12, weight: UIFont.Weight.init(25)) : UIFont.boldSystemFont(ofSize: 12)
            cellBackgroundView.backgroundColor = isHighlighted ? .black : .white
        }
    }
    
    override var isSelected: Bool {
        didSet {
            sectionLabel.textColor = isSelected ? .white : .black
            sectionLabel.font = isSelected ? UIFont.systemFont(ofSize: 12, weight: UIFont.Weight.init(25)) : UIFont.boldSystemFont(ofSize: 12)
            cellBackgroundView.backgroundColor = isSelected ? .black : .white
        }
    }
    
    func setupView(){
        addSubview(cellBackgroundView)
        cellBackgroundView.addSubview(sectionLabel)
        
        cellBackgroundView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        sectionLabel.anchor(top: nil, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: sectionLabel.intrinsicContentSize.width, height: sectionLabel.intrinsicContentSize.height)
        sectionLabel.centerXAnchor.constraint(equalTo: cellBackgroundView.centerXAnchor).isActive = true
        sectionLabel.centerYAnchor.constraint(equalTo: cellBackgroundView.centerYAnchor).isActive = true
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
