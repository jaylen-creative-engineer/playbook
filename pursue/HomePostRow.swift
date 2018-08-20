//
//  HomePostRow.swift
//  pursue
//
//  Created by Jaylen Sanders on 8/19/18.
//  Copyright © 2018 Glory. All rights reserved.
//

import UIKit

class HomePostRow : UICollectionViewCell {
    
    let peopleId = "peopleId"
    
    let imageView : UIImageView = {
       let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "ferrari").withRenderingMode(.alwaysOriginal)
        iv.contentMode = .scaleAspectFill
        iv.layer.cornerRadius = 8
        iv.layer.masksToBounds = true
        return iv
    }()
    
    let photoBackground : GroupChatView = {
        let view = GroupChatView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let postTableView : UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.isScrollEnabled = false
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        return tableView
    }()
    
    let detailLabel : UILabel = {
        let label = UILabel()
        label.text = "Have a vision to work towards"
        label.textColor = .white
        label.font = UIFont(name: "Lato-Black", size: 12)
        return label
    }()
    
    let usernameLabel : UILabel = {
        let label = UILabel()
        label.text = "Test"
        label.font = UIFont(name: "Lato-Bold", size: 10)
        label.textColor = .white
        return label
    }()
    
    let userPhoto : UIImageView = {
        let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "samuel-l").withRenderingMode(.alwaysOriginal)
        iv.contentMode = .scaleAspectFill
        iv.layer.cornerRadius = 15
        iv.layer.masksToBounds = true
        return iv
    }()
    
    func setupView(){
        addSubview(photoBackground)
        addSubview(imageView)
        addSubview(postTableView)
        addSubview(userPhoto)
        addSubview(usernameLabel)
        addSubview(detailLabel)
        
        photoBackground.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 8, paddingLeft: 10, paddingBottom: 0, paddingRight: 10, width: 0, height: 270)
        imageView.anchor(top: photoBackground.topAnchor, left: photoBackground.leftAnchor, bottom: photoBackground.bottomAnchor, right: photoBackground.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        userPhoto.anchor(top: imageView.topAnchor, left: imageView.leftAnchor, bottom: nil, right: nil, paddingTop: 8, paddingLeft: 8, paddingBottom: 0, paddingRight: 0, width: 30, height: 30)
        usernameLabel.anchor(top: nil, left: imageView.leftAnchor, bottom: imageView.bottomAnchor, right: imageView.rightAnchor, paddingTop: 0, paddingLeft: 8, paddingBottom: 12, paddingRight: 8, width: 0, height: 14)
        detailLabel.anchor(top: nil, left: imageView.leftAnchor, bottom: usernameLabel.topAnchor, right: imageView.rightAnchor, paddingTop: 0, paddingLeft: 8, paddingBottom: 6, paddingRight: 8, width: 0, height: 14)
        postTableView.anchor(top: imageView.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 16, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: frame.height * 2)
        postTableView.delegate = self
        postTableView.dataSource = self
        postTableView.register(HomePostRowCells.self, forCellReuseIdentifier: "Cell")
        postTableView.reloadData()
    }
    
    let userPhotos = [#imageLiteral(resourceName: "clean-3"),#imageLiteral(resourceName: "clean-2"),#imageLiteral(resourceName: "comment-2"), #imageLiteral(resourceName: "comment-6")]

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension HomePostRow : UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! HomePostRowCells
        cell.setupView()
        return cell
       
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return frame.height
    }
}
