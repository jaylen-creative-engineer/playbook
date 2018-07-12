//
//  HomePursuitsCells.swift
//  pursue
//
//  Created by Jaylen Sanders on 6/19/18.
//  Copyright © 2018 Glory. All rights reserved.
//

import UIKit


class HomePursuitsCells : UICollectionViewCell {
    
    let photo : UIImageView = {
       let iv = UIImageView()
        iv.layer.cornerRadius = 8
        iv.layer.masksToBounds = true
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    let detailLabel : UILabel = {
       let label = UILabel()
        label.text = "Have a vision to work towards"
        label.font = UIFont(name: "Lato-Semibold", size: 12)
        return label
    }()
    
    let usernameLabel : UILabel = {
       let label = UILabel()
        label.text = "Test"
        label.font = UIFont.systemFont(ofSize: 10)
        return label
    }()
    
    let circleView : UIView = {
       let view = UIView()
        view.backgroundColor = .black
        view.layer.cornerRadius = 2
        return view
    }()
    
    let daysLabel : UILabel = {
       let label = UILabel()
        label.text = "2 Days"
        label.font = UIFont.systemFont(ofSize: 10)
        return label
    }()
    
    let saveButtonBackground : GroupChatView = {
        let gcv = GroupChatView()
        gcv.translatesAutoresizingMaskIntoConstraints = false
        gcv.backgroundColor = .white
        return gcv
    }()
    
    let saveButton : UIButton = {
       let button = UIButton()
        button.setTitle("Save", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont(name: "Lato-Bold", size: 12)
        button.titleLabel?.textAlignment = .center
        return button
    }()
    
    let userPhoto : UIImageView = {
       let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "samuel-l").withRenderingMode(.alwaysOriginal)
        iv.contentMode = .scaleAspectFill
        iv.layer.cornerRadius = 20
        iv.layer.masksToBounds = true
        return iv
    }()
    
    let playBackground : PlayView = {
       let view = PlayView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    
    let playIcon : UIImageView = {
       let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "view-more").withRenderingMode(.alwaysOriginal)
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    func setupView(){
        addSubview(photo)
        
        photo.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
