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
            postDetail.text = post.posts_description
//            guard let timeAgoDisplay = post.created_at?.timeAgoDisplay() else { return }
//            let attributedText = NSAttributedString(string: timeAgoDisplay, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12), NSAttributedString.Key.foregroundColor: UIColor.gray])
//            timeLabel.attributedText = attributedText
        }
    }
    
    let imageView : UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = .blue
        iv.layer.cornerRadius = 4
        iv.clipsToBounds = true
        iv.image = #imageLiteral(resourceName: "ferrari").withRenderingMode(.alwaysOriginal)
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    
    let postDetail : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()
    
    let timeLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .gray
        return label
    }()
    
    
    func setupView(){
    
        addSubview(imageView)
        addSubview(postDetail)
        addSubview(timeLabel)
        
        imageView.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: (frame.height / 1.3) - 20)
        postDetail.anchor(top: imageView.bottomAnchor, left: imageView.leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 8, paddingLeft: 0, paddingBottom: 0, paddingRight: 12, width: 0, height: 14)
        timeLabel.anchor(top: postDetail.bottomAnchor, left: postDetail.leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 8, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 14)
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
