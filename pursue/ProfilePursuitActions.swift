//
//  ProfilePursuitActions.swift
//  Inpursuit
//
//  Created by Jaylen Sanders on 12/28/18.
//  Copyright © 2018 Glory. All rights reserved.
//

import UIKit

class ProfilePursuitActions : UICollectionViewCell, UICollectionViewDelegateFlowLayout {
    
    lazy var menuBar : ActionMenuBar = {
       let ab = ActionMenuBar()
        ab.accessActionsCell = self
        return ab
    }()
    
    let scrollView : UIScrollView = {
        let sv = UIScrollView()
        sv.showsHorizontalScrollIndicator = false
        sv.showsVerticalScrollIndicator = false
        sv.backgroundColor = .white
        sv.isPagingEnabled = true
        sv.isDirectionalLockEnabled = true
        return sv
    }()
    
    var pages = [UIViewController]()
    
    func setupScrollView(){
        let page1 = setupActivePursuitsView()
        let page2 = setupIssueView()
        let page3 = setupChallengeView()
        
        pages = [page1, page2, page3]
        
        scrollView.contentSize = CGSize(width: frame.width * CGFloat(pages.count), height: frame.height)
        scrollView.frame = CGRect(x: 0, y: 60, width: frame.width, height: frame.height)
        addSubview(scrollView)
        
        for i in 0 ..< pages.count{
            pages[i].view.frame = CGRect(x: frame.width * CGFloat(i), y: 0, width: frame.width, height: frame.height)
            scrollView.addSubview(pages[i].view)
        }
    }
    
    func setupActivePursuitsView() -> ProfilePursuit {
        let activePursuit = ProfilePursuit(collectionViewLayout: UICollectionViewFlowLayout())
        activePursuit.view.translatesAutoresizingMaskIntoConstraints = false
        return activePursuit
    }
    
    func setupChallengeView() -> ProfileChallengeView {
        let challengeView = ProfileChallengeView(collectionViewLayout: UICollectionViewFlowLayout())
        challengeView.view.translatesAutoresizingMaskIntoConstraints = false
        return challengeView
    }
    
    func setupIssueView() -> ProfileIssueView {
        let issueView = ProfileIssueView(collectionViewLayout: UICollectionViewFlowLayout())
        issueView.view.translatesAutoresizingMaskIntoConstraints = false
        return issueView
    }
    
    func setupMenuBar(){
        addSubview(menuBar)
        insertSubview(menuBar, aboveSubview: scrollView)
        menuBar.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 45)
    }
    
    func scrollToMenuIndex(menuIndex : Int) {
        if scrollView == scrollView {
            let indexPath = IndexPath(item: menuIndex, section: 0)
            scrollView.scrollRectToVisible(pages[indexPath.item].view.frame, animated: true)
        }
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        scrollView.delegate = self
        setupScrollView()
        setupMenuBar()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ProfilePursuitActions : UIScrollViewDelegate {
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if scrollView == self.scrollView {
            self.scrollView.contentOffset = CGPoint(x: self.scrollView.contentOffset.x, y: 0)
            
            let currentpage = Int(scrollView.contentOffset.x / scrollView.bounds.width)
            let cellIndexPath = IndexPath(row: currentpage, section: 0)
            menuBar.collectionView.selectItem(at: cellIndexPath, animated: true, scrollPosition: .centeredHorizontally)
        }
    }
}
