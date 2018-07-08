//
//  SearchView.swift
//  pursue
//
//  Created by Jaylen Sanders on 7/8/18.
//  Copyright © 2018 Glory. All rights reserved.
//

import UIKit

class SearchView : UIViewController {
    
    let alertViewGrayColor = UIColor(red: 224.0/255.0, green: 224.0/255.0, blue: 224.0/255.0, alpha: 1)
    let cellId = "cellId"
    let searchController = UISearchController(searchResultsController: nil)
    let tableViewCellId = "tableViewCellId"
    
    lazy var alertView : UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    lazy var searchBar: UISearchBar = {
        let sb = UISearchBar()
        sb.placeholder = "Search..."
        sb.searchBarStyle = UISearchBarStyle.prominent
        sb.backgroundImage = UIImage(color: .clear)
        sb.delegate = self
        sb.translatesAutoresizingMaskIntoConstraints = false
        sb.barTintColor = .white
        sb.isTranslucent = true
        
        let attributedPlaceholder = NSMutableAttributedString(string: "Search...", attributes: [NSAttributedStringKey.font: UIFont(name: "Lato-Black", size: 24) as Any, NSAttributedStringKey(rawValue: NSAttributedStringKey.foregroundColor.rawValue): UIColor.gray])
        
        let textFieldPlaceHolder = sb.value(forKey: "searchField") as? UITextField
        textFieldPlaceHolder?.attributedPlaceholder = attributedPlaceholder
        
        return sb
    }()
    
    let trendingLabel : UILabel = {
       let label = UILabel()
        label.text = "Trending."
        label.font = UIFont(name: "Lato-Bold", size: 14)
        return label
    }()
    
    let trendingCollection : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    let searchHistoryLabel : UILabel = {
        let label = UILabel()
        label.text = "Search History."
        label.font = UIFont(name: "Lato-Bold", size: 14)
        return label
    }()
    
    let clearSearchHistory : UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "waste-bin").withRenderingMode(.alwaysOriginal), for: .normal)
        button.imageView?.contentMode = .scaleAspectFill
        return button
    }()
    
    
    let searchHistoryCollection : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
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
    
    let searchId = "searchId"
    let trendingId = "trendingId"
    
    let images = ["788572ee949285fae33dca5d846a4664", "clean-2", "academics", "fashion-design", "690dae66bfe860df34fc7a756b53c15d"]
    
    @objc func clearHistory(){
        
    }
    
    func setupTrendingCollectionView(){
        view.addSubview(trendingLabel)
        view.addSubview(trendingCollection)
        
        trendingCollection.delegate = self
        trendingCollection.dataSource = self
        trendingCollection.register(SearchTrendingCell.self, forCellWithReuseIdentifier: trendingId)
        
        trendingLabel.anchor(top: searchBar.bottomAnchor, left: view.leftAnchor, bottom: nil, right: nil, paddingTop: 24, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: trendingLabel.intrinsicContentSize.width, height: trendingLabel.intrinsicContentSize.height)
        trendingCollection.anchor(top: trendingLabel.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 32, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 370)
    }
    
    func setupSearchCollectionView(){
        view.addSubview(searchHistoryLabel)
        view.addSubview(searchHistoryCollection)
        view.addSubview(clearSearchHistory)
        
        searchHistoryCollection.delegate = self
        searchHistoryCollection.dataSource = self
        searchHistoryCollection.register(SearchHistoryCell.self, forCellWithReuseIdentifier: searchId)
        
        searchHistoryLabel.anchor(top: trendingCollection.bottomAnchor, left: trendingLabel.leftAnchor, bottom: nil, right: nil, paddingTop: 24, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: searchHistoryLabel.intrinsicContentSize.width, height: searchHistoryLabel.intrinsicContentSize.height)
        clearSearchHistory.anchor(top: searchHistoryLabel.topAnchor, left: nil, bottom: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 12, width: 17, height: 20)
        searchHistoryCollection.anchor(top: searchHistoryLabel.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 24, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 150)
    }
    
    func setupSearchBar(){
        view.addSubview(searchBar)
        searchBar.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 12, width: 0, height: searchBar.intrinsicContentSize.height)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(alertView)
        
        alertView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        setupSearchBar()
        setupTrendingCollectionView()
        setupSearchCollectionView()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupView()
        animateView()
    }
    
    
    @objc func handleCancel(){
        dismiss(animated: true, completion: nil)
    }
    
    func setupView() {
        alertView.layer.cornerRadius = 15
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.4)
    }
    
    func animateView() {
        alertView.alpha = 0;
        self.alertView.frame.origin.y = self.alertView.frame.origin.y + 50
        UIView.animate(withDuration: 0.4, animations: { () -> Void in
            self.alertView.alpha = 1.0;
            self.alertView.frame.origin.y = self.alertView.frame.origin.y - 50
        })
    }
    
    func dismissAlertView(action : UIAlertAction) {
        self.dismiss(animated: true, completion: nil)
    }
    
}

extension SearchView : UISearchBarDelegate {
    
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

extension SearchView : UITableViewDataSource {
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

extension SearchView : UITableViewDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: tableViewCellId, for: indexPath) as! SearchReturn
//        cell.user = user
//        cell.principle = principles?[indexPath.item]
//        cell.step = steps?[indexPath.item]
        return cell
    }
}

extension SearchView : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case searchHistoryCollection:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: searchId, for: indexPath) as! SearchHistoryCell
            return cell
        case trendingCollection:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: trendingId, for: indexPath) as! SearchTrendingCell
            cell.photo.image = UIImage(named: images[indexPath.item])
            return cell
        default:
            assert(false, "Not a valid collection")
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 12)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        accessHomeController?.handleChangeToDetail(viewType: "isPrinciplesDetail")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch collectionView {
        case searchHistoryCollection:
            return CGSize(width: view.frame.width / 3, height: 120)
        case trendingCollection:
            return CGSize(width: view.frame.width - 155, height: 360)
        default:
            assert(false, "Not a valid collection")
        }
    }
}
