//
//  ProfilePursuitCells.swift
//  pursue
//
//  Created by Jaylen Sanders on 3/13/18.
//  Copyright © 2018 Glory. All rights reserved.
//

import UIKit

class ProfilePursuitCells : UICollectionViewCell {
    
    let imageId = "imageId"
    
    let rowLabel : UILabel = {
       let label = UILabel()
        label.text = "Have a vision to work towards"
        label.font = UIFont(name: "Lato-Black", size: 12)
        return label
    }()
    
    var posts = [#imageLiteral(resourceName: "steph"), #imageLiteral(resourceName: "cars"), #imageLiteral(resourceName: "ferrari-f70"), #imageLiteral(resourceName: "ferrari"), #imageLiteral(resourceName: "samuel-l"), #imageLiteral(resourceName: "fall")]
    
    let collectionView : UICollectionView = {
        let layout = ProfilePinterestLayout()
        layout.numberOfColumns = 3
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        
        collectionView.showsVerticalScrollIndicator = false
        collectionView.isScrollEnabled = false
        collectionView.layer.cornerRadius = 8
        collectionView.layer.masksToBounds = true
        return collectionView
    }()
    
    func setupView(){
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(ImageCells.self, forCellWithReuseIdentifier: imageId)
        if let layout = collectionView.collectionViewLayout as? ProfilePinterestLayout {
            layout.delegate = self
        }
        
        addSubview(collectionView)
        addSubview(rowLabel)
        collectionView.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 460)
        rowLabel.anchor(top: nil, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 16)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ProfilePursuitCells : UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: imageId, for: indexPath) as! ImageCells
        if posts.count < 13 {
            let backgroundCell = UIImage(color: .lightGray)
            posts.append(backgroundCell!)
        }
        cell.photo.image = posts[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if posts.count < 13 {
            return 13
        } else {
            return posts.count
        }
    }
}

extension ProfilePursuitCells : ProfilePinterestLayoutDelegate {
    
    func collectionView(_ collectionView: UICollectionView, heightForPhotoAtIndexPath indexPath: IndexPath, withWidth: CGFloat) -> CGFloat {
        switch indexPath.item {
        case posts.count...12:
            if indexPath.item % 2 != 0 {
                return CGFloat(100)
            } else {
                return CGFloat(120)
            }
        default:
            if indexPath.item % 2 != 0 {
                if posts[indexPath.item].size.height / (CGFloat(5) + 2.5) > 100 {
                    return CGFloat(100)
                }
                return posts[indexPath.item].size.height / (CGFloat(4.5) + 1.25)
            } else {
                if posts[indexPath.item].size.height / (CGFloat(5) + 2.5) > 100 {
                    return CGFloat(90)
                }
                return posts[indexPath.item].size.height / (CGFloat(4.5) + 1.25)
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, heightForAnnotationAtIndexPath indexPath: IndexPath, withWidth width: CGFloat) -> CGFloat {
        switch indexPath.item {
        case posts.count...12:
            if indexPath.item % 2 != 0 {
                return CGFloat(100)
            } else {
                return CGFloat(120)
            }
        default:
            if indexPath.item % 2 != 0 {
                if posts[indexPath.item].size.height / (CGFloat(5) + 2.5) > 100 {
                    return CGFloat(90)
                }
                return posts[indexPath.item].size.height / (CGFloat(4.5) + 1.25)
            } else {
                if posts[indexPath.item].size.height / (CGFloat(5) + 2.5) > 100 {
                    return CGFloat(90)
                }
                return posts[indexPath.item].size.height / (CGFloat(4.5) + 1.25)
            }
        }
    }
}
