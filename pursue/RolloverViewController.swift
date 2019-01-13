//
//  RolloverViewController.swift
//  Inpursuit
//
//  Created by Jaylen Sanders on 12/30/18.
//  Copyright © 2018 Glory. All rights reserved.
//

import UIKit

class RolloverViewController : UICollectionViewController {
    
    let headerId = "headerId"
    let actionId = "actionId"
    let tryId = "tryId"
    let teamId = "teamId"
    let questionId = "questionId"
    
    let usernameLabel : UILabel = {
       let label = UILabel()
        label.text = "Test"
        label.textColor = .darkGray
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 14)
        return label
    }()
    
    let viewCountLabel : UILabel = {
       let label = UILabel()
        label.text = "24 Views"
        label.textAlignment = .left
        label.textColor = .darkGray
        label.font = UIFont.boldSystemFont(ofSize: 14)
        return label
    }()

    let peekDetails : UIStackView = {
       let sv = UIStackView()
        sv.axis = .vertical
        sv.spacing = 10
        return sv
    }()
    
    let postDetails : UIStackView = {
        let sv = UIStackView()
        sv.axis = .horizontal
        sv.distribution = .fillEqually
        sv.spacing = 2
        return sv
    }()

    lazy var engagementsBar : EngagementsMenuBar = {
        let mb = EngagementsMenuBar()
        mb.accessRolloverController = self
        return mb
    }()
    
    lazy var pageScrollView : UIScrollView = {
        let sv = UIScrollView()
        sv.delegate = self
        sv.showsHorizontalScrollIndicator = false
        sv.showsVerticalScrollIndicator = false
        sv.backgroundColor = .red
        sv.isPagingEnabled = true
        sv.isDirectionalLockEnabled = true
        return sv
    }()
    
    var pages = [UICollectionViewController]()
    
    func setupMenuBar(){
//        let backgroundFill = UIView()
//        backgroundFill.backgroundColor = .white
//        backgroundFill.translatesAutoresizingMaskIntoConstraints = false
//
//        view.addSubview(engagementsBar)
//        view.addSubview(backgroundFill)
//        engagementsBar.alpha = 1.0
//        engagementsBar.anchor(top: nil, left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 50)
//        backgroundFill.anchor(top: engagementsBar.bottomAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
    }
    
    func hideMenuBar(){
        engagementsBar.alpha = 0.0
    }
    
    func setupScrollView(){
//        let page1 = setupSeasonsView()
//        let page2 = setupTryingView()
//        let page3 = setupTeamView()
//        let page4 = setupIssuesView()
//
//
//        pages = [page1, page2, page3, page4]
//
//        pageScrollView.contentSize = CGSize(width: view.frame.width * CGFloat(pages.count), height: view.frame.height)
//        pageScrollView.frame = CGRect(x: 0, y: 100, width: view.frame.width, height: view.frame.height)
//        view.addSubview(pageScrollView)
//
//        for i in 0 ..< pages.count{
//            pages[i].view.frame = CGRect(x: view.frame.width * CGFloat(i), y: 0, width: view.frame.width, height: view.frame.height)
//            pageScrollView.addSubview(pages[i].view)
//            addChild(pages[i])
//            pages[i].didMove(toParent: self)
//        }
    }
    
    func setupSeasonsView() -> DetailSeasonsController {
        let containerView = DetailSeasonsController(collectionViewLayout: UICollectionViewFlowLayout())
        containerView.collectionView.translatesAutoresizingMaskIntoConstraints = false
        return containerView
    }
    
    func setupTeamView() -> DetailTeamController {
        let containerView = DetailTeamController(collectionViewLayout: UICollectionViewFlowLayout())
        containerView.collectionView.translatesAutoresizingMaskIntoConstraints = false
        return containerView
    }
    
    func setupIssuesView() -> DetailIssuesController {
        let containerView = DetailIssuesController(collectionViewLayout: UICollectionViewFlowLayout())
        containerView.collectionView.translatesAutoresizingMaskIntoConstraints = false
        return containerView
    }
    
    func setupTryingView() -> DetailTryingController {
        let containerView = DetailTryingController(collectionViewLayout: UICollectionViewFlowLayout())
        containerView.collectionView.translatesAutoresizingMaskIntoConstraints = false
        return containerView
    }
    
    func setupDetailsTop(){
        
    }
    
    func scrollToMenuIndex(menuIndex : Int) {
        let indexPath = IndexPath(item: menuIndex, section: 0)
        pageScrollView.scrollRectToVisible(pages[indexPath.item].view.frame, animated: true)
         engagementsBar.collectionView.selectItem(at: indexPath, animated: true, scrollPosition: .centeredHorizontally)
    }
    
    override func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
//        self.pageScrollView.contentOffset = CGPoint(x: self.pageScrollView.contentOffset.x, y: 0)
//        let currentpage = Int(pageScrollView.contentOffset.x / pageScrollView.bounds.width)
//        let cellIndexPath = IndexPath(row: currentpage, section: 0)
//        engagementsBar.collectionView.selectItem(at: cellIndexPath, animated: true, scrollPosition: .centeredHorizontally)
    }
    
    func setupCollectionView(){
        collectionView?.backgroundColor = UIColor.rgb(red: 243, green: 243, blue: 249)
        collectionView?.showsVerticalScrollIndicator = false
        collectionView?.contentInset = UIEdgeInsets.init(top: 0, left: 0, bottom: 100, right: 0)
        collectionView?.register(RolloverHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerId)
        collectionView?.register(RolloverActionCells.self, forCellWithReuseIdentifier: actionId)
        collectionView?.register(RolloverTryCell.self, forCellWithReuseIdentifier: tryId)
        collectionView?.register(RolloverTeamCell.self, forCellWithReuseIdentifier: teamId)
        collectionView?.register(RolloverQuestionCell.self, forCellWithReuseIdentifier: questionId)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
    }
}

extension RolloverViewController : UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 500)
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath) as! RolloverHeader
        return header
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.item {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: actionId, for: indexPath) as! RolloverActionCells
            return cell
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: tryId, for: indexPath) as! RolloverTryCell
            return cell
        case 2:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: teamId, for: indexPath) as! RolloverTeamCell
            return cell
        default:
           let cell = collectionView.dequeueReusableCell(withReuseIdentifier: questionId, for: indexPath) as! RolloverQuestionCell
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 18, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 35.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 35.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch indexPath.item {
        case 0:
            return CGSize(width: view.frame.width, height: 580)
        case 1:
            return CGSize(width: view.frame.width, height: 640)
        case 2:
            return CGSize(width: view.frame.width, height: 224)
        default:
            return CGSize(width: view.frame.width, height: 720)
        }
    }
}
