//
//  ExploreContainer.swift
//  pursue
//
//  Created by Jaylen Sanders on 11/27/17.
//  Copyright © 2017 Glory. All rights reserved.
//

import UIKit
import XLActionController
import Alamofire

class ExploreController : UICollectionViewController, UICollectionViewDelegateFlowLayout, ExploreExerciseDelegate, ExplorePrincipleDelegate, ExploreImageDelegate, PeopleRowDelegate  {
    
    let cellId = "cellId"
    let secondaryId = "secondaryId"
    let customRowId = "customRowId"
    let peopleId = "peopleId"
    let principleId = "principleId"
    let exerciseId = "exerciseId"
    let categoryId = "categoryId"
    let discussionId = "discussionId"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTopBar()
        
        collectionView?.register(ExploreImageRow.self, forCellWithReuseIdentifier: cellId)
        collectionView?.register(PeopleRow.self, forCellWithReuseIdentifier: peopleId)
        collectionView?.register(ExplorePrinciplesRow.self, forCellWithReuseIdentifier: principleId)
        collectionView?.register(ExploreExerciseRow.self, forCellWithReuseIdentifier: exerciseId)
        collectionView?.backgroundColor = .white
        collectionView?.showsVerticalScrollIndicator = false
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.navigationController?.navigationBar.isHidden = true
        navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    var users = [User]()
    
    let backgroundFill = UIView()
    let categoryBarBackgroundColor = UIView()
    
    lazy var searchBar: UISearchBar = {
        let sb = UISearchBar()
        sb.placeholder = "Search..."
        sb.searchBarStyle = UISearchBarStyle.prominent
        sb.backgroundImage = UIImage(color: .clear)
        sb.delegate = self
        sb.translatesAutoresizingMaskIntoConstraints = false
        sb.barTintColor = .white
        sb.isTranslucent = true
        
        let attributedPlaceholder = NSMutableAttributedString(string: "Search...", attributes: [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 18), NSAttributedStringKey(rawValue: NSAttributedStringKey.foregroundColor.rawValue): UIColor.gray])
        
        let textFieldPlaceHolder = sb.value(forKey: "searchField") as? UITextField
        textFieldPlaceHolder?.attributedPlaceholder = attributedPlaceholder
        
        return sb
    }()
    
    lazy var tableView : UITableView = {
       let tv = UITableView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.delegate = self
        tv.dataSource = self
        return tv
    }()
    
    let searchController = UISearchController(searchResultsController: nil)
    let tableViewCellId = "tableViewCellId"
    
    private func setupTopBar(){
        let guide = view.safeAreaLayoutGuide
        view.addSubview(backgroundFill)
        view.addSubview(searchBar)
        backgroundFill.backgroundColor = .white
        backgroundFill.anchor(top: view.topAnchor, left: guide.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 95)
        searchBar.anchor(top: nil, left: view.leftAnchor, bottom: backgroundFill.bottomAnchor, right: backgroundFill.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: searchBar.intrinsicContentSize.height)
        tableView.register(SearchReturn.self, forCellReuseIdentifier: tableViewCellId)
    }
    
    
    func imageTapped() {
        handleChangeToDetail(viewType: "isImageDetail")
    }
    
    func imageHeld() {
        
    }
    
    func explorePrincipleTapped() {
        handleChangeToDetail(viewType: "isPrinciplesDetail")
    }
    
    func explorePrincipleHeld() {
        let customAlert = CustomAlertView()
        customAlert.providesPresentationContextTransitionStyle = true
        customAlert.definesPresentationContext = true
        customAlert.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        customAlert.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        self.showDetailViewController(customAlert, sender: self)
    }
    
    
    func explorePursuitHeld() {
        let customAlert = CustomAlertView()
        customAlert.providesPresentationContextTransitionStyle = true
        customAlert.definesPresentationContext = true
        customAlert.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        customAlert.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        self.showDetailViewController(customAlert, sender: self)
    }
    
    func explorePursuitTapped() {
        handleChangeToDetail(viewType: "isPursuitDetail")
    }
    
    func profileTapped() {
        let layout = UICollectionViewFlowLayout()
        let profileController = ProfileController(collectionViewLayout: layout)
        navigationController?.pushViewController(profileController, animated: true)
    }
    
    func handleChangeToDetail(viewType : String) {
        switch viewType {
        case "isPrinciplesDetail":
            let detail = PursuitsDetailController(collectionViewLayout: UICollectionViewFlowLayout())
            detail.principleView()
            navigationController?.pushViewController(detail, animated: true)
        case "isPursuitDetail":
            let detail = PursuitsDetailController(collectionViewLayout: UICollectionViewFlowLayout())
            detail.pursuitView()
            navigationController?.pushViewController(detail, animated: true)
        case "isImageDetail":
            let detail = PursuitsDetailController(collectionViewLayout: UICollectionViewFlowLayout())
            detail.imageView()
            navigationController?.pushViewController(detail, animated: true)
        case "isDiscussionDetail":
            let detail = PursuitsDetailController(collectionViewLayout: UICollectionViewFlowLayout())
            detail.discussionView()
            navigationController?.pushViewController(detail, animated: true)
        default:
            assert(false, "Not a valid view type")
        }
    }
    
    func handleChangeToFeed(viewType : String) {
        switch viewType {
        case "isPrinciplesFeed":
            let feed = HomeController(collectionViewLayout: UICollectionViewFlowLayout())
            feed.principleView()
            navigationController?.pushViewController(feed, animated: true)
        case "isPursuitFeed":
            let feed = HomeController(collectionViewLayout: UICollectionViewFlowLayout())
            feed.pursuitView()
            navigationController?.pushViewController(feed, animated: true)
        case "isImageFeed":
            let feed = HomeController(collectionViewLayout: UICollectionViewFlowLayout())
            feed.imageView(isExplore: true)
            navigationController?.pushViewController(feed, animated: true)
        default:
            assert(false, "Not a valid view type")
        }
    }
    
    var listOfNames = ["random", "person", "name"]
    var detailList = ["random", "detail", "list"]
}

