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
    let principleId = "principleId"
    let peopleId = "peopleId"
    
    lazy var searchBar : UITextField = {
        let tf = UITextField()
        tf.font = UIFont.systemFont(ofSize: 15)
        tf.attributedPlaceholder = NSAttributedString(string: "Search", attributes: [kCTForegroundColorAttributeName as NSAttributedStringKey: UIColor.black])
        tf.clearButtonMode = .whileEditing
        tf.backgroundColor = .white
        tf.isUserInteractionEnabled = true
        tf.delegate = self
        tf.motionIdentifier = "searchBar"
        return tf
    }()
    
    lazy var searchButton : UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "search_selected").withRenderingMode(.alwaysTemplate), for: .normal)
        button.tintColor = .gray
        button.imageView?.contentMode = .scaleAspectFill
        button.translatesAutoresizingMaskIntoConstraints = false
        button.motionIdentifier = "searchButton"
        return button
    }()
    
    let searchBackground : SearchCardView = {
        let view = SearchCardView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.motionIdentifier = "searchBackground"
        return view
    }()
    
    
    lazy var backButton : UIButton = {
       let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "back-arrow").withRenderingMode(.alwaysOriginal), for: .normal)
        button.imageView?.contentMode = .scaleAspectFill
        button.addTarget(self, action: #selector(handleDismiss), for: .touchUpInside)
        return button
    }()
    
//    func setupCollectionView(){
//        collectionView?.register(SearchHeader.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerId)
//        collectionView?.register(RecentSearchUsers.self, forCellWithReuseIdentifier: peopleId)
//        collectionView?.register(RecentSearchPrinciples.self, forCellWithReuseIdentifier: principleId)
//        collectionView?.backgroundColor = .white
//        collectionView?.showsVerticalScrollIndicator = false
//    }
    
    @objc func handleDismiss(){
        dismiss(animated: true, completion: nil)
    }
    
    fileprivate func setupView() {
        view.addSubview(searchBackground)
        view.addSubview(searchBar)
        view.addSubview(searchButton)
        view.addSubview(backButton)
        
        searchBackground.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 32, paddingLeft: 10, paddingBottom: 0, paddingRight: 10, width: 0, height: 32)
        searchButton.anchor(top: nil, left: searchBackground.leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 8, paddingBottom: 0, paddingRight: 8, width: 14, height: 14)
        searchButton.centerYAnchor.constraint(equalTo: searchBackground.centerYAnchor).isActive = true
        searchBar.anchor(top: nil, left: searchButton.rightAnchor, bottom: nil, right: searchBackground.rightAnchor, paddingTop: 0, paddingLeft: 8, paddingBottom: 0, paddingRight: 4, width: 0, height: 20)
        searchBar.centerYAnchor.constraint(equalTo: searchBackground.centerYAnchor).isActive = true
        searchBar.becomeFirstResponder()
        backButton.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: 18, height: 16)
    }
    
    fileprivate func setupAnimation() {
        isMotionEnabled = true
        
        searchBackground.transition(.translate(y: -80), .duration(0.5))
        searchBar.transition(.translate(y: -80), .duration(0.5))
        searchButton.transition(.translate(y: -80), .duration(0.5))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.backgroundColor = .white
        collectionView?.showsVerticalScrollIndicator = false
        setupAnimation()
        setupView()
//        setupCollectionView()
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        navigationController?.navigationBar.isHidden = true
//    }
}

extension SearchController : UITextFieldDelegate {
    
}
//extension SearchController : UICollectionViewDelegateFlowLayout {
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
//        return CGSize(width: view.frame.width, height: 325)
//    }
//
//    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
//        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath) as! SearchHeader
//        return header
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: view.frame.width, height: 120)
//    }
//
//    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: peopleId, for: indexPath) as! RecentSearchUsers
//        cell.backgroundColor = .red
//        return cell
//    }
//
//    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return 5
//    }
//}

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
