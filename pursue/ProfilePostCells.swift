//
//  ProfilePostCells.swift
//  pursue
//
//  Created by Jaylen Sanders on 10/26/17.
//  Copyright © 2017 Glory. All rights reserved.
//

import UIKit

protocol ProfilePostCellDelegate {
    func postTapped()
    func postHeld()
}

class ProfilePostCells : UICollectionViewCell {
        
    lazy var exploreImage : UIImageView = {
        let iv = UIImageView()
        iv.layer.masksToBounds = true
        iv.contentMode = .scaleAspectFill
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleImageTap))
        let longGesture = UILongPressGestureRecognizer(target: self, action: #selector(handleImageHold))
        tapGesture.numberOfTapsRequired = 1
        iv.addGestureRecognizer(tapGesture)
        iv.addGestureRecognizer(longGesture)
        iv.isUserInteractionEnabled = true
        iv.image = #imageLiteral(resourceName: "samuel-l")
        iv.layer.cornerRadius = 4
        return iv
    }()
    
    @objc func handleImageTap(){
    }
    
    @objc func handleImageHold(){
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        exploreMainDescription.sizeToFit()
    }
    
    let exploreMainDescription : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight(rawValue: 25))
        label.textAlignment = .justified
        label.text = "Text is here"
        return label
    }()
    
    func setupView() {
        addSubview(exploreImage)
        addSubview(exploreMainDescription)
        
        exploreImage.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 48, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 305)
//        exploreImage.centerYAnchor.constraint(equalTo: <#T##NSLayoutAnchor<NSLayoutYAxisAnchor>#>)
        exploreMainDescription.anchor(top: exploreImage.bottomAnchor, left: exploreImage.leftAnchor, bottom: nil, right: exploreImage.rightAnchor, paddingTop: 16, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 50)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

