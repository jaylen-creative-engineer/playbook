//
//  ImageCells.swift
//  pursue
//
//  Created by Jaylen Sanders on 8/5/18.
//  Copyright © 2018 Glory. All rights reserved.
//

import UIKit

protocol ProfileImageCellsDelegate {
    func handleHold(for cell : ImageCells)
}

class ImageCells : UICollectionViewCell {
    
    var delegate : ProfileImageCellsDelegate?
    
    lazy var photo : UIImageView = {
        let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "steph").withRenderingMode(.alwaysOriginal)
        iv.layer.masksToBounds = true
        iv.contentMode = .scaleAspectFill
        iv.hero.id = "photoId-1"
        return iv
    }()
    
    let rowLabel : UILabel = {
       let label = UILabel()
        label.text = "Sample Label."
        label.font = UIFont(name: "Lato-Bold", size: 14)
        return label
    }()
    
    
    @objc func handleHeld(){
        delegate?.handleHold(for: self)
    }
    
    func setupView(){
        addSubview(photo)
        photo.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        
        let longGesture = UILongPressGestureRecognizer(target: self, action: #selector(handleHeld))
        addGestureRecognizer(longGesture)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
