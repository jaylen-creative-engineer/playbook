//
//  SearchHeader.swift
//  pursue
//
//  Created by Jaylen Sanders on 8/23/18.
//  Copyright © 2018 Glory. All rights reserved.
//

import UIKit
import Gemini

class SearchHeader : UICollectionViewCell {
    
    let cellId = "cellId"
    
    lazy var searchBar : UITextField = {
       let tf = UITextField()
        tf.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.init(25))
        tf.attributedPlaceholder = NSAttributedString(string: "SEARCH...", attributes: [kCTForegroundColorAttributeName as NSAttributedStringKey: UIColor.gray])
        tf.clearButtonMode = .whileEditing
        return tf
    }()
    
    let collectionView : GeminiCollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let collectionView = GeminiCollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.decelerationRate = UIScrollViewDecelerationRateFast
        return collectionView
    }()
    
    lazy var profilePhoto : UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "steph").withRenderingMode(.alwaysOriginal), for: .normal)
        button.imageView?.contentMode = .scaleAspectFill
        button.layer.cornerRadius = 12
        button.layer.masksToBounds = true
        return button
    }()
    
    let images = [#imageLiteral(resourceName: "cars"), #imageLiteral(resourceName: "ferrari"), #imageLiteral(resourceName: "ferrari-f70"), #imageLiteral(resourceName: "fashion-design"), #imageLiteral(resourceName: "comment-1")]
    let detailLabels = ["Pursuits", "People", "Steps", "Principles", "Challenges"]
    var scaleEffect: GeminScaleEffect = .scaleUp

    func setupCollectionView(){
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(SearchCarouselCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.gemini
            .scaleAnimation()
            .scale(0.85)
            .scaleEffect(scaleEffect)
            .ease(.easeOutQuart)
        addSubview(collectionView)
        collectionView.anchor(top: nil, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 250)
        collectionView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
    
    func setupView(){
        addSubview(searchBar)
        searchBar.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 12, paddingBottom: 5, paddingRight: 12, width: 0, height: 18)
        setupCollectionView()
       
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SearchHeader : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        collectionView.animateVisibleCells()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 60.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 215, height: 240)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if let cell = cell as? GeminiCell {
            self.collectionView.animateCell(cell)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return detailLabels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! SearchCarouselCell
        cell.detailLabel.text = detailLabels[indexPath.item]
        cell.photo.image = images[indexPath.item]
        self.collectionView.animateCell(cell)
        return cell
    }
}


extension SearchHeader : UISearchBarDelegate {
    
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
