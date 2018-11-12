//
//  SearchPostCells.swift
//  pursue
//
//  Created by Jaylen Sanders on 9/15/18.
//  Copyright © 2018 Glory. All rights reserved.
//

import UIKit


class SearchPostCells : UICollectionViewCell  {
    
    var post : Post! {
        didSet {
            guard let photo = post.thumbnailUrl else { return }
            imageView.loadImageUsingCacheWithUrlString(photo)
            postDetail.text = post.description
        }
    }
    
    let imageView : UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = .white
        iv.layer.cornerRadius = 8
        iv.clipsToBounds = true
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    
    let postDetail : UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.init(25))
        label.textAlignment = .center
        return label
    }()
    
    let backgroundShadow : HomeCellRectangleView = {
        let view = HomeCellRectangleView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    
    func setupView(){
        addSubview(backgroundShadow)
        addSubview(imageView)
        addSubview(postDetail)
        
        backgroundShadow.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        imageView.anchor(top: backgroundShadow.topAnchor, left: backgroundShadow.leftAnchor, bottom: backgroundShadow.bottomAnchor, right: backgroundShadow.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        postDetail.anchor(top: nil, left: imageView.leftAnchor, bottom: imageView.bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 12, paddingBottom: 18, paddingRight: 12, width: 0, height: 0)
        postDetail.heightAnchor.constraint(lessThanOrEqualToConstant: 52).isActive = true
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        hero.isEnabled = true
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