extension ExploreController {
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.item {
        case 0:
            let imageCell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ExploreImageRow
            imageCell.exploreDelegate = self
            imageCell.accessExploreController = self
            return imageCell
        case 1:
            let pursuitCell = collectionView.dequeueReusableCell(withReuseIdentifier: exerciseId, for: indexPath) as! ExploreExerciseRow
            pursuitCell.exploreDelegate = self
            pursuitCell.accessExploreController = self
            return pursuitCell
        case 2:
            let peopleCell = collectionView.dequeueReusableCell(withReuseIdentifier: peopleId, for: indexPath) as! PeopleRow
            peopleCell.peopleDelegate = self
            return peopleCell
        case 3:
            let principleCell = collectionView.dequeueReusableCell(withReuseIdentifier: principleId, for: indexPath) as! ExplorePrinciplesRow
            principleCell.exploreDelegate = self
            principleCell.accessExploreController = self
            return principleCell
        default:
            assert(false, "This is not a valid cell")
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch indexPath.item {
        case 0:
            return CGSize(width: view.frame.width, height: 460)
        case 1:
            return CGSize(width: view.frame.width, height: 310)
        case 2:
            return CGSize(width: view.frame.width, height: 230)
        case 3:
            return CGSize(width: view.frame.width, height: 345)
        default:
            assert(false, "This is not a valid cell")
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 70)
    }
    
    func filterContentForSearchText(_ searchText: String, scope: String = "All") {
        tableView.reloadData()
    }
    
    func searchBarIsEmpty() -> Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    func isFiltering() -> Bool {
        let searchBarScopeIsFiltering = searchController.searchBar.selectedScopeButtonIndex != 0
        return searchController.isActive && (!searchBarIsEmpty() || searchBarScopeIsFiltering)
    }
}

extension ExploreController : UISearchBarDelegate {
 
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        
        guard let searchText = searchBar.text else { return }
        getSearchContent(searchText: searchText)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            print("Search is empty")
            tableView.isHidden = true
        } else {
            tableView.isHidden = false
            view.addSubview(tableView)
            tableView.anchor(top: searchBar.bottomAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        }
    }
    
    func getSearchContent(searchText : String){
        let url = "https://pursuit-jaylenhu27.c9users.io/search"
        var parameters = Alamofire.Parameters()
        parameters["searchField"] = searchText
        
        Alamofire.request(url, method: .get, parameters: parameters, encoding: URLEncoding.default).responseJSON { response in
            switch response.result {
            case .success:
                guard let _ = response.result.value as? [Dictionary<String,AnyObject>] else { return }
                
            case .failure:
                print("Failure: \(response.result.isSuccess)")
            }
            
        }
    }
}

extension ExploreController : UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.frame.height * 2
    }
}

extension ExploreController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: tableViewCellId, for: indexPath) as! SearchReturn
        return cell
    }
}

extension ExploreController: UISearchResultsUpdating {
    // MARK: - UISearchResultsUpdating Delegate
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        let scope = searchBar.scopeButtonTitles![searchBar.selectedScopeButtonIndex]
        filterContentForSearchText(searchController.searchBar.text!, scope: scope)
    }
}

