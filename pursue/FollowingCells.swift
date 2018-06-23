//
//  FollowingCells.swift
//  pursue
//
//  Created by Jaylen Sanders on 2/27/18.
//  Copyright © 2018 Glory. All rights reserved.
//

import UIKit

class FollowingCells : UICollectionViewCell {
    
    var follower : Follower? {
        didSet {
            guard let photoUrl = follower?.photoUrl else { return }
            self.imageView.loadImage(urlString: photoUrl)
        }
    }
    
    let imageView : CustomImageView = {
       let iv = CustomImageView()
        iv.contentMode = .scaleAspectFill
        iv.layer.masksToBounds = true
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.layer.cornerRadius = 20
        return iv
    }()
 
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(imageView)
        imageView.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 10, paddingLeft: 8, paddingBottom: 0, paddingRight: 0, width: 40, height: 40)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

