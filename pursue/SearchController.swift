//
//  SearchController.swift
//  pursue
//
//  Created by Jaylen Sanders on 8/23/18.
//  Copyright © 2018 Glory. All rights reserved.
//

import UIKit

class SearchController : UICollectionViewController {
    
    let headerId = "headerId"
    let principleId = "principleId"
    let peopleId = "peopleId"
    
    func setupCollectionView(){
        collectionView?.register(SearchHeader.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerId)
        collectionView?.register(RecentSearchUsers.self, forCellWithReuseIdentifier: peopleId)
        collectionView?.register(RecentSearchPrinciples.self, forCellWithReuseIdentifier: principleId)
        collectionView?.backgroundColor = .white
        collectionView?.showsVerticalScrollIndicator = false
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

extension SearchController : UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 325)
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath) as! SearchHeader
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 120)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: peopleId, for: indexPath) as! RecentSearchUsers
        cell.backgroundColor = .red
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
}

extension SearchController : UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
//        searchBar.resignFirstResponder()
//
//        guard let searchText = searchBar.text else { return }
//        getSearchContent(searchText: searchText)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        if searchText.isEmpty {
//            searchTableView.isHidden = true
//        } else {
//            searchTableView.isHidden = false
//            view.addSubview(searchTableView)
//            searchTableView.anchor(top: searchBar.bottomAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
//            getSearchContent(searchText: searchText)
//        }
    }
    
    func getSearchContent(searchText : String){
//        let queryString = searchText + "%"
//        exploreService.queryDatabase(searchText: queryString) { (search) in
//            DispatchQueue.main.async{
//                self.user = search.users
//                self.principles = search.principles
//                self.steps = search.steps
//                self.searchTableView.reloadData()
//            }
//
//        }
    }
}
