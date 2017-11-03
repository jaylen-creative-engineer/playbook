//
//  FeedChallengeRow.swift
//  pursue
//
//  Created by Jaylen Sanders on 10/30/17.
//  Copyright © 2017 Glory. All rights reserved.
//

import UIKit

class FeedChallengeRow : PursuitChallenge {
    
    let challengeId = "challengeId"
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: challengeId, for: indexPath) as! FeedChallengeCells
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        pursuitChallenge.register(FeedChallengeCells.self, forCellWithReuseIdentifier: challengeId)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }    
    
}
