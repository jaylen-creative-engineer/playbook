//
//  FeedPictureRow.swift
//  pursue
//
//  Created by Jaylen Sanders on 10/30/17.
//  Copyright © 2017 Glory. All rights reserved.
//

import UIKit

class FeedPictureRow : FeedRow {
    let pictureId = "pictureId"
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: pictureId, for: indexPath) as! FeedPictureRowCells
        return cell
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        postCollection.register(FeedPictureRowCells.self, forCellWithReuseIdentifier: pictureId)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
