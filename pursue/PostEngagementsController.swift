//
//  PostEngagementsController.swift
//  pursue
//
//  Created by Jaylen Sanders on 9/5/18.
//  Copyright © 2018 Glory. All rights reserved.
//

import UIKit

class PostEngagementsController : UICollectionViewController {
    
    let cellId = "cellId"
    let stepId = "stepId"
    let principleId = "principleId"
    let challengeId = "challengeId"
    let teamId = "teamId"
    let relatedId = "relatedId"
    let commentId = "commentId"
    
    lazy var cancelButton : UIButton = {
       let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "cancel").withRenderingMode(.alwaysOriginal), for: .normal)
        button.imageView?.contentMode = .scaleAspectFill
        button.addTarget(self, action: #selector(handleDismiss), for: .touchUpInside)
        return button
    }()
    
    lazy var engagementsHeader : EngagementsHeader = {
       let header = EngagementsHeader()
        header.accessPostEngagementsController = self
        return header
    }()
    
    @objc func handleDismiss(){
        dismiss(animated: true, completion: nil)
    }
    
    func setupNavBar(){
        view.addSubview(cancelButton)
        view.addSubview(engagementsHeader)
        
        cancelButton.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: nil, paddingTop: 12, paddingLeft: 2, paddingBottom: 0, paddingRight: 0, width: 16, height: 16)
        engagementsHeader.anchor(top: cancelButton.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 12, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 50)
        
    }
    
    func scrollToMenuIndex(menuIndex: Int) {
        let indexPath = IndexPath(item: menuIndex, section: 0)
        collectionView?.scrollToItem(at: indexPath, at: [], animated: true)
    }
    
    func setupCollectionView(){
        if let flowLayout = collectionView?.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.scrollDirection = .horizontal
            flowLayout.minimumLineSpacing = 0
        }
        
        collectionView?.register(PursuitDay.self, forCellWithReuseIdentifier: cellId)
        collectionView?.register(DetailSteps.self, forCellWithReuseIdentifier: stepId)
        collectionView?.register(PursuitPrinciple.self, forCellWithReuseIdentifier: principleId)
        collectionView?.register(DetailChallenge.self, forCellWithReuseIdentifier: challengeId)
        collectionView?.register(TeamList.self, forCellWithReuseIdentifier: teamId)
        collectionView?.register(PostComments.self, forCellWithReuseIdentifier: commentId)
        collectionView?.register(DetailRelated.self, forCellWithReuseIdentifier: relatedId)
        collectionView?.backgroundColor = UIColor.white
        collectionView?.isPagingEnabled = true
        setupNavBar()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
    }
}

extension PostEngagementsController : UICollectionViewDelegateFlowLayout {
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.item {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! PursuitDay
            return cell
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: stepId, for: indexPath) as! DetailSteps
            return cell
        case 2:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: principleId, for: indexPath) as! PursuitPrinciple
            return cell
        case 3:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: challengeId, for: indexPath) as! DetailChallenge
            return cell
        case 4:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: teamId, for: indexPath) as! TeamList
            return cell
        case 5:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: commentId, for: indexPath) as! PostComments
            return cell
        case 6:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: relatedId, for: indexPath) as! DetailRelated
            return cell
        default:
            assert(false, "Not a valid cell")
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 7
    }
}
