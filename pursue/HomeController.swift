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
import UserNotifications
import NVActivityIndicatorView

class HomeController : UICollectionViewController {
    
    let cellId = "cellId"
    let searchUserId = "searchUserId"
    let teamId = "teamId"
    let headerId = "headerId"
    let challengeId = "challengeId"
    let postId = "postId"
    let pursuitId = "pursuitId"
    let loadId = "loadId"
    let conflictId = "conflictId"
    let daysId = "daysId"
    let standardId = "standardId"
    
    var isFirstLaunch = false
    
    let homeServices = HomeServices()
    let exploreServices = ExploreServices()
    let detailController = PostDetailController()
    let searchController = UISearchController(searchResultsController: nil)
    var homeArray = [Home]()
    var search : Search?
    let leadingScreensForBatching:CGFloat = 3.0
    var pages = [HomeViews]()
    let backgroundFill = UIView()
    
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
    
    lazy var menuBar : HomeMenuBar = {
       let mb = HomeMenuBar()
        mb.accessHomeController = self
        return mb
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
        button.contentVerticalAlignment = .center
        button.addTarget(self, action: #selector(getMoreData), for: .touchUpInside)
        return button
    }()
    
    let resultsCollectionView : UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.backgroundColor = .white
        collectionView.showsVerticalScrollIndicator = false
        collectionView.keyboardDismissMode = .onDrag
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 105, right: 0)
        return collectionView
    }()
    
    lazy var pageScrollView : UIScrollView = {
       let sv = UIScrollView()
        sv.showsHorizontalScrollIndicator = false
        sv.showsVerticalScrollIndicator = false
        sv.backgroundColor = .white
        sv.isPagingEnabled = true
        sv.isDirectionalLockEnabled = true
        return sv
    }()
    
    func setupResultsCollectionView(){
        resultsCollectionView.delegate = self
        resultsCollectionView.dataSource = self
        resultsCollectionView.register(SearchUsers.self, forCellWithReuseIdentifier: searchUserId)
        resultsCollectionView.register(SearchPosts.self, forCellWithReuseIdentifier: postId)
        resultsCollectionView.register(SearchPursuits.self, forCellWithReuseIdentifier: pursuitId)
    }

    func setupScrollView(){
        let page1 = setupFeedViews()
        let page2 = setupFeedViews()
        let page3 = setupFeedViews()

        pages = [page1, page2, page3]
        
        pageScrollView.contentSize = CGSize(width: view.frame.width * CGFloat(pages.count), height: view.frame.height)
        pageScrollView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        view.insertSubview(pageScrollView, belowSubview: backgroundFill)

        for i in 0 ..< pages.count{
            pages[i].view.frame = CGRect(x: view.frame.width * CGFloat(i), y: 0, width: view.frame.width, height: view.frame.height)
            pageScrollView.addSubview(pages[i].view)
            addChild(pages[i])
            pages[i].didMove(toParent: self)
        }
    }

    func setupFeedViews() -> HomeViews {
        let containerView = HomeViews(collectionViewLayout: UICollectionViewFlowLayout())
        containerView.view.translatesAutoresizingMaskIntoConstraints = false
        return containerView
    }
    
    func setupCollectionView(){
        collectionView?.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "randomId")
        collectionView?.isPagingEnabled = true
        collectionView?.backgroundColor = .white
    }
    
    func setupNavBar(){
        tabBarController?.tabBar.isTranslucent = false
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
    
    func scrollToMenuIndex(menuIndex : Int) {
        let indexPath = IndexPath(item: menuIndex, section: 0)
        pageScrollView.scrollRectToVisible(pages[indexPath.item].view.frame, animated: true)
    }
    
    @objc func getHomeFeedData(){
//        homeServices.getHomeFeed { (home) in
//            self.collectionView?.refreshControl?.endRefreshing()
//            DispatchQueue.main.async {
//                if home.isEmpty {
//                    self.isFinishedFetching = true
//                }
//                self.spinnerView.stopAnimating()
//                self.spinnerView.isHidden = true
//                self.homeArray = home
//                self.lastPostId = home.last?.posts?.first?.postId
//                self.collectionView?.reloadData()
//            }
//        }
    }
    
    var lastPostId : Int?
    var refreshId : Int?
    
    let spinnerView : NVActivityIndicatorView = {
        let spinner = NVActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        spinner.type = NVActivityIndicatorType.ballScaleRipple
        spinner.color = .blue
        return spinner
    }()
    
    
    
    @objc func getMoreData(){
//        if lastPostId != nil && isFinishedFetching == false {
//            homeServices.getMorePostForHomeFeed(postId: lastPostId) { (home) in
//                if home.isEmpty {
//                    self.isFinishedFetching = true
//                }
//                home.forEach({ (value) in
//                    self.lastPostId = value.posts?.first?.postId
//                    self.endReached = value.posts?.count == 0
//                    value.posts?.forEach({ (data) in
//                        self.feed.append(Feed(post: data, post_count: value.posts_count ?? 1))
//                    })
//
//                    self.spinnerView.stopAnimating()
//                    self.spinnerView.isHidden = true
//                    UIView.performWithoutAnimation {
//                        self.collectionView.reloadData()
//                    }
//                })
//            }
//        } else {
//            getHomeFeedData()
//        }
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
        callAgain.anchor(top: tryAgainLabel.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 18, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 120, height: 48)
    }
    
    func setupMenuBar(){
        backgroundFill.translatesAutoresizingMaskIntoConstraints = false
        backgroundFill.backgroundColor = .white
        
        view.addSubview(backgroundFill)
        view.addSubview(menuBar)
        
        backgroundFill.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 100)
        menuBar.anchor(top: backgroundFill.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 50)
        
    }
    
    fileprivate func checkInternetConnection() {
        NotificationCenter.default.addObserver(self, selector: #selector(handleRefresh), name: CaptureDetailView.updateFeedNotificationName, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleRefresh), name: CaptureResponseView.updateResponseFeedNotificationName, object: nil)
        
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { (didAllow, error) in
        }
        
        
        searchBar.delegate = self
        //        setupResultsCollectionView()
        
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pageScrollView.delegate = self
        
        setupNavBar()
        setupMenuBar()
        setupScrollView()
        setupCollectionView()
        checkInternetConnection()
        setupNotification()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        resultsCollectionView.isHidden = true
        navigationController?.hidesBarsOnSwipe = true
        self.searchBar.text = nil
        self.searchBar.endEditing(true)
        searchBar.resignFirstResponder()
        setupNavBar()
    }
    
    func setupNotification(){
        let content = UNMutableNotificationContent()
        content.title = "Check Out The Latests Pursuits in Your Interests"
        content.subtitle = "15 New Pursuits You May Like"
        content.body = "View Latests Pursuits"
        content.badge = 1
        
        var dateComponents = DateComponents()
        dateComponents.weekday = 5
        dateComponents.hour = 10
        dateComponents.minute = 0
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        let request = UNNotificationRequest(identifier: "pursuitNotification", content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
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
//        getHomeFeedData()
    }
    
    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        if scrollView == resultsCollectionView {
            searchBar.resignFirstResponder()
        }
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
    
    func postHeld(transitionId : String) {
        
    }
    
    override func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if scrollView == pageScrollView {
            self.pageScrollView.contentOffset = CGPoint(x: self.pageScrollView.contentOffset.x, y: 0)
            
            let currentpage = Int(pageScrollView.contentOffset.x / pageScrollView.bounds.width)
            let cellIndexPath = IndexPath(row: currentpage, section: 0)
            menuBar.collectionView.selectItem(at: cellIndexPath, animated: true, scrollPosition: .centeredHorizontally)
        }
    }
    
}

