//
//  PursuiDiscussionCells.swift
//  GoogleToolboxForMac
//
//  Created by Jaylen Sanders on 12/9/17.
//

import UIKit

class PursuitDiscussionCells : UICollectionViewCell {
    
    let discussionLabel : UILabel = {
        let label = UILabel()
        label.text = "Click on this when you need a little help."
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    
    let discussionPhoto : UIImageView = {
        let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "car-3")
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
        
    }()
    
    func setupView(){
        addSubview(discussionPhoto)
        addSubview(discussionLabel)
        
        discussionPhoto.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: 100, height: 60)
        discussionLabel.anchor(top: discussionPhoto.topAnchor, left: discussionPhoto.rightAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 12, paddingBottom: 0, paddingRight: 10, width: 0, height: 40)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
