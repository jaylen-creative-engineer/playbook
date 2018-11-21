//
//  HomeRowContainer.swift
//  pursue
//
//  Created by Jaylen Sanders on 11/27/17.
//  Copyright © 2017 Glory. All rights reserved.
//

import UIKit
import Hero
import Reachability
import KWTransition

class HomeController : UICollectionViewController {
    
    let cellId = "cellId"
    let userId = "userId"
    let headerId = "headerId"
    let postId = "postId"
    let pursuitId = "pursuitId"
    let loadId = "loadId"
    
    var isFirstLaunch = false
    
    let homeServices = HomeServices()
    let exploreServices = ExploreServices()
    let detailController = PostDetailController()
    let searchController = UISearchController(searchResultsController: nil)
    var homeArray = [Home]()
    var search : Search?
    let leadingScreensForBatching:CGFloat = 3.0

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
    
    let tryAgainLabel : UILabel = {
       let label = UILabel()
        label.text = "Could not connect to server. Please try again."
        label.font = UIFont.boldSystemFont(ofSize: 14)
        return label
    }()
    
    lazy var callAgain : UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Try Again", for: .normal)
        button.backgroundColor = UIColor.black
        button.layer.cornerRadius = 12
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.init(25))
        button.setTitleColor(.white, for: .normal)
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.borderWidth = 1
        button.addTarget(self, action: #selector(getHomeFeedData), for: .touchUpInside)
        return button
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
        collectionView?.register(HomeLoadMoreIndicator.self, forCellWithReuseIdentifier: loadId)
        collectionView?.backgroundColor = .white
        collectionView?.showsVerticalScrollIndicator = false
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 40, right: 0)
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
    
    var posts_count = [Int]()
    var anotherTry = [Home]()
    var feed = [Feed]()
    
    @objc func getHomeFeedData(){
        homeServices.getHomeFeed { (home) in
            self.collectionView?.refreshControl?.endRefreshing()
            DispatchQueue.main.async {
                if home.isEmpty {
                    self.isFinishedFetching = true
                }
                self.homeArray = home
                self.lastPostId = home.last?.posts?.first?.postId
                self.collectionView?.reloadData()
            }
        }
    }
    
    var lastPostId : Int?
    var refreshId : Int?
    
    func getMoreData(){
        if lastPostId != nil && isFinishedFetching == false {
            homeServices.getMorePostForHomeFeed(postId: lastPostId) { (home) in
                if home.isEmpty {
                    self.isFinishedFetching = true
                }
                home.forEach({ (value) in
                    self.lastPostId = value.posts?.first?.postId
                    self.endReached = value.posts?.count == 0
                    value.posts?.forEach({ (data) in
                        self.feed.append(Feed(post: data, post_count: value.posts_count ?? 1))
                    })
                    
                    UIView.performWithoutAnimation {
                        self.collectionView.reloadData()
                    }
                })
            }
        } else {
            getHomeFeedData()
        }
    }
    
    var isFinishedFetching = false
    var endReached = false
    
    let reachability = Reachability()
    
    func setupTryConnection(){
        view.addSubview(tryAgainLabel)
        view.addSubview(callAgain)
        
        tryAgainLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        tryAgainLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        tryAgainLabel.anchor(top: nil, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 30)
        callAgain.centerXAnchor.constraint(equalTo: tryAgainLabel.centerXAnchor).isActive = true
        callAgain.anchor(top: tryAgainLabel.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 18, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 120, height: 24)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        tabBarController?.tabBar.isTranslucent = false
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)
        collectionView?.refreshControl = refreshControl
       
        searchBar.delegate = self
        setupCollectionView()
        setupResultsCollectionView()
        
        reachability?.whenReachable = { _ in
            DispatchQueue.main.async {
                self.getMoreData()
            }
        }
        
        reachability?.whenUnreachable = { _ in
            DispatchQueue.main.async {
                self.setupTryConnection()
            }
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(internetChanged), name: Notification.Name.reachabilityChanged, object: reachability)
        
        do {
            try reachability?.startNotifier()
        } catch {
            print("Could not start notifier")
        }
    }
    
    @objc func internetChanged(note : Notification) {
        let reachability = note.object as! Reachability
        switch reachability.connection {
        case .wifi:
            self.getMoreData()
        case .cellular:
            self.getMoreData()
        case .none:
            self.setupTryConnection()
        }
    }
    
    @objc func handleRefresh() {
        self.feed.removeAll()
        getHomeFeedData()
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
}

extension HomeController : UICollectionViewDelegateFlowLayout, HomePostDelegate {
    
    func changeToDetail(for cell: HomePostCells) {
        guard let indexPath = collectionView?.indexPath(for: cell) else { return }
        let detail = PostDetailController(collectionViewLayout: UICollectionViewFlowLayout())
        detail.post = self.homeArray[indexPath.item].posts
        present(detail, animated: true, completion: nil)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case resultsCollectionView:
            return 3
        default:
             return homeArray.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch collectionView {
        case resultsCollectionView:
            switch indexPath.item {
            case 0:
                return CGSize(width: view.frame.width, height: 120)
            case 1:
                return CGSize(width: view.frame.width, height: (view.frame.height / 2.2) + 100)
            default:
                return CGSize(width: view.frame.width, height: (view.frame.height / 2.2) + 20)
            }
        default:
            return CGSize(width: view.frame.width, height: view.frame.height / 1.2)
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
            if indexPath.item == self.feed.count - 1 && !isFinishedFetching {
                getMoreData()
            }
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: postId, for: indexPath) as! HomePostCells
            cell.delegate = self
            cell.post = homeArray[indexPath.item].posts
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
                self.search?.posts?.removeAll()
                self.search?.pursuits?.removeAll()
                self.search = search
                self.resultsCollectionView.reloadData()
            }
        }
    }
    
    func searchBarIsEmpty() -> Bool {
        return searchBar.text?.isEmpty ?? true
    }
}
