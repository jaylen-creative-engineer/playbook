//
//  SwipingController.swift
//  pursue
//
//  Created by Jaylen Sanders on 12/6/17.
//  Copyright © 2017 Glory. All rights reserved.
//

import UIKit

class SwipingController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    let pages = [
        Page(imageName: "celebrate-walkthrough", headerText: "Collaborate", bodyText: "Add teams of friends to your pursuits."),
        Page(imageName: "share-walkthrough", headerText: "Share", bodyText: "Share the behind the scenes of your day 20 seconds at a time."),
        Page(imageName: "try-walkthrough", headerText: "Try", bodyText: "Try the pursuits you like and build the path through your interests.")
    ]
    
    @objc private func handlePrev() {
        let nextIndex = max(pageControl.currentPage - 1, 0)
        let indexPath = IndexPath(item: nextIndex, section: 0)
        pageControl.currentPage = nextIndex
        collectionView?.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    
    private let nextButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Next", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.setTitleColor(UIColor.black, for: .normal)
        button.addTarget(self, action: #selector(handleNext), for: .touchUpInside)
        button.contentHorizontalAlignment = .right
        button.contentVerticalAlignment = .bottom
        return button
    }()
    
    @objc private func handleNext() {
        if nextButton.currentTitle == "Sign Up" {
            let appDelegate = UIApplication.shared.delegate! as! AppDelegate
            appDelegate.window = UIWindow()
            appDelegate.window?.rootViewController = MainTabController()
            appDelegate.window?.makeKeyAndVisible()
            UserDefaults.standard.set("true", forKey: "firstAppLaunch")

        }
        
        let nextIndex = min(pageControl.currentPage + 1, pages.count - 1)
        let indexPath = IndexPath(item: nextIndex, section: 0)
        pageControl.currentPage = nextIndex
        collectionView?.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        
        if pageControl.currentPage == 2 {
            nextButton.setTitle("Sign Up", for: .normal)
        } else {
            nextButton.setTitle("Next", for: .normal)
        }
        
    }
    
    lazy var pageControl: UIPageControl = {
        let pc = UIPageControl()
        pc.currentPage = 0
        pc.numberOfPages = pages.count
        pc.currentPageIndicatorTintColor = UIColor.rgb(red: 74, green: 144, blue: 226)
        pc.pageIndicatorTintColor = .gray
        return pc
    }()
    
    fileprivate func setupView() {
        view.addSubview(pageControl)
        view.addSubview(nextButton)
        
        pageControl.anchor(top: nil, left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 12, paddingBottom: 18, paddingRight: 0, width: 60, height: 40)
        nextButton.anchor(top: nil, left: nil, bottom: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 12, width: 120, height: 40)
        nextButton.centerYAnchor.constraint(equalTo: pageControl.centerYAnchor).isActive = true
    }
    
    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        let x = targetContentOffset.pointee.x
        pageControl.currentPage = Int(x / view.frame.width)
        
        if nextButton.currentTitle == "Sign Up" && pageControl.currentPage == 2 {
            let appDelegate = UIApplication.shared.delegate! as! AppDelegate
            appDelegate.window = UIWindow()
            appDelegate.window?.rootViewController = MainTabController()
            appDelegate.window?.makeKeyAndVisible()
            UserDefaults.standard.set("true", forKey: "firstAppLaunch")
        }
        
        if pageControl.currentPage == 2 {
            nextButton.setTitle("Sign Up", for: .normal)
        } else {
            nextButton.setTitle("Next", for: .normal)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        
        collectionView?.backgroundColor = .white
        collectionView?.showsHorizontalScrollIndicator = false
        collectionView?.register(PageCell.self, forCellWithReuseIdentifier: "cellId")
        collectionView?.isPagingEnabled = true
    }
    
}

extension SwipingController {
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        
        coordinator.animate(alongsideTransition: { (_) in
            self.collectionViewLayout.invalidateLayout()
            
            if self.pageControl.currentPage == 0 {
                self.collectionView?.contentOffset = .zero
            } else {
                let indexPath = IndexPath(item: self.pageControl.currentPage, section: 0)
                self.collectionView?.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
            }
            
        }) { (_) in
            
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pages.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! PageCell
        let page = pages[indexPath.item]
        cell.page = page
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height)
    }
    
}

