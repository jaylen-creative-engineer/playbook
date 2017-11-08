//
//  ChallengesController.swift
//  pursue
//
//  Created by Jaylen Sanders on 11/7/17.
//  Copyright © 2017 Glory. All rights reserved.
//

import UIKit

class ChallengesController : UICollectionViewController, UICollectionViewDelegateFlowLayout, ChallengeDelegate {
    
    let headerId = "headerId"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.backgroundColor = .white
        collectionView?.register(ChallengesHeader.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerId)
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath) as! ChallengesHeader
        header.challengeDelegate = self
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: (view.frame.height / 2) + 100)
    }
    
    func goBack() {
        navigationController?.popViewController(animated: true)
    }
    
    func handleMessage(for cell: ChallengesHeader) {
        let messageController = MessagesController()
        let navController = UINavigationController(rootViewController: messageController)
        present(navController, animated: true, completion: nil)
    }
}
