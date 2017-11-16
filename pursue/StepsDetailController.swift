//
//  StepsDetailController.swift
//  pursue
//
//  Created by Jaylen Sanders on 11/8/17.
//  Copyright © 2017 Glory. All rights reserved.
//

import UIKit

class StepsDetailController : UICollectionViewController, UICollectionViewDelegateFlowLayout, StepsDelegate {
    
    let headerId = "headerId"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView?.backgroundColor = .white
        collectionView?.register(StepsHeader.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerId)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: (view.frame.height / 2) + 100)
    }
    
    func goBack() {
        navigationController?.popViewController(animated: true)
    }
    
    func handleMessage(for cell: StepsHeader) {
        let messageController = MessagesController()
        let navController = UINavigationController(rootViewController: messageController)
        present(navController, animated: true, completion: nil)
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath) as! StepsHeader
        header.stepsDelegate = self
        return header
    }
}
