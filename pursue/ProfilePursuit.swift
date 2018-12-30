//
//  ProfilePursuit.swift
//  pursue
//
//  Created by Jaylen Sanders on 3/13/18.
//  Copyright © 2018 Glory. All rights reserved.
//

import UIKit
import PinterestLayout

class ProfilePursuit : UICollectionViewController {
    
    var pursuits : [Post]? {
        didSet {
            collectionView.reloadData()
        }
    }
    
    let imageNames = [UIImage(named : "cafe-768771_1280"), UIImage(named : "gian-cescon-637914-unsplash"), UIImage(named : "IMG_0807"), UIImage(named : "IMG_3935")]
    
    let cellId = "cellId"
    let labelId = "labelId"
    
    @objc func handleHeld(){
    }

    func setupCollectionView(){
        collectionView.register(RecommenedPursuitCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.backgroundColor = .clear
        collectionView.isScrollEnabled = false
    }
    
    func changeToDetail(for cell: ProfilePursuit) {
//        guard let indexPath = postCollectionView.indexPath(for: cell) else { return }
//        let detail = PostDetailController(collectionViewLayout: UICollectionViewFlowLayout())
//        detail.post = self.pursuits
//        present(detail, animated: true, completion: nil)
    }
    
    var accessProfileController : ProfileController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
    }
}

extension ProfilePursuit : UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (view.frame.width / 2) - 24, height: 220)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 15.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 15.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 12)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! RecommenedPursuitCell
        cell.photo.image = imageNames[indexPath.item]
        return cell
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageNames.count
    }
}
