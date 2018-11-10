//
//  HomeRowContainer.swift
//  pursue
//
//  Created by Jaylen Sanders on 11/27/17.
//  Copyright © 2017 Glory. All rights reserved.
//

import UIKit
import Hero
import KWTransition

class HomeController : UICollectionViewController {
    
    let cellId = "cellId"
    let userId = "userId"
    let headerId = "headerId"
    let postId = "postId"
    let pursuitId = "pursuitId"
    
    var isFirstLaunch = false
    
    let homeServices = HomeServices()
    let exploreServices = ExploreServices()
    let detailController = PostDetailController()
    let searchController = UISearchController(searchResultsController: nil)
    var homeArray = [Home]()
    var search : Search?

    lazy var searchBar: UISearchBar = {
        let sb = UISearchBar()
        sb.searchBarStyle = UISearchBar.Style.prominent
        sb.backgroundImage = UIImage(color: .clear)
        sb.translatesAutoresizingMaskIntoConstraints = false
        sb.barTintColor = .white
        sb.isTranslucent = true
        let attributedPlaceholder = NSMutableAttributedString(string: "Search", attributes: [NSAttributedString.Key.font: UIFont(name: "Lato-Bold", size: 16) as Any, NSAttributedString.Key(rawValue: NSAttributedString.Key.foregroundColor.rawValue): UIColor.gray])
        
        let textFieldPlaceHolder = sb.value(forKey: "searchField") as? UITextField
        textFieldPlaceHolder?.attributedPlaceholder = attributedPlaceholder
        
        
        return sb
    }()
    
    let resultsScrollView : UIScrollView = {
       let sv = UIScrollView()
        return sv
    }()
    
    let resultsCollectionView : UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.backgroundColor = .white
        collectionView.showsVerticalScrollIndicator = false
        collectionView.keyboardDismissMode = .onDrag
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 105, right: 0)
        return collectionView
    }()
    
    func setupResultsCollectionView(){
        resultsCollectionView.delegate = self
        resultsCollectionView.dataSource = self
        resultsCollectionView.register(SearchUsers.self, forCellWithReuseIdentifier: userId)
        resultsCollectionView.register(SearchPosts.self, forCellWithReuseIdentifier: postId)
        resultsCollectionView.register(SearchPursuits.self, forCellWithReuseIdentifier: pursuitId)
    }
    
    func setupCollectionView(){
        collectionView?.register(HomeHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerId)
        collectionView?.register(HomePostCells.self, forCellWithReuseIdentifier: postId)
        collectionView?.register(RecommenedPursuit.self, forCellWithReuseIdentifier: cellId)
        collectionView?.backgroundColor = .white
        collectionView?.showsVerticalScrollIndicator = false
    }
    
    func setupNavBar(){
        navigationItem.titleView = searchBar
        
        navigationController?.hidesBarsOnSwipe = true
        searchController.searchResultsUpdater = self
        definesPresentationContext = true
        
        if searchBar.text?.isEmpty == false {
            navigationController?.view.backgroundColor = .white
            navigationController?.navigationBar.isTranslucent = false
            navigationController?.hidesBarsOnSwipe = false
        } else {
            if let navController = navigationController {
                System.clearNavigationBar(forBar: navController.navigationBar)
                navController.view.backgroundColor = .white
            }
        }
        
    }
    
    func getHomeFeedData(){
        homeServices.getHomeFeed { (home) in
            DispatchQueue.main.async {
                self.homeArray = home
                self.collectionView?.reloadData()
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        getHomeFeedData()
        setupNavBar()
        tabBarController?.tabBar.isTranslucent = false
       
        searchBar.delegate = self
        setupCollectionView()
        setupResultsCollectionView()
    }
    
    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
       searchBar.resignFirstResponder()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.searchBar.endEditing(true)
    }
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        self.searchBar.endEditing(true)
//        self.view.endEditing(true)
//    }
    
    
//    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
//        searchBar.resignFirstResponder()
//        return true
//    }
    
    // MARK: - Setup View
    
    @objc func goToSearchController(){
        let searchView = SearchController(collectionViewLayout: UICollectionViewFlowLayout())
        present(searchView, animated: true, completion: nil)
    }
    
    @objc func handleProfile(){
        let profile = ProfileController(collectionViewLayout: UICollectionViewFlowLayout())
        present(profile, animated: true, completion: nil)
    }
    
    func postHeld(transitionId : String) {
        
    }
    
    func handleChangeToDetail(transitionId : String){
        let detail = PostDetailController(collectionViewLayout: UICollectionViewFlowLayout())
        //        detail.imageView.hero.id = transitionId
        present(detail, animated: true, completion: nil)
    }
}

extension HomeController : UICollectionViewDelegateFlowLayout {
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case resultsCollectionView:
            return 3
        default:
            if !homeArray.isEmpty {
                return homeArray.count
            } else {
                return 0
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch collectionView {
        case resultsCollectionView:
            switch indexPath.item {
            case 0:
                return CGSize(width: view.frame.width, height: 100)
            case 1:
                return CGSize(width: view.frame.width, height: (view.frame.height / 2.2) + 100)
            default:
                return CGSize(width: view.frame.width, height: (view.frame.height / 2.2) + 30)
            }
        default:
            return CGSize(width: view.frame.width, height: view.frame.height / 1.3)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        switch collectionView {
        case resultsCollectionView:
            return 60.0
        default:
            return 20.0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        switch collectionView {
        case resultsCollectionView:
            return 60.0
        default:
            return 20.0
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case resultsCollectionView:
            switch indexPath.item {
            case 0:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: userId, for: indexPath) as! SearchUsers
                cell.searchUser = search
                return cell
            case 1:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: pursuitId, for: indexPath) as! SearchPursuits
                cell.pursuits = search?.pursuits
                return cell
            default:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: postId, for: indexPath) as! SearchPosts
                cell.posts = search?.posts
                return cell
            }
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: postId, for: indexPath) as! HomePostCells
            if !homeArray.isEmpty {
                let homeContent = homeArray[indexPath.item]
                cell.home = homeContent
                cell.post = homeContent.posts?[indexPath.item]
            }
            cell.accessHomeController = self
            return cell
        }
    }
    
}

extension HomeController : UISearchBarDelegate, UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == ""{
            resultsCollectionView.isHidden = true
            navigationController?.hidesBarsOnSwipe = true
            
            setupNavBar()
        } else {
            resultsCollectionView.isHidden = false
            navigationController?.hidesBarsOnSwipe = false
            
            view.addSubview(resultsCollectionView)
            resultsCollectionView.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
            setupNavBar()
            getSearchContent(searchText: searchText)
            
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
            self.searchBar.endEditing(true)
            searchBar.resignFirstResponder()
            guard let searchText = searchBar.text else { return }
            getSearchContent(searchText: searchText)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.searchBar.endEditing(true)
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        self.searchBar.endEditing(true)
    }
    
    func getSearchContent(searchText : String){
        let queryString = "%" + searchText + "%"
        
        exploreServices.queryDatabase(searchText: queryString) { (search) in
            DispatchQueue.main.async{
                self.search = search
                self.resultsCollectionView.reloadData()
            }
        }
    }
    
    func searchBarIsEmpty() -> Bool {
        return searchBar.text?.isEmpty ?? true
    }
}
