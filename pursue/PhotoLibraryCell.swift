//
//  PhotoLibraryCell.swift
//  pursue
//
//  Created by Jaylen Sanders on 2/21/18.
//  Copyright © 2018 Glory. All rights reserved.
//

import UIKit

protocol PhotoDelegate {
    func didSelect(for cell : PhotoLibraryCell)
}

class PhotoLibraryCell : UICollectionViewCell {
    
    var delegate : PhotoDelegate?
    
    lazy var imageView : UIImageView = {
       let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.clipsToBounds = true
        iv.layer.cornerRadius = 4
        return iv
    }()
    
    lazy var timeLabel : UILabel = {
       let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 12)
        label.textAlignment = .right
        return label
    }()
    
    override var isSelected: Bool {
        didSet {
            delegate?.didSelect(for: self)
        }
    }
    
    var representedAssetIdentifier: String!

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(imageView)
        imageView.addSubview(timeLabel)
        imageView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        timeLabel.anchor(top: nil, left: nil, bottom: imageView.bottomAnchor, right: imageView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 8, paddingRight: 4, width: 44, height: timeLabel.intrinsicContentSize.height)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
