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
    let savedId = "savedId"
    
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
        
        cancelButton.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.safeAreaLayoutGuide.leftAnchor, bottom: nil, right: nil, paddingTop: 12, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: 16, height: 16)
        engagementsHeader.anchor(top: cancelButton.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 18, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 25)
        
    }
    
    func scrollToMenuIndex(menuIndex: Int) {
        let indexPath = IndexPath(item: menuIndex, section: 0)
        collectionView?.scrollToItem(at: indexPath, at: [], animated: true)
    }
    

    override func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let currentpage = Int(scrollView.contentOffset.x / scrollView.bounds.width)
        let cellIndexPath = IndexPath(row: currentpage, section: 0)

        engagementsHeader.collectionView.selectItem(at: cellIndexPath, animated: true, scrollPosition: .centeredHorizontally)
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
        collectionView?.register(DetailSaved.self, forCellWithReuseIdentifier: savedId)
        collectionView?.register(DetailRelated.self, forCellWithReuseIdentifier: relatedId)
        collectionView?.backgroundColor = UIColor.white
        collectionView?.contentInset = UIEdgeInsetsMake(130, 0, 0, 0)
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
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: savedId, for: indexPath) as! DetailSaved
            return cell
        case 7:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: relatedId, for: indexPath) as! DetailRelated
            return cell
        default:
            assert(false, "Not a valid cell")
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: view.frame.width, height: view.frame.height - 130)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 8
    }
}
