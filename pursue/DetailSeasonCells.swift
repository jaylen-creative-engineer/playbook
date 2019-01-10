//
//  DetailSeasonCells.swift
//  Inpursuit
//
//  Created by Jaylen Sanders on 1/9/19.
//  Copyright © 2019 Glory. All rights reserved.
//

import UIKit

class DetailSeasonCells : UICollectionViewCell, UIScrollViewDelegate {
    
    
    lazy var pageScrollView : UIScrollView = {
        let sv = UIScrollView()
        sv.showsHorizontalScrollIndicator = false
        sv.showsVerticalScrollIndicator = false
        sv.backgroundColor = .white
        sv.isPagingEnabled = true
        sv.isDirectionalLockEnabled = true
        return sv
    }()
    
    let cellId = "cellId"
    var pages = [DetailSeasonSteps]()
    let detailHeader = DetailSeasonHeader()
    
//    func setupCollectionView(){
//        collectionView.delegate = self
//        collectionView.dataSource = self
//        collectionView.register(DetailSeasonHorizontalRow.self, forCellWithReuseIdentifier: cellId)
//
//        addSubview(collectionView)
//        collectionView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
//    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        self.pageScrollView.contentOffset = CGPoint(x: self.pageScrollView.contentOffset.x, y: 0)
        let currentpage = Int(pageScrollView.contentOffset.x / pageScrollView.bounds.width)
        let cellIndexPath = IndexPath(row: currentpage, section: 0)
        print(cellIndexPath)
//        detailHeader.scrollToMenuIndex(menuIndex: cellIndexPath)
        //        detailHeader.collectionView.scrollToItem(at: cellIndexPath, at: .centeredHorizontally, animated: true)
    }
    
    func setupScrollView(){
        let page1 = setupStepViews()
        let page2 = setupStepViews()
        let page3 = setupStepViews()
        
        pages = [page1, page2, page3]
        
        pageScrollView.delegate = self
        pageScrollView.contentSize = CGSize(width: frame.width * CGFloat(pages.count), height: frame.height)
        pageScrollView.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.height)
        addSubview(pageScrollView)
//        view.insertSubview(pageScrollView, belowSubview: backgroundFill)
        
        for i in 0 ..< pages.count{
            pages[i].view.frame = CGRect(x: frame.width * CGFloat(i), y: 0, width: frame.width, height: frame.height)
            pageScrollView.addSubview(pages[i].view)
//            addChild(pages[i])
//            pages[i].didMove(toParent: self)
        }
    }
    
    func setupStepViews() -> DetailSeasonSteps {
        let containerView = DetailSeasonSteps(collectionViewLayout: UICollectionViewFlowLayout())
        containerView.view.translatesAutoresizingMaskIntoConstraints = false
        return containerView
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupScrollView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return 4
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! DetailSeasonHorizontalRow
//        return cell
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: frame.width, height: frame.height)
//    }
    
}

class DetailSeasonSteps : UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    let cellId = "cellId"
    
    func setupCollectionView(){
        collectionView.register(DetailSeasonStepCells.self, forCellWithReuseIdentifier: cellId)
        collectionView.backgroundColor = .white
        collectionView.showsVerticalScrollIndicator = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 50)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! DetailSeasonStepCells
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
}

class DetailSeasonStepCells : UICollectionViewCell {
    
    let checkMark : UIButton = {
        let button = UIButton()
        button.layer.borderWidth = 1.5
        button.layer.masksToBounds = true
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.cornerRadius = 10
        return button
    }()
    
    let itemLabel : UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.text = "Test Item"
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = .black
        return label
    }()
    
    func setupView(){
        addSubview(checkMark)
        addSubview(itemLabel)
        
        checkMark.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        checkMark.anchor(top: nil, left: leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 18, paddingBottom: 0, paddingRight: 0, width: 20, height: 20)
        itemLabel.centerYAnchor.constraint(equalTo: checkMark.centerYAnchor).isActive = true
        itemLabel.anchor(top: nil, left: checkMark.rightAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: 0, height: 18)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
