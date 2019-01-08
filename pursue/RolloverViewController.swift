//
//  RolloverViewController.swift
//  Inpursuit
//
//  Created by Jaylen Sanders on 12/30/18.
//  Copyright © 2018 Glory. All rights reserved.
//

import UIKit

class RolloverViewController : UIViewController, UIScrollViewDelegate {
    
    let pullIndicator : UIView = {
       let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    let descriptionLabel : UILabel = {
       let label = UILabel()
        label.text = "This is a placeholder description"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.init(25))
        return label
    }()
    
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
    
    var pages = [DetailEngagementsView]()
    
    func setupMenuBar(){
        let backgroundFill = UIView()
        backgroundFill.backgroundColor = .white
        backgroundFill.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(engagementsBar)
        view.addSubview(backgroundFill)
        engagementsBar.alpha = 1.0
        engagementsBar.anchor(top: nil, left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 50)
        backgroundFill.anchor(top: engagementsBar.bottomAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
    }
    
    func hideMenuBar(){
        engagementsBar.alpha = 0.0
    }
    
    func setupScrollView(){
        let page1 = setupEngagementViews(backgroundColor: .white)
        let page2 = setupEngagementViews(backgroundColor: .red)
        let page3 = setupEngagementViews(backgroundColor: .blue)
        let page4 = setupEngagementViews(backgroundColor: .green)

        
        pages = [page1, page2, page3, page4]
        
        pageScrollView.contentSize = CGSize(width: view.frame.width * CGFloat(pages.count), height: view.frame.height)
        pageScrollView.frame = CGRect(x: 0, y: 100, width: view.frame.width, height: view.frame.height)
        view.addSubview(pageScrollView)
//        view.insertSubview(pageScrollView, belowSubview: engagementsBar)
        
        for i in 0 ..< pages.count{
            pages[i].view.frame = CGRect(x: view.frame.width * CGFloat(i), y: 0, width: view.frame.width, height: view.frame.height)
            pageScrollView.addSubview(pages[i].view)
            addChild(pages[i])
            pages[i].didMove(toParent: self)
        }
    }
    
    func setupEngagementViews(backgroundColor : UIColor) -> DetailEngagementsView {
        let containerView = DetailEngagementsView(collectionViewLayout: UICollectionViewFlowLayout())
        containerView.collectionView.backgroundColor = backgroundColor
        containerView.collectionView.translatesAutoresizingMaskIntoConstraints = false
        return containerView
    }
    
    func setupDetailsTop(){
        peekDetails.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        peekDetails.heightAnchor.constraint(lessThanOrEqualToConstant: 60).isActive = true
        peekDetails.centerXAnchor.constraint(equalTo: pullIndicator.centerXAnchor).isActive = true
        
        view.addSubview(postDetails)
        postDetails.addArrangedSubview(usernameLabel)
        postDetails.addArrangedSubview(viewCountLabel)
        postDetails.centerXAnchor.constraint(equalTo: pullIndicator.centerXAnchor).isActive = true
        postDetails.anchor(top: peekDetails.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 8, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 24)
    }
    
    
    func setupDetailsBottom(){
        view.addSubview(peekDetails)
        peekDetails.addArrangedSubview(descriptionLabel)
        peekDetails.anchor(top: pullIndicator.topAnchor, left: nil, bottom: nil, right: nil, paddingTop: 12, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        peekDetails.heightAnchor.constraint(lessThanOrEqualToConstant: 60).isActive = true
        peekDetails.centerXAnchor.constraint(equalTo: pullIndicator.centerXAnchor).isActive = true
        
        view.addSubview(postDetails)
        postDetails.addArrangedSubview(usernameLabel)
        postDetails.addArrangedSubview(viewCountLabel)
        postDetails.centerXAnchor.constraint(equalTo: pullIndicator.centerXAnchor).isActive = true
        postDetails.anchor(top: peekDetails.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 8, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 24)
    }
    
    func setupView(){
        view.addSubview(pullIndicator)
        pullIndicator.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 100)
        setupDetailsBottom()
    }
    
    func scrollToMenuIndex(menuIndex : Int) {
        let indexPath = IndexPath(item: menuIndex, section: 0)
        pageScrollView.scrollRectToVisible(pages[indexPath.item].view.frame, animated: true)
         engagementsBar.collectionView.selectItem(at: indexPath, animated: true, scrollPosition: .centeredHorizontally)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        self.pageScrollView.contentOffset = CGPoint(x: self.pageScrollView.contentOffset.x, y: 0)
        let currentpage = Int(pageScrollView.contentOffset.x / pageScrollView.bounds.width)
        let cellIndexPath = IndexPath(row: currentpage, section: 0)
        engagementsBar.collectionView.selectItem(at: cellIndexPath, animated: true, scrollPosition: .centeredHorizontally)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupView()
        setupScrollView()
        setupMenuBar()
    }
}
