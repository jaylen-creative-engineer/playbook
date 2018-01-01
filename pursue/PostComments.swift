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
    
    var accessDetailController : PostDetailController?
    
    let photosOfCommenters = ["comment-1", "comment-2", "comment-3", "comment-4", "comment-5", "comment-6", "comment-7"]
    let nameOfCommenters = ["Colion Noir", "Mike O'Hearn", "Jocko", "Tai Lopez", "Whitesse", "Traction Conf", "Nasseh"]
    let textForComments = ["Take advantage of free Instagram tools", "Promote instagram post across your other social media profiles.", "Don't overwhelm your audience", "Interact with followers to spark growth", "Create an interactive hashtag.", "Repurpose content from other relevant accounts.", "Use creativity to connect with your audience."]
    
    let postComments : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    func setupView(){
        addSubview(postComments)
        
        postComments.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! PostCommentsCell
        cell.userPhoto.image = UIImage(named: photosOfCommenters[indexPath.item])?.withRenderingMode(.alwaysOriginal)
        cell.commentText.text = textForComments[indexPath.item]
        cell.usernameLabel.text = nameOfCommenters[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        accessDetailController?.showUserProfile()
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
