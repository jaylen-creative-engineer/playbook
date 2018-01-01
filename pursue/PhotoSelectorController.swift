//
//  PhotoSelectorController.swift
//  pursue
//
//  Created by Jaylen Sanders on 9/19/17.
//  Copyright © 2017 Glory. All rights reserved.
//

import Foundation
import Photos

class PhotoSelectorController : UICollectionViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var cameraController : SelectCameraController?
    
    let cellId = "cellId"
    let headerId = "headerId"
    var images = [UIImage]()
    var assets = [PHAsset]()
    
    let photoCollection : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        
        photoCollection.delegate = self
        photoCollection.dataSource = self
        photoCollection.register(PhotoSelectorCell.self, forCellWithReuseIdentifier: cellId)
       
        let guide = safeAreaLayoutGuide
        addSubview(photoCollection)
        photoCollection.contentInset = UIEdgeInsetsMake((frame.width / 3) - 50, 0, 75, 0)
        photoCollection.anchor(top: nil, left: guide.leftAnchor, bottom: guide.bottomAnchor, right: guide.rightAnchor, paddingTop: 0, paddingLeft: 6, paddingBottom: 0, paddingRight: 6, width: 0, height: frame.height)
        fetchPhotos()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        self.selectedImage = images[indexPath.item]
        self.photoCollection.reloadData()
        
        guard let image = selectedImage else { return }
        cameraController?.handleNext(image: image)
    }
    
    var selectedImage : UIImage?
    
    fileprivate func assetFetchOptions() -> PHFetchOptions {
        let fetchOptions = PHFetchOptions()
        fetchOptions.fetchLimit = 30
        
        let sortDescriptor = NSSortDescriptor(key: "creationDate", ascending: false)
        fetchOptions.sortDescriptors = [sortDescriptor]
        
        return fetchOptions
    }
    
    fileprivate func fetchPhotos(){
        
        let allPhotos = PHAsset.fetchAssets(with: .image, options: assetFetchOptions())
        
        DispatchQueue.global(qos: .background).async {
            
            allPhotos.enumerateObjects({ (asset, count, stop) in
                
                let imageManager = PHImageManager.default()
                let targetSize = CGSize(width: 200, height: 200)
                let options = PHImageRequestOptions()
                options.isSynchronous = true
                imageManager.requestImage(for: asset, targetSize: targetSize, contentMode: .aspectFit, options: options, resultHandler: { (image, info) in
                    if let image = image {
                        self.images.append(image)
                        self.assets.append(asset)
                        
                        if self.selectedImage == nil {
                            self.selectedImage = image
                        }
                    }
                    
                    if count == allPhotos.count - 1 {
                        DispatchQueue.main.async {
                            self.photoCollection.reloadData()
                        }
                    }
                })
            })
            
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(1, 0, 0, 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (frame.width - 25) / 3
        return CGSize(width: width, height: width + 70)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! PhotoSelectorCell
        cell.photoImageView.image = images[indexPath.item]
        return cell
        
    }
    
    
    @objc func handleCancel(){
//        dismiss(animated: true, completion: nil)
    }
    
    @objc func handleNext(){
        
//        let sharePhotoController = SharePhotoController()
//        sharePhotoController.selectedImage = header?.photoImageView.image
//        navigationController?.pushViewController(sharePhotoController, animated: true)
    }
}
