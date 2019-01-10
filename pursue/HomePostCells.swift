//
//  HomePostCells.swift
//  pursue
//
//  Created by Jaylen Sanders on 8/28/18.
//  Copyright © 2018 Glory. All rights reserved.
//

import UIKit
import Hero
import PinterestLayout

protocol HomePostDelegate {
    func changeToDetail(for cell : HomePostCells)
}

class HomePostCells : UICollectionViewCell  {
    
    var delegate : HomePostDelegate?
    var accessHomeController : HomeController?
    let cellId = "cellId"
    
//    var post : [Post]! {
//        didSet {
//            guard let photo = post.first?.thumbnailUrl else { return }
//            guard let postUser = post.first?.userPhotourl else { return }
//            imageView.loadImageUsingCacheWithUrlString(photo)
//            userPhoto.loadImageUsingCacheWithUrlString(postUser)
//            postDetail.text = post.first?.posts_description
//            username.text = post.first?.username
//            
//            let dateFormatterGet = DateFormatter()
//            dateFormatterGet.dateFormat = "yyyy-MM-dd HH:mm:ss.SSSSSS"
//            
//            let dateFormatterPrint = DateFormatter()
//            dateFormatterPrint.dateFormat = "MMM dd,yyyy"
//            
//            if let date = dateFormatterGet.date(from: (post.first?.created_at!)!) {
//                let timeAgoDisplay = date.timeAgoDisplay()
//                let attributedText = NSAttributedString(string: timeAgoDisplay, attributes: [NSAttributedString.Key.font: UIFont(name: "Lato-Bold", size: 12) as Any, NSAttributedString.Key.foregroundColor: UIColor.white])
//                timeLabel.attributedText = attributedText
//            } else {
//                print("There was an error decoding the string")
//            }
//            collectionView.reloadData()
//        }
//    }
    
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
        let layout = PinterestLayout()
        layout.numberOfColumns = 2
        layout.cellPadding = 10
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isScrollEnabled = false
        return collectionView
    }()
    
    let trendingPostLabel : UILabel = {
       let label = UILabel()
        label.text = "Recent Posts"
        label.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.init(25))
        return label
    }()
    
    let imageNames = [UIImage(named : "cafe-768771_1280"), UIImage(named : "gian-cescon-637914-unsplash"), UIImage(named : "IMG_0807"), UIImage(named : "IMG_3935")]
    
    @objc func handleChangeDetail(){
        delegate?.changeToDetail(for: self)
//        accessHomeController?.handleChangeToDetail(transitionId: "0")
    }
    
    func setupCollectionView(){
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(HomePinterestCell.self, forCellWithReuseIdentifier: cellId)
        
        if let layout = collectionView.collectionViewLayout as? PinterestLayout {
            layout.delegate = self
        }
        
        addSubview(collectionView)
        collectionView.anchor(top: trendingPostLabel.bottomAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 24, paddingLeft: 0, paddingBottom: 20, paddingRight: 0, width: 0, height: 0)
    }

    func setupView(){
        addSubview(trendingPostLabel)
        
        trendingPostLabel.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 18, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: trendingPostLabel.intrinsicContentSize.width, height: 18)
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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! HomePinterestCell
        cell.photo.image = imageNames[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageNames.count
    }
}

extension HomePostCells : PinterestLayoutDelegate {
    
    func collectionView(collectionView: UICollectionView, heightForImageAtIndexPath indexPath: IndexPath, withWidth: CGFloat) -> CGFloat {
        if indexPath.item % 2 != 0 {
            return 120
        } else {
            return 115
        }
    }
    
    func collectionView(collectionView: UICollectionView, heightForAnnotationAtIndexPath indexPath: IndexPath, withWidth: CGFloat) -> CGFloat {
        if indexPath.item % 2 != 0 {
            return 120
        } else {
            return 115
        }
    }
}
