//
//  NotificationsContainer.swift
//  pursue
//
//  Created by Jaylen Sanders on 6/28/18.
//  Copyright © 2018 Glory. All rights reserved.
//

import UIKit

class NotificationsController : UICollectionViewController {
    
    let headerId = "headerId"
    let chatId = "chatId"
    let notificationId = "notificationId"
    
    let composeButton : UIButton = {
       let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "compose").withRenderingMode(.alwaysOriginal), for: .normal)
        button.imageView?.contentMode = .scaleAspectFill
        return button
    }()
    
    lazy var notificationsHeader : NotificationHeader = {
       let header = NotificationHeader()
        return header
    }()

    func handleChangeToChatDetail(){
        let chatDetail = ChatDetailController()
        navigationController?.pushViewController(chatDetail, animated: true)
    }
    
    func setupNavBar(){
        view.addSubview(notificationsHeader)
        notificationsHeader.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 35, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 40)
    }
    
    func setupCollectionView(){
        if let flowLayout = collectionView?.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.scrollDirection = .horizontal
            flowLayout.minimumLineSpacing = 0
        }
   
        collectionView?.register(ChatController.self, forCellWithReuseIdentifier: chatId)
        collectionView?.register(NotificationsList.self, forCellWithReuseIdentifier: notificationId)
        collectionView?.backgroundColor = .white
        collectionView?.showsHorizontalScrollIndicator = false
        collectionView?.isPagingEnabled = true
        collectionView?.contentInset = UIEdgeInsetsMake(95, 0, 60, 0)
        setupNavBar()
    }
    
    func scrollToMenuIndex(menuIndex : Int){
        let indexPath = IndexPath(item: menuIndex, section: 0)
        collectionView?.scrollToItem(at: indexPath, at: [], animated: true)
    }
    
    override func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let currentpage = Int(scrollView.contentOffset.x / scrollView.bounds.width)
        let cellIndexPath = IndexPath(row: currentpage, section: 0)
        
        notificationsHeader.labelCollectionView.selectItem(at: cellIndexPath, animated: true, scrollPosition: .centeredHorizontally)
    }
    
    func goToProfile(){
        let profile = ProfileController(collectionViewLayout: UICollectionViewFlowLayout())
        navigationController?.pushViewController(profile, animated: true)
    }
    
    func goToSearchController(){
        let searchView = SearchController(collectionViewLayout: UICollectionViewFlowLayout())
        present(searchView, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
}

extension NotificationsController : UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height - 155)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.item {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: notificationId, for: indexPath) as!  NotificationsList
            return cell
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: chatId, for: indexPath) as! ChatController
            return cell
        }
    }
}
