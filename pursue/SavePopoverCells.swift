//
//  SavePopoverCells.swift
//  pursue
//
//  Created by Jaylen Sanders on 10/17/18.
//  Copyright © 2018 Glory. All rights reserved.
//

import UIKit

class SavePopoverCells : UICollectionViewCell {
    
//    var pursuit : Pursuit? {
//        didSet {
//            guard let image = pursuit?.thumbnailUrl else { return }
//            imageView.loadImageUsingCacheWithUrlString(image)
//            postDetail.text = pursuit?.pursuit_description
//        }
//    }
    
    override var isSelected: Bool {
        didSet {
            if isSelected == true {
                selectedFill.isHidden = false
                checkMark.isHidden = false
            } else {
                selectedFill.isHidden = true
                checkMark.isHidden = true
            }
        }
    }
    
    override var isHighlighted: Bool {
        didSet {
            if isHighlighted == true {
                selectedFill.isHidden = false
                checkMark.isHidden = false
            } else {
                selectedFill.isHidden = true
                checkMark.isHidden = true
            }
        }
    }
    
    lazy var imageView : UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named : "apartment-architecture-ceiling-259962")?.withRenderingMode(.alwaysOriginal)
        iv.layer.cornerRadius = 8
        iv.clipsToBounds = true
        iv.contentMode = .scaleAspectFill
        iv.isUserInteractionEnabled = true
        return iv
    }()
    
    let backgroundShadow : HomeCellRectangleView = {
        let view = HomeCellRectangleView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    
    lazy var selectedFill : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.init(white: 0.4, alpha: 0.8)
        view.layer.cornerRadius = 8
        view.layer.masksToBounds = true
        view.isHidden = true
        return view
    }()
    
    lazy var checkMark : UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "check")?.withRenderingMode(.alwaysOriginal)
        iv.contentMode = .scaleAspectFill
        iv.isHidden = true
        return iv
    }()
    
    let postDetail : UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = "This is filler text"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.init(25))
        label.textAlignment = .center
        return label
    }()
    
    func setupView(){
        addSubview(backgroundShadow)
        addSubview(imageView)
        addSubview(postDetail)
        addSubview(selectedFill)
        addSubview(checkMark)
        
        backgroundShadow.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        imageView.anchor(top: backgroundShadow.topAnchor, left: backgroundShadow.leftAnchor, bottom: backgroundShadow.bottomAnchor, right: backgroundShadow.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        postDetail.anchor(top: nil, left: imageView.leftAnchor, bottom: imageView.bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 12, paddingBottom: 12, paddingRight: 12, width: 0, height: 0)
        postDetail.heightAnchor.constraint(lessThanOrEqualToConstant: 52).isActive = true
        selectedFill.anchor(top: imageView.topAnchor, left: imageView.leftAnchor, bottom: imageView.bottomAnchor, right: imageView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        checkMark.centerXAnchor.constraint(equalTo: selectedFill.centerXAnchor).isActive = true
        checkMark.centerYAnchor.constraint(equalTo: selectedFill.centerYAnchor).isActive = true
        checkMark.anchor(top: nil, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 24, height: 24)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

