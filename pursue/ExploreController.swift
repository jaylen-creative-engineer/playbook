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
    
    lazy var searchTableView : UITableView = {
        let tv = UITableView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.delegate = self
        tv.dataSource = self
        tv.showsHorizontalScrollIndicator = false
        tv.showsVerticalScrollIndicator = false
        return tv
    }()
    
    let exploreCollection : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    let searchController = UISearchController(searchResultsController: nil)
    let tableViewCellId = "tableViewCellId"
    let recentCellId = "recentCellId"
    let exploreService = ExploreServices()
    var user : SearchedUsers?
    var steps = [SearchedSteps]()
    var principles = [SearchedPrinciples]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTopBar()
        
        collectionView?.register(ExploreImageRow.self, forCellWithReuseIdentifier: cellId)
        collectionView?.register(PeopleRow.self, forCellWithReuseIdentifier: peopleId)
        collectionView?.register(ExplorePrinciplesRow.self, forCellWithReuseIdentifier: principleId)
        collectionView?.register(ExploreExerciseRow.self, forCellWithReuseIdentifier: exerciseId)
        collectionView?.backgroundColor = .white
        collectionView?.showsVerticalScrollIndicator = false
        getContent()
    }
    
    func getContent(){
//        exploreService.getPursuits { (pursuits, posts, steps, users, principles) in
//            <#code#>
//        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.navigationController?.navigationBar.isHidden = true
        navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    private func setupTopBar(){
        let guide = view.safeAreaLayoutGuide
        view.addSubview(backgroundFill)
        view.addSubview(searchBar)
        collectionView?.showsVerticalScrollIndicator = false
        backgroundFill.backgroundColor = .white
        backgroundFill.anchor(top: view.topAnchor, left: guide.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 95)
        searchBar.anchor(top: nil, left: view.leftAnchor, bottom: backgroundFill.bottomAnchor, right: backgroundFill.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: searchBar.intrinsicContentSize.height)
        searchTableView.register(SearchReturn.self, forCellReuseIdentifier: tableViewCellId)
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
        
    }
    
    
    func explorePursuitHeld() {
        
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
            navigationController?.pushViewController(detail, animated: true)
        case "isPursuitDetail":
            let detail = PursuitsDetailController(collectionViewLayout: UICollectionViewFlowLayout())
            navigationController?.pushViewController(detail, animated: true)
        case "isImageDetail":
            let detail = PursuitsDetailController(collectionViewLayout: UICollectionViewFlowLayout())
            navigationController?.pushViewController(detail, animated: true)
        case "isDiscussionDetail":
            let detail = PursuitsDetailController(collectionViewLayout: UICollectionViewFlowLayout())
            navigationController?.pushViewController(detail, animated: true)
        default:
            assert(false, "Not a valid view type")
        }
    }
    
    var listOfNames = ["random", "person", "name"]
    var detailList = ["random", "detail", "list"]
}

extension ExploreController {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 70)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if section == 0 {
            return UIEdgeInsetsMake(0, 0, 0, 0)
        } else {
            return UIEdgeInsetsMake(32, 0, 0, 0)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch indexPath.item {
        case 0:
            return CGSize(width: view.frame.width, height: 330)
        case 1:
            return CGSize(width: view.frame.width, height: 345)
        case 2:
            return CGSize(width: view.frame.width, height: 230)
        case 3:
            return CGSize(width: view.frame.width, height: 410)
        default:
            return CGSize(width: view.frame.width, height: 260)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell : UICollectionViewCell
        switch indexPath.item {
        case 0:
            let pursuitCell = collectionView.dequeueReusableCell(withReuseIdentifier: exerciseId, for: indexPath) as! ExploreExerciseRow
            pursuitCell.exploreDelegate = self
            pursuitCell.accessExploreController = self
            return pursuitCell
        case 1:
            let principleCell = collectionView.dequeueReusableCell(withReuseIdentifier: principleId, for: indexPath) as! ExplorePrinciplesRow
            principleCell.accessExploreController = self
            principleCell.exploreDelegate = self
            return principleCell
        case 2:
            let peopleCell = collectionView.dequeueReusableCell(withReuseIdentifier: peopleId, for: indexPath) as! PeopleRow
            peopleCell.peopleDelegate = self
            return peopleCell
        case 3:
            let imageCell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ExploreImageRow
            imageCell.exploreDelegate = self
            imageCell.accessExploreController = self
            return imageCell
        default:
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: exerciseId, for: indexPath) as! ExploreExerciseRow
            return cell
        }
    }
    
    func filterContentForSearchText(_ searchText: String, scope: String = "All") {
        searchTableView.reloadData()
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
            searchTableView.isHidden = true
        } else {
            searchTableView.isHidden = false
            view.addSubview(searchTableView)
            searchTableView.anchor(top: searchBar.bottomAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
            getSearchContent(searchText: searchText)
        }
    }
    
    func getSearchContent(searchText : String){
        let queryString = searchText + "%"
        exploreService.queryDatabase(searchText: queryString) { (search) in
            DispatchQueue.main.async{
                self.user = search.users
                search.principles.forEach({ (principle) in
                    self.principles.append(principle)
                })
                
                search.steps.forEach({ (step) in
                    self.steps.append(step)
                })
                self.searchTableView.reloadData()
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
        return view.frame.height
    }
}

extension ExploreController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: tableViewCellId, for: indexPath) as! SearchReturn
            cell.user = user

            switch true {
            case !principles.isEmpty:
                cell.principles = principles
            case !steps.isEmpty:
                cell.steps = steps
            default:
                cell.steps = []
            }
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

