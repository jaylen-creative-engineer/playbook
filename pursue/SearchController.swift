//
//  SearchController.swift
//  pursue
//
//  Created by Jaylen Sanders on 2/14/18.
//  Copyright © 2018 Glory. All rights reserved.
//

import UIKit

class SearchController : UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    let headerId = "headerId"
    
    override func viewDidLoad() {
        collectionView?.backgroundColor = .white
        collectionView?.register(SearchHeader.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerId)
    }
    
    func goBack(){
        navigationController?.popViewController(animated: true)
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath) as! SearchHeader
        header.accessSearchController = self
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height:  (view.frame.height / 8.5) - 5)
    }
    
}


