//
//  SearchController.swift
//  pursue
//
//  Created by Jaylen Sanders on 8/23/18.
//  Copyright © 2018 Glory. All rights reserved.
//

import UIKit
import Motion

class SearchController : UICollectionViewController {
    
    let headerId = "headerId"
    let pursuitId = "pursuitId"
    let peopleId = "peopleId"
    let postId = "postId"
    
    lazy var searchBar : UITextField = {
        let tf = UITextField()
        tf.font = UIFont.systemFont(ofSize: 16)
        tf.attributedPlaceholder = NSAttributedString(string: "Search", attributes: [
            .foregroundColor: UIColor.black, .font: UIFont.systemFont(ofSize: 16)])
        tf.clearButtonMode = .whileEditing
        tf.backgroundColor = .white
        tf.isUserInteractionEnabled = true
        tf.delegate = self
        tf.motionIdentifier = "searchBar"
        return tf
    }()
    
    let searchBackground : SearchCardView = {
        let view = SearchCardView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.motionIdentifier = "searchBackground"
        return view
    }()

    func setupCollectionView(){
        collectionView?.register(SearchUsers.self, forCellWithReuseIdentifier: peopleId)
        collectionView?.register(SearchPosts.self, forCellWithReuseIdentifier: postId)
        collectionView?.register(SearchPursuits.self, forCellWithReuseIdentifier: pursuitId)
        
        collectionView?.backgroundColor = .white
        collectionView?.showsVerticalScrollIndicator = false
        collectionView?.contentInset = UIEdgeInsetsMake(50, 0, 0, 0)
    }
    
    @objc func handleDismiss(){
        dismiss(animated: true, completion: nil)
    }
    
    fileprivate func setupView() {
        let searchBackground = UIView()
        searchBackground.backgroundColor = .white
        searchBackground.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(searchBackground)
        view.addSubview(searchBar)
        
        searchBackground.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 80)
        searchBar.anchor(top: nil, left: searchBackground.leftAnchor, bottom: searchBackground.bottomAnchor, right: searchBackground.rightAnchor, paddingTop: 0, paddingLeft: 12, paddingBottom: 8, paddingRight: 12, width: 0, height: 20)
        searchBar.becomeFirstResponder()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupCollectionView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
}

extension SearchController : UITextFieldDelegate {
    
}

extension SearchController : UICollectionViewDelegateFlowLayout {
    
}

extension SearchController  {
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
//        return CGSize(width: view.frame.width, height: 50)
//    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch indexPath.item {
        case 0:
            return CGSize(width: view.frame.width, height: 100)
        case 1:
            return CGSize(width: view.frame.width, height: view.frame.height / 2.2)
        default:
            return CGSize(width: view.frame.width, height: (view.frame.height / 2.2) + 30)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 60.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 60.0
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.item {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: peopleId, for: indexPath) as! SearchUsers
            return cell
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: pursuitId, for: indexPath) as! SearchPursuits
            return cell
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: postId, for: indexPath) as! SearchPosts
            return cell
        }
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
}

//extension SearchController : UISearchBarDelegate {
//
//    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
////        searchBar.resignFirstResponder()
////
////        guard let searchText = searchBar.text else { return }
////        getSearchContent(searchText: searchText)
//    }
//
//    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
////        if searchText.isEmpty {
////            searchTableView.isHidden = true
////        } else {
////            searchTableView.isHidden = false
////            view.addSubview(searchTableView)
////            searchTableView.anchor(top: searchBar.bottomAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
////            getSearchContent(searchText: searchText)
////        }
//    }
//
//    func getSearchContent(searchText : String){
////        let queryString = searchText + "%"
////        exploreService.queryDatabase(searchText: queryString) { (search) in
////            DispatchQueue.main.async{
////                self.user = search.users
////                self.principles = search.principles
////                self.steps = search.steps
////                self.searchTableView.reloadData()
////            }
////
////        }
//    }
//}
