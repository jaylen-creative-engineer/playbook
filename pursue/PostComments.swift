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
    let textForComments = ["Take advantage of free Instagram tools", "Promote instagram post across your other social media profiles.", "Don't overwhelm your audience", "Interact with followers to spark growth", "Create an interactive hashtag.", "Repurpose content from other relevant accounts.", "Use creativity to connect with your audience."]
    
    let postComments : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    let commentsLabel : UILabel = {
        let label = UILabel()
        label.text = "Comments"
        label.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight(rawValue: 25))
        return label
    }()
    
    let downArrow : UIImageView = {
        let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "expand_arrow1600").withRenderingMode(.alwaysOriginal)
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    func setupView(){
        let underlineView = UIView()
        underlineView.backgroundColor = .gray
        
        addSubview(downArrow)
        addSubview(commentsLabel)
        addSubview(postComments)
        addSubview(underlineView)
        
        commentsLabel.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: commentsLabel.intrinsicContentSize.width, height: commentsLabel.intrinsicContentSize.height)
        downArrow.anchor(top: commentsLabel.bottomAnchor, left: nil, bottom: nil, right: rightAnchor, paddingTop: 8, paddingLeft: 0, paddingBottom: 0, paddingRight: 14, width: 25, height: 25)
        postComments.anchor(top: commentsLabel.bottomAnchor, left: leftAnchor, bottom: nil, right: downArrow.leftAnchor, paddingTop: 8, paddingLeft: 0, paddingBottom: 0, paddingRight: 8, width: 0, height: 70)
        underlineView.anchor(top: postComments.bottomAnchor, left: commentsLabel.leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 32, paddingLeft: 0, paddingBottom: 0, paddingRight: 12, width: 0, height: 0.5)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! PostCommentsCell
        cell.userPhoto.image = UIImage(named: photosOfCommenters[indexPath.item])?.withRenderingMode(.alwaysOriginal)
        cell.commentText.text = textForComments[indexPath.item]
        cell.usernameLabel.text = nameOfCommenters[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(12, 42, 0, 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
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
