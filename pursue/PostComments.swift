//
//  PostComments.swift
//  pursue
//
//  Created by Jaylen Sanders on 10/15/17.
//  Copyright © 2017 Glory. All rights reserved.
//

import UIKit

class PostComments: UICollectionViewCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    let cellId = "cellId"
    
    
    let photosOfCommenters = ["comment-1", "comment-2", "comment-3", "comment-4", "comment-5", "comment-6", "comment-7"]
    let nameOfCommenters = ["Colion Noir", "Mike O'Hearn", "Jocko", "Tai Lopez", "Whitesse", "Traction Conf", "Nasseh"]
    let comments = ["Take advantage of free Instagram tools", "Promote instagram post across your other social media profiles.", "Don't overwhelm your audience", "Interact with followers to spark growth", "Create an interactive hashtag.", "Repurpose content from other relevant accounts.", "Use creativity to connect with your audience."]
    
    let postComments : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.showsVerticalScrollIndicator = false
        collectionView.isScrollEnabled = false
        return collectionView
    }()
    
    let commentsLabel : UILabel = {
        let label = UILabel()
        label.text = "3 Comments."
        label.font = UIFont.boldSystemFont(ofSize: 14)
        return label
    }()
    
    let downArrow : UIImageView = {
        let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "expand_arrow1600").withRenderingMode(.alwaysOriginal)
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    func setupView(){        
        addSubview(commentsLabel)
        addSubview(postComments)
        postComments.backgroundColor = .blue
        commentsLabel.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: commentsLabel.intrinsicContentSize.width, height: commentsLabel.intrinsicContentSize.height)
        postComments.anchor(top: commentsLabel.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 8, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 300)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! PostCommentsCell
        cell.userPhoto.image = UIImage(named: photosOfCommenters[indexPath.item])?.withRenderingMode(.alwaysOriginal)
        cell.commentText.text = comments[indexPath.item]
        cell.usernameLabel.text = nameOfCommenters[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width, height: 275)
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//        return UIEdgeInsetsMake(12, 42, 0, 0)
//    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        return 0
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//        return 1
//    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        accessDetailController?.showUserProfile()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        
        postComments.dataSource = self
        postComments.delegate = self
        postComments.register(PostCommentsCell.self, forCellWithReuseIdentifier: cellId)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
