//
//  PursuitsController.swift
//  pursue
//
//  Created by Jaylen Sanders on 9/25/17.
//  Copyright © 2017 Glory. All rights reserved.
//

import UIKit

class PursuitsController: UICollectionViewController, UICollectionViewDelegateFlowLayout, PursuitHeaderDelegate, PursuitDelegate {
   
    let cellId = "cellId"
    let headerId = "headerId"
    let pursuitSecondaryId = "pursuitSecondaryId"
    let pursuitPrimaryId = "pursuitPrimaryId"
    let tomorrowId = "tomorrowId"
    let pursuitLaterId = "pursuitLaterId"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.backgroundColor = .white
        
        collectionView?.register(PursuitTodayPrimaryCard.self, forCellWithReuseIdentifier: cellId)
        collectionView?.register(PursuitTodaySecondaryCard.self, forCellWithReuseIdentifier: pursuitSecondaryId)
        collectionView?.register(PursuitTommorrowPrimaryCard.self, forCellWithReuseIdentifier: pursuitPrimaryId)
        collectionView?.register(PursuitLater.self, forCellWithReuseIdentifier: pursuitLaterId)
        collectionView?.register(PursuitTommorrowSecondaryCard.self, forCellWithReuseIdentifier: tomorrowId)
        collectionView?.register(PursuitHeader.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerId)
        
        self.navigationController?.isNavigationBarHidden = true

    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return 5
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell : PursuitTodayPrimaryCard
        
        switch indexPath.item {
        case 0:
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! PursuitTodayPrimaryCard
            cell.delegate = self
            return cell
            
        case 1:
             cell = collectionView.dequeueReusableCell(withReuseIdentifier: pursuitSecondaryId, for: indexPath) as! PursuitTodaySecondaryCard
             return cell
            
        case 2:
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: pursuitPrimaryId, for: indexPath) as! PursuitTommorrowPrimaryCard
            return cell
        case 3:
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: tomorrowId, for: indexPath) as! PursuitTommorrowSecondaryCard
            return cell
        case 4:
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: pursuitLaterId, for: indexPath) as! PursuitLater
            return cell
        default:
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: pursuitSecondaryId, for: indexPath) as! PursuitTodaySecondaryCard
            return cell
        }
        
    }

    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        switch indexPath.item {
        case 0:
            return CGSize(width: view.frame.width, height: view.frame.width + 300)
        case 2:
            return CGSize(width: view.frame.width, height: 270)
        default:
            return CGSize(width: view.frame.width, height: 260)
        }
        
    }

    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: (view.frame.width / 8) + 50)
    }
    
    func pursuitSelected(for cell : PursuitTodayPrimaryCard){
        let pursuits = PursuitsDetailController(collectionViewLayout: UICollectionViewFlowLayout())
        navigationController?.pushViewController(pursuits, animated: true)
    }
    
    func handleCamera(for cell: PursuitHeader) {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        alertController.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (_) in
            let cameraController = CameraController()
            self.present(cameraController, animated: true, completion: nil)
        }))
        
        alertController.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: { (_) in
            let layout = UICollectionViewFlowLayout()
            let photoSelectorController = PhotoSelectorController(collectionViewLayout: layout)
            let navController = UINavigationController(rootViewController: photoSelectorController)
            self.present(navController, animated: true, completion: nil)
            
        }))
        
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
    
    func handleMessage(for cell: PursuitHeader) {
        let messageController = MessagesController()
        let navController = UINavigationController(rootViewController: messageController)
        present(navController, animated: true, completion: nil)
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath) as! PursuitHeader
        header.pursuitDelegate = self
        return header
    }
}
