//
//  KeyPostListCells.swift
//  pursue
//
//  Created by Jaylen Sanders on 9/25/18.
//  Copyright © 2018 Glory. All rights reserved.
//

import UIKit

protocol KeyPostListDelegate {
    func handleSave(for cell : KeyPostListCells)
}

class KeyPostListCells : UICollectionViewCell {
    
    var post : Post? {
        didSet {
            guard let image = post?.thumbnailUrl else { return }
            imageView.loadImageUsingCacheWithUrlString(image)
            postDetail.text = post?.description
            
            let dateFormatterGet = DateFormatter()
            dateFormatterGet.dateFormat = "yyyy-MM-dd HH:mm:ss.SSSSSS"
            
            let dateFormatterPrint = DateFormatter()
            dateFormatterPrint.dateFormat = "MMM dd,yyyy"
            
            guard let createdTime = post?.created_at else { return }
            if let date = dateFormatterGet.date(from: createdTime) {
                let timeAgoDisplay = date.timeAgoDisplay()
                timeLabel.text = timeAgoDisplay
            }
        }
    }
    
    var delegate : KeyPostListDelegate?
    
    let countLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    
    let imageView : UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.layer.cornerRadius = 4
        iv.layer.masksToBounds = true
        return iv
    }()
    
    let postDetail : UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.boldSystemFont(ofSize: 12)
        return label
    }()
    
    let timeLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()
    
    lazy var createButton : UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "add").withRenderingMode(.alwaysTemplate), for: .normal)
        button.tintColor = .gray
        button.imageView?.contentMode = .scaleAspectFill
        button.addTarget(self, action: #selector(handleSave), for: .touchUpInside)
        return button
    }()
    
    @objc func handleSave(){
        delegate?.handleSave(for: self)
    }
    
    func setupView(){
        addSubview(countLabel)
        addSubview(imageView)
        addSubview(postDetail)
        addSubview(timeLabel)
        addSubview(createButton)
        
        countLabel.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: 15, height: 18)
        imageView.anchor(top: countLabel.topAnchor, left: countLabel.rightAnchor, bottom: bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: 100, height: 0)
        postDetail.anchor(top: imageView.topAnchor, left: imageView.rightAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 12, paddingBottom: 0, paddingRight: 12, width: 0, height: 0)
        postDetail.heightAnchor.constraint(lessThanOrEqualToConstant: 30).isActive = true
        timeLabel.anchor(top: postDetail.bottomAnchor, left: postDetail.leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 8, paddingLeft: 0, paddingBottom: 0, paddingRight: 12, width: 0, height: 0)
        timeLabel.heightAnchor.constraint(lessThanOrEqualToConstant: 30).isActive = true
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
