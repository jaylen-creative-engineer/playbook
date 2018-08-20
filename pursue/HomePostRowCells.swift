//
//  HomePostRowCells.swift
//  pursue
//
//  Created by Jaylen Sanders on 8/19/18.
//  Copyright © 2018 Glory. All rights reserved.
//

import UIKit
import Firebase

class HomePostRowCells : UITableViewCell {
    
    let cellId = "cellId"
    let peopleId = "peopleId"
    
    let postCollectionView : UICollectionView = {
        let layout = PinterestLayout()
        layout.numberOfColumns = 2
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        
        collectionView.showsVerticalScrollIndicator = false
        collectionView.isScrollEnabled = false
        return collectionView
    }()
 
    let imageName = [#imageLiteral(resourceName: "health"), #imageLiteral(resourceName: "fashion-design"), #imageLiteral(resourceName: "ferrari-f70"), #imageLiteral(resourceName: "ferrari")]
    let userPhotos = [#imageLiteral(resourceName: "clean-3"),#imageLiteral(resourceName: "clean-2"),#imageLiteral(resourceName: "comment-2"), #imageLiteral(resourceName: "comment-6")]
    
    func setupPeopleCollection(){
//        peopleCollectionView.delegate = self
//        peopleCollectionView.dataSource = self
//        peopleCollectionView.register(HomePeopleCells.self, forCellWithReuseIdentifier: peopleId)
//        contentView.addSubview(peopleCollectionView)
//        peopleCollectionView.anchor(top: postCollectionView.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 18, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 200)
    }
    
    func setupView(){
        self.selectionStyle = .none
        
        contentView.addSubview(postCollectionView)
        postCollectionView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        postCollectionView.dataSource = self
        postCollectionView.delegate = self
        postCollectionView.register(HomePursuitsCells.self, forCellWithReuseIdentifier: cellId)
        if let layout = postCollectionView.collectionViewLayout as? PinterestLayout {
            layout.delegate = self
        }
        
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension HomePostRowCells : UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! HomePursuitsCells
        //        cell.delegate = self
        //        cell.accessHomePursuitsRow = self
        //        cell.photo.heroID = String(indexPath.item)
        cell.photo.image = imageName[indexPath.item]
        cell.userPhoto.image = userPhotos[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        accessHomeController?.handleChangeToDetail(viewType: "isPursuitDetail", transitionId: String(indexPath.item))
//        Analytics.logEvent("Change to detail for \(String(describing: rowLabel.text))", parameters: nil)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
}

extension HomePostRowCells : PinterestLayoutDelegate {
    
    func collectionView(_ collectionView: UICollectionView, heightForPhotoAtIndexPath indexPath: IndexPath, withWidth: CGFloat) -> CGFloat {
        return 105
    }
    
    func collectionView(_ collectionView: UICollectionView, heightForAnnotationAtIndexPath indexPath: IndexPath, withWidth width: CGFloat) -> CGFloat {
        return 105
    }
}
