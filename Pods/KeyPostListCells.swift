//
//  KeyPostListCells.swift
//  Alamofire
//
//  Created by Jaylen Sanders on 9/25/18.
//

import UIKit

class KeyPostListCells : UICollectionViewCell {
    
    let countLabel : UILabel = {
        let label = UILabel()
        label.text = "1"
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    
    let imageView : UIImageView = {
        let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "beauty").withRenderingMode(.alwaysOriginal)
        iv.contentMode = .scaleAspectFill
        iv.layer.cornerRadius = 4
        iv.layer.masksToBounds = true
        return iv
    }()
    
    let postDetail : UILabel = {
        let label = UILabel()
        label.text = "Some text about this post"
        label.numberOfLines = 0
        label.font = UIFont.boldSystemFont(ofSize: 12)
        return label
    }()
    
    let timeLabel : UILabel = {
        let label = UILabel()
        label.text = "2 days ago"
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()
    
    lazy var createButton : UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "create_unselected").withRenderingMode(.alwaysOriginal), for: .normal)
        button.imageView?.contentMode = .scaleAspectFill
        return button
    }()
    
    func setupView(){
        addSubview(countLabel)
        addSubview(imageView)
        addSubview(postDetail)
        addSubview(timeLabel)
        addSubview(createButton)
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
