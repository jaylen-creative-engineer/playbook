//
//  ExploreRowCells.swift
//  pursue
//
//  Created by Jaylen Sanders on 10/23/17.
//  Copyright © 2017 Glory. All rights reserved.
//

import UIKit

protocol ExerciseImageCellDelegate {
    func imageCellTapped()
    func imageCellHeld()
}
class ExerciseImageCells : UICollectionViewCell {
    
    var exerciseImageDelegate : ExerciseImageCellDelegate?
    
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
        iv.layer.cornerRadius = 4
        return iv
    }()
    
    @objc func handleImageTap(){
        exerciseImageDelegate?.imageCellTapped()
    }
    
    @objc func handleImageHold(){
        exerciseImageDelegate?.imageCellHeld()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        exploreMainDescription.sizeToFit()
    }
    
    let exploreMainDescription : UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 14)
        label.textAlignment = .justified
        return label
    }()
    
    func setupView() {
        addSubview(exploreImage)
        addSubview(exploreMainDescription)
        
        exploreImage.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 48, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 305)
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