extension HomeController : HomePostDelegate, UICollectionViewDelegateFlowLayout {
    
    func changeToDetail(for cell: HomePostCells) {
//        guard let indexPath = collectionView?.indexPath(for: cell) else { return }
//        let detail = PostDetailController(collectionViewLayout: UICollectionViewFlowLayout())
//        detail.postId = self.homeArray[indexPath.item].posts?.first?.postId
//        detail.pursuitId = self.homeArray[indexPath.item].posts?.first?.pursuitId
//        detail.isProfile = false
//        present(detail, animated: true, completion: nil)
    }
    
    func changeToSearchPostDetail(searchPostId : Int, searchPursuitId : Int) {
        let detail = PostDetailController(collectionViewLayout: UICollectionViewFlowLayout())
        detail.postId = searchPostId
        detail.pursuitId = searchPursuitId
        detail.isProfile = false
        present(detail, animated: true, completion: nil)
    }
    
    func changeToPursuitDetail(searchPursuitId : Int){
        let detail = PostDetailController(collectionViewLayout: UICollectionViewFlowLayout())
        detail.pursuitId = searchPursuitId
        detail.isProfile = true
        present(detail, animated: true, completion: nil)
    }
    
    func handleChangeToProfile(userId : String) {
        let profileController = ProfileController()
        profileController.isForeignAccount = true
        profileController.userId = userId
        navigationController?.pushViewController(profileController, animated: true)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "randomId", for: indexPath)
        return cell
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
            self.search?.posts?.removeAll()
            self.search?.pursuits?.removeAll()
            self.search = search
            self.resultsCollectionView.reloadData()
        }
    }
    
    func searchBarIsEmpty() -> Bool {
        return searchBar.text?.isEmpty ?? true
    }
}

