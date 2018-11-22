//
//  HomePostCells.swift
//  pursue
//
//  Created by Jaylen Sanders on 8/28/18.
//  Copyright © 2018 Glory. All rights reserved.
//

import UIKit
import Hero

protocol HomePostDelegate {
    func changeToDetail(for cell : HomePostCells)
}

class HomePostCells : UICollectionViewCell  {
    
    var delegate : HomePostDelegate?
    var accessHomeController : HomeController?
    
    var post : [Post]! {
        didSet {
            guard let photo = post.first?.thumbnailUrl else { return }
            guard let postUser = post.first?.userPhotourl else { return }
            imageView.loadImageUsingCacheWithUrlString(photo)
            userPhoto.loadImageUsingCacheWithUrlString(postUser)
            postDetail.text = post.first?.posts_description
            username.text = post.first?.username
            
            let dateFormatterGet = DateFormatter()
            dateFormatterGet.dateFormat = "yyyy-MM-dd HH:mm:ss.SSSSSS"
            
            let dateFormatterPrint = DateFormatter()
            dateFormatterPrint.dateFormat = "MMM dd,yyyy"
            
            if let date = dateFormatterGet.date(from: (post.first?.created_at!)!) {
                let timeAgoDisplay = date.timeAgoDisplay()
                let attributedText = NSAttributedString(string: timeAgoDisplay, attributes: [NSAttributedString.Key.font: UIFont(name: "Lato-Bold", size: 12) as Any, NSAttributedString.Key.foregroundColor: UIColor.white])
                timeLabel.attributedText = attributedText
            } else {
                print("There was an error decoding the string")
            }
            collectionView.reloadData()
        }
    }
    
    var postArrayCount : Int?
    lazy var imageView : UIImageView = {
        let iv = UIImageView()
        iv.layer.cornerRadius = 8
        iv.clipsToBounds = true
        iv.contentMode = .scaleAspectFill
        iv.isUserInteractionEnabled = true
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleChangeDetail))
        tap.numberOfTapsRequired = 1
        iv.addGestureRecognizer(tap)
        return iv
    }()
    
    let backgroundShadow : GroupChatView = {
       let view = GroupChatView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let userPhoto : UIImageView = {
       let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.layer.cornerRadius = 20
        iv.layer.masksToBounds = true
        return iv
    }()
    
    let postDetail : UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.init(25))
        label.textAlignment = .left
        return label
    }()
    
    let username : UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Lato-Bold", size: 14)
        label.textColor = .white
        return label
    }()
    
    let timeLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Lato-Bold", size: 12)
        label.textColor = .white
        return label
    }()

    let collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    @objc func handleChangeDetail(){
        delegate?.changeToDetail(for: self)
//        accessHomeController?.handleChangeToDetail(transitionId: "0")
    }
    
    func setupCollectionView(){
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cellId")
        
        addSubview(collectionView)
        collectionView.anchor(top: imageView.topAnchor, left: imageView.leftAnchor, bottom: nil, right: imageView.rightAnchor, paddingTop: 8, paddingLeft: 8, paddingBottom: 0, paddingRight: 8, width: 0, height: 2.5)
    }

    func setupView(){
        addSubview(backgroundShadow)
        addSubview(imageView)
        addSubview(userPhoto)
        addSubview(postDetail)
        addSubview(username)
        addSubview(timeLabel)
        
        backgroundShadow.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 8, paddingBottom: 0, paddingRight: 8, width: 0, height: frame.height)
        imageView.anchor(top: backgroundShadow.topAnchor, left: backgroundShadow.leftAnchor, bottom: backgroundShadow.bottomAnchor, right: backgroundShadow.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        userPhoto.anchor(top: imageView.topAnchor, left: imageView.leftAnchor, bottom: nil, right: nil, paddingTop: 24, paddingLeft: 8, paddingBottom: 0, paddingRight: 0, width: 40, height: 40)
        username.anchor(top: userPhoto.topAnchor, left: userPhoto.rightAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 12, paddingBottom: 0, paddingRight: 24, width: 0, height: 16)
        timeLabel.anchor(top: username.bottomAnchor, left: username.leftAnchor, bottom: nil, right: nil, paddingTop: 8, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 14)
        postDetail.anchor(top: nil, left: imageView.leftAnchor, bottom: imageView.bottomAnchor, right: imageView.rightAnchor, paddingTop: 0, paddingLeft: 12, paddingBottom: 18, paddingRight: 12, width: 0, height: 0)
        postDetail.heightAnchor.constraint(lessThanOrEqualToConstant: 52).isActive = true
        setupCollectionView()
        
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

extension HomePostCells : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath)
        cell.backgroundColor = .white
        cell.layer.cornerRadius = 2
        cell.layer.masksToBounds = true
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return post.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (frame.width - 32) / CGFloat(post.count), height: frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 8.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8.0
    }
}
